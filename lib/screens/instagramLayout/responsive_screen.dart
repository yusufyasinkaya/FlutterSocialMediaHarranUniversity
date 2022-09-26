import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiyatrokulubu/models/providers/user_provider.dart';

class ResponsiveSc extends StatefulWidget {
  final Widget instagramScreenLayout;

  const ResponsiveSc({Key? key, required this.instagramScreenLayout})
      : super(key: key);

  @override
  State createState() => _ResponsiveScLay();
}

class _ResponsiveScLay extends State<ResponsiveSc> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(
      context,
      listen: false,
    );
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constarints) {
      return widget.instagramScreenLayout;
    });
  }
}
