import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/user/homePage.dart';
import 'package:gym_system/pages/user/questionaire/formFive.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';

class FormFour extends StatefulWidget {
  const FormFour({Key? key}) : super(key: key);

  @override
  State<FormFour> createState() => _FormFourState();
}

class _FormFourState extends State<FormFour> {
  final TextEditingController goalController = TextEditingController();

  final TextEditingController timesOfGymDailyController =
      TextEditingController();
  final TextEditingController timesOfGymWeeklyController =
      TextEditingController();
  final TextEditingController historyOfGymController = TextEditingController();
  final TextEditingController supplementNameController =
      TextEditingController();
  final TextEditingController historyOfInjuryController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  String gymHistory = "";
  String injuryHistory = "";
  String supplementsHistory = "";

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
                backgroundImage(context,
                image: SharedPrefs.getData(key: "Gender")=="Female"?"lib/assets/images/f2.jpg":"lib/assets/images/gemy9.jpg"),

                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          textField(
                            context,
                            text: "الهدف بتاعك ايه",
                            prefixIcon: Icons.add,
                            controller: goalController,
                            type: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: backgroundColor,

                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("روحت جيم قبل كدا ؟ " , style: TextStyle(fontSize: 17),),
                                ),

                                Row(
                                  children: [
                                    radioButton(context,
                                        text: "YES",
                                        value: "yes",
                                        groupValue: gymHistory.toString(),
                                        function: (value) {
                                      setState(() {
                                        gymHistory = value.toString();
                                      });
                                    }),
                                    radioButton(context,
                                        text: "NO",
                                        value: "no",
                                        groupValue: gymHistory.toString(),
                                        function: (value) {
                                      setState(() {
                                        gymHistory = value.toString();
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
                          if (gymHistory == "yes")
                            Column(
                              children: [
                                textField(
                                  context,
                                  text: "بتتمرن بقالك قد ايه",
                                  prefixIcon: Icons.height_outlined,
                                  controller: historyOfGymController,
                                  type: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                textField(
                                  context,
                                  text: "تقدر تروح الجيم كام يوم ف الاسبوع",
                                  prefixIcon: Icons.height_outlined,
                                  controller: timesOfGymWeeklyController,
                                  type: TextInputType.number,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                textField(
                                  context,
                                  text: "تقدر تروح الجيم كام مره ف اليوم",
                                  prefixIcon: Icons.height_outlined,
                                  controller: timesOfGymDailyController,
                                  type: TextInputType.number,
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            color: backgroundColor,
                            child: Column(

                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("عندك اصابات قبل كدا" , style: TextStyle(fontSize: 17),),
                                ),

                                Row(
                                  children: [
                                    radioButton(context,
                                        text: "YES",
                                        value: "yes",
                                        groupValue: injuryHistory.toString(),
                                        function: (value) {
                                      setState(() {
                                        injuryHistory = value.toString();
                                      });
                                    }),
                                    radioButton(context,
                                        text: "NO",
                                        value: "no",
                                        groupValue: injuryHistory.toString(),
                                        function: (value) {
                                      setState(() {
                                        injuryHistory = value.toString();
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
                          if (injuryHistory == "yes")
                            Column(
                              children: [
                                textField(
                                  context,
                                  text: "ايه هي الاصابه حتي لو بسيطه",
                                  prefixIcon: Icons.height_outlined,
                                  controller: historyOfInjuryController,
                                  type: TextInputType.text,
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: backgroundColor,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,

                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("عايز تستخدم مكملات " , style: TextStyle(fontSize: 17),),
                                ),

                                Row(
                                  children: [
                                    radioButton(context,
                                        text: "YES",
                                        value: "yes",
                                        groupValue: supplementsHistory.toString(),
                                        function: (value) {
                                      setState(() {
                                        supplementsHistory = value.toString();
                                      });
                                    }),
                                    radioButton(context,
                                        text: "NO",
                                        value: "no",
                                        groupValue: supplementsHistory.toString(),
                                        function: (value) {
                                      setState(() {
                                        supplementsHistory = value.toString();
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
                          if (supplementsHistory == "yes")
                            Column(
                              children: [
                                textField(context,
                                    text: "اكتب اسمه",
                                    prefixIcon: Icons.support,
                                    controller: supplementNameController,
                                    type: TextInputType.text),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text('please enter photo of supplement'),
                                    IconButton(
                                        onPressed: () {
                                          cubit
                                              .get(context)
                                              .uploadSupplementsPhoto();
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.images,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        Image(
                                            image: NetworkImage(cubit
                                                .get(context)
                                                .supplementsPhotoURL[index]),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    itemCount: cubit
                                        .get(context)
                                        .supplementsPhotoURL
                                        .length,
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              button(
                                  context: context,
                                  text: "Next",
                                  color: Colors.transparent,
                                  minWidth:
                                      MediaQuery.of(context).size.width / 3,
                                  height:
                                      MediaQuery.of(context).size.height / 13,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      if (gymHistory != "" &&
                                          injuryHistory != "" &&
                                          supplementsHistory != "") {
                                        cubit.get(context).dataMap.addAll({
                                          "photosOfSupplements": cubit
                                              .get(context)
                                              .supplementsPhotoURL,
                                          "supplementName":
                                              supplementNameController.text,
                                          "Goal": goalController.text,
                                          "historyOfGym": gymHistory,
                                          "historyOfGymText":
                                              historyOfGymController.text,
                                          "historyOfSupplements":
                                              supplementsHistory,
                                          "historyOfInjury": injuryHistory,
                                          "historyOfInjuryText":
                                              historyOfInjuryController.text,
                                          "timesOfGymDaily":
                                              timesOfGymDailyController.text,
                                          "timesOfGymWeekly":
                                              timesOfGymWeeklyController.text,
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FormFive()));
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
                )
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SuccessfullyEnterUserDataState) {
        SharedPrefs.saveData(key: "data", value: true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      } else if (state is ErrorEnterUserDataState) {
        Fluttertoast.showToast(
            msg: "Error in enter data", backgroundColor: Colors.red);
      }
    });
  }
}
