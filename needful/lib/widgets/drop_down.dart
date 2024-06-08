import 'package:flutter/material.dart';
import 'package:needful/widgets/MarketPlaceReceive.dart';
import 'package:needful/widgets/MarketPlaceDonate.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String _selectedItem = 'Receive';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedItem,
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue!;
            });
          },
          items: <String>['Donate', 'Receive'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        _selectedItem == 'Receive'
            ? const MarketPlaceReceive()
            : const MarketPlaceReceive(),
      ],
    );
  }
}
