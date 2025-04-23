import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:video_desktop_saver/features/keyboard/domain/keyboard_state.dart';

class KeyboardWidget extends StatelessWidget {
  final String keyLabel;
  final bool isSpace;

  const KeyboardWidget({
    super.key,
    required this.keyLabel,
    this.isSpace = false,
  });

  @override
  Widget build(BuildContext context) {
    final keyboardState = Provider.of<KeyboardState>(context);
    final isPressed =
        keyboardState.pressedKeys.contains(keyLabel.toUpperCase());
    return Container(
      width: isSpace ? 100 : 50,
      height: 50,
      decoration: BoxDecoration(
        color: isPressed ? Colors.blueAccent : Colors.grey[700],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      ),
      child: Center(
        child: Text(
          keyLabel,
          style: GoogleFonts.aladin(
            color: isPressed ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
