import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_desktop_saver/core/constants/app_constants.dart';
import 'package:video_desktop_saver/core/widget/keyboard_widget.dart';
import 'package:video_desktop_saver/features/keyboard/data/typing_result.dart';
import 'package:video_desktop_saver/features/keyboard/domain/keyboard_state.dart';

class KeyboardScreen extends StatefulWidget {
  const KeyboardScreen({super.key});
  static const String routeName = '/keyboard_screen';

  @override
  State<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  Timer? wpmTimer;
  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    startWpmTimer();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    wpmTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardState = Provider.of<KeyboardState>(context);

    String currentText = keyboardState.currentText;
    String userInput = keyboardState.userInput;
    int currentPosition = keyboardState.currentPosition;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTextInputOptions(context);
        },
        backgroundColor: Colors.blue[400],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: KeyboardListener(
        onKeyEvent: (event) {
          final keyboardState =
              Provider.of<KeyboardState>(context, listen: false);
          String? keyLabel = _getKeyLabel(event.logicalKey);

          if (keyLabel != null) {
            if (event is KeyDownEvent) {
              keyboardState.pressKey(keyLabel);

              if (keyLabel == 'Backspace' && _controller.text.isNotEmpty) {
                _controller.text =
                    _controller.text.substring(0, _controller.text.length - 1);
              } else if (keyLabel == 'Space') {
                _controller.text += ' ';
              } else if (keyLabel.length == 1) {
                String expectedChar =
                    keyboardState.currentText[keyboardState.currentPosition];
                if (keyLabel.toLowerCase() == expectedChar.toLowerCase()) {
                  _controller.text += expectedChar; // сохраняем оригинал
                }
              }
              // 👇 Обновляем состояние
              keyboardState.updateUserInput(_controller.text);
              if (keyboardState.isCompleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ Текст завершён!')),
                );
                final resultBox =
                    Hive.box<TypingResult>(AppConstants.resultBox);
                resultBox.add(TypingResult(
                  wpm: keyboardState.wpm,
                  timeStamp: DateTime.now(),
                ));
                _controller.clear(); // сброс ввода
              }
            } else if (event is KeyUpEvent) {
              keyboardState.releaseKey(keyLabel);
            }
          }
        },
        focusNode: _focusNode,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: 100,
              child: Stack(children: [
                Positioned(
                  left: 10,
                  top: 10,
                  child: Text(
                    '${keyboardState.wpm.toStringAsFixed(1)} WPM',
                    style: GoogleFonts.asapCondensed(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
            ),
            // Text display area
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
                right: 30,
                left: 30,
              ),
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: _buildTextSpans(
                            currentText, userInput, currentPosition),
                      ),
                    ),
                  ),
                  // History widget with fixed width
                  Container(
                    width:
                        200, // Adjusted width without .w (remove flutter_screenutil dependency if not needed)
                    height: 200,
                    margin: const EdgeInsets.only(left: 16.0),
                    child: _buildWpmHistory(),
                  ),
                ],
              ),
            ),
            // Hidden TextField for input
            Opacity(
              opacity: 0.0,
              child: TextField(
                controller: _controller,
                decoration: null,
                style: const TextStyle(color: Colors.transparent),
                cursorColor: Colors.transparent,
                maxLength: currentText.length, // Prevent over-typing
              ),
            ),
            // Virtual keyboard
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[800],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildKeyboardRow([
                    'Q',
                    'W',
                    'E',
                    'R',
                    'T',
                    'Y',
                    'U',
                    'I',
                    'O',
                    'P',
                    '<-',
                  ]),
                  const SizedBox(height: 8),
                  _buildKeyboardRow(
                      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L']),
                  const SizedBox(height: 8),
                  _buildKeyboardRow(
                      ['Z', 'X', 'C', 'V', 'B', 'N', 'M', ',', '.']),
                  const SizedBox(height: 8),
                  _buildKeyboardRow(['Space'], isSpace: true),
                ],
              ),
            ),
            // Reset button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  keyboardState.resetText();
                  _controller.clear();
                  _focusNode.requestFocus();
                },
                child: const Text('New Text'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String target, String input, int position) {
    List<TextSpan> spans = [];
    for (int i = 0; i < target.length; i++) {
      if (i < input.length) {
        // Already typed
        spans.add(TextSpan(
          text: target[i],
          style: GoogleFonts.robotoMono(
            // Changed to monospace for readability
            fontSize: 24,
            color: target[i] == input[i] ? Colors.green : Colors.red,
          ),
        ));
      } else if (i == position) {
        // Current letter
        spans.add(TextSpan(
          text: target[i],
          style: GoogleFonts.robotoMono(
            fontSize: 24,
            color: Colors.white,
            decoration: TextDecoration.underline,
          ),
        ));
      } else {
        // Upcoming letters
        spans.add(TextSpan(
          text: target[i],
          style: GoogleFonts.robotoMono(
            fontSize: 24,
            color: Colors.grey[500],
          ),
        ));
      }
    }
    return spans;
  }

  String? _getKeyLabel(LogicalKeyboardKey key) {
    final keyLabels = {
      LogicalKeyboardKey.keyQ: 'Q',
      LogicalKeyboardKey.keyW: 'W',
      LogicalKeyboardKey.keyE: 'E',
      LogicalKeyboardKey.keyR: 'R',
      LogicalKeyboardKey.keyT: 'T',
      LogicalKeyboardKey.keyY: 'Y',
      LogicalKeyboardKey.keyU: 'U',
      LogicalKeyboardKey.keyI: 'I',
      LogicalKeyboardKey.keyO: 'O',
      LogicalKeyboardKey.keyP: 'P',
      LogicalKeyboardKey.keyA: 'A',
      LogicalKeyboardKey.keyS: 'S',
      LogicalKeyboardKey.keyD: 'D',
      LogicalKeyboardKey.keyF: 'F',
      LogicalKeyboardKey.keyG: 'G',
      LogicalKeyboardKey.keyH: 'H',
      LogicalKeyboardKey.keyJ: 'J',
      LogicalKeyboardKey.keyK: 'K',
      LogicalKeyboardKey.keyL: 'L',
      LogicalKeyboardKey.keyZ: 'Z',
      LogicalKeyboardKey.keyX: 'X',
      LogicalKeyboardKey.keyC: 'C',
      LogicalKeyboardKey.keyV: 'V',
      LogicalKeyboardKey.keyB: 'B',
      LogicalKeyboardKey.keyN: 'N',
      LogicalKeyboardKey.keyM: 'M',
      LogicalKeyboardKey.space: 'Space',
      LogicalKeyboardKey.backspace: 'Backspace',
      LogicalKeyboardKey.period: '.',
      LogicalKeyboardKey.comma: ',',
    };
    return keyLabels[key];
  }

  Widget _buildKeyboardRow(List<String> list, {bool isSpace = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.map((key) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: KeyboardWidget(
            keyLabel: key,
            isSpace: isSpace,
          ),
        );
      }).toList(),
    );
  }

  void _showTextInputOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.file_open),
            title: const Text('Загрузить с .docx'),
            onTap: () async {
              context.pop();
              await _pickDocxFile(context);
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Напечатать вручную'),
            onTap: () {
              Navigator.pop(context);
              _showManualInputDialog(context);
            },
          )
        ],
      ),
    );
  }

  void _showManualInputDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Введите текст'),
        content: TextField(
          controller: controller,
          maxLines: 10,
          decoration:
              const InputDecoration(hintText: 'Введите свой текст здесь'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              final text = controller.text;
              Provider.of<KeyboardState>(context, listen: false).setText(text);
              Navigator.pop(context);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  Widget _buildWpmHistory() {
    final box = Hive.box<TypingResult>(AppConstants.resultBox);
    final results = box.values.toList().reversed.toList(); // последние — сверху

    if (results.isEmpty) {
      return const Center(
        child: Text(
          'Нет результатов',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Card(
          color: Colors.grey[850],
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${result.wpm.toStringAsFixed(1)} WPM\n${formatDate(result.timeStamp)}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  String formatDate(DateTime dateTime) {
    final formatter = DateFormat('dd MMM, HH:mm');
    return formatter.format(dateTime);
  }

  Future<void> _pickDocxFile(BuildContext context) async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final content = await file.readAsString();

      if (context.mounted) {
        Provider.of<KeyboardState>(context, listen: false).setText(content);
      }
    }
  }

  void startWpmTimer() {
    wpmTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
  }
}
