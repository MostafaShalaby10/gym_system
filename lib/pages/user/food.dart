
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';

class Food extends StatelessWidget {
  final int dayIndex ;

  const Food({Key? key, required this.dayIndex}) : super(key: key);

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
                    backgroundImage(context, image:  SharedPrefs.getData(key: "Gender")=="Male"?"lib/assets/images/gemy6.jpg" : "lib/assets/images/f1.jpg") ,

                    ConditionalBuilder(
                        condition: state is! LoadingGetExerciseState,
                        builder: (context) =>cubit.get(context).food[dayIndex]!=null ?ListView.builder(
                          itemBuilder: (context , index)=>Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding:const EdgeInsets.all(16),
                                        color: Colors.teal.withOpacity(0.5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Meal ${index+1}',style: const TextStyle(color:Colors.white ),),
                                              const SizedBox(height: 5,) ,
                                              Text(
                                                'Time : ${cubit.get(context).food[dayIndex].map["Meal ${index + 1}"][1]}',
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),),
                                      const SizedBox(width: 15,),
                                      Expanded(
                                        child: Container(
                                          padding:const EdgeInsets.all(16),
                                          color: backgroundColor,
                                          child: Text(
                                            '${cubit.get(context).food[dayIndex].map["Meal ${index + 1}"][0]}',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                          itemCount: cubit.get(context).food[dayIndex].map.length,
                        ) : const Text("Wait for Meal 😉" , style: TextStyle(color: Colors.white , fontSize: 30),),
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
