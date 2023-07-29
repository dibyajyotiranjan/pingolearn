
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn/screen/UI.dart';
import 'package:pingolearn/screen/auth/e_signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 40,bottom: 40),
          child: SafeArea(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("e-Shop"),
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: email,
                          validator: (value)=>value!.isEmpty?"Enter a Email":null,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),

                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: password,
                          validator: (value)=>value!.isEmpty?"Input a password":null,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),

                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(onPressed: ()async{
                        if(_formkey.currentState!.validate()){
                          try {
                            var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: email.text.toString(),
                                password: password.text.toString()
                            ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please input a valid Email")));
                             } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your password is wrong")));
                            }
                          }
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You Input a wrong formate")));
                        }

                      },
                          child: Text("Login")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New here?"),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUP()));
                          },
                              child: Text("signup")
                          ),
                        ],
                      )

                    ],
                  )

                ],
              ),
            ),
          ),
        )
    );
  }
}
