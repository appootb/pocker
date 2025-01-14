import 'dart:convert';

class Filters {
  final Map<String, Map<String, bool>> fields;

  Filters() : fields = {};

  Filters.fromKeyValuePair(String key, String value) : fields = {} {
    fields[key] = {value: true};
  }

  add(String key, String value) {
    fields.containsKey(key)
        ? fields[key]![value] = true
        : fields[key] = {value: true};
  }

  del(String key, String value) {
    if (fields.containsKey(key)) {
      fields[key]!.remove(value);
      if (fields[key]!.isEmpty) {
        fields.remove(key);
      }
    }
  }

  Map<String, List<String>> convertToSlice() {
    final Map<String, List<String>> fs = {};
    fields.forEach((String key, Map<String, bool> value) {
      fs[key] = value.keys.toList();
    });
    return fs;
  }

  @override
  String toString() {
    if (fields.isEmpty) {
      return '{}';
    }
    return json.encode(convertToSlice());
  }
}
