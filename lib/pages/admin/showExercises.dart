import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';

import 'addExercise.dart';

class ShowExercise extends StatelessWidget {
  final String id;

  const ShowExercise({Key? key, required this.id}) : super(key: key);

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
                        image: "lib/assets/images/gemy3.jpg"),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          button(
                              context: context,
                              text: "Add exercise",
                              color: Colors.transparent,
                              minWidth: MediaQuery.of(context)
                                  .size
                                  .width /
                                  2,
                              height: MediaQuery.of(context)
                                  .size
                                  .height /
                                  8,
                              function: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddExercise(id: id,)));
                              })
                        ],
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
