import 'dart:io';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('❌ Error: Please provide a feature/module name.');
    print('Usage: dart run scripts/generate_feature.dart <name>');
    exit(1);
  }

  final rawName = arguments.first.trim();
  final featureName = rawName.toLowerCase();
  final capitalizedName = rawName[0].toUpperCase() + rawName.substring(1);

  final baseDir = 'lib';
  final folders = [
    '$baseDir/features/$featureName/data',
    '$baseDir/features/$featureName/model',
    '$baseDir/features/$featureName/repository',
    '$baseDir/src/view/$featureName',
  ];

  print('🚀 Generating structure for: $capitalizedName...');

  for (final folder in folders) {
    await Directory(folder).create(recursive: true);
  }

  await _createFile(
    '$baseDir/features/$featureName/repository/${featureName}_repo.dart',
    '''
    abstract class ${capitalizedName}Repo {
      // TODO: Define abstract methods here
    }
    ''',
  );

  await _createFile(
    '$baseDir/features/$featureName/repository/${featureName}_repo_impl.dart',
    '''
    import '${featureName}_repo.dart';

    class ${capitalizedName}RepoImpl implements ${capitalizedName}Repo {
      // TODO: Implement repository logic
    }
    ''',
  );

  await _createFile(
    '$baseDir/src/view/$featureName/${featureName}_provider.dart',
    '''
    import 'package:flutter/foundation.dart';

    class ${capitalizedName}Provider extends ChangeNotifier {
      // TODO: Add state logic here
    }
    ''',
  );

  await _createFile(
    '$baseDir/src/view/$featureName/${featureName}_view.dart',
    '''
    import 'package:flutter/material.dart';

    class ${capitalizedName}View extends StatelessWidget {
      const ${capitalizedName}View({super.key});

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text('$capitalizedName')),
          body: const Center(
            child: Text('$capitalizedName View'),
          ),
        );
      }
    }
    ''',
  );

  print('✅ Successfully generated $capitalizedName module structure!\n');

  // Print the tree for features and view folders
  print('lib/');
  _printFullTree(Directory(baseDir));
  // _printTree(Directory('$baseDir/features/$featureName'), '│   ');
  // _printTree(Directory('$baseDir/src/view/$featureName'), '│   ', isLast: true);
}

Future<void> _createFile(String path, String content) async {
  final file = File(path);
  await file.parent.create(recursive: true);
  if (!await file.exists()) {
    await file.writeAsString(content.trim());
  }
}

void _printTree(Directory dir, String prefix, {bool isLast = false}) {
  final entities =
      dir.listSync().toList()..sort((a, b) => a.path.compareTo(b.path));

  for (var i = 0; i < entities.length; i++) {
    final entity = entities[i];
    final last = i == entities.length - 1;
    final pointer = last ? '└── ' : '├── ';
    final name = entity.uri.pathSegments.where((s) => s.isNotEmpty).last;

    print('$prefix$pointer$name');

    if (entity is Directory) {
      final newPrefix = prefix + (last ? '    ' : '│   ');
      _printTree(entity, newPrefix);
    }
  }

  
}
void _printFullTree(Directory dir, [String prefix = '']) {
  final entities = dir.listSync().toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  for (var i = 0; i < entities.length; i++) {
    final entity = entities[i];
    final isLast = i == entities.length - 1;
    final pointer = isLast ? '└── ' : '├── ';
    final name = entity.uri.pathSegments.where((s) => s.isNotEmpty).last;

    print('$prefix$pointer$name');

    if (entity is Directory) {
      final extension = isLast ? '    ' : '│   ';
      _printFullTree(entity, prefix + extension);
    }
  }}