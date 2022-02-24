const get = r'''
query Get(){
  notes(
    id,
    title,
    locationNames,
    isFeatured
  )
}''';
