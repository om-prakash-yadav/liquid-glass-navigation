# Publishing Guide for liquid_glass_nav 🚀

This guide will help you publish the `liquid_glass_nav` package to pub.dev.

## Prerequisites ✅

Before publishing, ensure you have:

1. ✅ A Google account
2. ✅ Verified email with pub.dev
3. ✅ Flutter SDK installed
4. ✅ All tests passing
5. ✅ Updated CHANGELOG.md
6. ✅ Updated version in pubspec.yaml

## Pre-Publication Checklist 📋

### 1. Code Quality

Run all checks:

```bash
# Format code
flutter format .

# Analyze code
flutter analyze

# Run tests
flutter test

# Check pub score
flutter pub publish --dry-run
```

### 2. Documentation

Ensure you have:

- [ ] Comprehensive README.md
- [ ] Updated CHANGELOG.md
- [ ] API documentation (dartdoc comments)
- [ ] Example app
- [ ] Screenshots (recommended)
- [ ] License file

### 3. Package Metadata

Verify `pubspec.yaml` contains:

```yaml
name: liquid_glass_nav
description: Clear, concise description (60-180 characters)
version: 1.0.0
homepage: https://github.com/username/repo
repository: https://github.com/username/repo
issue_tracker: https://github.com/username/repo/issues
documentation: https://github.com/username/repo#readme

topics:
  - ui
  - navigation
  - glassmorphism

screenshots:
  - description: 'Description'
    path: screenshots/image.png
```

### 4. Version Management

Follow semantic versioning:

- **1.0.0** - Initial release
- **1.0.1** - Patch (bug fixes)
- **1.1.0** - Minor (new features, backward compatible)
- **2.0.0** - Major (breaking changes)

## Publishing Steps 📦

### Step 1: Dry Run

Test the publishing process:

```bash
flutter pub publish --dry-run
```

Review the output for:
- ✅ No errors or warnings
- ✅ All files included correctly
- ✅ Package score is good

### Step 2: Publish

If dry run succeeds:

```bash
flutter pub publish
```

You'll be asked to:
1. Confirm publication
2. Authenticate with Google account
3. Verify your email (first time only)

### Step 3: Verify

After publishing:

1. Visit https://pub.dev/packages/liquid_glass_nav
2. Check package appears correctly
3. Verify documentation rendered properly
4. Test installation in a new project

## Post-Publication 🎉

### 1. Create Git Tag

```bash
git tag v1.0.0
git push origin v1.0.0
```

### 2. Create GitHub Release

1. Go to your repository
2. Click "Releases" → "Create a new release"
3. Tag: v1.0.0
4. Title: Version 1.0.0
5. Description: Copy from CHANGELOG.md
6. Upload screenshots (optional)
7. Publish release

### 3. Promote Your Package

Share on:
- [ ] Twitter/X
- [ ] Reddit (r/FlutterDev)
- [ ] Discord communities
- [ ] LinkedIn
- [ ] Dev.to or Medium article

### 4. Monitor

- Check pub.dev package page
- Monitor package score
- Watch for issues on GitHub
- Respond to questions

## Screenshots Guide 📸

### Creating Screenshots

1. **Take Screenshots**
   - Use Flutter's screenshot capability
   - Or use device/simulator screenshots
   - Recommended size: 1080x1920 or similar

2. **Optimize Images**
   ```bash
   # Create screenshots directory
   mkdir screenshots
   
   # Add images (PNG format recommended)
   # Keep file sizes under 4MB
   ```

3. **Add to pubspec.yaml**
   ```yaml
   screenshots:
     - description: 'Default glassmorphism style'
       path: screenshots/default.png
     - description: 'With notification badges'
       path: screenshots/badges.png
   ```

### Screenshot Tips

- Show different features
- Use attractive backgrounds
- Include both light/dark modes
- Keep text readable
- Max 10 screenshots

## Troubleshooting 🔧

### Common Issues

**"Package name already exists"**
- Choose a unique name
- Check pub.dev for availability

**"Email not verified"**
- Check your email for verification link
- Wait a few minutes and try again

**"Package validation failed"**
- Run `flutter pub publish --dry-run`
- Fix all errors and warnings
- Ensure description is 60-180 characters

**"Score is too low"**
- Add example code
- Improve documentation
- Add tests
- Follow pub.dev best practices

### Improving Package Score

To get 130/130 points:

1. **Documentation (10 points)**
   - Comprehensive README
   - API documentation
   - Example code

2. **Platforms (20 points)**
   - Support multiple platforms
   - Declare in pubspec.yaml

3. **Analysis (30 points)**
   - No errors
   - Follow lints
   - Type safe

4. **Dependencies (20 points)**
   - Up-to-date dependencies
   - Minimal dependencies
   - Clear constraints

5. **Null Safety (20 points)**
   - Full null safety support

6. **Pub Points (30 points)**
   - Pass all automated checks

## Updating the Package 🔄

For future versions:

1. Make changes
2. Update version in pubspec.yaml
3. Update CHANGELOG.md
4. Run tests
5. Run `flutter pub publish --dry-run`
6. Run `flutter pub publish`
7. Create git tag
8. Create GitHub release

## Best Practices 💡

- **Semantic Versioning**: Follow strictly
- **Breaking Changes**: Clearly document
- **Deprecations**: Mark with @deprecated
- **Migration Guides**: Provide for major versions
- **Testing**: Comprehensive test coverage
- **Examples**: Keep examples up-to-date
- **Issues**: Respond promptly
- **Pull Requests**: Review and merge

## Resources 📚

- [pub.dev Publishing Guide](https://dart.dev/tools/pub/publishing)
- [Package Layout Conventions](https://dart.dev/tools/pub/package-layout)
- [Verified Publishers](https://dart.dev/tools/pub/verified-publishers)
- [Package Scoring](https://pub.dev/help/scoring)

## Support 💬

If you encounter issues:

1. Check [pub.dev help](https://pub.dev/help)
2. Ask on [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
3. Join [Flutter Discord](https://discord.gg/flutter)

---

Good luck with your publication! 🎉

Remember: Quality over speed. A well-documented, well-tested package will be more successful long-term.
