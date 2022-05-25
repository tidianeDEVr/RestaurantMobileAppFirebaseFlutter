import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ui_kit/screens/phoneLogin/phone_login_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/buttons/primary_button.dart';
import '../../signIn/sign_in_screen.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  FocusNode? _emaildNode;
  FocusNode? _passwordNode;
  FocusNode? _conformPasswordNode;

  // ignore: unused_field
  // String? _fullName, _email, _password, _conformPassword;

  String _fullName = '';
  String _email = '';
  String _password = '';
  String _conformPassword = '';

  String get fullName => this._fullName;
  String get email => this._email;
  String get password => this._password;
  String get conformPassword => this._conformPassword;

  @override
  void initState() {
    super.initState();
    _passwordNode = FocusNode();
    _emaildNode = FocusNode();
    _conformPasswordNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordNode!.dispose();
    _emaildNode!.dispose();
    _conformPasswordNode!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Full Name Field
          TextFormField(
            validator: requiredValidator,
            onSaved: (value) => _fullName = value!,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              // Once user click on Next then it go to email field
              _emaildNode!.requestFocus();
            },
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            decoration: InputDecoration(
              hintText: "Full Name",
              contentPadding: kTextFieldPadding,
            ),
          ),
          VerticalSpacing(),

          // Email Field
          TextFormField(
            focusNode: _emaildNode,
            validator: emailValidator,
            onSaved: (value) => _email = value!,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              // Once user click on Next then it go to password field
              _passwordNode!.requestFocus();
            },
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email Address",
              contentPadding: kTextFieldPadding,
            ),
          ),
          VerticalSpacing(),

          // Password Field
          TextFormField(
            focusNode: _passwordNode,
            obscureText: _obscureText,

            validator: passwordValidator,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => _conformPasswordNode!.requestFocus(),
            // We need to validate our password
            onChanged: (value) => _password = value,
            onSaved: (value) => _password = value!,
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            decoration: InputDecoration(
              hintText: "Password",
              contentPadding: kTextFieldPadding,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? const Icon(Icons.visibility_off, color: kBodyTextColor)
                    : const Icon(Icons.visibility, color: kBodyTextColor),
              ),
            ),
          ),
          VerticalSpacing(),

          // Confirm Password Field
          TextFormField(
            focusNode: _conformPasswordNode,
            obscureText: _obscureText,
            validator: (value) =>
                matchValidator.validateMatch(value!, _password),
            onSaved: (value) => _conformPassword = value!,
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            decoration: InputDecoration(
              hintText: "Confirm Password",
              contentPadding: kTextFieldPadding,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? const Icon(Icons.visibility_off, color: kBodyTextColor)
                    : const Icon(Icons.visibility, color: kBodyTextColor),
              ),
            ),
          ),
          VerticalSpacing(),
          // Sign Up Button
          PrimaryButton(
            text: "Sign Up",
            press: () {
              if (_formKey.currentState!.validate()) {
                // If all data are correct then save data to out variables
                _formKey.currentState!.save();
                signUp();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PghoneLoginScreen(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(),
            ));
        Fluttertoast.showToast(
            msg: 'Compte cree avec succes 🎊',
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            gravity: ToastGravity.TOP);
        ;
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(
          msg: 'Une erreur s\'est produite !',
          backgroundColor: Colors.red,
          gravity: ToastGravity.TOP);
    }
  }
}
