import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  static String tag = 'Register';

  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  String dummyEmail = 'ju.jiiz.1579@gmail.com';
  String dummyPassword = 'JuJiizTest';

  /*final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();*/
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _password;
  String _conpass;

  @override
  initState() {
    super.initState();
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 6)
      return 'Password must be more than 6 charater';
    else
      return null;
  }

  String validateConfirmPassword(String value) {
    if (value != _password)
      return 'Password does not match the confirm password';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: dummyEmail,
      validator: validateEmail,
      onSaved: (String val) {
        _email = val;
      },
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: dummyPassword,
      obscureText: true,
      validator: validatePassword,
      onSaved: (String val) {
        _password = val;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      initialValue: dummyPassword,
      obscureText: true,
      onSaved: (String val) {
        _conpass = val;
      },
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final registerButton = OutlineButton(
        child:
            Text('Register', style: TextStyle(color: Colors.lightBlueAccent)),
        borderSide: BorderSide(color: Colors.lightBlueAccent),
        //color: Colors.lightBlueAccent,
        onPressed: _validateInputs,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      key: _formKey,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            confirmPassword,
            SizedBox(height: 24.0),
            registerButton,
          ],
        ),
      ),
    );
  }
}
