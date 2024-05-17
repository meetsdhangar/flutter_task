import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/Controller/AuthController.dart';
import 'package:flutter_task/Screen/Login/SignUp/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authcontroller = Get.put(AuthController());
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final cpasscontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
          child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Sign Up")),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/images/createacc.png"),
                            fit: BoxFit.cover)),
                    height: 250.h,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  authcontroller.login.value
                      ? Container()
                      : TextFormField(
                          key: ValueKey('fullname'),
                          controller: namecontroller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'User Name',
                              hintStyle: TextStyle(fontSize: 17.sp),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.h),
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Full Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    controller: emailcontroller,
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 17.sp),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.h),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@gmail.com')) {
                        return 'Please Enter valid Email';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      emailcontroller.text = value!;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordcontroller,
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 17.sp),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.h),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Please Enter Password of min length 6';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      passwordcontroller.text = value!;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    controller: cpasscontroller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(fontSize: 17.sp),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.h),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                    validator: (value) {
                      if (value != passwordcontroller.text) {
                        return 'Password & ConfirmPassword Sould be same';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                      if (emailcontroller.text.isNotEmpty &&
                          passwordcontroller.text.isNotEmpty &&
                          cpasscontroller.text.isNotEmpty) {
                        await authcontroller.signupUser(
                            emailcontroller.text,
                            passwordcontroller.text,
                            namecontroller.text,
                            context);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 13,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadiusDirectional.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Registration",
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "or",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => LoginScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You have alredy account ? ",
                            style: TextStyle(
                              fontSize: 17.sp,
                            )),
                        Text(
                          "Log-in",
                          style: TextStyle(fontSize: 17.sp, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.infinity.w,
                    height: 50,
                    child: SignInButton(Buttons.google,
                        elevation: 5,
                        text: "Sign up with Google", onPressed: () async {
                      await authcontroller.googlesignIn();
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
