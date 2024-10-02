import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test/features/daily_news')) {
    dir = dir.replaceAll('/test/features/daily_news', '');
  }
  return File('$dir/test/features/daily_news/$name').readAsStringSync();
}
