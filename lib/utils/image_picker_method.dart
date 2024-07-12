import 'package:image_picker/image_picker.dart';

pickImage(ImageSource src) async {
  // final ImagePickerPlatform imagePickerImplementation =
  //     ImagePickerPlatform.instance;
  // if (imagePickerImplementation is ImagePickerAndroid) {
  //   imagePickerImplementation.useAndroidPhotoPicker = true;
  // }
  final ImagePicker imagePicker = ImagePicker();
  final XFile? image = await imagePicker.pickImage(source: src);
  if (image != null) {
    return await image.readAsBytes();
  }
}
