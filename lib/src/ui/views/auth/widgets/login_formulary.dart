import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tots_test/src/ui/common/util/app_color.dart';
import 'package:tots_test/src/ui/common/util/assets.dart';
import 'package:tots_test/src/ui/common/widgets/custom_button.dart';
import 'package:tots_test/src/ui/dialogs/info_dialog.dart';
import 'package:tots_test/src/ui/routes/routes.dart';
import 'package:tots_test/src/ui/views/auth/auth_controller.dart';

class LoginFormulary extends StatefulWidget {
  const LoginFormulary({
    super.key,
  });

  @override
  State<LoginFormulary> createState() => _LoginFormularyState();
}

class _LoginFormularyState extends State<LoginFormulary> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthController(),
      builder: (context, child) {
        final authController = context.read<AuthController>();
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.logo),
                const Text(
                  'LOG IN',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: 2.5),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(label: Text('Mail')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }

                   
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: obscureText,
                  validator: (value) {
                    if (value?.isNotEmpty ?? false) return null;
                    return 'complete this field';
                  },
                  decoration: InputDecoration(
                      label: const Text('Password'),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: AppColors.black.withOpacity(0.38),
                        ),
                      )),
                  style: const TextStyle(),
                ),
                const SizedBox(height: 50),
                Selector<AuthController, bool>(
                  selector: (_, c) => c.isLoading,
                  builder: (context, isLoading, child) => CustomButton(
                    onTap: isLoading ? null : () => _sumit(authController),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'LOG IN',
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _sumit(AuthController authController) async {
    if (!_formKey.currentState!.validate()) return;
    final errorMessage = await authController.login(
        email: _emailController.text, password: _passwordController.text);
    if (!mounted) return;
    if (errorMessage == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.HOME,
        (Route<dynamic> route) => false,
      );
     // Navigator.pushNamed(context, Routes.HOME);
    } else {
      InfoDialog.show(context, title: 'Login error', message: errorMessage);
    }
  }
}
