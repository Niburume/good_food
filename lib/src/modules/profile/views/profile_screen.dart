import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mall/src/components/list_tiles/setting_list_tile.dart';
import 'package:mall/src/components/restart/restart_widget.dart';
import 'package:mall/src/modules/themes/theme_bloc.dart';
import 'package:mall/src/utils/colors.dart';
import 'package:mall/src/utils/styles.dart';
import '../../auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Color currentColor = Colors.transparent;
  @override
  void initState() {
    super.initState();
  }

  void pickColor() {
    // create some values
// ValueChanged<Color> callback
    void changeColor(Color color) {
      context.read<ThemeBloc>().add(ChangeThemeEvent(color, null));
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: context.read<ThemeBloc>().state.color,
                onColorChanged: changeColor,
              ),
            ),
            actions: <Widget>[
              Column(
                children: [
                  TextButton(
                    child: Text(
                      'Reset to default',
                      style: smallStyle,
                    ),
                    onPressed: () {
                      context
                          .read<ThemeBloc>()
                          .add(ChangeThemeEvent(kColorPurple, null));
                      Navigator.of(context).pop();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text('  Done!  '),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(const SignOutRequired());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            _changeTheme(context),
            SizedBox(
              height: 10,
            ),
            _pickColorWidget(context),
          ],
        ),
      ),
    );
  }

  // region widgets
  Widget _changeTheme(BuildContext context) => KSettingListTile(
      title: 'Theme',
      subTitle: '',
      trailingWidget: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return SegmentedButton(
            showSelectedIcon: false,
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity(horizontal: -3, vertical: -3),
            ),
            onSelectionChanged: (selected) {
              print(selected);
              context
                  .read<ThemeBloc>()
                  .add(ChangeThemeEvent(null, selected.first as ThemeMode));
            },
            multiSelectionEnabled: false,
            segments: [
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(
                  Icons.light_mode,
                ),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.phone_android),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode),
              ),
            ],
            selected: {context.watch<ThemeBloc>().state.themeMode},
          );
        },
      ));

  Widget _pickColorWidget(BuildContext context) => KSettingListTile(
      title: 'Color',
      subTitle: '',
      trailingWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                pickColor();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: context.watch<ThemeBloc>().state.color,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ],
      ));
}
