import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

import '../../constants/sizes.dart';

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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                validator: (value) {
                  return;
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
                validator: (value) {
                  return;
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
                child: FormButton(
                  disabled: false,
                  text: 'Log in',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}