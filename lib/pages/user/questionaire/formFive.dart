import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/user/homePage.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';

class FormFive extends StatefulWidget {
  const FormFive({Key? key}) : super(key: key);

  @override
  State<FormFive> createState() => _FormFiveState();
}

class _FormFiveState extends State<FormFive> {
  final TextEditingController sensitiveController = TextEditingController();

  final TextEditingController numberOfMealDailyController =
      TextEditingController();

  final TextEditingController timeOfFirstMealController =
      TextEditingController();
  final TextEditingController timeOfGymController = TextEditingController();
  String forbiddenFood = "";

  final formKey = GlobalKey<FormState>();
  bool test = true;
  bool flag1 = false;
  bool flag2 = false;
  bool flag3 = false;
  bool flag4 = false;
  bool flag5 = false;
  bool flag6 = false;

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
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                color: backgroundColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "عندك حساسيه من اكل معين ",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Row(
                                      children: [
                                        radioButton(context,
                                            text: "YES",
                                            value: "yes",
                                            groupValue: forbiddenFood
                                                .toString(), function: (value) {
                                          setState(() {
                                            forbiddenFood = value.toString();
                                          });
                                        }),
                                        radioButton(context,
                                            text: "NO",
                                            value: "no",
                                            groupValue: forbiddenFood
                                                .toString(), function: (value) {
                                          setState(() {
                                            forbiddenFood = value.toString();
                                          });
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (forbiddenFood == "yes")
                                Column(
                                  children: [
                                    textField(context,
                                        text: "اكتب الاكل اللي عندك حساسيه منه",
                                        prefixIcon: Icons.no_food_outlined,
                                        controller: sensitiveController,
                                        type: TextInputType.text),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              textField(context,
                                  text: "ممكن تاكل كام وجبه ف اليوم",
                                  prefixIcon: Icons.no_food_outlined,
                                  controller: numberOfMealDailyController,
                                  type: TextInputType.number),
                              const SizedBox(
                                height: 20,
                              ),
                              textField(context,
                                  text: "عايز اول وجبه الساعه كام",
                                  prefixIcon: Icons.no_food_outlined,
                                  controller: timeOfFirstMealController,
                                  type: TextInputType.number),
                              const SizedBox(
                                height: 20,
                              ),
                              textField(context,
                                  text: "بتروح الجيم الساعه كام",
                                  prefixIcon: Icons.no_food_outlined,
                                  controller: timeOfGymController,
                                  type: TextInputType.number),
                              const SizedBox(
                                height: 20,
                              ),

                              Container(
                                color: Colors.red[800],
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "لازم تدخل صنف واحد ع الاقل ف كل نوع",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              ///Done
                              dropDownMenu(
                                  food: [
                                    " جبنه قريش  ",
                                    "لبن ",
                                    "كبده ",
                                    "سمك ",
                                    "لحمه ",
                                    "بيض ",
                                    "فراخ"
                                  ],
                                  text: "بروتين ",
                                  function: (value) {
                                    cubit
                                        .get(context)
                                        .addFavoriteFood(item: value!);
                                    Fluttertoast.showToast(
                                        msg: '$value is added',
                                        backgroundColor: Colors.green);
                                    flag1 = true;
                                  }),

                              const SizedBox(
                                height: 30,
                              ),

                              ///Done
                              dropDownMenu(
                                  food: [
                                    " عدس   ",
                                    "فاصوليا بيضا   ",
                                    "فاصوليا حمرا  ",
                                    "حمص  ",
                                  ],
                                  text: "بروتين نباتي ",
                                  function: (value) {
                                    cubit
                                        .get(context)
                                        .addFavoriteFood(item: value!);
                                    Fluttertoast.showToast(
                                        msg: '$value is added',
                                        backgroundColor: Colors.green);
                                    flag2 = true;
                                  }),
                              const SizedBox(
                                height: 30,
                              ),

                              ///Done
                              dropDownMenu(
                                  food: [
                                    "رز",
                                    "شوفان",
                                    "بطاطس",
                                    "بطاطا",
                                    "مكرونه",
                                    "فول ",
                                    "عيش بلدي او تورتيلا"
                                  ],
                                  text: " كاربوهيدرات ",
                                  function: (value) {
                                    cubit
                                        .get(context)
                                        .addFavoriteFood(item: value!);
                                    Fluttertoast.showToast(
                                        msg: '$value is added',
                                        backgroundColor: Colors.green);
                                    flag3 = true;
                                  }),

                              const SizedBox(
                                height: 30,
                              ),

                              ///Done
                              dropDownMenu(
                                  food: [
                                    "افوكادو",
                                    "صفار بيض",
                                    "زبده فول سوداني ",
                                    "زيت زيتون",
                                    "جوز هند",
                                    "لوز  ",
                                    "كاجو  ",
                                    "عين جمل  ",
                                  ],
                                  text: "دهون صحيه",
                                  function: (value) {
                                    cubit
                                        .get(context)
                                        .addFavoriteFood(item: value!);
                                    Fluttertoast.showToast(
                                        msg: '$value is added',
                                        backgroundColor: Colors.green);
                                    flag4 = true;
                                  }),

                              const SizedBox(
                                height: 30,
                              ),

                              ///Done
                              dropDownMenu(
                                  food: [
                                    "بطيخ ",
                                    "اناناس  ",
                                    "فراوله  ",
                                    "موز  ",
                                    "تين شوكي  ",
                                    "برقوق ",
                                    "تفاح ",
                                    "مانجا ",
                                    "عنب ",
                                    "توت "
                                  ],
                                  text: "الفاكهه",
                                  function: (value) {
                                    cubit
                                        .get(context)
                                        .addFavoriteFood(item: value!);
                                    Fluttertoast.showToast(
                                        msg: '$value is added',
                                        backgroundColor: Colors.green);
                                    flag5 = true;
                                  }),

                              const SizedBox(
                                height: 30,
                              ),

                              dropDownMenu(
                                  food: [
                                    " فاصوليا خضرا   ",
                                    "بروكلي  ",
                                    "كوسه  ",
                                    "بسله  ",
                                    "جزر  ",
                                    "فلفل بجميع الالوان ",
                                    "خيار ",
                                    "طماطم  ",
                                    "خس  ",
                                    "اسبراجس  ",
                                  ],
                                  text: "خضار ",
                                  function: (value) {
                                    cubit
                                        .get(context)
                                        .addFavoriteFood(item: value!);
                                    Fluttertoast.showToast(
                                        msg: '$value is added',
                                        backgroundColor: Colors.green);
                                    flag6 = true;
                                  }),

                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 200,
                                color: backgroundColor,
                                child: ListView.builder(
                                    itemBuilder: (context, index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(cubit
                                                .get(context)
                                                .favoriteFoods
                                                .elementAt(index)),
                                            IconButton(
                                                onPressed: () {
                                                  cubit
                                                      .get(context)
                                                      .removeFavoriteFood(
                                                          item: cubit
                                                              .get(context)
                                                              .favoriteFoods
                                                              .elementAt(
                                                                  index));
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        ),
                                    itemCount: cubit
                                        .get(context)
                                        .favoriteFoods
                                        .length),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  button(
                                      context: context,
                                      text: "Finish",
                                      color: Colors.transparent,
                                      minWidth:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              13,
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          if (flag1 &&
                                              flag2 &&
                                              flag3 &&
                                              flag4 &&
                                              flag5 &&
                                              flag6) {
                                            cubit.get(context).dataMap.addAll({
                                              "forbiddenFood":
                                                  sensitiveController.text,
                                              "numberOfMeals":
                                                  numberOfMealDailyController
                                                      .text,
                                              "timeOfFirstMeal":
                                                  timeOfFirstMealController
                                                      .text,
                                              "timeOfGym":
                                                  timeOfGymController.text,
                                              "favoritesFood": cubit
                                                  .get(context)
                                                  .favoriteFoods,
                                            });
                                            SharedPrefs.saveData(
                                                key: "Gender",
                                                value: cubit
                                                    .get(context)
                                                    .dataMap["Gender"]);

                                            cubit.get(context).enterUserData();
                                            SharedPrefs.saveData(
                                                key: "user", value: true);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage()),
                                                (route) => false);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "There is empty fields",
                                                backgroundColor: Colors.red);
                                          }
                                        }
                                      }),
                                ],
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
