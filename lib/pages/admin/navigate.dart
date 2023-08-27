import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/admin/addExercise.dart';
import 'package:gym_system/pages/admin/addFood.dart';
import 'package:gym_system/pages/admin/addSupplemnts.dart';

import 'userData.dart';

class Navigate extends StatelessWidget {
  final String id;

  const Navigate({Key? key, required this.id}) : super(key: key);

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
                        image: "lib/assets/images/gemy9.jpg"),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                            child: Column(
                          children: [
                            Container(
                              color: backgroundColor,
                              child: button(
                                  context: context,
                                  text: "Data",
                                  color: Colors.transparent,
                                  minWidth: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.height / 6,
                                  function: () {
                                    cubit
                                        .get(context)
                                        .getUserData(id: id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserData(
                                                  id:id,
                                                )));
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: backgroundColor,
                              child: button(
                                  context: context,
                                  text: "Exercise",
                                  color: Colors.transparent,
                                  minWidth: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.height / 6,
                                  function: () {
                                    // cubit.get(context).getExercise(
                                    //     id: id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                             AddExercise(id: id,)));
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: backgroundColor,
                              child: button(
                                  context: context,
                                  text: "Food",
                                  color: Colors.transparent,
                                  minWidth: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.height / 6,
                                  function: () {
                                    // cubit.get(context).getFood(
                                    //     id: id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  AddFood(id: id,)));                                }),
                            ) ,
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: backgroundColor,
                              child: button(
                                  context: context,
                                  text: "Supplements",
                                  color: Colors.transparent,
                                  minWidth: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.height / 6,
                                  function: () {
                                    // cubit.get(context).getFood(
                                    //     id: id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  AddSupplements(id: id,)));                                }),
                            )
                          ],
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
