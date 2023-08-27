import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/authentication/login.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';

class AddFood extends StatelessWidget {
  final String id;

  AddFood({Key? key, required this.id}) : super(key: key);
  final TextEditingController dayController = TextEditingController();
  final TextEditingController mealController = TextEditingController();
  final TextEditingController mealTimeController = TextEditingController();
  final TextEditingController mealNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                backgroundImage(context, image: "lib/assets/images/gemy4.jpg"),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          textField(context,
                              text: "Enter the day",
                              prefixIcon: Icons.date_range,
                              controller: dayController,
                              type: TextInputType.number),
                          const SizedBox(
                            height: 10,
                          ),
                          textField(context,
                              text: "Enter the number of meal",
                              prefixIcon: Icons.date_range,
                              controller: mealNumberController,
                              type: TextInputType.number),
                          const SizedBox(
                            height: 10,
                          ),
                          textField(context,
                              maxLines: 8,
                              text: "Enter the meal",
                              prefixIcon: Icons.sports_gymnastics,
                              controller: mealController,
                              type: TextInputType.text),
                          const SizedBox(
                            height: 10,
                          ),
                          textField(context,
                              text: "Enter the time of meal",
                              prefixIcon: Icons.timer,
                              controller: mealTimeController,
                              type: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoadingAddFoodState,
                              builder: (context) => button(
                                  context: context,
                                  text: "Send Meal",
                                  color: Colors.transparent,
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.get(context).addFood(
                                          day: int.parse(dayController.text),
                                          meal: mealController.text,
                                          mealNumber: int.parse(
                                              mealNumberController.text),
                                          mealTime: mealTimeController.text,
                                          id: id);
                                    }
                                  }),
                              fallback: (context) => const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
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
    }, listener: (context, state) {
      if (state is SuccessfullyAddFoodState) {
        mealController.clear();
        mealNumberController.clear();
        Fluttertoast.showToast(
            msg: "Meal added successfully", backgroundColor: Colors.green);
      } else if (state is ErrorAddFoodState) {
        Fluttertoast.showToast(
            msg: "Meal added failed", backgroundColor: Colors.red);
      }
    });
  }
}
