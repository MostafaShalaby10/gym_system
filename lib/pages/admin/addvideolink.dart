import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';

class AddVideoLink extends StatelessWidget {

  AddVideoLink({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController linkController = TextEditingController();


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
                backgroundImage(context, image: "lib/assets/images/gemy5.jpg"),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          textField(context,
                              text: "Enter the name of video",
                              prefixIcon: Icons.text_fields_rounded,
                              controller: nameController,
                              type: TextInputType.text),
                          const SizedBox(
                            height: 10,
                          ),
                          textField(context,
                              text: "Enter the Link",
                              prefixIcon: Icons.link,
                              controller: linkController,
                              type: TextInputType.text),
                          const SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoadingCreateVideoLink,
                              builder: (context) => button(
                                  context: context,
                                  text: "Send Video",
                                  color: Colors.transparent,
                                  minWidth:
                                  MediaQuery.of(context).size.width / 2,
                                  height:
                                  MediaQuery.of(context).size.height / 10,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.get(context).createVideoLink(
                                         name: nameController.text , link: linkController.text);
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
      if (state is SuccessfullyCreateVideoLink) {

        Fluttertoast.showToast(
            msg: "video added successfully", backgroundColor: Colors.green);
      } else if (state is ErrorCreateVideoLink) {
        Fluttertoast.showToast(
            msg: "video added failed", backgroundColor: Colors.red);
      }
    });
  }
}
