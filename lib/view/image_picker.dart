import 'dart:io';

import 'package:authetication_with_google/bloc/image_picker/image_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authetication/authentication_bloc.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _imagesPickerBloc = BlocProvider.of<ImagesPickerBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: BlocBuilder<ImagesPickerBloc, ImagesPickerState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case None: 
              case ImagesPickerState:
                return GridView.count(
                  padding: const EdgeInsets.all(15),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    InkWell(
                      onTap: () => _imagesPickerBloc.add(FirstImagePicked()),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                        ),
                        child: state.firstImage != null && state.firstImage != File("")
                            ? Image.file(
                                state.firstImage!,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              )
                            : const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                    InkWell(
                      onTap: () => _imagesPickerBloc.add(SecondImagePicked()),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                        ),
                        child: state.secondImage != null && state.secondImage != File("")
                            ? Image.file(
                                state.secondImage!,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              )
                            : const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                    InkWell(
                      onTap: () => _imagesPickerBloc.add(ThirdImagePicked()),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                        ),
                        child: state.thirdImage != null && state.thirdImage != File("")
                            ? Image.file(
                                state.thirdImage!,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              )
                            : const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                    InkWell(
                      onTap: () => _imagesPickerBloc.add(FourthImagePicked()),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5))),
                        child: state.fourthImage != null && state.fourthImage != File("")
                            ? Image.file(
                                state.fourthImage!,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              )
                            : const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                    InkWell(
                      onTap: () => _imagesPickerBloc.add(FifthImagePicked()),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: state.fifthImage != null && state.fifthImage != File("")
                              ? Image.file(
                                  state.fifthImage!,
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                )
                              : const Icon(Icons.camera_alt_outlined)),
                    ),
                    InkWell(
                      onTap: () => _imagesPickerBloc.add(SixthImagePicked()),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: state.sixthImage != null && state.sixthImage != File("")
                              ? Image.file(
                                  state.sixthImage!,
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                )
                              : const Icon(Icons.camera_alt_outlined)),
                    ),
                  ],
                );
              case Error:
                return const Text("Ocorreu um erro no servidor");
              default:
                print(state.runtimeType);
                return const Text("Estado inválido");
            }
          },
        ),
      ),
    );
  }
}
