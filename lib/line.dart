import 'package:flutter/material.dart';
import 'package:xoxgame/custom_colors.dart';
import 'line_form.dart';

class Line extends StatefulWidget {
  final LineForm form;
  final int position;
  final String attack;

  const Line({
    Key? key,
    required this.form,
    required this.position,
    required this.attack,
  }) : super(key: key); // 0 1 2

  @override
  State<StatefulWidget> createState() => _LineState();
}

class _LineState extends State<Line> with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    var controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: LinePainter(
      progress: _progress,
      form: widget.form,
      position: widget.position,
      attack: widget.attack,
    ));
  }
}

class LinePainter extends CustomPainter {
  late Paint _paint;
  final double progress;
  final LineForm form;
  final int position; // 0 1 2
  final String attack;

  LinePainter(
      {required this.progress,
      required this.form,
      required this.position,
      required this.attack}) {
    _paint = Paint()
      ..color = attack == 'X' ? CustomColors.xColor : CustomColors.oColor
      ..strokeWidth = 8.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (form) {
      case LineForm.HORIZONTAL:
        canvas.drawLine(
          Offset(
            0.0,
            size.width / 6 * (position * 2 + 1),
          ),
          Offset(
            size.height - size.height * progress,
            size.width / 6 * (position * 2 + 1),
          ),
          // Offset(size.width - size.width * progress,
          //     size.height - size.height * progress),
          _paint,
        );
        break;
      case LineForm.VERTICAL:
        canvas.drawLine(
          Offset(size.width / 6 * (position * 2 + 1), 0.0),
          Offset(size.width / 6 * (position * 2 + 1),
              size.height - size.height * progress),
          // Offset(size.width - size.width * progress,
          //     size.height - size.height * progress),
          _paint,
        );
        break;
      case LineForm.CROSS:
        if (position == 0) {
          canvas.drawLine(
            Offset(0.0, 0.0),
            Offset(size.width - size.width * progress,
                size.height - size.height * progress),
            _paint,
          );
        } else {
          canvas.drawLine(
            Offset(size.width, 0.0),
            Offset(
              size.width * progress,
              size.height - size.height * progress,
            ),
            _paint,
          );
        }

        break;
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
