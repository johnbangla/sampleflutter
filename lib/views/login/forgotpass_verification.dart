import 'dart:io';


import 'package:buroleave/sessionmanager/session_manager.dart';
import 'package:buroleave/views/login/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localization/Language/languages.dart';
import '../../repository/bloc/forgot_pass_verification/forgot_pass_verification_cubit.dart';
import '../../repository/models/generate_otp.dart';

import '../../theme/colors.dart';
import '../../theme/styles.dart';
import '../../utilities/common_methods.dart';

//This class has been used for forgot password
// user verification with mobile or email Otp

class ForgotPassVerification extends StatefulWidget {
  static const routeName = '/forgotPassVerification';

  late final GenerateOTP arguments;

  ForgotPassVerification(this.arguments, {Key? key}) : super(key: key);

  @override
  _ForgotPassVerificationState createState() => _ForgotPassVerificationState();
}

class _ForgotPassVerificationState extends State<ForgotPassVerification> {
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  String otpCode = "";
  var selectedLang;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgotPassVerificationCubit>();

    var user = widget.arguments;
    var info;
    if (widget.arguments.data!.otpToMobile) {
      info = widget.arguments.data!.mobile;
    } else {
      info = widget.arguments.data!.email;
    }

    var width = MediaQuery.of(context).size.width / 2;
    print('Width $width  ${MediaQuery.of(context).size.width}');
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return Column(children: [
        Flexible(
          flex: 2,
          child: CommonMethods.topBanner(width),
        ),
        Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: ListView(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        Languages.of(context)!.verificationCode,
                        style: TextStyle(fontSize: 28, color: Colors.black),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${Languages.of(context)!.otpTextMobile} $info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorResources.GREY_DARK_SIXTY),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  otpField(),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        Languages.of(context)!.recoverCodeMessage,
                        style: TextStyle(color: ColorResources.GREY_DARK_SIXTY),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'OTP validation ${user.data!.otpValidity}',
                        style: TextStyle(color: ColorResources.APP_THEME_COLOR),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      //style: ButtonStyle(),
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: ColorResources.APP_THEME_COLOR,
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      onPressed: () async {
                        if (otpCode.length == 4) {
                          CommonMethods.showLoaderDialog(context);
                          selectedLang = await sessionManager.selectedLang;
                          try {
                            final result =
                                await InternetAddress.lookup('google.com');
                            if (result.isNotEmpty &&
                                result[0].rawAddress.isNotEmpty) {
                              var response = await user.data!.otpToMobile
                                  ? bloc.submitOtpForgotPass(
                                      mobileOtp: otpCode, emailOtp: '')
                                  : bloc.submitOtpForgotPass(
                                      mobileOtp: '', emailOtp: otpCode);
                              response
                                  .then((value) => {
                                        print('Value ${value}'),
                                        if (value!.success)
                                          {
                                            Navigator.pop(context),
                                            Navigator.pushNamed(context,
                                                ResetPassword.routeName,
                                                arguments: otpCode)
                                          }
                                        else
                                          {
                                            Navigator.pop(context),
                                            if (selectedLang == 'en')
                                              {
                                                showMessage(
                                                    context,
                                                    '${value.messageEn}',
                                                    Colors.red),
                                              }
                                            else
                                              {
                                                showMessage(
                                                    context,
                                                    '${value.messageBn}',
                                                    Colors.red),
                                              }
                                          }
                                      })
                                  .onError((error, stackTrace) => {
                                        Navigator.pop(context),
                                        // print('On Error  ${error.toString()}')
                                        if (selectedLang == 'en')
                                          {
                                            showMessage(
                                                context,
                                                Languages.of(context)!
                                                    .wrongOtpValidationText,
                                                Colors.red),
                                          }
                                        else
                                          {
                                            showMessage(
                                                context,
                                                Languages.of(context)!
                                                    .wrongOtpValidationText,
                                                Colors.red),
                                          }
                                      });
                            }
                          } on SocketException catch (_) {
                            Navigator.pop(context);
                            showMessage(
                                context,
                                Languages.of(context)!.internetErrorText,
                                Colors.red);
                          }
                        } else {
                          showMessage(
                              context,
                              '${Languages.of(context)!.otpValidation}',
                              Colors.red);
                        }
                      },
                      child: Container(
                        height: 56,
                        child: Center(
                          child: Text(
                            Languages.of(context)!.submitButton,
                            style: Styles.buttonTextStyle,
                          ),
                        ),
                      ))
                ],
              ),
            ))
      ]);
    }));
  }

  Widget otpField() {
    return OTPTextField(
      length: 4,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: ColorResources.OTP_FIELD_COLOR,
          borderColor: Colors.white,
          focusBorderColor: Colors.orangeAccent),
      style: TextStyle(fontSize: 17, color: Colors.black),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          otpCode = pin;
        });
      },
      onChanged: (pin) {
        setState(() {
          otpCode = pin;
        });
      },
    );
  }
}

void showMessage(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
    ),
    backgroundColor: color,
  ));
}


