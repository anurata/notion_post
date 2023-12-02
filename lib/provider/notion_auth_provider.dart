import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notion_sample/model/notion_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notion_auth_provider.g.dart';

@riverpod
class NotionAuth extends _$NotionAuth {
  final _storage = const FlutterSecureStorage();
  @override
  AsyncValue<NotionAuthState> build() {
    return const AsyncValue.data(
      NotionAuthState(
        isAuth: false,
        workspaceIcon: null,
        workspaceName: null,
      ),
    );
  }

  Future<void> getNotionWorkspace() async {
    state = const AsyncValue.loading();
    try {
      final isAuth =
          await _storage.read(key: 'access_token') != null ? true : false;
      final workspaceName = await _storage.read(key: 'workspace_name');
      final workspaceIcon = await _storage.read(key: 'workspace_icon');
      if (isAuth) {
        state = AsyncValue.data(
          NotionAuthState(
            isAuth: true,
            workspaceIcon: workspaceIcon,
            workspaceName: workspaceName,
          ),
        );
      } else {
        state = const AsyncValue.data(
          NotionAuthState(
            isAuth: false,
            workspaceIcon: null,
            workspaceName: null,
          ),
        );
      }
    } catch (e) {
      throw Exception('Flutter Storage error: $e');
    }
  }

  Future<void> deleteNotionWorkspace() async {
    state = const AsyncValue.loading();
    try {
      _storage.delete(key: 'access_token');
      _storage.delete(key: 'workspace_name');
      _storage.delete(key: 'workspace_icon');
      state = const AsyncValue.data(
        NotionAuthState(
          isAuth: false,
          workspaceIcon: null,
          workspaceName: null,
        ),
      );
    } catch (e) {
      throw Exception('Flutter Storage error: $e');
    }
  }
}
