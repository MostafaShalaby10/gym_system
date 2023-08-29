import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:intl/intl.dart';

import '../../components/constants.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  bool isPassword = true;
  bool isConfPassword = true;
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
                backgroundImage(context, image: "lib/assets/images/gemy7.jpg"),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            color: backgroundColor,
                            child: textField(
                              context,
                              text: "Name",
                              prefixIcon: Icons.person_outline,
                              controller: nameController,
                              type: TextInputType.name,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: backgroundColor,
                            child: textField(
                              context,
                              text: "E-mail",
                              prefixIcon: Icons.email_outlined,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: backgroundColor,
                            child: textField(
                              context,
                              text: "Phone",
                              prefixIcon: Icons.phone_outlined,
                              controller: phoneController,
                              type: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: backgroundColor,
                            child: textField(context,
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
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: backgroundColor,
                            child: textField(context,
                                text: "Conf-Password",
                                prefixIcon: Icons.lock_outline,
                                controller: confPasswordController,
                                type: TextInputType.visiblePassword,
                                isPass: isConfPassword,
                                suffixIcon: isConfPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off, function: () {
                              setState(() {
                                isConfPassword = !isConfPassword;
                              });
                            }),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoadingSignUpState,
                              builder: (context) => Container(
                                    color: backgroundColor,
                                    child: button(
                                        context: context,
                                        text: "Create account",
                                        color: Colors.transparent,
                                        minWidth:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                13,
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (passwordController.text ==
                                                confPasswordController.text) {
                                              cubit.get(context).signUp(
                                                  date:
                                                      "${DateFormat.yMMMd().format(DateTime.now())} ${TimeOfDay.now().format(context).toString()}",
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  name: nameController.text,
                                                  phone: phoneController.text);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Passwords aren't the same",
                                                  backgroundColor: Colors.red);
                                            }
                                          }
                                        }),
                                  ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()))
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
      if (state is SuccessfullySignUpState) {
        Fluttertoast.showToast(
            msg: "Create account successfully", backgroundColor: Colors.green);
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        confPasswordController.clear();
        phoneController.clear();
        isPassword = true;
        isConfPassword = true;
      } else if (state is ErrorSignUpState) {
        if (state.error
            .toString()
            .contains("The email address is badly formatted")) {
          Fluttertoast.showToast(
              msg: "The email address is badly formatted",
              backgroundColor: Colors.red);
        } else if (state.error.toString().contains(
            "The email address is already in use by another account")) {
          Fluttertoast.showToast(
              msg: "The email address is already in use by another account",
              backgroundColor: Colors.red);
        } else if (state.error
            .toString()
            .contains("Password should be at least 6 characters")) {
          Fluttertoast.showToast(
              msg: "Password should be at least 6 characters",
              backgroundColor: Colors.red);
        }
      }
    });
  }
}
