import 'models/result_type.dart';
import 'models/fast_validator.dart';
import 'models/validation_result.dart';

/// [FastRequiredValidation] is used to do required validation on a filed. Null and empty fields are also considered as invalid.
class FastRequiredValidation implements FastValidation {
  FastRequiredValidation({this.customMessage});

  @override
  String? customMessage;

  @override
  validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (dataToValidate == null ||
        (dataToValidate.runtimeType == String &&
            dataToValidate.toString().isEmpty)) {
      errorMessage =
          customMessage ?? '${fieldName ?? 'this field'} is required';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastMinLengthValidation] is used to validate minimum length of a string
class FastMinLengthValidation implements FastValidation {
  final int minLength;
  FastMinLengthValidation({required this.minLength, this.customMessage});

  @override
  String? customMessage;

  @override
  validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (dataToValidate.runtimeType != String ||
        dataToValidate.toString().length < minLength) {
      errorMessage = customMessage ??
          'minimum length of ${fieldName ?? 'this field'} must be $minLength';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastMaxLengthValidation] is used to validate maximum length of a string
class FastMaxLengthValidation implements FastValidation {
  final int maxLength;
  FastMaxLengthValidation({required this.maxLength, this.customMessage});

  @override
  String? customMessage;

  @override
  validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (dataToValidate.runtimeType != String ||
        dataToValidate.toString().length > maxLength) {
      errorMessage = customMessage ??
          'maximum length of ${fieldName ?? 'this field'} must be $maxLength';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastExactLengthValidation] is used to validate exact length of a string
class FastExactLengthValidation implements FastValidation {
  final int length;
  FastExactLengthValidation({required this.length, this.customMessage});

  @override
  String? customMessage;

  @override
  validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (dataToValidate.runtimeType != String ||
        dataToValidate.toString().length != length) {
      errorMessage = customMessage ??
          'length of ${fieldName ?? 'this field'} must be $length';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastMinValueValidation] is used to validate minimum value of a number
class FastMinValueValidation implements FastValidation {
  final num minValue;
  FastMinValueValidation({required this.minValue, this.customMessage});

  @override
  String? customMessage;

  @override
  validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if ((dataToValidate.runtimeType != int &&
            dataToValidate.runtimeType != double) ||
        (dataToValidate as num) < minValue) {
      errorMessage = customMessage ??
          '${fieldName ?? 'this field'} must be greater than $minValue';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastMaxValueValidation] is used to validate maximum value of a number
class FastMaxValueValidation implements FastValidation {
  final num maxValue;
  FastMaxValueValidation({required this.maxValue, this.customMessage});

  @override
  String? customMessage;

  @override
  validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if ((dataToValidate.runtimeType != int &&
            dataToValidate.runtimeType != double) ||
        (dataToValidate as num) > maxValue) {
      errorMessage = customMessage ??
          '${fieldName ?? 'this field'} must be lesser than $maxValue';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastExactValueValidation] is used to validate exact value of given data
class FastExactValueValidation implements FastValidation {
  final dynamic value;
  FastExactValueValidation({required this.value, this.customMessage});

  @override
  String? customMessage;

  @override
  validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (dataToValidate != value) {
      errorMessage =
          customMessage ?? '${fieldName ?? 'this field'} must be $value';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastTypeValidation] is used to validate the datatype of given data
class FastTypeValidation implements FastValidation {
  final List<Type> allowedTypes;
  FastTypeValidation({required this.allowedTypes, this.customMessage});

  @override
  String? customMessage;

  @override
  validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (!allowedTypes.contains(dataToValidate.runtimeType)) {
      errorMessage = customMessage ??
          '${fieldName ?? 'this field'} must be any of the following type - ${allowedTypes.join(', ')}';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastEmailValidation] is used to validate an email
class FastEmailValidation implements FastValidation {
  FastEmailValidation({this.customMessage});

  @override
  String? customMessage;

  @override
  validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (dataToValidate.runtimeType != String ||
        !emailRegex.hasMatch(dataToValidate.toString())) {
      errorMessage =
          customMessage ?? '${fieldName ?? 'this field'} is not a valid email';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastUrlValidation] is used to validate an URL
class FastUrlValidation implements FastValidation {
  FastUrlValidation({this.customMessage});

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    RegExp urlRegex = RegExp(
      r'''^(https?|ftp):\/\/[^\s/$.?#].\S*$''',
      caseSensitive: false,
      multiLine: false,
    );

    if (dataToValidate.runtimeType != String ||
        !urlRegex.hasMatch(dataToValidate.toString())) {
      errorMessage =
          customMessage ?? '${fieldName ?? 'this field'} is not a valid url';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastDigitsOnlyValidation] is used to validate whether a string contains numbers alone
class FastDigitsOnlyValidation implements FastValidation {
  FastDigitsOnlyValidation({this.customMessage});

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    bool isString = dataToValidate.runtimeType == String;

    if (isString) {
      String digits = '1234567890';
      for (int i = 0; i < dataToValidate.toString().length; i++) {
        if (!digits.contains(dataToValidate.toString()[i])) {
          errorMessage = customMessage ??
              '${fieldName ?? 'this field'} must contain digits only';
          break;
        }
      }
    }

