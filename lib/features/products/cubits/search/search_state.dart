abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<dynamic> products;
  SearchSuccess(this.products);
}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}
