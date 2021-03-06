import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mykeke/main.dart';
import 'package:mykeke/screens/home.dart';
import 'package:mykeke/screens/Signup.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 30.0,),
              Image(
                image: AssetImage("images/keke.png"),
                width: 250.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 15.0,),
              Text(
                "Login",
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:Column(
                  children: [
                SizedBox(height: 1.0,),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    fontSize: 14.0,

                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                  ),
                ),
                style: TextStyle(fontSize: 14.0),
              ),
                    SizedBox(height: 1.0,),

                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,

                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0,),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage(
                              "Email address is not valid", context);
                        }
                        else if (passwordTextEditingController.text.isEmpty) {
                          displayToastMessage("password is mandatory ",
                              context);
                        }
                        else {
                          loginAndAuthenticateUser(context);
                        }
                      },


                      ),



                  ]
          ),),
           FlatButton(
             onPressed: (){
               Navigator.pushNamedAndRemoveUntil(context, Signup.idScreen, (route) => false);
             },
             child: Text("Do not have an account? Register Here"),
           ),
            ],
    ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async
  {
    final User firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      displayToastMessage("Error: " + errMsg.toString(), context);
    }
    )).user;  
    if (firebaseUser != null)
    {
      usersRef.child(firebaseUser.uid).once().then( (DataSnapshot snap){
        if(snap.value !=null)
          {
            Navigator.pushNamedAndRemoveUntil(context, MyHomepage.idScreen, (route) => false);
            displayToastMessage("you are logged-in now.", context);

          }
        else
          {
            _firebaseAuth.signOut();
            displayToastMessage("No Records exist for this user, please create new account", context);
          }
      });



    }
    else {
      displayToastMessage("Error occurred  ", context);

    }

  }
  displayToastMessage(String message, BuildContext context)
  {
    Fluttertoast.showToast(msg: message);
  }
}
