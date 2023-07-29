
import 'package:flutter/material.dart';
import 'package:pingolearn/model/product_model.dart';
import 'package:pingolearn/screen/auth/e_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingolearn/services/repository/repository.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}


class _SignUPState extends State<SignUP> {
  final _formkey = GlobalKey<FormState>();
  var nameController =TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('user');

  onSubmit()async{
    if (_formkey.currentState!.validate()) {
      try {
        var userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString()
        ).then((value){
          FirebaseFirestore.instance.collection("user").add({
            "Uid":value.user!.uid,
            "name":nameController.text.toString(),
            "email":emailController.text.toString(),
            "password":passwordController.text.toString()
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SignUP sucessfully")));
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }else{
      print("Error");
    }

  }

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
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: nameController,
                          validator: (value) {
                            return value!.isEmpty ? "Enter name it is required" : null;
                          },
                          decoration: InputDecoration(
                              hintText: "Name",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),

                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 50,
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),
                          validator: (value) {
                            return value!.isEmpty ? "Enter name" : null;
                          },

                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 50,
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),
                           validator: (value) {
                             return value!.isEmpty ? "Enter name" : null;
                           },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(onPressed: ()=>onSubmit(),
                          child: Text("signup")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          },
                              child: Text("Login")
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
