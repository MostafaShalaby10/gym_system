import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/user/questionaire/formFour.dart';

class FormThree extends StatelessWidget {
  FormThree({Key? key}) : super(key: key);
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
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
                backgroundImage(context, image: "lib/assets/images/gemy9.jpg"),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text(
                          "صور لشكل جسمك الحالي في اضاءه واضحه  ",
                          maxLines: 4,
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "استني لحد ما الصوره تظهر هنا ",
                          maxLines: 4,
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'please enter your photo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  cubit.get(context).uploadBodyPhoto();
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.images,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Row(
                              children: [
                                Image(
                                    image: NetworkImage(
                                        cubit.get(context).bodyPhotoURL[index]),
                                    height:
                                        MediaQuery.of(context).size.height / 2),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            itemCount: cubit.get(context).bodyPhotoURL.length,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ConditionalBuilder(
                                condition: state is! LoadingUploadBodyPhotoOnline || state is! LoadingGetBodyPhotoOnline,
                                builder: (context) => button(
                                    context: context,
                                    text: "Next",
                                    color: Colors.transparent,
                                    minWidth:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    function: () {
                                      cubit.get(context).dataMap.addAll({
                                        "photosOfBody":
                                            cubit.get(context).bodyPhotoURL
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FormFour()));

                                      if (kDebugMode) {
                                        print(cubit.get(context).dataMap);
                                      }
                                    }),
                                fallback: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    )),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (kDebugMode) {
        print(state.runtimeType);
      }
    });
  }
}
