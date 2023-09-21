import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/authentication/login.dart';
import 'package:gym_system/pages/user/exerciseDays.dart';
import 'package:gym_system/pages/user/foodDays.dart';
import 'package:gym_system/pages/user/foodreplacement.dart';
import 'package:gym_system/pages/user/questionaire/formOne.dart';
import 'package:gym_system/pages/user/supplements.dart';
import 'package:gym_system/pages/user/tips.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cookingMeasurment.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                        image:SharedPrefs.getData(key: "Gender")=="Male"? "lib/assets/images/gemy.jpg":"lib/assets/images/f1.jpg"),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: PopupMenuButton(
                            color: Colors.white,
                            itemBuilder: (context) {
                              return menuItem;
                            },
                            onSelected: (value) {
                              if (value == 0) {
                                SharedPrefs.removeData(key: "user");

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                    (route) => false);
                              }
                            },
                          ),
                        ),
                        Spacer(),
                        Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Gemy",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        launch(
                                            SharedPrefs.getData(key: "Gender")=="Male"?
                                            "https://wa.me/${201093080663}/?text=${Uri.parse("")}": "https://wa.me/${201099759895}/?text=${Uri.parse("")}");
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.green,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        launch(
                                            "https://www.instagram.com/mostafa.gamal32/",
                                            universalLinksOnly: true);
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.instagram,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
                      ],
                    ),
                    ConditionalBuilder(
                        condition: state is! LoadingGetUserDataState,
                        builder: (context) => SingleChildScrollView(
                              child: Form(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        button(
                                            context: context,
                                            text: "Tips",
                                            color: Colors.transparent,
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            function: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Tips()));
                                            }),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        button(
                                            context: context,
                                            text: "Edit data",
                                            color: Colors.transparent,
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            function: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FormOne()));
                                            }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        button(
                                            context: context,
                                            text: "Food",
                                            color: Colors.transparent,
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            function: () {
                                              cubit.get(context).getFood(
                                                  id: SharedPrefs.getData(
                                                      key: "uid"));
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FoodDays()));
                                            }),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        button(
                                            context: context,
                                            text: "Exercise",
                                            color: Colors.transparent,
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            function: () {
                                              cubit.get(context).getExercise(
                                                  id: SharedPrefs.getData(
                                                      key: "uid"));
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ExerciseDays()));
                                            }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        button(
                                            context: context,
                                            text: "Supplements",
                                            color: Colors.transparent,
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            function: () {
                                              cubit.get(context).getSupplement(
                                                  id: SharedPrefs.getData(
                                                      key: "uid"));
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Supplements()));
                                            }),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        button(
                                            context: context,
                                            text: "Food\nReplacement",
                                            color: Colors.transparent,
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            function: () {
                                              cubit
                                                  .get(context)
                                                  .getFoodReplacement();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FoodReplacement()));
                                            }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()))
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
