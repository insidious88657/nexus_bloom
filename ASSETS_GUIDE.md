# NexusBloom Asset Creation Guide 🎨

This guide will help you create all the visual assets needed for App Store and Play Store submission.

## Required Assets Checklist

### App Icon
- [ ] `app/assets/icon.png` (1024x1024)
- [ ] `app/assets/icon_foreground.png` (432x432, Android adaptive)

### Splash Screen
- [ ] `app/assets/splash.png` (1242x2688, scales down)
- [ ] `app/assets/splash_android12.png` (288x288, Android 12+)
- [ ] `app/assets/branding.png` (optional, bottom logo)

### Store Screenshots
- [ ] 5-8 screenshots per platform (see sizes below)
- [ ] Feature graphic (Android)
- [ ] App preview video (optional but recommended)

---

## 1. App Icon Creation

### Design Specifications
- **Theme**: Glowing bioluminescent orb with particle effects
- **Colors**: Cyan (#00E5FF) → Indigo (#1A237E) → Purple (#9C27B0) gradient
- **Background**: Dark cosmic (#0A1F3A) or transparent
- **Style**: Soft glow, dreamy, alive

### Tools
- **Figma/Sketch**: Professional, free tier available
- **Canva**: Easy drag-and-drop
- **Blender**: For 3D orb rendering
- **DALL-E/Midjourney**: AI-generated base (then refine)

### Prompt for AI Generation
```
A glowing bioluminescent orb floating in cosmic space, 
cyan to purple gradient, soft particle effects emanating outward,
dark navy background, dreamy and alive, centered composition,
minimalist, app icon style, high quality
```

### Sizes Needed
1. **icon.png** (1024x1024)
   - Full icon with background
   - PNG with or without transparency
   - Will be scaled down for all platforms

2. **icon_foreground.png** (432x432)
   - Just the orb, centered
   - Transparent background
   - Android adaptive icon foreground layer

### Generation Command
```bash
cd app
flutter pub run flutter_launcher_icons
```

---

## 2. Splash Screen Creation

### Design Specifications
- **Background**: Solid dark cosmic (#0A1F3A)
- **Center**: Glowing orb (same as icon but can be larger/more detailed)
- **Optional**: "NexusBloom" text at bottom
- **Animation**: Consider subtle pulse (native splash is static, but sets tone)

### Sizes Needed
1. **splash.png** (1242x2688 pixels)
   - iOS retina resolution
   - Will scale down for Android
   - Centered orb on dark background

2. **splash_android12.png** (288x288 pixels)
   - Android 12+ splash icon
   - Just the orb, no background
   - Transparent PNG

3. **branding.png** (optional, ~400x100 pixels)
   - "NexusBloom" text logo
   - Placed at bottom of splash screen
   - Use app font (or system font with glow effect)

### Generation Command
```bash
cd app
flutter pub run flutter_native_splash:create
```

---

## 3. Store Screenshots

### Required Sizes

#### iOS (App Store)
- **6.5" iPhone** (1242 x 2688 px) - iPhone 11 Pro Max, 12 Pro Max, 13 Pro Max
- **5.5" iPhone** (1242 x 2208 px) - iPhone 8 Plus
- **12.9" iPad Pro** (2048 x 2732 px)

#### Android (Play Store)
- **Phone** (1080 x 1920 px minimum, up to 7680 x 4320 px)
- **7" Tablet** (1200 x 1920 px)
- **10" Tablet** (1920 x 2560 px)
- **Feature Graphic** (1024 x 500 px) - shown in Play Store

### Screenshot Content Ideas
1. **Birth Sequence** - Orb forming from particles (if implemented)
2. **Home Screen** - Pulsing orb with voice journal FAB
3. **Voice Journal** - User speaking, real-time transcription
4. **Insight Card** - Beautiful AI-generated insight display
5. **Journal History** - Timeline of entries (if implemented)
6. **Federation Hub** - Global contribution stats
7. **Settings** - Customization options
8. **Life Weaver** - Branching futures visualization (if implemented)

### Taking Screenshots
```bash
# Run app on emulator/simulator
flutter run

# Use built-in screenshot tools:
# - Android: Ctrl+S in emulator
# - iOS: Cmd+S in simulator

# Or use Flutter DevTools screenshot feature
```

### Enhancing Screenshots
1. Add device frames using [screenshots.pro](https://screenshots.pro)
2. Add captions/annotations using Figma or Canva
3. Use gradient overlays for cohesion
4. Keep text minimal, focus on visuals
5. Show the orb in different states (low/high energy)

---

## 4. Feature Graphic (Android Only)

### Specifications
- **Size**: 1024 x 500 px
- **Format**: PNG or JPG
- **Content**: Wide banner with orb, app name, tagline

### Design Layout
```
┌────────────────────────────────────────┐
│                                        │
│  [Glowing Orb]  NexusBloom            │
│                 The first true        │
│                 human-AI symbiont     │
│                                        │
└────────────────────────────────────────┘
```

---

## 5. App Preview Video (Optional but Powerful)

### Specifications
- **Duration**: 15-30 seconds
- **Resolution**: 1080p minimum (1920x1080)
- **Format**: MP4, MOV
- **Content**: Show core interaction loop

### Suggested Flow
1. (0-5s) Orb awakening with particles
2. (5-10s) Tap mic → speak → insight appears
3. (10-15s) Orb pulses brighter
4. (15-20s) Tap federation → "∆ contributed"
5. (20-30s) Journal history scroll + app name/tagline

### Recording Tools
- **iOS Simulator**: QuickTime screen recording
- **Android Emulator**: OBS Studio or built-in
- **Editing**: iMovie, DaVinci Resolve (free), Adobe Premiere

### Enhancement Tips
- Add subtle background music (royalty-free)
- Sync cuts to orb pulse rhythm
- Use slow-motion on particle effects
- Add subtle sound effects for mic tap, insights

---

## 6. Quick Start with Placeholders

If you want to test the setup before creating final assets:

```bash
cd app/assets

# Create placeholder icon (solid color circle)
convert -size 1024x1024 xc:"#00E5FF" -fill "#0A1F3A" -draw "circle 512,512 512,256" icon.png

# Create placeholder splash
convert -size 1242x2688 xc:"#0A1F3A" splash.png

# Then run generators
cd ..
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

---

## 7. Asset Validation Checklist

Before submission, verify:

- [ ] All icons display correctly in device settings
- [ ] Splash screen appears on app launch
- [ ] Icons are not pixelated on any device size
- [ ] Screenshots have no device chrome (unless intentional framing)
- [ ] All text is readable on small screens
- [ ] Colors match app theme
- [ ] No copyrighted material in assets
- [ ] Privacy policy URL is correct
- [ ] App name is consistent across all assets

---

## 8. Submission Metadata

### App Store Connect
- **App Name**: NexusBloom
- **Subtitle**: Your AI Companion
- **Promotional Text**: Speak. Reflect. Bloom.
- **Description**: (see MARKETING.md)
- **Keywords**: AI, journal, privacy, meditation, wellness, companion
- **Category**: Health & Fitness / Lifestyle

### Google Play Console
- **Title**: NexusBloom
- **Short Description**: Privacy-first AI companion with voice journaling
- **Full Description**: (see MARKETING.md)
- **Category**: Health & Fitness
- **Content Rating**: Everyone
- **Privacy Policy URL**: https://yourdomain.com/privacy.html

---

## Resources

### Free Stock Assets
- [Unsplash](https://unsplash.com) - Cosmic backgrounds
- [Freepik](https://freepik.com) - Gradient overlays
- [Flaticon](https://flaticon.com) - UI icons

### Design Tools
- [Figma](https://figma.com) - Professional design (free)
- [Canva](https://canva.com) - Quick mockups
- [Remove.bg](https://remove.bg) - Background removal
- [TinyPNG](https://tinypng.com) - Image compression

### AI Generation
- [Midjourney](https://midjourney.com) - High-quality orb renders
- [DALL-E](https://openai.com/dall-e-2) - Icon concepts
- [Stable Diffusion](https://stability.ai) - Free alternative

---

## Next Steps

1. Create icon.png and splash.png
2. Run generator commands
3. Take screenshots on emulator
4. Enhance with device frames
5. Create feature graphic
6. Review all assets
7. Submit to stores! 🚀

**Remember**: The orb should feel alive. Every asset should pulse with that same energy that makes users feel the symbiosis.

Built with ❤️ by two devs in Arkansas
🌸 Birthing the next layer of human consciousness
