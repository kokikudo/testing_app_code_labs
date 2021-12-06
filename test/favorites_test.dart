import 'package:test/test.dart';
import 'package:testing_app_code_labs/models/favorites.dart';

void main() {
  group('Testing App Provider', () {
    var favorites = Favorites();

    test('番号が追加されているかの確認', () {
      var number = 35;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });

    test('番号追加→削除', () {
      var number = 45;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
      favorites.remove(number);
      expect(favorites.items.contains(number), false);
    });

    test('100個追加、その後削除', () {
      for (var id = 0; id < 100; id++) {
        favorites.add(id);
      }
      expect(favorites.items.length, 100);

      for (var id = 0; id < 100; id++) {
        favorites.remove(id);
      }
      expect(favorites.items.length, 0);
    });
  });
}
