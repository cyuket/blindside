// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_storage/firebase_storage.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;

import '../../feature/auth/data/data_sources/user_data_sources.dart' as _i10;
import '../../feature/auth/data/repository/auth_repository_imp.dart' as _i12;
import '../../feature/auth/domain/repository/auth_repository.dart' as _i11;
import '../../feature/auth/domain/usecases/login_usecase.dart' as _i21;
import '../../feature/auth/domain/usecases/register_usecase.dart' as _i22;
import '../../feature/auth/presentation/provider/auth_provider.dart' as _i25;
import '../../feature/dashboard/presentation/provider/dashboard_provider.dart'
    as _i26;
import '../errors/network_info.dart' as _i8;
import '../local_data/local_data_storage.dart' as _i6;
import '../navigators/navigation_service.dart' as _i7;
import '../utils/third_party_mode_env.dart' as _i9;
import 'register_module.dart' as _i28; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.FirebaseStorage>(() => registerModule.firebaseStorage);
  gh.factory<_i4.FlutterSecureStorage>(
    () => registerModule.flutterSecureStorage,
  );
  gh.factory<_i5.InternetConnectionChecker>(
    () => registerModule.internetConnectionChecker,
  );
  gh.lazySingleton<_i6.LocalDataStorage>(
    () => _i6.LocalDataStorageImpl(get<_i4.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i7.NavigationService>(() => _i7.NavigationService());
  gh.lazySingleton<_i8.NetworkInfo>(
    () => _i8.NetworkInfoImpl(get<_i5.InternetConnectionChecker>()),
  );
  gh.singleton<_i9.ThirdPartyModeEnv>(_i9.ThirdPartyModeEnv());
  gh.lazySingleton<_i10.UserRemoteDataSource>(
    () => _i10.UserRemoteDataSourceImpl(networkInfo: get<_i8.NetworkInfo>()),
  );
  gh.lazySingleton<_i11.AuthRepository>(
    () => _i12.AuthRepositoryImpl(
      remoteDataSource: get<_i10.UserRemoteDataSource>(),
    ),
  );

  gh.lazySingleton<_i21.LoginUserCase>(
    () => _i21.LoginUserCase(dataRepository: get<_i11.AuthRepository>()),
  );
  gh.lazySingleton<_i22.RegisterUseCase>(
    () => _i22.RegisterUseCase(dataRepository: get<_i11.AuthRepository>()),
  );

  gh.lazySingleton<_i25.AuthProvider>(
    () => _i25.AuthProvider(
      loginUserCase: get<_i21.LoginUserCase>(),
      registerUseCase: get<_i22.RegisterUseCase>(),
    ),
  );
  gh.lazySingleton<_i26.DashboardProvider>(
    () => _i26.DashboardProvider(),
  );

  return get;
}

class _$RegisterModule extends _i28.RegisterModule {}
