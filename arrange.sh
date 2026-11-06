ls -1
miss=""
m() { mkdir -p "$1"; d=$1; shift; for f in "$@"; do if [ -f "$f" ]; then mv "$f" "$d/"; else miss="$miss $f"; fi; done; }
J=app/src/main/java/com/glassextend/app
R=app/src/main/res
m $J Imaging.kt Outpaint.kt ExtendViewModel.kt MainActivity.kt
m $J/ui GlassTheme.kt Preview.kt Controls.kt Screens.kt
m $R/values strings.xml colors.xml themes.xml
m $R/drawable ic_launcher_background.xml ic_launcher_foreground.xml
m $R/mipmap-anydpi-v26 ic_launcher.xml
m app/src/main AndroidManifest.xml
m app proguard-rules.pro
if [ -f app-build.gradle.kts ]; then mv app-build.gradle.kts app/build.gradle.kts; else miss="$miss app-build.gradle.kts"; fi
for f in settings.gradle.kts build.gradle.kts gradle.properties; do [ -f "$f" ] || miss="$miss $f"; done
if [ -n "$miss" ]; then echo "::error::Missing files:$miss"; exit 1; fi
echo "All files arranged."
