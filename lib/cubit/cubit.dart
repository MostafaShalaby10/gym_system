// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/constants.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/models/datamodel.dart';
import 'package:gym_system/models/exercisemodel.dart';
import 'package:gym_system/models/foodmodel.dart';
import 'package:gym_system/models/foodreplacementmodel.dart';
import 'package:gym_system/models/supplementmodel.dart';
import 'package:gym_system/models/usermodel.dart';
import 'package:gym_system/models/videosmodel.dart';
import 'package:gym_system/sharedPrefrences/sharedPrefrences.dart';

import 'package:image_picker/image_picker.dart';

class cubit extends Cubit<States> {
  cubit() : super(InitialState());



  static cubit get(context) => BlocProvider.of(context);
  List<dynamic> exercise = [];
  List<dynamic> food = [];
  Set<String> favoriteFoods = {};
  List<dynamic> links = [];
  List<dynamic> users = [];
  Map<String, dynamic> userData = {};
  UserModel? userModel;
  DataModel? dataModel;
  ExerciseModel? exerciseModel;
  Map<String, dynamic> dataMap = {};

  void signUp(
      {
      required String email,
      required String password,
      required String name,
      required String date,
      required String phone}) {
    emit(LoadingSignUpState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          name: name,
          email: email,
          id: value.user!.uid,
          phone: phone,
          date: date);
      emit(SuccessfullySignUpState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorSignUpState(error.toString()));
    });
  }

  void createUser(
      {required String name,
      required String email,
      required String id,
      required String date,
      required String phone}) {
    userModel = UserModel(
      name: name,
      id: id,
      phone: phone,
      email: email,
      dateTime: date,
    );
    emit(LoadingCreateUserState());
    FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .set(userModel!.tomap())
        .then((value) {
      emit(SuccessfullyCreateUserState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorCreateUserState());
    });
  }

  void login({required String email, required String password}) async {
    emit(LoadingLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      SharedPrefs.saveData(key: "uid", value: value.user!.uid);
      await getSpecificUserData();
      await getUserData(id: value.user!.uid);
      emit(SuccessfullyLoginState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorLoginState(error.toString()));
    });
  }

  void getAllUsers() {
    users = [];
    emit(LoadingGetUsersState());
    FirebaseFirestore.instance
        .collection("Users")
        .orderBy("dateTime", descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (SharedPrefs.getData(key: "uid") != element.data()["id"]) {
          users.add(UserModel.fromjson(element.data()));
        }
      }
      emit(SuccessfullyGetUsersState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetUsersState(error.toString()));
    });
  }

  Future getSpecificUserData() {
    users = [];
    emit(LoadingGetSpecificUserDataState());
    return FirebaseFirestore.instance.collection("Users").get().then((value) {
      for (var element in value.docs) {
        if (SharedPrefs.getData(key: "uid") == element.data()["id"]) {
          nameOfUser = element.data()["name"];
        }
      }
      emit(SuccessfullyGetSpecificUserDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetSpecificUserDataState(error.toString()));
    });
  }

  void enterUserData() async {
    dataModel = DataModel(map: dataMap);
    emit(LoadingEnterUserDataState());
    FirebaseFirestore.instance
        .collection("Users")
        .doc(SharedPrefs.getData(key: "uid"))
        .collection("data")
        .doc("data")
        .set(dataModel!.tomap())
        .then((value) async {
      await getUserData(id: SharedPrefs.getData(key: "uid"));
      emit(SuccessfullyEnterUserDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorEnterUserDataState(error.toString()));
    });
  }

  Future getUserData({required String id}) async {
    userData = {};
    emit(LoadingGetUserDataState());
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .collection("data")
        .doc("data")
        .get()
        .then((value) {
      userData = value.data()!;
          SharedPrefs.saveData(key: "Gender", value: userData["map"]["Gender"]);
      emit(SuccessfullyGetUserDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetUserDataState(error.toString()));
    });
  }

  void addExercise(
      {required int day,
      required String exercise,
      required int exerciseNumber,
      required String link,
      required String rest,
      required String additionalLink,
      required String id}) async {
    await getExercise(id: id, index: day - 1);
    bigMap.addAll({
      "EX $exerciseNumber": [
        exercise,
        link,
        additionalLink == "" ? null : additionalLink,
        rest
      ]
    });
    exerciseModel = ExerciseModel(day: "Day $day", map: bigMap);
    emit(LoadingAddExerciseState());
    FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .collection("Exercise")
        .doc("Day $day")
        .set(exerciseModel!.tomap())
        .then((value) {
      emit(SuccessfullyAddExerciseState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorAddExerciseState(error.toString()));
    });
  }

  Map<String, dynamic> bigMap = {};

  Future getExercise({required String id, int index = 0}) {
    bigMap = {};
    exercise = [];
    links = [];
    emit(LoadingGetExerciseState());
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .collection("Exercise")
        .get()
        .then((value) async {
      for (var element in value.docs) {
        exercise.add(ExerciseModel.fromjson(element.data()));
      }

      bigMap.addAll(exercise[index].map);

      emit(SuccessfullyGetExerciseState());
    }).catchError((error) {
      emit(ErrorGetExerciseState(error.toString()));
    });
  }

  List<File> bodyPhoto = [];
  final picker = ImagePicker();

  Future<void> uploadBodyPhoto() async {
    final profilePhoto = await picker.pickMultiImage();
    List<XFile> xFilePick = profilePhoto;
    if (xFilePick.isNotEmpty) {
      for (int i = 0; i < xFilePick.length; i++) {
        bodyPhoto.add(File(xFilePick[i].path));
      }
      uploadBodyPhotoOnline();
      emit(SuccessfullyUploadBodyPhoto());
    } else {
      if (kDebugMode) {
        print("There is no image");
      }
      emit(ErrorUploadBodyPhoto());
    }
  }

  List<String> bodyPhotoURL = [];

  void uploadBodyPhotoOnline() async {
    // profileFlag = true ;
    emit(LoadingUploadBodyPhotoOnline());
    for (int i = 0; i < bodyPhoto.length; i++) {
      await FirebaseStorage.instance
          .ref()
          .child(
              "Users/$nameOfUser/bodyPhotos/${Uri.file(bodyPhoto[i].path).pathSegments.last}")
          .putFile(bodyPhoto[i])
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          getBodyImagesUrl();
          emit(SuccessfullyUploadBodyPhotoOnline());
        }).catchError((error) {
          if (kDebugMode) {
            print(error.toString());
          }
          emit(ErrorUploadBodyPhotoOnline(error.toString()));
        });
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(ErrorUploadBodyPhotoOnline(error.toString()));
      });
    }
  }

  void getBodyImagesUrl() async {
    bodyPhotoURL = [];
    emit(LoadingGetBodyPhotoOnline());
    await FirebaseStorage.instance
        .ref()
        .child("Users/$nameOfUser/bodyPhotos/")
        .listAll()
        .then((value) {
      value.items.forEach((element) async {
        final String test = await element.getDownloadURL();
        bodyPhotoURL.add(test);
        emit(SuccessfullyGetBodyPhotoOnline());
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetBodyPhotoOnline(error.toString()));
    });
  }

  List<File> supplementsPhoto = [];

  Future<void> uploadSupplementsPhoto() async {
    final profilePhoto = await picker.pickMultiImage();
    List<XFile> xFilePick = profilePhoto;
    if (xFilePick.isNotEmpty) {
      for (int i = 0; i < xFilePick.length; i++) {
        supplementsPhoto.add(File(xFilePick[i].path));
      }
      uploadSupplementsPhotoOnline();
      emit(SuccessfullyUploadSupplementsPhoto());
    } else {
      if (kDebugMode) {
        print("There is no image");
      }
      emit(ErrorUploadSupplementsPhoto());
    }
  }

  List<String> supplementsPhotoURL = [];

  void uploadSupplementsPhotoOnline() async {
    // profileFlag = true ;
    emit(LoadingUploadSupplementsPhotoOnline());
    for (int i = 0; i < supplementsPhoto.length; i++) {
      await FirebaseStorage.instance
          .ref()
          .child(
              "Users/$nameOfUser/supplementsPhoto/${Uri.file(supplementsPhoto[i].path).pathSegments.last}")
          .putFile(supplementsPhoto[i])
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          getSupplementsImagesUrl();
          emit(SuccessfullyUploadSupplementsPhotoOnline());
        }).catchError((error) {
          if (kDebugMode) {
            print(error.toString());
          }
          emit(ErrorUploadSupplementsPhotoOnline(error.toString()));
        });
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(ErrorUploadSupplementsPhotoOnline(error.toString()));
      });
    }
  }

  void getSupplementsImagesUrl() async {
    supplementsPhotoURL = [];
    emit(LoadingGetSupplementsPhotoOnline());
    await FirebaseStorage.instance
        .ref()
        .child("Users/$nameOfUser/supplementsPhoto/")
        .listAll()
        .then((value) {
      value.items.forEach((element) async {
        final String test = await element.getDownloadURL();
        supplementsPhotoURL.add(test);

        emit(SuccessfullyGetSupplementsPhotoOnline());
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetSupplementsPhotoOnline(error.toString()));
    });
  }

  FoodModel? foodModel;

  Map<String, dynamic> bigFoodMap = {};

  void addFood(
      {required int day,
      required String meal,
      required String mealTime,
      required int mealNumber,
      required String id}) async {
    await getExercise(id: id, index: day - 1);
    await getFood(id: id, index: day - 1);
    bigFoodMap.addAll({
      "Meal $mealNumber": [meal, mealTime]
    });
    foodModel = FoodModel(day: "Day $day", map: bigFoodMap);
    emit(LoadingAddFoodState());
    FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .collection("Food")
        .doc("Day $day")
        .set(foodModel!.tomap())
        .then((value) {
      emit(SuccessfullyAddFoodState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorAddFoodState(error.toString()));
    });
  }

  Future getFood({required String id, int index = 0}) {
    bigFoodMap = {};
    food = [];
    emit(LoadingGetFoodState());
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .collection("Food")
        .get()
        .then((value) {
      for (var element in value.docs) {
        food.add(FoodModel.fromjson(element.data()));
      }

      bigFoodMap.addAll(food[index].map);
      emit(SuccessfullyGetFoodState());
    }).catchError((error) {
      emit(ErrorGetFoodState(error.toString()));
    });
  }

  void resetPassword({required String email}) {
    emit(LoadingResetPassword());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(SuccessfullyResetPassword());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorResetPassword(error.toString()));
    });
  }

  SupplementModel? supplementModel;

  Map<String, dynamic> supplementMap = {};

  void addSupplement(
      {required String supplement,
      required String supplementTime,
      required int supplementNumber,
      required String id}) async {
    await getSupplement(id: id);
    supplementMap.addAll({
      "supp $supplementNumber": [supplement, supplementTime]
    });
    supplementModel = SupplementModel(map: supplementMap);
    emit(LoadingAddSupplementState());
    FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .collection("Supplement")
        .doc("Supplement")
        .set(supplementModel!.tomap())
        .then((value) {
      emit(SuccessfullyAddSupplementState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorAddSupplementState(error.toString()));
    });
  }

  Future getSupplement({required String id, int index = 0}) {
    supplementMap = {};
    emit(LoadingGetSupplementState());
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .collection("Supplement")
        .doc("Supplement")
        .get()
        .then((value) {
      supplementMap.addAll(value["map"]);

      emit(SuccessfullyGetSupplementState());
    }).catchError((error) {
      emit(ErrorGetSupplementState(error.toString()));
    });
  }

  VideoModel? videoModel;

  void createVideoLink({required String name, required String link}) {
    videoModel = VideoModel(link: link, name: name);
    emit(LoadingCreateVideoLink());
    FirebaseFirestore.instance
        .collection("Videos")
        .doc(name)
        .set(videoModel!.tomap())
        .then((value) {
      emit(SuccessfullyCreateVideoLink());
    }).catchError((error) {
      emit(ErrorCreateVideoLink(error.toString()));
    });
  }

  List<dynamic> videosLinks = [];

  void getVideoLink() {
    videosLinks = [];
    emit(LoadingGetVideoLink());
    FirebaseFirestore.instance.collection("Videos").get().then((value) {
      for (var element in value.docs) {
        videosLinks.add(VideoModel.fromjson(element.data()));
      }
      // print(videosLinks.length);
      emit(SuccessfullyGetVideoLink());
    }).catchError((error) {
      emit(ErrorGetVideoLink(error.toString()));
    });
  }

  FoodReplacementModel? foodReplacementModel;

  void createFoodReplacement({required String food1, required String food2}) {
    foodReplacementModel = FoodReplacementModel(food1: food1, food2: food2);
    emit(LoadingCreateFoodReplacement());
    FirebaseFirestore.instance
        .collection("Food Replacement")
        .doc()
        .set(foodReplacementModel!.tomap())
        .then((value) {
      emit(SuccessfullyCreateFoodReplacement());
    }).catchError((error) {
      emit(ErrorCreateFoodReplacement(error.toString()));
    });
  }

  List<dynamic> foodReplacements = [];

  void getFoodReplacement() {
    foodReplacements = [];
    emit(LoadingGetFoodReplacement());
    FirebaseFirestore.instance
        .collection("Food Replacement")
        .get()
        .then((value) {
      for (var element in value.docs) {
        foodReplacements.add(FoodReplacementModel.fromjson(element.data()));
      }
      // print(videosLinks.length);
      emit(SuccessfullyGetFoodReplacement());
    }).catchError((error) {
      emit(ErrorGetFoodReplacement(error.toString()));
    });
  }

  void addFavoriteFood({required String item}) {
    favoriteFoods.add(item);
    emit(AddItemState());
  }

  void removeFavoriteFood({required String item}) {
    favoriteFoods.remove(item);
    emit(RemoveItemState());
  }

}
