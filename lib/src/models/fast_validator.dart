import 'package:fast_validator/src/models/validation_result.dart';

/// [FastValidation] is the base class of any FastValidator.
/// [customMessage] is the error message which the user can give. This error message overrides the built-in error message
/// [validate] function validates the given data. The "fieldName" param name of the filed. If the "fieldName" is given
/// the build-in error message will be concatenated with the "fieldName"
abstract class FastValidation {
  String? customMessage;

  ValidationResult<T> validate<T>(T toValidate, String? fieldName);
}
