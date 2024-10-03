import 'dart:convert';

import 'package:daily_news/features/daily_news/data/models/article_model.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testArticleModel = ArticleModel(
    author: "Sagar Naresh Bhavsar",
    title:
        "Google Maps now lets you upgrade to a new vehicle, at least virtually",
    description:
        "Google Maps on iOS is getting multiple new navigation vehicles and customization options.",
    url:
        "https://www.neowin.net/news/google-maps-now-lets-you-upgrade-to-a-new-vehicle-at-least-virtually/",
    urlToImage:
        "https://cdn.neowin.com/news/images/uploaded/2024/07/1721970922_google-maps_story.jpg",
    // publishedAt: "2024-11-09T06:36:02Z",
    content:
        "Google Maps is the default navigation app on most phones globally, used by both iOS and Android users.",
  );
  test('Should be a subclass of article entity', () async {
    // act

    // assert
    expect(testArticleModel, isA<ArticleEntity>());
  });

  test("should return a valid model from json", () async {
// arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('helpers/dummy_data/dummy_article_response.json'));

    // act
    final result = ArticleModel.fromJson(jsonMap);
    // assert
    expect(result, testArticleModel);
  });

  test('Should return a json map containing proper data ', () async {
    // act
    final result = testArticleModel.toJson();

    // assert
    final toJsonMap = {
      "author": "Sagar Naresh Bhavsar",
      "title":
          "Google Maps now lets you upgrade to a new vehicle, at least virtually",
      "description":
          "Google Maps on iOS is getting multiple new navigation vehicles and customization options.",
      "url":
          "https://www.neowin.net/news/google-maps-now-lets-you-upgrade-to-a-new-vehicle-at-least-virtually/",
      "urlToImage":
          "https://cdn.neowin.com/news/images/uploaded/2024/07/1721970922_google-maps_story.jpg",
      "content":
          "Google Maps is the default navigation app on most phones globally, used by both iOS and Android users.",
    };
    expect(result, equals(toJsonMap));
  });
}
