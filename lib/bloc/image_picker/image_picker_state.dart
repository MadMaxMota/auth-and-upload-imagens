part of 'image_picker_bloc.dart';

class ImagesPickerState {
  final File? firstImage;
  final File? secondImage;
  final File? thirdImage;
  final File? fourthImage;
  final File? fifthImage;
  final File? sixthImage;

  ImagesPickerState({
    this.firstImage,
    this.secondImage,
    this.thirdImage,
    this.fourthImage,
    this.fifthImage,
    this.sixthImage,
  });
}

class None extends ImagesPickerState{}

class Error extends ImagesPickerState{}

class Success extends ImagesPickerState{}