import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/admin/navigate.dart';

import '../../components/components.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

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
                    ConditionalBuilder(
                        condition: state is! LoadingGetUsersState,
                        builder: (context) => cubit
                                .get(context)
                                .users
                                .isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ListView.separated(
                                    itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            // cubit.get(context).getUserData(id: cubit.get(context).users[index].id) ;
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> UserData(id: cubit.get(context).users[index].id,)));
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Navigate(
                                                          id: cubit
                                                              .get(context)
                                                              .users[index]
                                                              .id,
                                                        )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(17.0),
                                            /////////////////////////add/////////////////////////////////
                                            child: Container(
                                              color: backgroundColor,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "${cubit.get(context).users[index].name}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                  // SizedBox(height: 10,),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "${cubit.get(context).users[index].dateTime}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          color: Colors.white,
                                          height: 1,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                    itemCount: cubit.get(context).users.length),
                              )
                            : const Text(
                                "No users",
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
