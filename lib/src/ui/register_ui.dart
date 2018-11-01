import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/register_approval_dialog.dart';

class Register extends StatefulWidget {
  static String tag = 'Register';

  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  String dummyEmail = 'ju.jiiz.1579@gmail.com';
  String dummyPassword = 'JuJiizTest';

  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  bool _validate = false;
  String _email, _password, _conpass;

  initState() {
    super.initState();
  }

  String validateEmail(String value) {
    _email = value;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    _password = value;
    if (value.length < 6)
      return 'Password must be more than 6 charater';
    else
      return null;
  }

  String validateConfirmPassword(String value) {
    _conpass = value;
    if (value.length < 6)
      return 'Password must be more than 6 charater';
    else if (value != _password)
      return 'Password does not match the confirm password';
    else
      return null;
  }

  void _sendToServer() {
    print('${_key.currentState.validate()}');
    if (_key.currentState.validate()) {
      //If all data are correct then save data to out variables
      _key.currentState.save();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return RegisterApproveDialog(_email);
          });
    } else {
      //If all data are not valid then start auto validation.
      setState(() {
        _validate = true;
      });
    }
  }

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
      validator: validateConfirmPassword,
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
        onPressed: _sendToServer,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ));

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15.0),
          child: new Form(
            key: _key,
            autovalidate: _validate,
            child: Column(
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
        ),
      ),
    );
  }
}