    if (errorMessage != null) {
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastAlphabetsOnlyValidation] is used to validate whether a string contains alphabets alone
class FastAlphabetsOnlyValidation implements FastValidation {
  FastAlphabetsOnlyValidation({this.customMessage});

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    bool isString = dataToValidate.runtimeType == String;

    RegExp alphabetPattern = RegExp(r'^[a-zA-Z]+$');

    if (!isString || !alphabetPattern.hasMatch(dataToValidate.toString())) {
      errorMessage = customMessage ??
          '${fieldName ?? 'this field'} must contain alphabets only';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastAlphaNumericOnlyValidation] is used to validate whether a string contains alphabets and numbers alone
class FastAlphaNumericOnlyValidation implements FastValidation {
  FastAlphaNumericOnlyValidation({this.customMessage});

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    bool isString = dataToValidate.runtimeType == String;

    RegExp alphabetPattern = RegExp(r'^[a-zA-Z0-9]+$');

    if (!isString || !alphabetPattern.hasMatch(dataToValidate.toString())) {
      errorMessage = customMessage ??
          '${fieldName ?? 'this field'} must contain alphanumerics only';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastAllowedCharactersValidation] is used to validate whether a string contains the allowed characters alone
class FastAllowedCharactersValidation implements FastValidation {
  String allowedCharacters;
  FastAllowedCharactersValidation({
    this.customMessage,
    required this.allowedCharacters,
  });

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    bool isString = dataToValidate.runtimeType == String;

    String error = customMessage ??
        '${fieldName ?? 'this field'} must contain only the following characters - $allowedCharacters';

    if (!isString) {
      errorMessage = error;
    } else {
      for (int i = 0; i < dataToValidate.toString().length; i++) {
        if (!allowedCharacters.contains(dataToValidate.toString()[i])) {
          errorMessage = error;
        }
      }
    }

    if (errorMessage != null) {
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastRegexValidation] is used to validate a [String] against a [RegExp]
class FastRegexValidation implements FastValidation {
  RegExp regex;
  FastRegexValidation({this.customMessage, required this.regex});

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (dataToValidate.runtimeType != String ||
        !regex.hasMatch(dataToValidate.toString())) {
      errorMessage = customMessage ?? '${fieldName ?? 'this field'} is invalid';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }
}

/// [FastPasswordValidation] is used to validate a password field.
class FastPasswordValidation implements FastValidation {
  final int minLength;
  final bool uppercase;
  final bool lowercase;
  final bool specialCharacter;
  final bool number;
  final String? minLengthMessage;
  final String? uppercaseMessage;
  final String? lowercaseMessage;
  final String? specialCharacterMessage;
  final String? numberMessage;
  final String? generalInvalidMessage;
  FastPasswordValidation({
    this.generalInvalidMessage,
    this.minLength = 8,
    this.lowercase = false,
    this.uppercase = false,
    this.specialCharacter = false,
    this.number = false,
    this.minLengthMessage,
    this.lowercaseMessage,
    this.numberMessage,
    this.specialCharacterMessage,
    this.uppercaseMessage,
  });

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    bool isString = dataToValidate.runtimeType == String;

    if (!isString) {
      errorMessage = generalInvalidMessage ??
          '${fieldName ?? 'this field'} must be a valid password';
    } else {
      String? specialCharCondition =
          _checkSpecialChar(dataToValidate.toString(), fieldName);
      if (specialCharCondition != null) errorMessage = specialCharCondition;

      String? checkNumCondition =
          _checkNumber(dataToValidate.toString(), fieldName);
      if (checkNumCondition != null) errorMessage = checkNumCondition;

      String? upperCaseCondition =
          _checkUppercase(dataToValidate.toString(), fieldName);
      if (upperCaseCondition != null) errorMessage = upperCaseCondition;

      String? lowercaseCondition =
          _checkLowercase(dataToValidate.toString(), fieldName);
      if (lowercaseCondition != null) {
        errorMessage = lowercaseCondition;
      }

      String? minLenCondition =
          _checkMinLength(dataToValidate.toString(), fieldName);
      if (minLenCondition != null) errorMessage = minLenCondition;
    }

    if (errorMessage != null) {
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }

  String? _checkMinLength(String data, String? fieldName) {
    if (data.length >= minLength) return null;

    return minLengthMessage ??
        'minimum length of ${fieldName ?? 'this field'} must be $minLength';
  }

  String? _checkUppercase(String data, String? fieldName) {
    if (!uppercase) return null;

    RegExp uppercasePattern = RegExp(r'^[A-Z]+$');
    for (int i = 0; i < data.length; i++) {
      if (uppercasePattern.hasMatch(data[i]) &&
          data[i] == data[i].toUpperCase()) {
        return null;
      }
    }

    return uppercaseMessage ??
        '${fieldName ?? 'this field'} must contain at least one uppercase letter';
  }

