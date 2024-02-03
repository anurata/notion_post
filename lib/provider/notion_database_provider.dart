import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notion_post/api/notion_database_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notion_database_provider.g.dart';
part 'notion_database_provider.freezed.dart';

@freezed
class NotionDatabaseState with _$NotionDatabaseState {
  const factory NotionDatabaseState({
    required AsyncValue<List<String>> titles,
    required String newTitle,
    required bool isInputting,
    required bool isInserting,
  }) = _NotionDatabaseState;
}

@riverpod
class NotionDatabase extends _$NotionDatabase {
  @override
  NotionDatabaseState build() {
    return const NotionDatabaseState(
      titles: AsyncValue.loading(),
      isInputting: false,
      newTitle: '',
      isInserting: false,
    );
  }

  Future<void> getDatabaseTitles() async {
    state = state.copyWith(titles: const AsyncValue.loading());
    final notionDatabaseApi = ref.read(notionDatabaseApiProvider);
    try {
      final databaseId = await notionDatabaseApi.searchDatabases();
      if (databaseId == null) {
        state = state.copyWith(titles: const AsyncValue.data([]));
        return;
      }
      final results = await notionDatabaseApi.fetchTitles(
        databaseId: databaseId,
      );
      state = state.copyWith(titles: AsyncValue.data(results));
    } catch (e, s) {
      state = state.copyWith(titles: AsyncValue.error(e, s));
    }
  }

  Future<void> insertTitle({required String title}) async {
    state = state.copyWith(titles: const AsyncValue.loading());
    state = state.copyWith(isInserting: true);
    final notionDatabaseApi = ref.read(notionDatabaseApiProvider);
    try {
      final databaseId = await notionDatabaseApi.searchDatabases();
      if (databaseId == null) {
        state = state.copyWith(titles: const AsyncValue.data([]));
        return;
      }
      final results = await notionDatabaseApi.insertTitle(
        databaseId: databaseId,
        title: title,
      );
      state = state.copyWith(titles: AsyncValue.data(results));
      state = state.copyWith(isInserting: false);
    } catch (e, s) {
      state = state.copyWith(titles: AsyncValue.error(e, s));
    }
  }

  void startInput() => state = state.copyWith(isInputting: true);
  void endInput() => state = state.copyWith(isInputting: false);
}
