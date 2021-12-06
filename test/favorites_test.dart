import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app_code_labs/models/favorites.dart';
import 'package:testing_app_code_labs/screens/favorites.dart';

// 後で定義
late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        // コールバック時にFavoritesをインスタンス化
        favoritesList = Favorites();
        return favoritesList;
      },
      child: MaterialApp(
        home: FavoritesPage(),
      ),
    );

// 偶数のIDを追加
void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('Favorites Page Widget Tests', () {
    testWidgets('追加後のListViewの確認', (tester) async {
      // スクリーンの生成。Favaritesクラスのインスタンス化
      await tester.pumpWidget(createFavoritesScreen());
      // テスト用にIDを追加
      addItems();
      // 追加のアニメーションが終わるまで生成
      await tester.pumpAndSettle();
      // 確認
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('削除ボタンの挙動確認', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();

      // tester.widgetListで見つかったWidgetをリストに格納
      var totalItems = tester.widgetList(find.byIcon(Icons.close)).length;
      // 最初の削除ボタンをタップ
      await tester.tap(find.byIcon(Icons.close).first);
      // 再描画
      await tester.pumpAndSettle();
      // 削除ボタンの数が、押す前より押した後の方が少ない＝＞リストから消えている
      expect(tester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(totalItems));
      // スナックの確認
      expect(find.text('Removed from favorites.'), findsOneWidget);
    });
  });
}
