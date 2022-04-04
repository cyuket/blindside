import 'package:blindside/app/view/view_model/base_view_model.dart';
import 'package:blindside/core/injections/injections.dart';
import 'package:blindside/feature/auth/presentation/provider/auth_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';

@lazySingleton
class DashboardProvider extends BaseModel {
  final user = sl<AuthProvider>().user;

  List<AssetEntity> _assets = [];

  List<AssetEntity> get assets => _assets;

  Future<void> setPermission() async {
    setBusy(value: true);
    final _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      final albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
      );

      if (albums.isNotEmpty) {
        final recentAlbum = albums.first;

        // Now that we got the album, fetch all the assets it contains
        final recentAssets = await recentAlbum.getAssetListRange(
          start: 0, // start at index 0
          end: 1000000, // end at a very big index (to get all the assets)
        );

        _assets = recentAssets
            .where(
              (element) => element.type == AssetType.video,
            )
            .toList();
      }
    }
    setBusy(value: false);
  }
}
