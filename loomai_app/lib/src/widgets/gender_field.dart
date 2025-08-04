import 'package:flutter/material.dart';

class GenderField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String defaultValue;

  const GenderField({
    super.key,
    required this.onChanged,
    this.defaultValue = 'Male', // 預設使用 internal value
  });

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  String? selectedGender;
  String? otherText;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.defaultValue;
    // 預設值觸發 onChanged
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChanged(
        selectedGender == 'Other' ? (otherText ?? '') : selectedGender!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AI 性別', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                      otherText = null;
                      widget.onChanged(value!);
                    });
                  },
                ),
                const Text('男性'),
              ],
            ),
            const SizedBox(width: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: 'Female',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                      otherText = null;
                      widget.onChanged(value!);
                    });
                  },
                ),
                const Text('女性'),
              ],
            ),
            const SizedBox(width: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: 'Other',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                      widget.onChanged(otherText ?? '');
                    });
                  },
                ),
                const Text('其他'),
              ],
            ),
          ],
        ),
        if (selectedGender == 'Other')
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: '請輸入性別(可空白)',
                    isDense: true,
                  ),
                  onChanged: (value) {
                    otherText = value;
                    widget.onChanged(value);
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
      ],
    );
  }
}
