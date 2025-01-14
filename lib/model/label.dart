class Label {
  String? withLabel;
  String? withoutLabel;

  Label.withLabelKey(String key) : withLabel = key;

  Label.withoutLabelKey(String key) : withoutLabel = key;

  Label.withLabelValue(String key, String value) : withLabel = '$key=$value';

  Label.withoutLabelValue(String key, String value)
      : withoutLabel = '$key=$value';

  @override
  String toString() {
    return withLabel ?? withoutLabel ?? '';
  }
}
