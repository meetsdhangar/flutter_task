import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/Screen/Login/SignUp/SignUpScreen.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../../Controller/AuthController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email Input Field
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/images/login.png"),
                          fit: BoxFit.cover)),
                  height: 300.h,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  key: const ValueKey('email'),
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    hintStyle: TextStyle(fontSize: 17.sp),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.h),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@gmail.com')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                // Password Input Field
                TextFormField(
                  key: const ValueKey('password'),
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 17.sp),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.h),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                // Login Button
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                    // Show loading indicator
                    // Get.dialog(Center(child: CircularProgressIndicator()),
                    //     barrierDismissible: false);
                    try {
                      await authController.signinUser(
                        emailController.text,
                        passwordController.text,
                        context,
                      );
                      //Get.back(); // Close the loading indicator
                    } catch (error) {
                      Get.back(); // Close the loading indicator
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())),
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 13,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                const Text("or", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10.h),

                // Create Account Navigation
                InkWell(
                  onTap: () {
                    Get.offAll(() => SignUpScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t have an account?",
                          style: TextStyle(fontSize: 17.sp)),
                      Text(" Create Account",
                          style:
                              TextStyle(fontSize: 17.sp, color: Colors.blue)),
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
                    await authController.googlesignIn();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
