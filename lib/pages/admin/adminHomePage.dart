import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/admin/addUser.dart';
import 'package:gym_system/pages/admin/addfoodreplacement.dart';
import 'package:gym_system/pages/admin/addvideolink.dart';
import 'package:gym_system/pages/admin/allUsers.dart';
import 'package:gym_system/pages/authentication/login.dart';

import '../../sharedPrefrences/sharedPrefrences.dart';
import 'addfemalevideos.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

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
                        image: "lib/assets/images/gemy2.jpg"),
                    Align(
                      alignment: Alignment.topLeft,
                      child: PopupMenuButton(
                        color: Colors.white,
                        itemBuilder: (context) {
                          return menuItem;
                        },
                        onSelected: (value) {
                          if (value == 0) {
                            SharedPrefs.removeData(key: "admin");
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                                (route) => false);
                          }
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: backgroundColor,
                                  child: button(
                                      context: context,
                                      text: "Add user",
                                      color: Colors.transparent,
                                      minWidth:
                                          MediaQuery.of(context).size.width / 3.5,
                                      height:
                                          MediaQuery.of(context).size.height / 6,
                                      function: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddUser()));
                                      }),
                                ),
                                const SizedBox(width: 10,),
                                Container(
                                  color: backgroundColor,
                                  child: button(
                                      context: context,
                                      text: "Users",
                                      color: Colors.transparent,
                                      minWidth:
                                      MediaQuery.of(context).size.width / 2.5,
                                      height:
                                      MediaQuery.of(context).size.height / 6,
                                      function: () {
                                        cubit.get(context).getAllUsers();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const AllUsers()));
                                      }),
                                ),

                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Container(
                                  color: backgroundColor,
                                  child: button(
                                      context: context,
                                      text: "Add Video",
                                      color: Colors.transparent,
                                      minWidth:
                                          MediaQuery.of(context).size.width / 3.5,
                                      height:
                                          MediaQuery.of(context).size.height / 6,
                                      function: () {
                                        cubit.get(context).getAllUsers();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddVideoLink()));
                                      }),
                                ),
                                const SizedBox(width: 10,),
                                Container(
                                  color: backgroundColor,
                                  child: button(
                                      context: context,
                                      text: "Add Female\nVideos",
                                      color: Colors.transparent,
                                      minWidth:
                                      MediaQuery.of(context).size.width / 3.5,
                                      height:
                                      MediaQuery.of(context).size.height / 6,
                                      function: () {
                                        cubit.get(context).getAllUsers();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddFemaleVideos()));
                                      }),
                                )

                              ],
                            ) ,
                            const SizedBox(
                              height: 15,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Container(
                                  color: backgroundColor,
                                  child: button(
                                      context: context,
                                      text: "Food\nReplacement",
                                      color: Colors.transparent,
                                      minWidth:
                                      MediaQuery.of(context).size.width / 3.5,
                                      height:
                                      MediaQuery.of(context).size.height / 6,
                                      function: () {
                                        cubit.get(context).getAllUsers();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddFoodReplacement()));
                                      }),
                                ),
                                const SizedBox(width: 10,),

                              ],
                            ) ,

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
