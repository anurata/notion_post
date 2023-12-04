import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notion_sample/api/notion_oauth_api.dart';
import 'package:notion_sample/provider/notion_auth_provider.dart';
import 'package:notion_sample/provider/webview_provider.dart';
import 'package:notion_sample/widget/notion_login_webview_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notionAuthAsync = ref.watch(notionAuthProvider);
    final notionAuthNotifier = ref.read(notionAuthProvider.notifier);
    final webview = ref.watch(webViewProvider);
    final webviewNotifier = ref.read(webViewProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (notionAuthAsync is AsyncLoading) {
        ref.read(notionAuthProvider.notifier).getNotionWorkspace();
      }
    });
    if (webview.isOpen) {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                  title: Row(children: [
                IconButton(
                  icon: const Icon(Icons.close_outlined, color: Colors.black),
                  onPressed: () => webviewNotifier.hide(),
                ),
                const Center(child: Text("Notionと連携")),
              ])),
              body: Column(children: [
                Expanded(
                    child: Stack(children: <Widget>[
                  const NotionLoginWebviewWidget(),
                  webview.isError
                      ? Center(child: Text(webview.errorText))
                      : webview.isLoading
                          ? Container(
                              color: Colors.white,
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : Container()
                ]))
              ])));
    } else {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: const Text('Notion Sample'),
              ),
              body: notionAuthAsync.when(
                error: (error, stackTrace) => Center(
                  child: Text('Error: $error'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (notionAuth) {
                  if (notionAuth.isAuth) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${notionAuth.workspaceName}'),
                          const SizedBox(height: 16),
                          notionAuth.workspaceIcon != null
                              ? Image.network(notionAuth.workspaceIcon!)
                              : const SizedBox(),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              await notionAuthNotifier.deleteNotionWorkspace();
                            },
                            child: const Text('連携を解除'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          webviewNotifier.show();
                        },
                        child: const Text('Notionと連携する'),
                      ),
                    );
                  }
                },
              )));
    }
  }
}
