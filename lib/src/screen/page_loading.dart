import 'package:myrscm/src/view/widget/widget_circular_progress.dart';
import 'package:flutter/material.dart';
class PageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: WidgetCircularProgress()
        ),
        color: Colors.grey[50]
    );
  }
}
