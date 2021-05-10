import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hagglex/core/navigations/route_paths.dart';
import 'package:hagglex/core/share_ui/shared/app_colors.dart';
import 'package:hagglex/core/share_ui/shared/input_field.dart';
import 'package:hagglex/core/share_ui/shared/touachable_opacity.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';
import 'package:hagglex/core/utils/form_validation.dart';
import 'package:hagglex/features/user/presentation/providers/auth_provider.dart';
import 'package:hagglex/features/user/presentation/widgets/gold_button_widget.dart';
import 'package:hagglex/features/user/presentation/widgets/hagglex_app_backgroun_widget.dart';
import 'package:logger/logger.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  StreamController<String> _emailStream;
  StreamController<String> _passwordStream;

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _emailStream = StreamController<String>.broadcast();
    _passwordStream = StreamController<String>.broadcast();
    _emailTextEditingController.addListener(() {
      _emailStream.sink.add(_emailTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _passwordStream.sink.add(_passwordTextEditingController.text);
    });
  }

  @override
  void dispose() {
    _emailStream.close();
    _passwordStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: HaggleXAppBackgroundWidget(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'BasisBold'),
                  ),
                  verticalSpace(30),
                  StreamBuilder<String>(
                    stream: _emailStream.stream,
                    builder: (context, snapshot) {
                      return InputField(
                        controller: _emailTextEditingController,
                        textInputType: TextInputType.emailAddress,
                        label: 'Email Address',
                        color: Colors.white,
                        labelTextColor: Colors.white,
                        validationMessage:
                            CustomFormValidation.errorEmailMessage(
                          snapshot?.data,
                          'Email is required',
                        ),
                      );
                    },
                  ),
                  verticalSpace(20.5),
                  StreamBuilder<String>(
                    stream: _passwordStream.stream,
                    builder: (context, snapshot) {
                      return InputField(
                        controller: _passwordTextEditingController,
                        label: 'Password (Min 8 characters)',
                        color: Colors.white,
                        validationMessage:
                            CustomFormValidation.errorMessagePassword(
                          snapshot?.data,
                          'Password is required',
                        ),
                        labelTextColor: Colors.white,
                        password: true,
                      );
                    },
                  ),
                  verticalSpace(10.5),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  verticalSpace(44),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isLoading,
                    builder: (context, loading, child) {
                      return GoldButton(
                        onTap: () async {
                          if (validateForm()) {
                            Logger().i('valid');

                            _isLoading.value = true;
                            await sl<AuthProvider>().login(
                              email: _emailTextEditingController.text,
                              password: _passwordTextEditingController.text,
                              context: context,
                            );
                            _isLoading.value = false;
                          }
                        },
                        title: loading ? 'Loading...' : 'LOG IN',
                      );
                    },
                  ),
                  verticalSpace(33),
                  Center(
                    child: TouchableOpacity(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.signupPage,
                        );
                      },
                      child: Text(
                        'New User? Create a new account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          // fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    var valid = true;
    if (CustomFormValidation.errorEmailMessage(
            _emailTextEditingController.text, 'message') !=
        null) {
      _emailStream.sink.add(
        _emailTextEditingController.text,
      );
      valid = false;
    }
    if (CustomFormValidation.errorMessagePassword(
          _passwordTextEditingController.text,
          'message',
        ) !=
        null) {
      valid = false;

      _passwordStream.sink.add(
        _passwordTextEditingController.text,
      );
    }

    return valid;
  }
}
