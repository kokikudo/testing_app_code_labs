import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app_code_labs/models/favorites.dart';
import 'package:testing_app_code_labs/screens/home.dart';

// プロバイダーに囲まれたHomePageスクリーンを取得
Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group('Home Page Widget Tests', () {
    testWidgets('画面にListViewが表示されてるか確認', (tester) async {
      // Widgets生成プロセスを実行
      await tester.pumpWidget(createHomeScreen());
      // 画面にListView型のWidgetが一つある
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('スクロールの確認', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      // 先頭のListTileのテキストのItem0がスクリーン上に表示されている
      expect(find.text('Item 0'), findsOneWidget);

      // 下にスクロール
      await tester.fling(find.byType(ListView), Offset(0, -200), 3000);
      // アニメーション（この場合はスクロール）が終了するまでWidgetを生成し続ける
      await tester.pumpAndSettle();
      // スクロールしたので先頭のTileが見えないはず
      expect(find.text('Item 0'), findsNothing);
    });

    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      // お気に入り登録済みボタンが無い
      expect(find.byIcon(Icons.favorite), findsNothing);
      // 最初に見つけたお気に入り登録ボタンをタップ
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      // 1秒待って再描画
      await tester.pumpAndSettle(Duration(seconds: 1));
      // スナックバー確認
      expect(find.text('Added to favorites.'), findsOneWidget);
      // お気に入り登録済みボタンがあるか確認
      expect(find.byIcon(Icons.favorite), findsWidgets);
      // タップ
      await tester.tap(find.byIcon(Icons.favorite).first);
      // 1秒待機し再描画
      await tester.pumpAndSettle(Duration(seconds: 1));
      // スナックバー確認
      expect(find.text('Removed from favorites.'), findsOneWidget);
      // お気に入り登録済みボタンが解除
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}
