part of 'image_picker_bloc.dart';

@immutable
abstract class ImagesPickerEvent extends Equatable {
  const ImagesPickerEvent();

  @override
  List<Object> get props => [];
}

class FirstImagePicked extends ImagesPickerEvent {}

class SecondImagePicked extends ImagesPickerEvent {}

class ThirdImagePicked extends ImagesPickerEvent {}

class FourthImagePicked extends ImagesPickerEvent {}

class FifthImagePicked extends ImagesPickerEvent {}

class SixthImagePicked extends ImagesPickerEvent {}
