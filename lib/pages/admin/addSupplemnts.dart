import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';

class AddSupplements extends StatelessWidget {
  final String id;

  AddSupplements({Key? key, required this.id}) : super(key: key);
  final TextEditingController supplementController = TextEditingController();
  final TextEditingController supplementNumberController =
      TextEditingController();
  final TextEditingController supplementTimeController =
      TextEditingController();
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
                backgroundImage(context, image: "lib/assets/images/gemy6.jpg"),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          textField(context,
                              text: "Enter the supplement Number",
                              prefixIcon: Icons.numbers,
                              controller: supplementNumberController,
                              type: TextInputType.number),
                          const SizedBox(
                            height: 10,
                          ),
                          textField(context,
                              maxLines: 8,
                              text: "Enter the supplement",
                              prefixIcon: Icons.medical_services_rounded,
                              controller: supplementController,
                              type: TextInputType.text),
                          const SizedBox(
                            height: 10,
                          ),
                          textField(context,
                              text: "الجرعه",
                              prefixIcon: Icons.timer,
                              controller: supplementTimeController,
                              type: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoadingAddSupplementState,
                              builder: (context) => button(
                                  context: context,
                                  text: "Send supplement",
                                  color: Colors.transparent,
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.get(context).addSupplement(
                                            supplementNumber:
                                                int.parse(supplementNumberController.text),
                                            supplementTime:
                                                supplementTimeController.text,
                                            id: id,
                                            supplement:
                                                supplementController.text,
                                          );
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
      if (state is SuccessfullyAddSupplementState) {

        Fluttertoast.showToast(
            msg: "Supplement added successfully", backgroundColor: Colors.green);
      } else if (state is ErrorAddSupplementState) {
        Fluttertoast.showToast(
            msg: "Supplement added failed", backgroundColor: Colors.red);
      }
    });
  }
}
