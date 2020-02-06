import 'package:flutter_music_neumorphism/blocs/music_player.dart';
import 'package:flutter_music_neumorphism/blocs/permissions.dart';

class GlobalBloc {
  PermissionsBloc _permissionsBloc;
  MusicPlayerBloc _musicPlayerBloc;
  MusicPlayerBloc get musicPlayerBloc => _musicPlayerBloc;
  PermissionsBloc get permissionsBloc => _permissionsBloc;

  GlobalBloc() {
    _musicPlayerBloc = MusicPlayerBloc();
    _permissionsBloc = PermissionsBloc();
  }

  void dispose() {
    _musicPlayerBloc.dispose();
    _permissionsBloc.dispose();
  }
}
