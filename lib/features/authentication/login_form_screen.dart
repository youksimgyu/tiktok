import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

import '../../constants/sizes.dart';
import '../onboarding/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({Key? key}) : super(key: key);

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const InterestsScreen(),
          ),
          (route) => false,
        );
      }
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Log in',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  onEditingComplete: _onSubmitTap,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please write your email';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    formData['email'] = newValue!;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
                Gaps.v16,
                TextFormField(
                  onEditingComplete: _onSubmitTap,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please write your password';
                    }
                    return null;
                  },
                  onSaved: (newValue) => formData['password'] = newValue!,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(
                    disabled: false,
                    text: 'Log in',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
