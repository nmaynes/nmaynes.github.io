# Test Suite Documentation

This directory contains a comprehensive test suite for the offset Hugo theme.

## Structure

```
content/_test/
├── _index.md              # Main test page with component showcase
├── single-post-test.md    # Tests single post layout
├── minimal-post.md        # Tests minimal front matter
├── long-content.md        # Tests long content and edge cases
├── image-test.md          # Tests image rendering
├── shortcode-test.md      # Tests custom shortcodes
└── README.md              # This file
```

## Accessing the Test Suite

With Hugo server running in development mode:

```bash
hugo server -D
```

Visit: **http://localhost:1313/_test/**

## What Gets Tested

### Templates
- `layouts/_test/list.html` - Section list view
- `layouts/_test/single.html` - Individual post view
- `layouts/baseof.html` - Base template wrapper
- All templates include debug information showing which files are being rendered

### Components
- Header with title and metadata
- Content area rendering
- Post navigation (prev/next)
- Category and tag display
- Date formatting
- Pagination

### Partials
- `_partials/pagination.html` - Page navigation
- `_partials/list.html` - Generic list partial

### Shortcodes
- `test-component` - Basic component demo
- `test-callout` - Styled callout boxes (info, warning, danger, success)

### Content Types
- Standard posts with full metadata
- Minimal posts (no categories/tags)
- Long content with edge cases
- Image-heavy content

### Edge Cases
- Long titles that wrap
- Many tags and categories
- Missing optional fields
- Special characters
- Long words/code

## Visual Indicators

Each test page includes colored boxes that identify:

- 🔍 **Blue boxes** - Template information
- 📋 **Light blue boxes** - Component information
- 🧩 **Orange boxes** - Partial usage
- 🎨 **Gray boxes** - CSS class reference
- 🧩 **Green boxes** - Shortcode information

## Development Workflow

1. **Make changes** to templates, CSS, or partials
2. **Visit test pages** to see how changes affect different components
3. **Check console** for any Hugo errors
4. **Verify responsive behavior** by resizing browser
5. **Test navigation** between pages

## Excluding from Production

All test content is marked with `draft: true` and `type: _test`.

To exclude from production builds:
- Don't use `-D` flag: `hugo` (instead of `hugo -D`)
- Or add to `.gitignore` if you don't want it in version control

## Adding New Tests

1. Create new `.md` file in `content/_test/`
2. Set front matter:
   ```yaml
   ---
   title: "Your Test Title"
   date: 2025-01-01T00:00:00-00:00
   draft: true
   type: _test
   ---
   ```
3. Add link to main `_index.md` navigation
4. Access via `http://localhost:1313/_test/your-test/`

## Customizing Test Templates

Edit templates in `themes/offset/layouts/_test/` to change how test pages render. The debug labels can be removed for production use.

## Notes

- The underscore prefix (`_test`) signals this is special/internal content
- All pages use `draft: true` to prevent accidental production deployment
- Sample images should be placed in `static/img/`
- Test shortcodes are in `layouts/_shortcodes/`
