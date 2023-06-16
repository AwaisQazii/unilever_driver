import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilever_driver/app/navigation_helper.dart';
import 'package:unilever_driver/app/routes.dart';
import 'package:unilever_driver/utils/app_colors.dart';
import 'package:unilever_driver/utils/assets.dart';
import 'package:unilever_driver/utils/widget_utils.dart';
import 'package:unilever_driver/utils/widgets/custom_text_form_field.dart';
import 'package:unilever_driver/utils/widgets/fractionally_elevated_button.dart';
import 'package:unilever_driver/utils/widgets/title_text.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                WidgetUtils.vrtSpace(100),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(color: AppColors.white),
                    child: Image.asset(
                      AssetsPath.appLogo,
                      color: AppColors.primaryColor,
                      height: MediaQuery.of(context).size.height * 0.25,
                      // width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ),
                WidgetUtils.vrtSpace(50),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CustomTextFormField(
                    controller: userName,
                    validator: validators,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hint: "Username",
                    textColor: AppColors.white,
                    errorTextColor: AppColors.white,
                    hintColor: AppColors.white.withOpacity(0.7),
                  ),
                ),
                WidgetUtils.vrtSpace(20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CustomTextFormField(
                    controller: password,
                    validator: validators,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hint: "Password",
                    textColor: AppColors.white,
                    errorTextColor: AppColors.white,
                    hintColor: AppColors.white.withOpacity(0.7),
                  ),
                ),
                WidgetUtils.vrtSpace(20),
                FractionallyElevatedButton(
                  backgroundColor: const Color(0xff1f35c7),
                  widthFactor: 0.8,
                  child: TitleText(
                    title: "Login",
                    color: AppColors.white,
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      pushNamed(AppRoutes.home);
                    } else {
                      print("value is empty");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validators(String? value) {
    if (value == null) {
      return "field can't be empty";
    } else if (value.isEmpty) {
      return "field can't be empty";
    }
    return null;
  }
}
