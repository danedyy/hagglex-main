import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hagglex/core/constants/app_assets.dart';
import 'package:hagglex/core/share_ui/shared/app_colors.dart';
import 'package:hagglex/core/share_ui/shared/custom_back_button.dart';
import 'package:hagglex/core/share_ui/shared/input_field.dart';
import 'package:hagglex/core/share_ui/shared/touachable_opacity.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';
import 'package:hagglex/core/utils/form_validation.dart';
import 'package:hagglex/features/user/presentation/providers/auth_provider.dart';
import 'package:hagglex/features/user/presentation/widgets/hagglex_app_backgroun_widget.dart';
import 'package:logger/logger.dart';

import '../../../../injection_container.dart';

class AccountVerificationPage extends StatefulWidget {
  AccountVerificationPage({Key key}) : super(key: key);

  @override
  _AccountVerificationPageState createState() =>
      _AccountVerificationPageState();
}

class _AccountVerificationPageState extends State<AccountVerificationPage> {
  final _codeEditingController = TextEditingController();
  StreamController<String> _otpStream;

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _otpStream = StreamController<String>.broadcast();
    _codeEditingController.addListener(() {
      _otpStream.sink.add(_codeEditingController.text.trim());
    });
  }

  @override
  void dispose() {
    _otpStream.close();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                    verticalSpace(30),
                    Text(
                      'Verify your account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              verticalSpaceSmall,
              verticalSpaceSmall,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        verticalSpace(35),
                        Image.asset(
                          AppAssets.checkIcon,
                          width: 64,
                          height: 64,
                        ),
                        verticalSpace(35),
                        Text(
                          'We just sent a verification code to your email. Please enter the code',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(5.5),
                        StreamBuilder<String>(
                          stream: _otpStream.stream,
                          builder: (context, snapshot) {
                            return InputField(
                              controller: _codeEditingController,
                              label: 'Verification code',
                              color: Colors.black,
                              labelTextColor: Colors.black,
                              password: true,
                              validationMessage:
                                  CustomFormValidation.errorMessagePin(
                                snapshot?.data,
                                'Code is required',
                              ),
                            );
                          },
                        ),
                        verticalSpace(35.5),
                        TouchableOpacity(
                          onTap: () async {
                            if (validateForm()) {
                              Logger().i('valid');

                              _isLoading.value = true;
                              await sl<AuthProvider>().verifyOtp(
                                context: context,
                                otp: _codeEditingController.text,
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
                                          'VERIFY ME',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                        ),
                        verticalSpace(28),
                        Text(
                          'This code will expire in 10 minutes',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(49),
                        TouchableOpacity(
                          onTap: () async {
                            _isLoading.value = true;
                            await sl<AuthProvider>().resendOtp(
                              context: context,
                            );
                            _isLoading.value = false;
                          },
                          child: Text(
                            'Resend Code',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.center,
                          ),
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
    if (CustomFormValidation.errorMessagePin(
            _codeEditingController.text, 'message') !=
        null) {
      _otpStream.sink.add(
        _codeEditingController.text,
      );
      valid = false;
    }

    return valid;
  }
}
