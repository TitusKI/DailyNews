import 'package:daily_news/core/constants/constants.dart';
import 'package:daily_news/features/daily_news/data/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part "news_api_services.g.dart";

@RestApi(baseUrl: newsApiBaseURL)
abstract class NewsApiServices {
  factory NewsApiServices(Dio dio) = _NewsApiServices;

  @GET('/top-headlines')
  Future<HttpResponse<NewsResponse>> getNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
  @GET('/top-headlines')
  Future<HttpResponse<NewsResponse>> getBusinessArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
  @GET('/top-headlines')
  Future<HttpResponse<NewsResponse>> getSportsArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
  @GET('/top-headlines')
  Future<HttpResponse<NewsResponse>> getTechnologyArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
  @GET('/top-headlines')
  Future<HttpResponse<NewsResponse>> getScienceArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
  @GET('/top-headlines')
  Future<HttpResponse<NewsResponse>> getEntertainmentArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
  @GET('/top-headlines')
  Future<HttpResponse<NewsResponse>> getHealthArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });

  @GET('/everything')
  Future<HttpResponse<NewsResponse>> getAllNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("domains") String? domains,
  });
  @GET('/everything')
  Future<HttpResponse<NewsResponse>> getPopularArticles({
    @Query("apiKey") String? apiKey,
    @Query("domains") String? domains,
    @Query("sortBy") String? sortBy,
  });
  @GET('/everything')
  Future<HttpResponse<NewsResponse>> getRecentArticles({
    @Query("apiKey") String? apiKey,
    @Query("domains") String? domains,
    @Query("sortBy") String? sortBy,
  });
}

class NewsResponse {
  NewsResponse({required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      articles: (json['articles'] as List<dynamic>)
          .map((i) => ArticleModel.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<ArticleModel> articles;
}
