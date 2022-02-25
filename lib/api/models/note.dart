import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(createToJson: false)
class Note {
  const Note({
    required this.id,
    required this.createdAt,
    this.subject,
    this.note,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  final String id;
  final String createdAt;
  @JsonKey(includeIfNull: true)
  final String? subject;
  @JsonKey(includeIfNull: true)
  final String? note;
}
