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
            placeholder: TextConstants.userNamePlaceholder,
            textInputAction: TextInputAction.next,
            errorText: TextConstants.usernameErrorText,
            onTextChanged: () {
              controller.username = controller.userNameController.text;
            },
          ),
          const SizedBox(height: 20),
          FitnessTextField(
            title: TextConstants.email,
            controller: controller.emailController,
            placeholder: TextConstants.emailPlaceholder,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            errorText: TextConstants.emailErrorText,
            onTextChanged: () {
              controller.email = controller.emailController.text;
            },
          ),
          const SizedBox(height: 20),
          FitnessTextField(
            title: TextConstants.password,
            placeholder: TextConstants.passwordPlaceholder,
            obscureText: true,
            // isError: state is ShowErrorState ? !ValidationService.password(bloc.passwordController.text) : false,
            textInputAction: TextInputAction.next,
            controller: controller.passwordController,
            errorText: TextConstants.passwordErrorText,
            onTextChanged: () {
              controller.password = controller.passwordController.text;
            },
          ),
          const SizedBox(height: 20),
          FitnessTextField(
            title: TextConstants.confirmPassword,
            placeholder: TextConstants.confirmPasswordPlaceholder,
            obscureText: true,
            // isError: state is ShowErrorState
            //     ? !ValidationService.confirmPassword(
            //         bloc.passwordController.text,
            //         bloc.confirmPasswordController.text)
            //     : false,
            controller: controller.confirmPasswordController,
            errorText: TextConstants.confirmPasswordErrorText,
            onTextChanged: () {
              controller.confirmPassword =
                  controller.confirmPasswordController.text;
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
