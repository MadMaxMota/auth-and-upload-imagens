import 'dart:async';
import 'dart:io';

import 'package:authetication_with_google/repository/authentication/repository.dart';
import 'package:authetication_with_google/repository/storage/storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagesPickerBloc extends Bloc<ImagesPickerEvent, ImagesPickerState> {
  ImagesPickerBloc(
    this._authRepository, {
    required this.storage,
  }) : super(None()) {
    // add(SecondImagePicked(path: state.authenticationModel.uid));
  }

  @override
  Future<void> close() async {
    _authenticationSubscription?.cancel();
    return super.close();
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseStorageService firebaseStorageService = FirebaseStorageService();
  StreamSubscription? _authenticationSubscription;
  AuthenticationRepository _authRepository;
  // String? stringPath;
  
  File firstImageFile = File('');
  File secondImageFile = File('lkfknf');
  File thirdImageFile = File('');
  File fourthImageFile = File('');
  File fifthImageFile = File('');
  File sixthImageFile = File('');

  @override
  Stream<ImagesPickerState> mapEventToState(ImagesPickerEvent event) async* {
    try {
      final path = (await _authRepository.getAuthDetailStream()).uid;
      if (event is FirstImagePicked) {
        final firstPicker = ImagePicker();
        final firstPickedImage =
            await firstPicker.pickImage(source: ImageSource.gallery);
        final firstImage = File(firstPickedImage!.path);
        

        firstImageFile = firstImage;
        firebaseStorageService.uploadImage('first:$path', firstImage);
        // PickedFile pickedFile = await ImagePicker().pickImage(source: source);
      } else if (event is SecondImagePicked) {
        final secondPicker = ImagePicker();
        final secondPickedImage =
            await secondPicker.pickImage(source: ImageSource.gallery);
        final secondImage = File(secondPickedImage!.path);

        secondImageFile = secondImage;

        firebaseStorageService.uploadImage('second:$path', secondImage);
        // PickedFile pickedFile = await ImagePick
      } else if (event is ThirdImagePicked) {
        final thirdPicker = ImagePicker();
        final thirdPickedImage =
            await thirdPicker.pickImage(source: ImageSource.gallery);
        final thirdImage = File(thirdPickedImage!.path);

        thirdImageFile = thirdImage;

        // firebaseStorageService.uploadImage(event.path, newImage);
        // PickedFile pickedFile = await ImagePick
      } else if (event is FourthImagePicked) {
        final fourthPicker = ImagePicker();
        final fourthPickedImage =
            await fourthPicker.pickImage(source: ImageSource.gallery);
        final fourthImage = File(fourthPickedImage!.path);

        fourthImageFile = fourthImage;

        // firebaseStorageService.uploadImage(event.path, newImage);
        // PickedFile pickedFile = await ImagePick
      } else if (event is FifthImagePicked) {
        final fifthPicker = ImagePicker();
        final fifthPickedImage =
            await fifthPicker.pickImage(source: ImageSource.gallery);
        final fifthImage = File(fifthPickedImage!.path);

        fifthImageFile = fifthImage;

        // firebaseStorageService.uploadImage(event.path, newImage);
        // PickedFile pickedFile = await ImagePick
      } else if (event is SixthImagePicked) {
        final sixthPicker = ImagePicker();
        final sixthPickedImage =
            await sixthPicker.pickImage(source: ImageSource.gallery);
        final sixthImage = File(sixthPickedImage!.path);

        sixthImageFile = sixthImage;

        // firebaseStorageService.uploadImage(event.path, newImage);
        // PickedFile pickedFile = await ImagePick
      }

      

      yield ImagesPickerState(
        firstImage: firstImageFile,
        secondImage: secondImageFile,
        thirdImage: thirdImageFile,
        fourthImage: fourthImageFile,
        fifthImage: fifthImageFile,
        sixthImage: sixthImageFile,
      );
      // emit(Success());
    } catch (e) {
      emit(Error());
    }
  }
}
