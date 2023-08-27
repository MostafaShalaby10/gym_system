abstract class States {}

class InitialState extends States {}

class LoadingSignUpState extends States {}

class SuccessfullySignUpState extends States {}

class ErrorSignUpState extends States {
  final String error;

  ErrorSignUpState(this.error);
}

class LoadingCreateUserState extends States {}

class SuccessfullyCreateUserState extends States {}

class ErrorCreateUserState extends States {}

class LoadingLoginState extends States {}

class SuccessfullyLoginState extends States {}

class ErrorLoginState extends States {
  final String error;

  ErrorLoginState(this.error);
}

class LoadingGetUsersState extends States {}

class SuccessfullyGetUsersState extends States {}

class ErrorGetUsersState extends States {
  final String error;

  ErrorGetUsersState(this.error);
}

class LoadingGetSpecificUserDataState extends States {}

class SuccessfullyGetSpecificUserDataState extends States {}

class ErrorGetSpecificUserDataState extends States {
  final String error;

  ErrorGetSpecificUserDataState(this.error);
}

class LoadingEnterUserDataState extends States {}

class SuccessfullyEnterUserDataState extends States {}

class ErrorEnterUserDataState extends States {
  final String error;

  ErrorEnterUserDataState(this.error);
}

class LoadingGetUserDataState extends States {}

class SuccessfullyGetUserDataState extends States {}

class ErrorGetUserDataState extends States {
  final String error;

  ErrorGetUserDataState(this.error);
}

class LoadingUpdateUserDataState extends States {}

class SuccessfullyUpdateUserDataState extends States {}

class ErrorUpdateUserDataState extends States {
  final String error;

  ErrorUpdateUserDataState(this.error);
}

class LoadingAddExerciseState extends States {}

class SuccessfullyAddExerciseState extends States {}

class ErrorAddExerciseState extends States {
  final String error;

  ErrorAddExerciseState(this.error);
}

class LoadingAddFoodState extends States {}

class SuccessfullyAddFoodState extends States {}

class ErrorAddFoodState extends States {
  final String error;

  ErrorAddFoodState(this.error);
}

class LoadingAddSupplementState extends States {}

class SuccessfullyAddSupplementState extends States {}

class ErrorAddSupplementState extends States {
  final String error;

  ErrorAddSupplementState(this.error);
}

class LoadingGetExerciseState extends States {}

class SuccessfullyGetExerciseState extends States {}

class ErrorGetExerciseState extends States {
  final String error;

  ErrorGetExerciseState(this.error);
}

class LoadingGetSupplementState extends States {}

class SuccessfullyGetSupplementState extends States {}

class ErrorGetSupplementState extends States {
  final String error;

  ErrorGetSupplementState(this.error);
}

class LoadingGetFoodState extends States {}

class SuccessfullyGetFoodState extends States {}

class ErrorGetFoodState extends States {
  final String error;

  ErrorGetFoodState(this.error);
}

class LoadingUploadBodyPhoto extends States {}

class SuccessfullyUploadBodyPhoto extends States {}

class ErrorUploadBodyPhoto extends States {}

class LoadingUploadBodyPhotoOnline extends States {}

class SuccessfullyUploadBodyPhotoOnline extends States {}

class ErrorUploadBodyPhotoOnline extends States {
  final String error;

  ErrorUploadBodyPhotoOnline(this.error);
}

class LoadingGetBodyPhotoOnline extends States {}

class SuccessfullyGetBodyPhotoOnline extends States {}

class ErrorGetBodyPhotoOnline extends States {
  final String error;

  ErrorGetBodyPhotoOnline(this.error);
}

class LoadingUploadSupplementsPhoto extends States {}

class SuccessfullyUploadSupplementsPhoto extends States {}

class ErrorUploadSupplementsPhoto extends States {}

class LoadingUploadSupplementsPhotoOnline extends States {}

class SuccessfullyUploadSupplementsPhotoOnline extends States {}

class ErrorUploadSupplementsPhotoOnline extends States {
  final String error;

  ErrorUploadSupplementsPhotoOnline(this.error);
}

class LoadingGetSupplementsPhotoOnline extends States {}

class SuccessfullyGetSupplementsPhotoOnline extends States {}

class ErrorGetSupplementsPhotoOnline extends States {
  final String error;

  ErrorGetSupplementsPhotoOnline(this.error);
}

class SuccessfullyRemovePhoto extends States {}

class LoadingResetPassword extends States {}

class SuccessfullyResetPassword extends States {}

class ErrorResetPassword extends States {
  final String error;

  ErrorResetPassword(this.error);
}

class LoadingCreateVideoLink extends States {}

class SuccessfullyCreateVideoLink extends States {}

class ErrorCreateVideoLink extends States {
  final String error;

  ErrorCreateVideoLink(this.error);
}

class LoadingGetVideoLink extends States {}

class SuccessfullyGetVideoLink extends States {}

class ErrorGetVideoLink extends States {
  final String error;

  ErrorGetVideoLink(this.error);
}

class LoadingCreateFemaleVideos extends States {}

class SuccessfullyCreateFemaleVideos extends States {}

class ErrorCreateFemaleVideos extends States {
  final String error;

  ErrorCreateFemaleVideos(this.error);
}

class LoadingGetFemaleVideos extends States {}

class SuccessfullyGetFemaleVideos extends States {}

class ErrorGetFemaleVideos extends States {
  final String error;

  ErrorGetFemaleVideos(this.error);
}

class LoadingCreateFoodReplacement extends States {}

class SuccessfullyCreateFoodReplacement extends States {}

class ErrorCreateFoodReplacement extends States {
  final String error;

  ErrorCreateFoodReplacement(this.error);
}

class LoadingGetFoodReplacement extends States {}

class SuccessfullyGetFoodReplacement extends States {}

class ErrorGetFoodReplacement extends States {
  final String error;

  ErrorGetFoodReplacement(this.error);
}

class AddItemState extends States {}
class RemoveItemState extends States {}

