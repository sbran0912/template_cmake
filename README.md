# Build

Voraussetzungen: CMake, Ninja, GLFW, OpenGL und gcc.

Es gibt nur noch einen Build:

| Build       | Compiler | Ausgabe        | Artefakt-Verzeichnis |
| ----------- | -------- | -------------- | -------------------- |
| CMake/Ninja | gcc      | `build/snake`  | `build/`             |

## CMake + Ninja

Aus dem Projektverzeichnis heraus:

```sh
cmake -S . -B build -G Ninja
cmake --build build
```

Das Binary liegt danach unter `build/snake`.

Nach Code-Änderungen genügt:

```sh
cmake --build build
```

Der Build-Typ ist standardmäßig `Release` (`-O2 -DNDEBUG`). Für einen
Debug-Build mit vollen Debug-Infos (`-O0 -g3`):

```sh
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug
cmake --build build
```

Ein Wechsel des Build-Typs in einem bestehenden `build/` funktioniert über
`cmake -S . -B build -DCMAKE_BUILD_TYPE=...`; im Zweifel `rm -rf build` und
neu konfigurieren.

Neu konfigurieren (`cmake -S . -B build -G Ninja`) muss man nur, wenn sich
`CMakeLists.txt` ändert, neue Dateien hinzukommen oder `build/` gelöscht wurde.

> Hinweis: Der Compiler ist in `CMakeLists.txt` fest auf `gcc` gesetzt. Ein
> bereits mit einem anderen Compiler konfiguriertes `build/` muss vorher
> gelöscht werden (`rm -rf build`). Überschreiben lässt sich der Compiler mit
> `-DCMAKE_C_COMPILER=...`.

## Make (nur noch Wrapper um CMake)

Das Makefile baut nicht mehr selbst, sondern ruft nur noch CMake auf:

```sh
make              # konfiguriert (Release) und baut build/snake
make cmake-debug  # konfiguriert (Debug) und baut build/snake
make cmake-init   # konfiguriert (cmake -S . -B build -G Ninja)
make cmake-run    # baut und startet build/snake
make cmake-clean  # entfernt build/
```

## Starten

```sh
./build/snake
```

Das Programm öffnet ein GLFW/OpenGL-Fenster und braucht daher eine grafische
Umgebung.

## Editor / clangd

Der CMake-Build erzeugt `build/compile_commands.json` (gcc). Damit clangd
die Compile-Flags automatisch findet, verweist die Datei `.clangd` im
Projektwurzelverzeichnis auf dieses Verzeichnis:

```yaml
CompileFlags:
  CompilationDatabase: build
```
