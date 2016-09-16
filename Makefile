VALAC = valac
VALAPKG = --pkg gtk+-3.0 \
          --pkg gdk-3.0 \
          --pkg gee-0.8 \
          --pkg libnotify \

LIBS_SRC = libs/pulse.vala

SRC = src/main.vala \
      src/volume.vala \

OPTIONS = -X "-DGMENU_I_KNOW_THIS_IS_UNSTABLE" --target-glib 2.32 #--disable-warnings
BIN = koelintang

BIN_DIR = /usr/share/koelintang
SYSTEM_EXECUTABLE = /usr/bin/koelintang
DESKTOP_FILE = data/koelintang.desktop

all:
	echo "Starting compilation"
	$(VALAC) $(VAPIS) $(VALAPKG) $(LIBS_SRC) $(LTK_SRC) $(SRC) $(OPTIONS) -o $(BIN)
	echo "Compilation finished successfully"

clean:
	rm -f $(BIN)

install: all
	echo "Starting the installation"
	mkdir -p $(BIN_DIR)
	cp $(BIN) $(BIN_DESTINATION)
	chmod +x $(BIN_DESTINATION)
	cp $(LOCAL_EXECUTABLE) $(SYSTEM_EXECUTABLE)
	chmod +x $(SYSTEM_EXECUTABLE)
	echo "Installation finished successfully"

