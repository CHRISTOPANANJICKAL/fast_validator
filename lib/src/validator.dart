import 'package:fast_validator/src/built_in_validators.dart';
import 'models/result_type.dart';
import 'models/fast_validator.dart';
import 'models/validation_result.dart';

/// [FastValidator] is responsible for doing all the validations.

class FastValidator {
  /// [validate] function is the validator function. This functions validates the [toValidate] against the [validators]
  /// and returns the output immediately if any of the validation failed.
  static ValidationResult<T> validate<T>(
    T toValidate, {
    String? fieldName,
    required List<FastValidation> validators,
  }) {
    ValidationResult<T> validOutput = ValidationResult<T>(
      result: toValidate,
      errorMessage: null,
      type: ResultType.valid,
      valid: true,
    );

    bool isRequired = validators.map((e) => e.runtimeType).contains(FastRequiredValidation);

    if (!isRequired && (toValidate == null || toValidate.toString().isEmpty)) {
      validOutput.type = ResultType.validWithNoValue;

      return validOutput;
    }

    if (validators.isNotEmpty) {
      for (final validator in validators) {
        ValidationResult<T> result = validator.validate<T>(toValidate, fieldName);

        if (!result.valid) {
          validOutput = result;
          break;
        }
      }
    }

    return validOutput;
  }

  /// [validate] function is the validator function which validates the [toValidate] against all the [validators]
  /// and returns the List output after validating all the conditions.
  static ValidationAllResult<T> validateAll<T>(
    T toValidate, {
    String? fieldName,
    required List<FastValidation> validators,
  }) {
    ValidationAllResult<T> validAllOutput = ValidationAllResult<T>(
      result: toValidate,
      type: ResultType.valid,
      valid: true,
      allErrorMessage: [],
    );

    bool isRequired = validators.map((e) => e.runtimeType).contains(FastRequiredValidation);

    if (!isRequired && (toValidate == null || toValidate.toString().isEmpty)) {
      validAllOutput.type = ResultType.validWithNoValue;

      return validAllOutput;
    }

    List<ValidationResult<T>> results = [];

    if (validators.isNotEmpty) {
      for (final validator in validators) {
        ValidationResult<T> result = validator.validate<T>(toValidate, fieldName);

        if (!result.valid) {
          // set the output to error at first-time (isEmpty check is done to do this step only once)
          if (results.isEmpty) {
            validAllOutput.valid = false;
            validAllOutput.type = ResultType.invalid;
          }

          results.add(result);
        }
      }
    }

    validAllOutput.allErrorMessage = results;

    return validAllOutput;
  }
}
