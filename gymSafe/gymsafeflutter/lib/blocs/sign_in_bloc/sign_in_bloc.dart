import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      if (kDebugMode) {
        print('Sign-in process started for email: ${event.email}');
      }
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
        if (kDebugMode) {
          print('Sign-in successful for email: ${event.email}');
        }
      } on FirebaseAuthException catch (e) {
        emit(SignInFailure(message: e.code));
        if (kDebugMode) {
          print('Sign-in failed with error: ${e.code}');
        }
      } catch (e) {
        emit(const SignInFailure());
        if (kDebugMode) {
          print('Sign-in failed with an unknown error.');
        }
      }
    });

    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
    });
  }
}
