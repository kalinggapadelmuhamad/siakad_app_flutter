import 'package:bloc/bloc.dart';
import 'package:flutter_siakad_app/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_siakad_app/data/models/request/auth_request_model.dart';
import 'package:flutter_siakad_app/data/models/response/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final response =
          await AuthRemoteDataSource().login(event.authRequestModel);
      response.fold(
        (error) {
          emit(_Error(error));
        },
        (data) {
          emit(_Loaded(data));
        },
      );
      // TODO: implement event handler
    });
  }
}
