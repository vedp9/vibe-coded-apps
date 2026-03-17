import 'package:flutter/material.dart';

class AddItemScreenModel extends ChangeNotifier {
  bool _isDataUploading = false;
  bool get isDataUploading => _isDataUploading;

  set isDataUploading(bool value) {
    _isDataUploading = value;
    notifyListeners();
  }

  String _uploadedPhotoUrl = '';
  String get uploadedPhotoUrl => _uploadedPhotoUrl;

  set uploadedPhotoUrl(String value) {
    _uploadedPhotoUrl = value;
    notifyListeners();
  }

  final FocusNode titleFieldFocusNode = FocusNode();
  final TextEditingController titleFieldTextController = TextEditingController();

  final FocusNode priceFieldFocusNode = FocusNode();
  final TextEditingController priceFieldTextController = TextEditingController();

  String? titleFieldTextControllerValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? priceFieldTextControllerValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    return null;
  }

  @override
  void dispose() {
    titleFieldFocusNode.dispose();
    titleFieldTextController.dispose();
    priceFieldFocusNode.dispose();
    priceFieldTextController.dispose();
    super.dispose();
  }
}
