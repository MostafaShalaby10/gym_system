
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';
import 'package:url_launcher/url_launcher.dart';

class Videos extends StatelessWidget {
  const Videos({Key? key}) : super(key: key);

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
                        image:SharedPrefs.getData(key: "Gender")=="Male"? "lib/assets/images/gemy3.jpg":"lib/assets/images/f2.jpg"),
                    ConditionalBuilder(
                        condition: state is! LoadingGetVideoLink,
                        builder: (context) => cubit
                                .get(context)
                                .videosLinks
                                .isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                color: Colors.teal
                                                    .withOpacity(0.5),
                                                child: Text(
                                                  '${cubit.get(context).videosLinks[index].name}',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  launch(cubit
                                                      .get(context)
                                                      .videosLinks[index]
                                                      .link);
                                                },
                                                icon: const Icon(
                                                  FontAwesomeIcons.youtube,
                                                  color: Colors.white,
                                                  size: 35,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                itemCount:
                                    cubit.get(context).videosLinks.length,
                              )
                            : const Text(
                                "Coming soon 😉",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                        fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
