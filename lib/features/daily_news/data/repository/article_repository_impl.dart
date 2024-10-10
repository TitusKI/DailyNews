import 'dart:io';

import 'package:daily_news/core/constants/constants.dart';
import 'package:daily_news/core/resources/data_state.dart';
import 'package:daily_news/features/daily_news/data/data_source/local/app_database.dart';
import 'package:daily_news/features/daily_news/data/data_source/remote/news_api_services.dart';
import 'package:daily_news/features/daily_news/data/models/article_model.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiServices _newsApiServices;
  final AppDatabase _appDatabase;
  ArticleRepositoryImpl(this._newsApiServices, this._appDatabase);
  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiServices.getNewsArticles(
        apiKey: newsApiKey,
        country: countryQuery,
        category: categoryQuery,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .insertArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<DataState<List<ArticleEntity>>> getAllNewsArticles() async {
    try {
      final httpResponse = await _newsApiServices.getAllNewsArticles(
        apiKey: newsApiKey,
        country: countryQuery,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getBusinessArticles() async {
    try {
      final httpResponse = await _newsApiServices.getBusinessArticles(
          apiKey: newsApiKey,
          country: countryQuery,
          category: Category.business.name);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getEntertaimentArticles() async {
    try {
      final httpResponse = await _newsApiServices.getEntertainmentArticles(
        apiKey: newsApiKey,
        country: countryQuery,
        category: Category.entertaiment.name,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getHealthArticles() async {
    try {
      final httpResponse = await _newsApiServices.getHealthArticles(
        apiKey: newsApiKey,
        country: countryQuery,
        category: Category.health.name,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getPopularArticles() async {
    try {
      final httpResponse = await _newsApiServices.getPopularArticles(
        apiKey: newsApiKey,
        country: countryQuery,
        sortBy: SortBy.popularity.name,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getRecentArticles() async {
    try {
      final httpResponse = await _newsApiServices.getRecentArticles(
        apiKey: newsApiKey,
        country: countryQuery,
        sortBy: SortBy.publishedAt.name,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getScienceArticles() async {
    try {
      final httpResponse = await _newsApiServices.getScienceArticles(
        apiKey: newsApiKey,
        country: countryQuery,
        category: Category.science.name,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getSportsArticles() async {
    try {
      final httpResponse = await _newsApiServices.getSportsArticles(
        apiKey: newsApiKey,
        country: countryQuery,
        category: Category.sports.name,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getTechnologyArticles() async {
    try {
      final httpResponse = await _newsApiServices.getTechnologyArticles(
        apiKey: newsApiKey,
        country: countryQuery,
        category: Category.technology.name,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('REsponse in the Repository implmentation');
        print(httpResponse.data);
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
