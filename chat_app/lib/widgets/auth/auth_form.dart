import 'dart:io';

import 'package:flutter/material.dart';

import '../picker/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Function submitFn;
  final bool isLoading;

  const AuthForm(this.submitFn, this.isLoading, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLogin = true;

  var _userEmail = '';
  var _userName = '';
  var _userPass = '';
  File? _pickedImage;

  void _getPickedImage(File image) {
    _pickedImage = image;
  }

  void _saveForm() {
    final isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_pickedImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please Add an Image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isvalid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPass.trim(),
        _pickedImage,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!_isLogin) UserImagePicker(_getPickedImage),
                    TextFormField(
                      key: const ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email Address'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@') || !value.contains('.com')) {
                          return 'Invalid Email Address!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                      onChanged: (val) {
                        if (mounted) {
                          setState(() => _userEmail = val); //the email will trow to String that will give to firebaseAuth
                        }
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('username'),
                        decoration: const InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Username must be 4 characters long!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value!;
                        },
                        onChanged: (val) {
                          if (mounted) {
                            setState(() => _userName = val); //the email will trow to String that will give to firebaseAuth
                          }
                        },
                      ),
                    TextFormField(
                      key: const ValueKey('password'),
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must be atleast 6 characters long!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPass = value!;
                      },
                      onChanged: (val) {
                        if (mounted) {
                          setState(() => _userPass = val); //the email will trow to String that will give to firebaseAuth
                        }
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    widget.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: _saveForm,
                            child: Text(_isLogin ? 'Login' : 'SignUp'),
                          ),
                    if (!widget.isLoading)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin ? 'Create new account' : 'I already have an account'),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
