import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';

import '../../sharedPrefrences/sharedPrefrences.dart';
class CookingMeasurement extends StatelessWidget {
  const CookingMeasurement({Key? key}) : super(key: key);

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
                        image: SharedPrefs.getData(key: "Gender")=="Male"? "lib/assets/images/gemy3.jpg":"lib/assets/images/f3.jpg"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: backgroundColor,
                        width: MediaQuery.of(context).size.width,
                        child: const SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "COOKING MEASUREMENT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "ALL CARBOHYDRATES UNCOOKED ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    backgroundColor: Colors.white,

                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "يعني  جميع مصادر كاربوهيدرات مصل الارز / بطاطس / بطاطا / مكرونه / شوفان  قبل الطهي " ,textAlign: TextAlign.end, style: TextStyle(fontSize: 17),),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                " ALL PROTEINS COOKED ",
                                style: TextStyle(
                                    backgroundColor: Colors.white,

                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "جميع مصادر البروتين بعد الطهي مثل فراخ / سمك / لحمه / جمبري " ,textAlign: TextAlign.end, style: TextStyle(fontSize: 17),),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                " ALL VEGETABLES COOKED ",
                                style: TextStyle(
                                    backgroundColor: Colors.white,

                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "جميع مصادر  الخضراوات بعد الطهي مثل كوسه / فاصوليا خضرا / بروكلي" ,textAlign: TextAlign.end, style: TextStyle(fontSize: 17),),
                              ),


                            ],
                          ),
                        ),
                      ),
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
