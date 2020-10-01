import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> dialogItems = [1, 2, 3, 4, 5];

  Widget get _title => Text('Flutter Demo Tutorial');

  Widget _actionDialog(BuildContext context) => IconButton(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _dialog(context);
        },
      );

  Widget get _body => SafeArea(
        child: Center(
          child: Text('Selected value: $_selectedValue'),
        ),
      );

  int _selectedValue = 1;

  void _dialog(BuildContext context) async {
    _selectedValue = await showDialog(
      context: context,
      builder: (context) => new SimpleDialog(
        title: new Text('My Dialog'),
        children: dialogItems
            .map(
              (data) => new SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(data),
                child: new ListTile(
                  selected: data == this._selectedValue,
                  title: new Text(data.toString()),
                ),
              ),
            )
            .toList(),
      ),
    );

    setState(() {});
  }

  Widget _popupMenu() {
    return new PopupMenuButton<String>(
      onSelected: (val) {
        print('Popup got selected: $val');
        switch (val) {
          case 'DATA 1':
            _selectedValue = 10;
            break;
          case 'DATA 2':
            _selectedValue = 11;
            break;
        }
        setState(() {});
      },
      itemBuilder: (context) => <PopupMenuItem<String>>[
        new PopupMenuItem<String>(child: Text('DATA 1'), value: 'DATA 1'),
        new PopupMenuItem<String>(child: Text('DATA 2'), value: 'DATA 2'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title,
        actions: [
          _actionDialog(context),
          _popupMenu(),
        ],
      ),
      drawer: MainDrawer(),
      body: _body,
    );
  }
}
