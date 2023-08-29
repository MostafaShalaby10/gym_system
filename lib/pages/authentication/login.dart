import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/admin/adminHomePage.dart';
import 'package:gym_system/pages/authentication/resetPassword.dart';
import 'package:gym_system/pages/user/homePage.dart';
import 'package:gym_system/pages/user/questionaire/formOne.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                backgroundImage(context, image: "lib/assets/images/gemy.jpg"),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          textField(
                            context,
                            text: "E-mail",
                            prefixIcon: Icons.email_outlined,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          textField(context,
                              text: "Password",
                              prefixIcon: Icons.lock_outline,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              isPass: isPassword,
                              suffixIcon: isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off, function: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoadingLoginState && state is! LoadingGetSpecificUserDataState && state is! LoadingGetUserDataState,
                              builder: (context) => button(
                                  context: context,
                                  text: "Login",
                                  color: Colors.transparent,
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 13,
                                  function: () {
                                    // cubit.get(context).getAllPrefs();
                                    if (formKey.currentState!.validate()) {
                                      cubit.get(context).login(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  }),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator(color: Colors.white,))),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  color: backgroundColor,
                                  padding: const EdgeInsets.symmetric(vertical: 13 , horizontal: 8),
                                  child: const Text(
                                    "Forget password?",
                                    style: TextStyle(fontSize: 20),
                                  )),
                              const SizedBox(width: 10,) ,
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResetPassword()));
                                    },
                                    child: const Text(
                                      "Reset password",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SuccessfullyLoginState) {
        if (emailController.text == "mostafaagamal304@gmail.com"  ) {
          SharedPrefs.saveData(key: "admin", value: true);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AdminHomePage()),
              (route) => false);
          Fluttertoast.showToast(
              msg: "Welcome Gemy", backgroundColor: Colors.green);
        } else {
          if (cubit.get(context).userData.isEmpty) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => FormOne()),
                (route) => false);
          } else {
            SharedPrefs.saveData(key: "user", value: true);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
          }
          Fluttertoast.showToast(
              msg: "Welcome Coach", backgroundColor: Colors.green);
        }
      } else if (state is ErrorLoginState) {
if(state.error.toString().contains("here is no user record corresponding to this identifier"))
  {
    Fluttertoast.showToast(
        msg: "Incorrect email", backgroundColor: Colors.red);
  }
 else if(state.error.toString().contains("The password is invalid or the user does not have a password"))
   {
     Fluttertoast.showToast(
         msg: "Incorrect password", backgroundColor: Colors.red);
   } else if(state.error.toString().contains("The email address is badly formatted"))
   {
     Fluttertoast.showToast(
         msg: "Not valid email", backgroundColor: Colors.red);
   }
      }
    });
  }
}
