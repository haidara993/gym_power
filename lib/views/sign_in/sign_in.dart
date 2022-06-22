import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/controllers/auth_viewmodel.dart';
import 'package:gym_power/core/const/color_constant.dart';
import 'package:gym_power/core/const/text_constants.dart';
import 'package:gym_power/views/sign_up/sign_up_page.dart';
import 'package:gym_power/views/widgets/fitness_button.dart';
import 'package:gym_power/views/widgets/fitness_text_field.dart';

class SignInPage extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ColorConstants.white,
        child: Stack(
          children: [
            _createMainData(context),
          ],
        ),
      ),
    );
  }

  Widget _createMainData(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: height - 30 - MediaQuery.of(context).padding.bottom,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20),
              _createHeader(),
              // const SizedBox(height: 50),
              _createForm(context),
              const SizedBox(height: 20),
              _createForgotPasswordButton(context),
              const SizedBox(height: 40),
              _createSignInButton(context),
              Spacer(),
              _createDoNotHaveAccountText(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createHeader() {
    return Center(
      child: Text(
        TextConstants.signIn,
        style: TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FitnessTextField(
            title: TextConstants.email,
            keyboardType: TextInputType.emailAddress,
            hintText: TextConstants.emailPlaceholder,
            controller: controller.emailController,
            onSavedFn: (newValue) {
              controller.email = newValue;
            },
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4)
                return TextConstants.emailErrorText;
            },
          ),
          const SizedBox(height: 20),
          FitnessTextField(
            title: TextConstants.password,
            hintText: TextConstants.passwordPlaceholderSignIn,
            controller: controller.passwordController,
            obscureText: true,
            onSavedFn: (newValue) {
              controller.password = newValue;
            },
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4)
                return TextConstants.passwordErrorText;
            },
          ),
        ],
      ),
    );
  }

  Widget _createForgotPasswordButton(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 21),
        child: Text(
          TextConstants.forgotPassword,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstants.primaryColor,
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget _createSignInButton(BuildContext context) {
    return FitnessButton(
      title: TextConstants.signIn,
      // isEnabled: state is SignInButtonEnableChangedState
      //     ? state.isEnabled
      //     : false,
      onTap: () {
        FocusScope.of(context).unfocus();
        _formKey.currentState?.save();
        if (_formKey.currentState!.validate()) {
          controller.signinwithEmailAndPassword();
        }
      },
    );
  }

  Widget _createDoNotHaveAccountText(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: TextConstants.doNotHaveAnAccount,
          style: TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: " ${TextConstants.signUp}",
              style: TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(() => SignUpPage());
                },
            ),
          ],
        ),
      ),
    );
  }
}
