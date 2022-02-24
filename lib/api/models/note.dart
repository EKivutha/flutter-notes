import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(createToJson: false)
class Note {
  const Note({
    required this.id,
    required this.title,
    this.locationNames,
    this.isFeatured = false,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  final String id;
  final String title;
  @JsonKey(includeIfNull: true)
  final String? locationNames;
  @JsonKey(defaultValue: false)
  final bool isFeatured;
}
