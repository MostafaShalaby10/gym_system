
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';
import 'package:url_launcher/url_launcher.dart';

class Exercise extends StatelessWidget {
  final int dayIndex;

  const Exercise({Key? key, required this.dayIndex}) : super(key: key);

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
                        image: SharedPrefs.getData(key: "Gender")=="Male"? "lib/assets/images/gemy7.jpg" : "lib/assets/images/f1.jpg"),
                    ConditionalBuilder(
                        condition: state is! LoadingGetExerciseState,
                        builder: (context) => cubit
                                    .get(context)
                                    .exercise[dayIndex] !=
                                null
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Warm up upper",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              launch(
                                                  "https://www.youtube.com/shorts/iFCRVkJoUI0");
                                            },
                                            icon: const Icon(
                                              FontAwesomeIcons.youtube,
                                              color: Colors.red,
                                              size: 40,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Warm up lower",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              launch(
                                                  "https://youtube.com/shorts/m5L9ciapwkc?feature=shar");
                                            },
                                            icon: const Icon(
                                              FontAwesomeIcons.youtube,
                                              color: Colors.red,
                                              size: 40,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: backgroundColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    cubit
                                                            .get(context)
                                                            .exercise[dayIndex]
                                                            .map[
                                                        "EX ${index + 1}"][0],
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: backgroundColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Rest time : ${cubit.get(context).exercise[dayIndex].map["EX ${index + 1}"][3]}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "watch video : ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        launch(cubit
                                                                .get(context)
                                                                .exercise[dayIndex]
                                                                .map[
                                                            "EX ${index + 1}"][1]);
                                                      },
                                                      icon: const Icon(
                                                        FontAwesomeIcons
                                                            .youtube,
                                                        color: Colors.red,
                                                        size: 40,
                                                      )),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  if (cubit
                                                              .get(context)
                                                              .exercise[dayIndex]
                                                              .map[
                                                          "EX ${index + 1}"][2] !=
                                                      null)
                                                    IconButton(
                                                        onPressed: () {
                                                          launch(cubit
                                                                  .get(context)
                                                                  .exercise[
                                                                      dayIndex]
                                                                  .map[
                                                              "EX ${index + 1}"][2]);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .youtube,
                                                          color: Colors.white,
                                                          size: 40,
                                                        )),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      itemCount: cubit
                                          .get(context)
                                          .exercise[dayIndex]
                                          .map
                                          .length,
                                    ),
                                  ),

                                ],
                              )
                            : const Text(
                                "Wait for Exercise 😉",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                        fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
