import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/user/cookingMeasurment.dart';
import 'package:gym_system/pages/user/food.dart';
import 'package:gym_system/pages/user/videos.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';

class FoodDays extends StatelessWidget {
  const FoodDays({Key? key}) : super(key: key);

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
                    backgroundImage(context, image: SharedPrefs.getData(key: "Gender")=="Male"? "lib/assets/images/gemy5.jpg":"lib/assets/images/f5.jpg") ,

                    Column(
                      children: [
                        Expanded(
                          child: ConditionalBuilder(
                              condition: state is! LoadingGetFoodState,
                              builder: (context) => cubit.get(context).food.isNotEmpty?Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ListView.separated(
                                      itemBuilder: (context, index) =>  InkWell(
                                        onTap: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Food(dayIndex: index))) ;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            cubit.get(context).food[index].day,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(

                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                      )  ,
                                      separatorBuilder: (context, index) => Container(
                                        color: Colors.white.withOpacity(0.2),
                                        height: 1,
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                      itemCount: cubit.get(context).food.length)):const Center(child: Text("Wait for meals 😉" , style: TextStyle(color: Colors.white , fontSize: 30),)),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              button(
                                  sizeOfText: 20,
                                  context: context,
                                  text: "COOKING\n MEASUREMENT",
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
                                            const CookingMeasurement()));
                                  })
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              button(
                                  sizeOfText: 20,
                                  context: context,
                                  text: "Meals\n Video",
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
                                    cubit.get(context).getVideoLink();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const Videos()));
                                  })
                            ],
                          ),
                        ),
                      ],
                    ) ,
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
