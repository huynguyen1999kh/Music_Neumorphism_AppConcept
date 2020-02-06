import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_neumorphism/Services/navigationServices.dart';
import 'package:flutter_music_neumorphism/Services/router.dart';
import 'package:flutter_music_neumorphism/Services/routes.dart';
import 'package:flutter_music_neumorphism/blocs/global.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Root());
}

class Root extends StatelessWidget {
  final GlobalBloc _globalBloc = GlobalBloc();
  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>(
        create: (BuildContext context) {
          _globalBloc.permissionsBloc.storagePermissionStatus$.listen(
            (data) {
              if (data == PermissionStatus.granted) {
                _globalBloc.musicPlayerBloc.fetchSongs().then(
                  (_) {
                    _globalBloc.musicPlayerBloc.retrieveFavorites();
                  },
                );
              }
            },
          );
          return _globalBloc;
        },
        child: StreamBuilder(
          stream: _globalBloc.permissionsBloc.storagePermissionStatus$,
          builder:
              (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final PermissionStatus _status = snapshot.data;
            if (_status == PermissionStatus.denied) {
              _globalBloc.permissionsBloc.requestStoragePermission();
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return MaterialApp(
                  theme: ThemeData(
                    accentColor: Colors.grey[800],
                  ),
                  onGenerateRoute: generateRoute,
                  navigatorKey: navigatorKey,
                  initialRoute: Routes.SongList);
            }
          },
        ));
  }
}