  String? _checkLowercase(String data, String? fieldName) {
    if (!lowercase) return null;

    RegExp lowercasePattern = RegExp(r'^[a-z]+$');
    for (int i = 0; i < data.length; i++) {
      if (lowercasePattern.hasMatch(data[i]) &&
          data[i] == data[i].toLowerCase()) {
        return null;
      }
    }

    return lowercaseMessage ??
        '${fieldName ?? 'this field'} must contain at least one lowercase letter';
  }

  String? _checkSpecialChar(String data, String? fieldName) {
    if (!specialCharacter) return null;

    String specialCharacterPattern = '!@#\$%^&*(),.?":{}|<> +=-_/`~[]';
    for (int i = 0; i < specialCharacterPattern.length; i++) {
      if (data.contains(specialCharacterPattern[i])) {
        return null;
      }
    }

    return specialCharacterMessage ??
        '${fieldName ?? 'this field'} must contain at least one special character';
  }

  String? _checkNumber(String data, String? fieldName) {
    if (!number) return null;

    RegExp numberPattern = RegExp(r'\d');
    if (numberPattern.hasMatch(data)) return null;

    return numberMessage ??
        '${fieldName ?? 'this field'} must contain at least one number';
  }
}

/// [FastDateValidation] is used to validate a date field.
class FastDateValidation implements FastValidation {
  DateTime? minimumDate;
  DateTime? maximumDate;
  DateTime? equalsDate;
  String? maxError;
  String? minError;
  String? equalsError;
  String? generalError;
  FastDateValidation({
    this.generalError,
    this.minimumDate,
    this.maximumDate,
    this.equalsDate,
    this.equalsError,
    this.maxError,
    this.minError,
  });

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (dataToValidate.runtimeType != DateTime) {
      errorMessage = generalError ?? '${fieldName ?? 'this field'} is invalid';
    } else {
      String? maxDateError =
          _checkMaxDateValidation(dataToValidate as DateTime, fieldName);
      if (maxDateError != null) errorMessage = maxDateError;

      String? minDateError = _checkMinDateValidation(dataToValidate, fieldName);
      if (minDateError != null) errorMessage = minDateError;

      String? equalDateError = _checkEqualValidation(dataToValidate, fieldName);
      if (equalDateError != null) errorMessage = equalDateError;
    }

    if (errorMessage != null) {
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }

  String? _checkEqualValidation(DateTime date, String? fieldName) {
    if (equalsDate == null) return null;

    if (date.year == equalsDate!.year &&
        date.month == equalsDate!.month &&
        date.day == equalsDate!.day &&
        date.hour == equalsDate!.hour &&
        date.minute == equalsDate!.minute &&
        date.second == equalsDate!.second &&
        date.millisecond == equalsDate!.millisecond &&
        date.microsecond == equalsDate!.microsecond) {
      return null;
    }

    return equalsError ??
        '${fieldName ?? 'this field'} must be equal to the given date';
  }

  String? _checkMinDateValidation(DateTime date, String? fieldName) {
    if (minimumDate == null) return null;

    if (date.isAfter(minimumDate!)) return null;

    return minError ??
        '${fieldName ?? 'this field'} must be a date after the given date';
  }

  String? _checkMaxDateValidation(DateTime date, String? fieldName) {
    if (maximumDate == null) return null;

    if (date.isBefore(maximumDate!)) return null;

    return maxError ??
        '${fieldName ?? 'this field'} must be a date before the given date';
  }
}

/// [FastCreditCardValidation] is used to validate a credit card number using Luhn's algorithm.
class FastCreditCardValidation implements FastValidation {
  FastCreditCardValidation({this.customMessage});

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (dataToValidate.runtimeType != String ||
        !_isValidCreditCard(dataToValidate.toString())) {
      errorMessage =
          customMessage ?? '${fieldName ?? 'credit card'} is invalid';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }

  bool _isValidCreditCard(String creditCardNumber) {
    try {
      List<int> digits = creditCardNumber.split('').map(int.parse).toList();
      digits = digits.reversed.toList();

      int sum = 0;
      for (int i = 0; i < digits.length; i++) {
        int digit = digits[i];

        if (i % 2 == 1) {
          digit *= 2;
          if (digit > 9) {
            digit -= 9;
          }
        }

        sum += digit;
      }

      return sum % 10 == 0;
    } catch (_) {
      return false;
    }
  }
}

/// [FastGSTNumberValidation] is used to validate a GST number.
class FastGSTNumberValidation implements FastValidation {
  FastGSTNumberValidation({this.customMessage});

  @override
  String? customMessage;

  @override
  ValidationResult<T> validate<T>(T dataToValidate, String? fieldName) {
    String? errorMessage;
    bool valid = true;
    ResultType outputType = ResultType.valid;

    if (dataToValidate.runtimeType != String ||
        !_isValidGST(dataToValidate.toString())) {
      errorMessage = customMessage ?? '${fieldName ?? 'GST number'} is invalid';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: errorMessage,
      type: outputType,
      valid: valid,
      result: dataToValidate,
    );
  }

  bool _isValidGST(String gst) {
    if (gst.length != 15) return false;
    String regex = '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}\$';

    return RegExp(regex).hasMatch(gst);
  }
}
