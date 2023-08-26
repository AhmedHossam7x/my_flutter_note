// ignore_for_file: unnecessary_string_interpolations

const String messageImpty = "the feild is empty";
const String messageMin = "less input than";
const String messageMax = "larg input than";

validInput(String val, int min, int max) {
  if (val.isEmpty) {
    return "$messageImpty";
  } else if (val.length > max) {
    return "$messageMax $max";
  } else if (val.length < min) {
    return "$messageMin $min";
  }
}
