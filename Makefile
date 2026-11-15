BUILDDIR = build
APPNAME  = snake 
.PHONY: cmake cmake-debug cmake-clean cmake-run cmake-init cmake-tidy

# cmake builds
cmake:
	cmake -S . -B $(BUILDDIR) -G Ninja -DCMAKE_BUILD_TYPE=Release
	cmake --build $(BUILDDIR)

# Debug-Build (-O0 -g3), Binary unter build/snake.
cmake-debug:
	cmake -S . -B $(BUILDDIR) -G Ninja -DCMAKE_BUILD_TYPE=Debug
	cmake --build $(BUILDDIR)

cmake-clean:
	rm -rf $(BUILDDIR)

cmake-run: cmake
	./$(BUILDDIR)/$(APPNAME)

cmake-init:
	cmake -S . -B $(BUILDDIR) -G Ninja

# clang-tidy ueber die Compile-Datenbank aus build/.
# cmake-init stellt sicher, dass build/compile_commands.json existiert.
cmake-tidy: cmake-init
	@echo "----------------------------"
	@echo "Prüfen auf Speicherfehler..."
	@echo "----------------------------"
	clang-tidy -p $(BUILDDIR) lib3d/*.c app/*.c
