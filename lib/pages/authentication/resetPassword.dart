import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/authentication/login.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

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
                          ConditionalBuilder(
                              condition: state is! LoadingResetPassword,
                              builder: (context) => button(
                                  context: context,
                                  text: "ResetPassword",
                                  color: Colors.transparent,
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 13,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.get(context).resetPassword(
                                          email: emailController.text);
                                    }
                                  }),
                              fallback: (context) =>
                                  const Center(child: CircularProgressIndicator()))
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
      if (state is SuccessfullyResetPassword) {
        Fluttertoast.showToast(
            msg: "Check your email", backgroundColor: Colors.green);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      } else if (state is ErrorLoginState) {
        Fluttertoast.showToast(
            msg: state.error.toString(), backgroundColor: Colors.red);
      }
    });
  }
}
