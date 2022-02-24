// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    id: json['id'] as String,
    title: json['title'] as String,
    locationNames: json['locationNames'] as String?,
    isFeatured: json['isFeatured'] as bool? ?? false,
  );
}
