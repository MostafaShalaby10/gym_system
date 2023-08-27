import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/user/Exercise.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/components.dart';
import 'femalevideos.dart';

class ExerciseDays extends StatelessWidget {
  const ExerciseDays({Key? key}) : super(key: key);

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
                    backgroundImage(context,
                        image: "lib/assets/images/gemy5.jpg"),
                    Column(
                      children: [
                        Expanded(
                          child: ConditionalBuilder(
                              condition: state is! LoadingGetExerciseState,
                              builder: (context) => cubit
                                  .get(context)
                                  .exercise
                                  .isNotEmpty
                                  ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ListView.separated(
                                      itemBuilder: (context, index) =>
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Exercise(
                                                              dayIndex:
                                                              index)));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  15.0),
                                              child: Text(
                                                cubit
                                                    .get(context)
                                                    .exercise[index]
                                                    .day,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          Container(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                      itemCount: cubit
                                          .get(context)
                                          .exercise
                                          .length))
                                  : const Center(
                                  child: Text(
                                    "Wait for Exercise 😉",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  )),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
                        ),

                          ConditionalBuilder(
                              condition: state is! LoadingGetUserDataState,
                              builder: (context) 
                              { 
                                if (cubit.get(context).userData["map"]["Gender"] ==
                                  "Female") {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: button(
                                    context: context,
                                    text: "Exercise\nVideos",
                                    color: Colors.transparent,
                                    minWidth:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width / 3.5,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height / 7,
                                    function: () {
                                      cubit.get(context).getFemaleVideos();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const FemaleVideos()));
                                    }),
                                  );
                                }else {
                                  return const SizedBox();
                                }} , 
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator(color: Colors.white,)))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
