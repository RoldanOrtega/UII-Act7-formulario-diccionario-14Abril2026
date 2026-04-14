import 'dart:io';

const String reset = '\x1B[0m';
const String blackText = '\x1B[30m';
const String darkBlueText = '\x1B[34m';
const String lightBlueText = '\x1B[36m'; // Cyan acts as a visible light blue on terminal
const String bgLightBlue = '\x1B[106m';  // Cyan background
const String bold = '\x1B[1m';

void printHeader(String text) {
  print('\n$bgLightBlue$blackText$bold $text $reset');
}

void printInfo(String text) {
  print('$lightBlueText> $text$reset');
}

void printSubInfo(String text) {
  print('$darkBlueText  $text$reset');
}

String askQuestion(String question) {
  stdout.write('$bgLightBlue$blackText ? $reset$lightBlueText $question \n$darkBlueText> $reset');
  String? answer = stdin.readLineSync();
  return answer?.trim() ?? '';
}

Future<bool> runCommand(String executable, List<String> arguments, {bool showOutput = true}) async {
  if (showOutput) printSubInfo('Ejecutando: $executable ${arguments.join(' ')}');
  var result = await Process.run(executable, arguments);
  
  if (showOutput && result.stdout.toString().trim().isNotEmpty) {
    printSubInfo(result.stdout.toString().trim());
  }
  if (result.stderr.toString().trim().isNotEmpty) {
    // Git usually dumps progress and warnings to stderr, so we color it dark blue
    printSubInfo(result.stderr.toString().trim());
  }
  return result.exitCode == 0;
}

void main() async {
  printHeader('=== AGENTE DE REPOSITORIO GITHUB ===');
  printInfo('Iniciando configuración y carga al repositorio...');

  // 1. Revisar si git está instalado
  var gitCheck = await Process.run('git', ['--version']);
  if (gitCheck.exitCode != 0) {
    print('\n$bgLightBlue$blackText [ERROR] $reset$lightBlueText Git no está instalado o no se encuentra configurado en el PATH.$reset');
    return;
  }

  // 2. Inicializar repositorio git si no existe
  var isGit = await Process.run('git', ['rev-parse', '--is-inside-work-tree']);
  if (isGit.exitCode != 0) {
    printInfo('Inicializando nuevo repositorio Git...');
    await runCommand('git', ['init']);
  } else {
    printInfo('Repositorio Git detectado localmente.');
  }

  // 3. Revisar y configurar el remoto (remote URL)
  var remoteResult = await Process.run('git', ['remote', '-v']);
  String remotes = remoteResult.stdout.toString();
  
  if (remotes.isEmpty) {
    String repoLink = askQuestion('Ingrese el enlace del repositorio GitHub (Ej. https://github.com/usuario/repo.git):');
    if (repoLink.isNotEmpty) {
      await runCommand('git', ['remote', 'add', 'origin', repoLink]);
      printInfo('Remoto "origin" agregado correctamente.');
    } else {
      printInfo('No se ingresó un remoto. (Nota: el comando Push puede fallar si no hay un origin).');
    }
  } else {
    printInfo('Remotos configurados actualmente:');
    printSubInfo(remotes);
    String changeRemote = askQuestion('¿Desea cambiar o agregar un enlace remoto diferente? (s/N):');
    if (changeRemote.toLowerCase() == 's') {
      String repoLink = askQuestion('Ingrese el nuevo enlace del repositorio GitHub:');
      if (repoLink.isNotEmpty) {
        if (remotes.contains('origin')) {
          await runCommand('git', ['remote', 'set-url', 'origin', repoLink]);
        } else {
          await runCommand('git', ['remote', 'add', 'origin', repoLink]);
        }
        printInfo('Remoto origin actualizado exitosamente.');
      }
    }
  }

  // 4. Agregar cambios (git add .)
  printInfo('Preparando archivos para confirmar (git add .)...');
  await runCommand('git', ['add', '.']);

  // 5. Preguntar por el mensaje de commit
  var statusResult = await Process.run('git', ['status', '--porcelain']);
  if (statusResult.stdout.toString().trim().isEmpty) {
    printInfo('No se detectaron cambios pendientes por conformar.');
  } else {
    String commitMessage = askQuestion('Ingrese el mensaje para este Commit:');
    if (commitMessage.isEmpty) {
      commitMessage = 'Actualización automática usando Agente Repositorio en Dart';
    }
    await runCommand('git', ['commit', '-m', commitMessage]);
    printInfo('Commit se ha guardado exitosamente.');
  }

  // 6. Configurar la rama principal
  String branch = askQuestion('Ingrese el nombre de la rama (Deje vacio y presione Enter para usar "main" por defecto):');
  if (branch.isEmpty) {
    branch = 'main';
  }

  printInfo('Estableciendo y cambiando a la rama "$branch"...');
  await runCommand('git', ['branch', '-M', branch]);

  // 7. Subir código a GitHub
  printInfo('Subiendo cambios a GitHub en la rama "$branch"...');
  bool pushSuccess = await runCommand('git', ['push', '-u', 'origin', branch]);

  if (pushSuccess) {
    printHeader('=== ÉXITO: LOS CAMBIOS SE SUBIERON A GITHUB ===');
  } else {
    print('\n$bgLightBlue$blackText [OJO] $reset$lightBlueText Hubo un problema al subir los cambios a GitHub.$reset');
    print('$darkBlueText> Verifica que estés autenticado con GitHub o que el link sea correcto.$reset');
  }
}
