import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notion_sample/provider/notion_database_provider.dart';

class NotionDatabaseListWidget extends ConsumerWidget {
  const NotionDatabaseListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notionDatabaseTitles =
        ref.watch(notionDatabaseProvider.select((state) => state.titles));
    final isInputting =
        ref.watch(notionDatabaseProvider.select((state) => state.isInputting));
    final isInserting =
        ref.watch(notionDatabaseProvider.select((state) => state.isInserting));
    final notionDatabaseNotifier = ref.read(notionDatabaseProvider.notifier);
    final TextEditingController controller = TextEditingController();
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (notionDatabaseTitles is AsyncLoading && !isInserting) {
        ref.read(notionDatabaseProvider.notifier).getDatabaseTitles();
      }
    });
    return SingleChildScrollView(
        reverse: true,
        child: Padding(
            padding: isInputting
                ? EdgeInsets.only(bottom: bottomSpace)
                : EdgeInsets.zero,
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onTap: () => notionDatabaseNotifier.startInput(),
                    decoration: InputDecoration(
                      prefixIcon: isInputting
                          ? IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                notionDatabaseNotifier.endInput();
                              })
                          : null,
                      border: const OutlineInputBorder(),
                      hintText: 'タイトル',
                    ),
                    onSubmitted: (value) {
                      notionDatabaseNotifier.insertTitle(title: value);
                      notionDatabaseNotifier.endInput();
                      controller.clear();
                    },
                  )),
              notionDatabaseTitles.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(child: Text('データがありません'));
                  }
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          height: 250,
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final title = data[index];
                                return Card(
                                    child: ListTile(
                                  title: Text(title),
                                ));
                              })));
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text(error.toString()),
              )
            ])));
  }
}
