import 'package:fast_validator/fast_validator.dart';
import 'package:fast_validator/src/models/validation_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String url1 = 'cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg';

  String? error;

  test('validate an url', () {
    ValidationResult result =
        FastValidator.validate(url1, validators: [FastUrlValidation()]);
    if (!result.valid) error = result.errorMessage;

    debugPrint(error ?? 'No error');
  });
}
