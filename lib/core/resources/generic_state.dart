import 'dart:io';

import 'package:equatable/equatable.dart';

class GenericState<T> extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? failure;

  final T? data;
  final T? popularArticles;
  final T? recentArticles;
  final T? businessArticles;
  final T? sportsArticles;
  final T? technologyArticles;
  final T? scienceArticles;
  final T? entertainmentArticles;
  final T? healthArticles;
  final T? generalArticles;

  final File? imageFile;
  const GenericState({
    this.isLoading = false,
    this.popularArticles,
    this.recentArticles,
    this.businessArticles,
    this.sportsArticles,
    this.technologyArticles,
    this.scienceArticles,
    this.entertainmentArticles,
    this.healthArticles,
    this.generalArticles,
    this.isSuccess = false,
    this.data,
    this.imageFile,
    this.failure = "",
  });
  GenericState copyWith(
      {bool? isLoading,
      bool? isSuccess,
      String? failure,
      T? data,
      T? popularArticles,
      T? recentArticles,
      T? businessArticles,
      T? sportsArticles,
      T? technologyArticles,
      T? scienceArticles,
      T? entertainmentArticles,
      T? healthArticles,
      T? generalArticles,
      File? imageFile}) {
    return GenericState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      failure: failure ?? this.failure,
      data: data ?? this.data,
      popularArticles: popularArticles ?? this.popularArticles,
      recentArticles: recentArticles ?? this.recentArticles,
      businessArticles: businessArticles ?? this.businessArticles,
      sportsArticles: sportsArticles ?? this.sportsArticles,
      technologyArticles: technologyArticles ?? this.technologyArticles,
      scienceArticles: scienceArticles ?? this.scienceArticles,
      entertainmentArticles:
          entertainmentArticles ?? this.entertainmentArticles,
      healthArticles: healthArticles ?? this.healthArticles,
      generalArticles: generalArticles ?? this.generalArticles,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        failure,
        data,
        imageFile,
        recentArticles,
        popularArticles,
      ];
}
