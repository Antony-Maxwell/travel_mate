import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:lottie/lottie.dart';
import 'package:email_validator/email_validator.dart';

class signUp extends StatefulWidget {
  signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final usernameSignedController = TextEditingController();
  final passwordSignedController = TextEditingController();
  final gmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:DecorationImage(
          image: AssetImage("assets/images/LoginandSignUp.jpg"),
          opacity: 0.2,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 110, top: 150),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'kanit',
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                  right: 35,
                  left: 35,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: usernameSignedController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Colors.grey
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter atleast 4 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: passwordSignedController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color:  Colors.grey,
                            width: 1.0,
                          ),
                        ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                                color: Colors.grey,),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter atleast 4 characters';
                          }
                          return null;
                        },
                        obscureText: _isObscure,
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: gmailController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color:  Colors.grey,
                            width: 1.0,
                          ),
                        ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Gmail',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: 'Gmail',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                          ),
                          Text('SignIn',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'kanit',
                          fontSize: 25,
                        ),
                        ),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue[400],
                            radius: 25,
                            child: IconButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final userSigned = usernameSignedController.text;
                                  final passSigned = passwordSignedController.text;
                                  final email = gmailController.text;
                                  if (await saveToHive(userSigned, passSigned,email)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Sign up successful!'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Username already exists'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                } else {
                                  print('invalid data');
                                }
                              },
                              icon: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Already have an account ? Login here',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'kanit',
                          fontSize: 14,
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
