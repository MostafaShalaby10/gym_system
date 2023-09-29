import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/user/questionaire/formFour.dart';
import 'package:gym_system/pages/user/questionaire/formThree.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';

class FormOne extends StatefulWidget {
  const FormOne({Key? key}) : super(key: key);

  @override
  State<FormOne> createState() => _FormOneState();
}

class _FormOneState extends State<FormOne> {
  final TextEditingController ageController = TextEditingController();

  final TextEditingController weightController = TextEditingController();

  final TextEditingController heightController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool male = false;

  bool female = false;

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
                        image: SharedPrefs.getData(key: "Gender")=="Female"?"lib/assets/images/f1.jpg":"lib/assets/images/gemy9.jpg"),

                    ConditionalBuilder(condition: state is! LoadingGetUserDataState, builder: (context)=>SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              textField(
                                context,
                                text: "السن",
                                prefixIcon: Icons.numbers,
                                controller: ageController,
                                type: TextInputType.number,

                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textField(
                                context,
                                text: "الطول",
                                prefixIcon: Icons.height_outlined,
                                controller: heightController,
                                type: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              textField(
                                context,
                                text: "وزنك ع معده فاضيه ",
                                prefixIcon: Icons.numbers,
                                controller: weightController,
                                type: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                color: backgroundColor,
                                child: Row(
                                  children: [
                                    const Text("What is your gender"),
                                    checkBoxItem(
                                      context,
                                        function: (value) {
                                          setState(() {
                                            male = !male;
                                            if(male) {
                                              female = false ;
                                            }
                                          });
                                        },
                                        text: "Male",
                                        value: male),
                                    checkBoxItem(
                                      context,
                                        function: (value) {
                                          setState(() {
                                            female = !female;
                                            if(female) {
                                              male = false ;
                                            }
                                          });
                                        },
                                        text: "Female",
                                        value: female),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              if(male || female)
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
                                        MediaQuery.of(context).size.height /
                                            13,
                                        function: () {
                                          if (formKey.currentState!.validate()) {
                                            cubit.get(context).dataMap.addAll({
                                              "Age" : ageController.text ,
                                              "Weight" : weightController.text ,
                                              "Height" : heightController.text ,
                                              "Gender" : male?"Male":"Female"
                                            });

                                             if(male){
                                               Navigator.push(
                                                   context,
                                                   MaterialPageRoute(
                                                       builder: (context) =>
                                                           FormThree()));
                                             }else{
                                               Navigator.push(
                                                   context,
                                                   MaterialPageRoute(
                                                       builder: (context) =>
                                                           const FormFour()));
                                             }

                                          }
                                        }),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ), fallback: (context)=>const Center(child: CircularProgressIndicator()))
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
