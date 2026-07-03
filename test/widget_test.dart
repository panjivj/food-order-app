import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/main.dart';

void main() {
  testWidgets('menu and creator identity are displayed', (tester) async {
    await tester.pumpWidget(const FoodOrderApp());

    expect(find.text('Daftar Menu'), findsOneWidget);
    expect(find.text('Nasi Goreng'), findsOneWidget);
    expect(find.text('Created By: Panji Jaya Sutra'), findsOneWidget);
    expect(find.text('NIM: 20220801517'), findsOneWidget);
  });

  testWidgets('adding an item updates cart total', (tester) async {
    await tester.pumpWidget(const FoodOrderApp());
    await tester.tap(find.text('Tambah').first);
    await tester.pump();

    expect(find.text('1 item'), findsOneWidget);
    expect(find.text('Total: Rp 20.000'), findsOneWidget);
  });
}
