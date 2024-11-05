abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetArticlesEvent extends RemoteArticleEvent {
  const GetArticlesEvent();
}

class GetBusinessArticlesEvent extends RemoteArticleEvent {
  const GetBusinessArticlesEvent();
}

class GetSportsArticlesEvent extends RemoteArticleEvent {
  const GetSportsArticlesEvent();
}

class GetTechnologyArticlesEvent extends RemoteArticleEvent {
  const GetTechnologyArticlesEvent();
}

class GetScienceArticlesEvent extends RemoteArticleEvent {
  const GetScienceArticlesEvent();
}

class GetEntertainmentArticlesEvent extends RemoteArticleEvent {
  const GetEntertainmentArticlesEvent();
}

class GetHealthArticlesEvents extends RemoteArticleEvent {
  const GetHealthArticlesEvents();
}

class GetPopularArticlesEvent extends RemoteArticleEvent {
  const GetPopularArticlesEvent();
}

class GetRecentArticlesEvent extends RemoteArticleEvent {
  const GetRecentArticlesEvent();
}

class GetAllArticlesEvent extends RemoteArticleEvent {
  const GetAllArticlesEvent();
}

class FetchEverythingArticlesEvent extends RemoteArticleEvent {
  const FetchEverythingArticlesEvent();
}
