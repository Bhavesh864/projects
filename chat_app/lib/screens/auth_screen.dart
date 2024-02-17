import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    File? userImage,
    bool isLogin,
    BuildContext ctx,
  ) async {
    // ignore: unused_local_variable
    UserCredential authCredential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance.ref().child('user_image').child('${authCredential.user!.uid}.jpg');

        await ref.putFile(userImage!);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(authCredential.user!.uid).set({
          'username': username,
          'email': email,
          'image_url': url,
        });
      }
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      // ignore: unnecessary_null_comparison
      if (err.toString() != null) {
        message = err.toString();
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
