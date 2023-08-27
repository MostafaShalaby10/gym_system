import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
class Tips extends StatelessWidget {
  const Tips({Key? key}) : super(key: key);

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: backgroundColor,
                        width: MediaQuery.of(context).size.width,
                        child: const SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "Basics",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                " WATER INTAKE ( 4 – 6 ) ",
                                style: TextStyle(
                                  backgroundColor: Colors.white,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    "يعني مقدرا الماء اللي لازم تشربه خلال اليوم لا يقل عن 4 لتر" ,textAlign: TextAlign.end, style: TextStyle(fontSize: 17),),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                " BED TIME (8_10 ) ",
                                style: TextStyle(
                                  backgroundColor: Colors.white,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "عدد الساعات اللي لازم تنامها خلال اليوم لا تقل عن 8 ساعات ولا يزيد عن 10 ساعات" ,textAlign: TextAlign.end, style: TextStyle(fontSize: 17),),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "SALT INTAKE ( 2_ 5 ) ",
                                style: TextStyle(
                                  backgroundColor: Colors.white,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "يعني مقدار الملح اللي لازم تحصل عليه خلال اليوم في جميع وجباتك لا يقل عن 2 جرام ولا يزيد عن 5 جرام و يفضل وضعه بعد الانتهاء من تحضير الوجبات وليس اثناء التجهيز " ,textAlign: TextAlign.end, style: TextStyle(fontSize: 17),),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "OPTIONAL" ,
                                style: TextStyle(
                                    backgroundColor: Colors.white,

                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "شاي اخضر / قهوه / قرفه" ,textAlign: TextAlign.center, style: TextStyle(fontSize: 17),),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  " بهارات مثل فلفل اسود / كركم / شطه / بابريكا" ,textAlign: TextAlign.center, style: TextStyle(fontSize: 17),),
                              ),Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  " بودره فراخ / لحمه / سمك" ,textAlign: TextAlign.center, style: TextStyle(fontSize: 17),),
                              ),Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  " بصل / مشروم / توم " ,textAlign: TextAlign.center, style: TextStyle(fontSize: 17),),
                              ),Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "بيبسي دايت (2-1) كان يوميا" ,textAlign: TextAlign.center, style: TextStyle(fontSize: 17),),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  " سكر دايت سويتال او استيفا " ,textAlign: TextAlign.center, style: TextStyle(fontSize: 17),),
                              ),  Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "يمكن استخدام زيت زتون في طهي الطعام ولكن بكميه قليله لاتتجاوز جرام  5 " ,textAlign: TextAlign.center, style: TextStyle(fontSize: 17),),
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
