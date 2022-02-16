part of 'getuser_bloc.dart';

@immutable
abstract class GetUserState {}

class GetuserInitial extends GetUserState {}

class GetuserLoading extends GetUserState {}

class GetuserLoaded extends GetUserState {
  final List<UserModel> data ;
  GetuserLoaded(this.data);
}

class GetuserError extends GetUserState {
  final String message;
  GetuserError(this.message);
}
