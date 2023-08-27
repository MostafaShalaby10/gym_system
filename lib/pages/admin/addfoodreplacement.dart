import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/authentication/login.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';

class AddFoodReplacement extends StatelessWidget {

  AddFoodReplacement({Key? key}) : super(key: key);
  final TextEditingController food1Controller = TextEditingController();
  final TextEditingController food2Controller = TextEditingController();


  final formKey = GlobalKey<FormState>();

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
                backgroundImage(context, image: "lib/assets/images/gemy5.jpg"),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          textField(context,
                              text: "Enter the food",
                              prefixIcon: Icons.fastfood,
                              controller: food1Controller,
                              type: TextInputType.text),
                          const SizedBox(
                            height: 10,
                          ),
                          textField(context,
                              text: "Enter the replacement",
                              prefixIcon: Icons.fastfood,
                              controller: food2Controller,
                              type: TextInputType.text),
                          const SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoadingCreateFoodReplacement,
                              builder: (context) => button(
                                  context: context,
                                  text: "Done",
                                  color: Colors.transparent,
                                  minWidth:
                                  MediaQuery.of(context).size.width / 2,
                                  height:
                                  MediaQuery.of(context).size.height / 10,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.get(context).createFoodReplacement(
                                          food1: food1Controller.text , food2: food2Controller.text);
                                    }
                                  }),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SuccessfullyCreateFoodReplacement) {

        Fluttertoast.showToast(
            msg: "Food added successfully", backgroundColor: Colors.green);
      } else if (state is ErrorCreateFoodReplacement) {
        Fluttertoast.showToast(
            msg: "Food added failed", backgroundColor: Colors.red);
      }
    });
  }
}
