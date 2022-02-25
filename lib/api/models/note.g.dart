// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    id: json['id'] as String,
    createdAt: json['createdAt'] as String,
    subject: json['subject'] as String?,
    note: json['note'] as String?,
  );
}
