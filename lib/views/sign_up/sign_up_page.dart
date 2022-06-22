import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/controllers/auth_viewmodel.dart';
import 'package:gym_power/core/const/color_constant.dart';
import 'package:gym_power/core/const/text_constants.dart';
import 'package:gym_power/core/services/validation_service.dart';
import 'package:gym_power/views/sign_in/sign_in.dart';
import 'package:gym_power/views/widgets/custom_text.dart';
import 'package:gym_power/views/widgets/fitness_button.dart';
import 'package:gym_power/views/widgets/fitness_text_field.dart';

class SignUpPage extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: ColorConstants.white,
            child: Stack(
              children: [
                _createMainData(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createMainData(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _createTitle(),
            // const SizedBox(height: 50),
            _createForm(context),
            const SizedBox(height: 40),
            _createSignUpButton(context),
            // Spacer(),
            const SizedBox(height: 40),
            _createHaveAccountText(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _createTitle() {
    return Text(
      TextConstants.signUp,
      style: TextStyle(
        color: ColorConstants.textBlack,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FitnessTextField(
            title: TextConstants.username,
            controller: controller.userNameController,
            hintText: TextConstants.userNamePlaceholder,
            onSavedFn: (newValue) {
              controller.username = newValue;
            },
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4)
                return TextConstants.usernameErrorText;
            },
          ),
          const SizedBox(height: 20),
          FitnessTextField(
            title: TextConstants.email,
            controller: controller.emailController,
            hintText: TextConstants.emailPlaceholder,
            keyboardType: TextInputType.emailAddress,
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
            hintText: TextConstants.passwordPlaceholder,
            obscureText: true,
            controller: controller.passwordController,
            onSavedFn: (newValue) {
              controller.password = newValue;
            },
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4)
                return TextConstants.passwordErrorText;
            },
          ),
          const SizedBox(height: 20),
          FitnessTextField(
            title: TextConstants.confirmPassword,
            hintText: TextConstants.confirmPasswordPlaceholder,
            obscureText: true,
            controller: controller.confirmPasswordController,
            onSavedFn: (newValue) {
              controller.confirmPassword = newValue;
            },
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4)
                return TextConstants.confirmPasswordErrorText;
            },
          ),
        ],
      ),
    );
  }

  Widget _createSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FitnessButton(
        title: TextConstants.signUp,
        onTap: () {
          FocusScope.of(context).unfocus();

          _formKey.currentState?.save();
          if (_formKey.currentState!.validate()) {
            print('object');
            controller.createaccountwithemailandpassword();
          }
        },
      ),
    );
  }

  Widget _createHaveAccountText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: TextConstants.alreadyHaveAccount,
        style: TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 18,
        ),
        children: [
          TextSpan(
            text: " ${TextConstants.signIn}",
            style: TextStyle(
              color: ColorConstants.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.to(() => SignInPage());
              },
          ),
        ],
      ),
    );
  }
}
