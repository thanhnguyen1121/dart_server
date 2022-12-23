import 'dart:developer' as developer;

T? convertHelper<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  if (value == null) {
    return null;
  }
  if (T == double) {
    try {
      final result = (value is int
          ? value.toDouble()
          : double.tryParse(value.toString())) as T?;
      if (result == null) {
        developer.log(
          "value is $value has type ${value.runtimeType} is not subtype double",
          name: 'convertHelper',
        );
        return null;
      }
      return result;
    } catch (exception) {
      return null;
    }
  }

  if (T == int) {
    try {
      final result = (int.tryParse(value.toString()) ??
          double.tryParse(value.toString())?.toInt()) as T?;
      if (result == null) {
        developer.log(
          "value is $value has type ${value.runtimeType} is not subtype int",
          name: 'convertHelper',
        );
        return null;
      }
      return result;
    } catch (exception) {
      return null;
    }
  }

  if (T == String) {
    return value.toString() as T?;
  }

  if (T == bool) {
    return value is T ? value : null;
  }

  return value is T ? value : null;
}
