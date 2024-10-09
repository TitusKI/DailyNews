import 'package:daily_news/features/daily_news/data/data_source/local/DAO/article_dao.dart';
import 'package:daily_news/features/daily_news/data/models/article_model.dart';
import 'package:floor/floor.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
