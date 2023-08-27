import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';

import '../../components/constants.dart';

class AddExercise extends StatelessWidget {
  final String id;

  AddExercise({Key? key, required this.id}) : super(key: key);
  final TextEditingController dayController = TextEditingController();
  final TextEditingController exerciseController = TextEditingController();
  final TextEditingController exerciseNumberController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController restController = TextEditingController();
  final TextEditingController additionalLinkController = TextEditingController();
 final  formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    backgroundImage(context, image: "lib/assets/images/gemy10.jpg") ,
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                color: backgroundColor,
                                child: textField(context,
                                    text: "Enter the day",
                                    prefixIcon: Icons.date_range,
                                    controller: dayController,
                                    type: TextInputType.number),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: backgroundColor,
                                child: textField(context,
                                    text: "Enter the number of exercise",
                                    prefixIcon: Icons.date_range,
                                    controller: exerciseNumberController,
                                    type: TextInputType.number),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: backgroundColor,
                                child: textField(context,
                                    maxLines: 8,
                                    text: "Enter the Exercise",
                                    prefixIcon: Icons.sports_gymnastics,
                                    controller: exerciseController,
                                    type: TextInputType.text),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: backgroundColor,
                                child: textField(context,
                                    text: "Enter the rest time",
                                    prefixIcon: Icons.video_file_outlined,
                                    controller: restController,
                                    type: TextInputType.text),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: backgroundColor,
                                child: textField(context,
                                    text: "Enter the video link",
                                    prefixIcon: Icons.video_file_outlined,
                                    controller: linkController,
                                    type: TextInputType.text),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ///////////////////////////////////////////////////////////////////
                              Container(
                                color: backgroundColor,
                                child: TextFormField(

                                  style: const TextStyle(color: Colors.white),
                                  controller: additionalLinkController,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.link,
                                      color: Colors.white,
                                    ),

                                    label: const Text(
                                      "Enter additional link",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              ) ,
                              const SizedBox(
                                height: 20,
                              ),
                              ConditionalBuilder(
                                  condition: state is! LoadingAddExerciseState,
                                  builder: (context) => Container(
                                    color: backgroundColor,
                                    child: button(
                                        context: context,
                                        text: "Send Exercise",
                                        color: Colors.transparent,
                                        minWidth:
                                        MediaQuery.of(context).size.width / 2,
                                        height:
                                        MediaQuery.of(context).size.height / 10,
                                        function: () {
                                         if(formKey.currentState!.validate())
                                           {
                                             cubit.get(context).addExercise(
                                               rest: restController.text,
                                               additionalLink: additionalLinkController.text,
                                                 exerciseNumber: int.parse(exerciseNumberController.text),
                                                 day: int.parse(dayController.text),
                                                 exercise: exerciseController.text,
                                                 link: linkController.text,
                                                 id: id);
                                           }
                                        }),
                                  ),
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
        },
        listener: (context, state) {
          if(state is SuccessfullyAddExerciseState)
          {
            linkController.clear();
            exerciseController.clear();
            restController.clear();
            additionalLinkController.clear();
            Fluttertoast.showToast(msg: "Exercise added successfully" , backgroundColor: Colors.green);
          }else if(state is ErrorAddExerciseState)
          {
            Fluttertoast.showToast(msg: "Exercise added failed" , backgroundColor: Colors.red);

          }
        });
  }
}