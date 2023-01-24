import 'dart:math';

import 'package:flutter/material.dart';

class SeekBarData {
  final Duration position;
  final Duration duration;

  SeekBarData(this.position, this.duration);
}

class SeekBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangedEnd;

  const SeekBar(
      {Key? key,
      required this.position,
      required this.duration,
      this.onChanged,
      this.onChangedEnd})
      : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  @override
  Widget build(BuildContext context) {
    double? _dragValue;

    return Expanded(
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(
                disabledThumbRadius: 4, enabledThumbRadius: 4),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
            activeTrackColor: Colors.white.withOpacity(0.2),
            inactiveTrackColor: Colors.white,
            thumbColor: Colors.white,
            overlayColor: Colors.white),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Slider(
                  min: 0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: min(
                      _dragValue ?? widget.position.inMilliseconds.toDouble(),
                      widget.position.inMilliseconds.toDouble()),
                  onChanged: (value) {
                    setState(() {
                      _dragValue = value;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(Duration(milliseconds: value.round()));
                    }

                  }),
            )
          ],
        ),
      ),
    );
  }
}
