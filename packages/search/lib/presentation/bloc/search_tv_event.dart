part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();

  @override
  List<Object> get props => [];
}

class OnQueryTvChanged extends SearchTvEvent {
  final String query;

  const OnQueryTvChanged(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
}
