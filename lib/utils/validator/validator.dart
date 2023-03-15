class Validator {
  static String? rule(
    String? value, {
    bool required = false,
  }) {
    if (required && value!.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  //!String validator
  static String? required(
    dynamic value, {
    String? fieldName,
  }) {
    if (value is String || value == null) {
      if (value.toString() == "null") return "This field is required!";
      if (value.isEmpty) return "This field is required!";
    }
    return null;
  }
}
//#END