import 'package:blindside/core/errors/errors.dart';
import 'package:blindside/core/usecase/usecase.dart';
import 'package:blindside/feature/auth/data/model/user_model.dart';
import 'package:blindside/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUserCase extends UseCase<UserModel, LoginUserCaseParam> {
  LoginUserCase({
    required this.dataRepository,
  });

  final AuthRepository dataRepository;

  @override
  Future<Either<Failure, UserModel>> call(LoginUserCaseParam params) {
    return dataRepository.login(email: params.email, password: params.password);
  }
}

class LoginUserCaseParam extends Equatable {
  const LoginUserCaseParam({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
