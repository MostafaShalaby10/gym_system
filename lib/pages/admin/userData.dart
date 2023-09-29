
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';

class UserData extends StatelessWidget {
  final String id;

  const UserData({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Stack(
                    alignment: Alignment.center,
                    children: [
                    backgroundImage(context, image: "lib/assets/images/gemy3.jpg"),

              ConditionalBuilder(
                  condition: state is! LoadingGetUserDataState,
                  builder: (context) =>
                  cubit
                      .get(context)
                      .userData["map"] != null ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: SingleChildScrollView(
                        child: Container(
                          color: backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Age : ${cubit
                                      .get(context)
                                      .userData["map"]["Age"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Weight : ${cubit
                                      .get(context)
                                      .userData["map"]["Weight"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Height : ${cubit
                                      .get(context)
                                      .userData["map"]["Height"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),



                                const SizedBox(height: 15,),
                                Text(
                                  "Gender : ${cubit
                                      .get(context)
                                      .userData["map"]["Gender"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(height: 15,),
                                Text(
                                  "Goal : ${cubit
                                      .get(context)
                                      .userData["map"]["Goal"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                Text(
                                  "Number of meals : ${cubit
                                      .get(context)
                                      .userData["map"]["numberOfMeals"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ), const SizedBox(
                                  height: 15,
                                ),

                                Text(
                                  "Time of first meal : ${cubit
                                      .get(context)
                                      .userData["map"]["timeOfFirstMeal"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ), const SizedBox(
                                  height: 15,
                                ),

                                Text(
                                  "Times of gym per day : ${cubit
                                      .get(context)
                                      .userData["map"]["timesOfGymDaily"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ), const SizedBox(
                                  height: 15,
                                ),

                                Text(
                                  "Times of gym per week : ${cubit
                                      .get(context)
                                      .userData["map"]["timesOfGymWeekly"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ), const SizedBox(
                                  height: 15,
                                ),

                                Text(
                                  "Time of gym : ${cubit
                                      .get(context)
                                      .userData["map"]["timeOfGym"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),

                                const SizedBox(
                                  height: 15,
                                ),

                                Text(
                                  "Forbidden Food : ${cubit
                                      .get(context)
                                      .userData["map"]["forbiddenFood"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                Text(
                                  "Favorite Food : ${cubit
                                      .get(context)
                                      .userData["map"]["favoritesFood"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Went to gym before : ${cubit
                                      .get(context)
                                      .userData["map"]["historyOfGym"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "History of gym : ${cubit
                                      .get(context)
                                      .userData["map"]["historyOfGymText"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "History of injury : ${cubit
                                      .get(context)
                                      .userData["map"]["historyOfInjury"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Description of injury: ${cubit
                                      .get(context)
                                      .userData["map"]["historyOfInjuryText"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Take supplements: ${cubit
                                      .get(context)
                                      .userData["map"]["historyOfSupplements"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ), Text(
                                  "Name of supplements: ${cubit
                                      .get(context)
                                      .userData["map"]["supplementName"] ??
                                      "Not entered data"}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Photos of body : ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                if(cubit
                                    .get(context)
                                    .userData["map"]["photosOfBody"] != null)
                                  SizedBox(
                                    height: 250,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          Row(
                                            children: [
                                              Image(
                                                image: NetworkImage(cubit
                                                    .get(context)
                                                    .userData["map"]["photosOfBody"][index]),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                      itemCount:
                                      cubit
                                          .get(context)
                                          .userData["map"]["photosOfBody"]
                                          .length,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Photos of supplements : ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ), const SizedBox(
                                  height: 15,
                                ),
                                if( cubit
                                    .get(context)
                                    .userData["map"]["photosOfSupplements"] !=
                                    null)
                                  SizedBox(
                                    height: 250,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          Row(
                                            children: [
                                              Image(
                                                image: NetworkImage(cubit
                                                    .get(context)
                                                    .userData["map"]["photosOfSupplements"][index]),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                      itemCount:
                                      cubit
                                          .get(context)
                                          .userData["map"]["photosOfSupplements"]
                                          .length,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ) : const Text("User not enter data"),
                  fallback: (context) =>
                  const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))),
              ],
            ),
          ),)
          ,
          );
        },
        listener: (context, state) {});
  }
}
