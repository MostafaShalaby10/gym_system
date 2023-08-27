import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';

class Supplements extends StatelessWidget {

  const Supplements({Key? key}) : super(key: key);

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
                    backgroundImage(context, image: "lib/assets/images/gemy4.jpg") ,

                    ConditionalBuilder(
                        condition: state is! LoadingGetSupplementState,
                        builder: (context) =>cubit.get(context).supplementMap.isNotEmpty ?ListView.builder(
                          itemBuilder: (context , index)=>Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:const EdgeInsets.all(16),
                                    color: backgroundColor,
                                    child: Text(
                                      '${cubit.get(context).supplementMap["supp ${index+1}"][0]}',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Container(
                                    padding:const EdgeInsets.all(16),
                                    color: Colors.teal.withOpacity(0.5),
                                    child: Text(
                                      '${cubit.get(context).supplementMap["supp ${index+1}"][1]}',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 17),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          itemCount: cubit.get(context).supplementMap.length,
                        ) : const Text("Wait for\n    Supplement 😉" , textAlign: TextAlign.center,style: TextStyle(color: Colors.white , fontSize: 30),),
                        fallback: (context) =>
                        const Center(child: CircularProgressIndicator(color: Colors.white,)))
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
