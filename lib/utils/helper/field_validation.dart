String? Function(String?, String) requiredValidator = (value, fieldName) {
  if (value != null && value.isNotEmpty) {
    return null;
  }
  return "$fieldName Required";
};