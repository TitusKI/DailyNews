import 'package:daily_news/core/constants/constants.dart';
import 'package:daily_news/core/constants/export.dart';
import 'package:daily_news/features/daily_news/data/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late NewsApiServices newsApiServices;
  setUp(() {
    mockDio = MockDio();
    newsApiServices = NewsApiServices(mockDio);
    // Register fallback values to handle optional parameters.
    registerFallbackValue(RequestOptions(path: ''));
  });

  group("get a list of articles ", () {
    test("Should return a list of Article model  when the response is 200",
        () async {
      // arrange
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
          data: readJson('helpers/dummy_data/dummy_article_list.json'),
          requestOptions: RequestOptions(path: getArticles),
          statusCode: 200));
      // act
      final result = await newsApiServices.getNewsArticles();
      // assert
      expect(result, isA<List<ArticleModel>>());
    });
  });
}
