import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar(
      {super.key,
      required double value,
      required ColorScheme colorScheme,
      required String unit})
      : _value = value,
        _colorScheme = colorScheme,
        _unit = unit;
  final sensorValueStyle = const TextStyle(
    fontSize: 25,
  );
  final double _value;
  final ColorScheme _colorScheme;
  final String _unit;
  @override
  Widget build(BuildContext context) {
    final sensorHandleColor = _colorScheme.primary;
    final sensorHandleBGColor = _colorScheme.onPrimaryContainer;
    return SizedBox(
      height: 200,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              cornerStyle: CornerStyle.bothCurve,
              color: sensorHandleBGColor,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: _value,
                cornerStyle: CornerStyle.bothCurve,
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
                color: sensorHandleColor,
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: Text(
                  '${_value.toStringAsFixed(0)}$_unit',
                  style: sensorValueStyle,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
