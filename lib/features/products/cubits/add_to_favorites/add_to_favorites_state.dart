abstract class AddToFavoritesState {}

class AddToFavoritesInitial extends AddToFavoritesState {}

class AddToFavoritesLoading extends AddToFavoritesState {}

class AddToFavoritesError extends AddToFavoritesState {
  final String error;
  AddToFavoritesError(this.error);
}

class AddToFavoritesSuccess extends AddToFavoritesState {}
