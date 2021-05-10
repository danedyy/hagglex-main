import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hagglex/core/navigations/route_paths.dart';
import 'package:hagglex/core/share_ui/shared/app_colors.dart';
import 'package:hagglex/core/share_ui/shared/custom_back_button.dart';
import 'package:hagglex/core/share_ui/shared/input_field.dart';
import 'package:hagglex/core/share_ui/shared/touachable_opacity.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';
import 'package:hagglex/core/utils/form_validation.dart';
import 'package:hagglex/features/user/presentation/providers/auth_provider.dart';
import 'package:hagglex/features/user/presentation/widgets/hagglex_app_backgroun_widget.dart';
import 'package:hagglex/injection_container.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _usernameTextEditingController = TextEditingController();
  final _phoneTextEditingController = TextEditingController();
  final _referralCodeTextEditingController = TextEditingController();

  StreamController<String> _emailStream;
  StreamController<String> _passwordStream;
  StreamController<String> _usernameStream;
  StreamController<String> _phoneNumberStream;

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _emailStream = StreamController<String>.broadcast();
    _passwordStream = StreamController<String>.broadcast();
    _usernameStream = StreamController<String>.broadcast();
    _phoneNumberStream = StreamController<String>.broadcast();

    _emailTextEditingController.addListener(() {
      _emailStream.sink.add(_emailTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _passwordStream.sink.add(_passwordTextEditingController.text);
    });

    _usernameTextEditingController.addListener(() {
      _usernameStream.sink.add(_usernameTextEditingController.text.trim());
    });
    _phoneTextEditingController.addListener(() {
      _phoneNumberStream.sink.add(_phoneTextEditingController.text.trim());
    });
  }

  @override
  void dispose() {
    _emailStream.close();
    _passwordStream.close();
    _usernameStream.close();
    _phoneNumberStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: HaggleXAppBackgroundWidget(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceLarge,
              verticalSpaceMedium,
              Padding(
                padding: const EdgeInsets.only(
                  left: 36,
                ),
                child: CustomBackButton(),
              ),
              verticalSpace(24),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff00001A),
                        offset: Offset(0, 3),
                        blurRadius: 15,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 27,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        verticalSpace(40),
                        Text(
                          'Create a new account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        verticalSpace(30),
                        StreamBuilder<String>(
                          stream: _emailStream.stream,
                          builder: (context, snapshot) {
                            return InputField(
                              controller: _emailTextEditingController,
                              textInputType: TextInputType.emailAddress,
                              label: 'Email Address',
                              color: Colors.black,
                              labelTextColor: Colors.black,
                              validationMessage:
                                  CustomFormValidation.errorEmailMessage(
                                snapshot?.data,
                                'Email is required',
                              ),
                            );
                          },
                        ),
                        verticalSpace(5.5),
                        StreamBuilder<String>(
                          stream: _passwordStream.stream,
                          builder: (context, snapshot) {
                            return InputField(
                              controller: _passwordTextEditingController,
                              label: 'Password (Min 8 characters)',
                              color: Colors.black,
                              validationMessage:
                                  CustomFormValidation.errorMessagePassword(
                                snapshot?.data,
                                'Password is required',
                              ),
                              labelTextColor: Colors.black,
                              password: true,
                            );
                          },
                        ),
                        verticalSpace(5.5),
                        StreamBuilder<String>(
                          stream: _usernameStream.stream,
                          builder: (context, snapshot) {
                            return InputField(
                              controller: _usernameTextEditingController,
                              label: 'Create a username',
                              color: Colors.black,
                              labelTextColor: Colors.black,
                              validationMessage:
                                  CustomFormValidation.errorMessage(
                                snapshot?.data,
                                'Username is required',
                              ),
                            );
                          },
                        ),
                        verticalSpace(5.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Consumer<AuthProvider>(
                                builder: (context, value, _) {
                              return TouchableOpacity(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.selectCountryPage,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: 6.0,
                                  ),
                                  width: 75,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Color(0xffE8E8E8),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 20,
                                        child:
                                            // value.selectedCountry == null
                                            //     ? Image.asset(
                                            //         AppAssets.nigeriaFlagImage,
                                            //       )
                                            //     :
                                            SvgPicture.network(value
                                                .selectedCountry.flag
                                                .trim()),
                                      ),
                                      horizontalSpaceTiny,
                                      Text(
                                        // value.selectedCountry == null
                                        //     ? '(+234)'
                                        //     :
                                        '(+${value.selectedCountry.callingCode})',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            Expanded(
                              child: StreamBuilder<String>(
                                stream: _phoneNumberStream.stream,
                                builder: (context, snapshot) {
                                  return InputField(
                                    controller: _phoneTextEditingController,
                                    label: 'Enter your phone number',
                                    color: Colors.black,
                                    textInputType: TextInputType.phone,
                                    formatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    labelTextColor: Colors.black,
                                    validationMessage:
                                        CustomFormValidation.errorPhoneNumber(
                                      snapshot?.data,
                                      'Phone is required',
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(5.5),
                        InputField(
                          controller: _referralCodeTextEditingController,
                          label: 'Referral code (optional)',
                          color: Colors.black,
                          labelTextColor: Color(0xff000000).withOpacity(0.4),
                          password: true,
                        ),
                        verticalSpace(16),
                        Center(
                          child: Text(
                            'By signing, you agree to HaggleX terms and privacy policy.',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        verticalSpace(44),
                        TouchableOpacity(
                          onTap: () async {
                            if (validateForm()) {
                              Logger().i('valid');

                              _isLoading.value = true;
                              await sl<AuthProvider>().register(
                                email: _emailTextEditingController.text,
                                password: _passwordTextEditingController.text,
                                username: _usernameTextEditingController.text,
                                phone: _phoneTextEditingController.text,
                                context: context,
                                referralCode:
                                    _referralCodeTextEditingController.text,
                              );
                              _isLoading.value = false;
                            }
                          },
                          child: ValueListenableBuilder<bool>(
                              valueListenable: _isLoading,
                              builder: (context, loading, child) {
                                return Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff432B7B),
                                        Color(0xff6A4BBC),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: loading
                                        ? CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          )
                                        : Text(
                                            'SIGN UP',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'BasisBold',
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                );
                              }),
                        ),
                        verticalSpace(65),
                      ],
                    ),
                  ),
                ),
              )
            ],
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
    if (CustomFormValidation.errorMessage(
          _usernameTextEditingController.text,
          'message',
          _usernameTextEditingController.text,
        ) !=
        null) {
      valid = false;

      _usernameStream.sink.add(_usernameTextEditingController.text);
    }
    if (CustomFormValidation.errorPhoneNumber(
          _phoneTextEditingController.text,
          'message',
        ) !=
        null) {
      valid = false;

      _phoneNumberStream.sink.add(
        _phoneTextEditingController.text,
      );
    }

    return valid;
  }
}
