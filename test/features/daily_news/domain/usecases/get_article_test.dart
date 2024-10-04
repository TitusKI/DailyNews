import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:daily_news/core/resources/data_state.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/core/constants/export.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetArticleUseCase getArticleUseCase;
  late MockArticleRepository mockArticleRepository;
  // late MockDio mockDio;

  setUp(() {
    // Initialize mocks
    mockArticleRepository = MockArticleRepository();
    // mockDio = MockDio();
    getArticleUseCase = GetArticleUseCase(mockArticleRepository);
  });

  const articles = [
    ArticleEntity(
      author: "Sagar Naresh Bhavsar",
      title:
          "Google Maps now lets you upgrade to a new vehicle, at least virtually",
      description:
          "Google Maps on iOS is getting multiple new navigation vehicles and customization options.",
      url:
          "https://www.neowin.net/news/google-maps-now-lets-you-upgrade-to-a-new-vehicle-at-least-virtually/",
      urlToImage:
          "https://cdn.neowin.com/news/images/uploaded/2024/07/1721970922_google-maps_story.jpg",
      publishedAt: "2024-11-09T06:36:02Z",
      content:
          "Google Maps is the default navigation app on most phones globally, used by both iOS and Android users.",
    ),
  ];

  test('Should get a list of articles from the repository', () async {
    // Arrange
    when(() => mockArticleRepository.getNewsArticles())
        .thenAnswer((_) async => const DataSuccess(articles));

    // Act
    final result = await getArticleUseCase.call();

    // Assert
    expect(result, equals(const DataSuccess(articles)));
    verify(() => mockArticleRepository.getNewsArticles()).called(1);
  });
}
