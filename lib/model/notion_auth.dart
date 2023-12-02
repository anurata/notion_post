import 'package:freezed_annotation/freezed_annotation.dart';

part 'notion_auth.freezed.dart';

@freezed
class NotionAuthState with _$NotionAuthState {
  const factory NotionAuthState({
    required bool isAuth,
    required String? workspaceIcon,
    required String? workspaceName,
  }) = _NotionAuthState;
}
