import 'package:flutter/material.dart';

void main() => runApp(const SudokuApp());

class SudokuApp extends StatelessWidget {
  const SudokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SudokuGame(),
    );
  }
}

class SudokuGame extends StatefulWidget {
  const SudokuGame({super.key});

  @override
  State<SudokuGame> createState() => _SudokuGameState();
}

class _SudokuGameState extends State<SudokuGame> {
  // 81개의 칸 데이터를 담는 리스트 (0은 빈칸을 의미)
  List<int> board = List.filled(81, 0);

  void _onCellTap(int index) {
    setState(() {
      // 누를 때마다 숫자가 1 -> 2 -> ... -> 9 -> 0(빈칸) 순으로 바뀜
      board[index] = (board[index] + 1) % 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('나의 스도쿠 - 입력 모드'), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
              child: GridView.builder(
                itemCount: 81,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 9),
                itemBuilder: (context, index) {
                  int row = index ~/ 9;
                  int col = index % 9;

                  return GestureDetector(
                    onTap: () => _onCellTap(index), // 칸을 누르면 실행
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: (row % 3 == 2 && row < 8) ? 3.0 : 0.5),
                          right: BorderSide(width: (col % 3 == 2 && col < 8) ? 3.0 : 0.5),
                          top: const BorderSide(width: 0.5),
                          left: const BorderSide(width: 0.5),
                        ),
                        color: board[index] == 0 ? Colors.white : Colors.blue[50],
                      ),
                      child: Center(
                        child: Text(
                          board[index] == 0 ? '' : '${board[index]}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}