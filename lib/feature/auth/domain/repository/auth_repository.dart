import 'package:blindside/core/errors/errors.dart';
import 'package:blindside/feature/auth/data/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> create({
    required String email,
    required String name,
    required String password,
  });
}
