import 'package:api_hw/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'getuser_event.dart';
part 'getuser_state.dart';

class GetuserBloc extends Bloc<GetuserEvent, GetUserState> {
  GetuserBloc() : super(GetuserInitial()) {
    List<UserModel> listUserModel = [];
    on<GetuserEvent>((event, emit) async {
      emit(GetuserLoading());
      try{
         Response response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');
      final List<dynamic> listOfJson = response.data;
      listUserModel = listOfJson.map<UserModel>((e) => UserModel.fromJson(e)).toList();
      
        emit (GetuserLoaded(listUserModel));
      }
      catch (e){
        emit(GetuserError(e.toString()));
      }
    });
  }
}
