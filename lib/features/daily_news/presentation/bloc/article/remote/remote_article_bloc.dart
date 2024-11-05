import 'dart:async';

import 'package:daily_news/core/resources/generic_state.dart';
import 'package:daily_news/features/daily_news/domain/usecases/everything/get_all_news_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/everything/get_popular_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/everything/get_recent_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_article.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_business_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_entertainment_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_health_articles.dart';

import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_sports_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_technology_articles.dart';
import 'package:daily_news/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Cubit<GenericState> {
  // final GetArticleUseCase _getArticleUseCase;
  // Specify the init state as a loading
  RemoteArticleBloc() : super(const GenericState());
  Future<void> getArticle() async {
    try {
      emit(state.copyWith(isLoading: true));
      final dataState = await sl<GetArticleUseCase>().call();

      emit(state.copyWith(isLoading: false, generalArticles: dataState.data));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> getBusinessArticles() async {
    emit(state.copyWith(isLoading: true, isSuccess: false, failure: null));

    try {
      final dataState = await sl<GetBusinessArticlesUsecase>().call();

      emit(state.copyWith(
          isLoading: false, businessArticles: dataState.data, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> getSportsArticles() async {
    try {
      emit(state.copyWith(isLoading: true));
      final dataState = await sl<GetSportsArticlesUsecase>().call();

      emit(state.copyWith(isLoading: false, sportsArticles: dataState.data));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> getTechnologyArticles() async {
    try {
      emit(state.copyWith(isLoading: true));
      final dataState = await sl<GetTechnologyArticlesUsecases>().call();

      emit(
          state.copyWith(isLoading: false, technologyArticles: dataState.data));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> getScienceArticles() async {
    try {
      emit(state.copyWith(isLoading: true));
      final dataState = await sl<GetHealthArticlesUsecases>().call();

      emit(state.copyWith(isLoading: false, scienceArticles: dataState.data));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> getEntertainmentArticles() async {
    try {
      emit(state.copyWith(isLoading: true));
      final dataState = await sl<GetEntertainmentArticlesUsecases>().call();

      emit(state.copyWith(
          isLoading: false, entertainmentArticles: dataState.data));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> getHealthArticles() async {
    try {
      emit(state.copyWith(isLoading: true));
      final dataState = await sl<GetHealthArticlesUsecases>().call();

      emit(state.copyWith(isLoading: false, healthArticles: dataState.data));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> getPopularArticles() async {
    try {
      emit(state.copyWith(isLoading: true));
      final dataState = await sl<GetPopularArticlesUsecases>().call();

      emit(state.copyWith(isLoading: false, popularArticles: dataState.data));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> getRecentArticles() async {
    try {
      emit(state.copyWith(isLoading: true));
      final dataState = await sl<GetRecentArticlesUsecases>().call();
      print(dataState.data);
      emit(state.copyWith(isLoading: false, recentArticles: dataState.data));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> getAllArticles() async {
    emit(state.copyWith(isLoading: true, isSuccess: false, failure: null));

    try {
      final dataState = await sl<GetAllNewsArticlesUsecase>().call();

      emit(state.copyWith(isLoading: false, data: dataState.data));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }
  // FutureOr<void> fetchEverythingArticles() async{
  //   // try {
  //   //   final dataState = await sl<GetRecentArticlesUsecases>().call();
  //   //   if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
  //   //     emit(
  //   //       RecentArticleDone(dataState.data!),
  //   //     );
  //   //   }
  //   //   if (dataState is DataFailed) {
  //   //     emit(
  //   //       RemoteArticleError(dataState.error!),
  //   //     );
  //   //   }
  //   // } on Exception catch (e) {
  //   //   throw Exception(e.toString());
  //   // }
  //   await _onGetRecentArticles(const GetRecentArticlesEvent(), emit);
  //   await _onGetPopularArticles(const GetPopularArticlesEvent(), emit);
  //   await _onGetAllArticles(const GetAllArticlesEvent(), emit);
  // }
}
