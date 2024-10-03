import 'package:daily_news/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<ArticleRepository>(as: #MockArticleRepository),
  MockSpec<Dio>(as: #MockDio),
])
void main() {}
