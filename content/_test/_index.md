---
title: "Theme Component Test Suite"
date: 2025-01-01T00:00:00-00:00
draft: true
type: _test
---

# Theme Component Test Suite

This page showcases all templates, partials, and components used in the offset theme. Each section is clearly labeled to help identify which component is being rendered.

---

## Purpose

Use this test suite to:
- Verify all components render correctly
- Test CSS styling across different elements
- Identify which templates are being used
- Debug layout issues
- Preview changes during development

---

## Navigation

- [Component Showcase](#typography) (this page)
- [Test Single Post](/_test/single-post-test/)
- [Test with Images](/_test/image-test/)
- [Minimal Post Test](/_test/minimal-post/)
- [Long Content Test](/_test/long-content/)
- [Shortcode Test](/_test/shortcode-test/)
- [Risograph Effect Test](/_test/riso-test/)

---

## Typography Tests

### Heading 1
### Heading 2
#### Heading 3
##### Heading 4
###### Heading 5

This is a paragraph with **bold text**, *italic text*, ***bold and italic***, and `inline code`. Here's a [link to the homepage](/).

> This is a blockquote. It should be styled differently from regular paragraphs and stand out visually.

---

## List Tests

### Unordered List
- First item
- Second item with a longer description that might wrap to multiple lines
  - Nested item 1
  - Nested item 2
- Third item

### Ordered List
1. First step
2. Second step
3. Third step with details
   1. Sub-step A
   2. Sub-step B
4. Final step

### Mixed List
1. Ordered item
   - Unordered nested
   - Another nested
2. Second ordered
   1. Nested ordered
   2. Another nested ordered

---

## Code Blocks

### Inline Code
Use `hugo server -D` to run the development server.

### Code Block
```python
def hello_world():
    """A simple function to test code highlighting."""
    message = "Hello, World!"
    print(message)
    return message

if __name__ == "__main__":
    hello_world()
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test Page</title>
</head>
<body>
    <h1>Hello World</h1>
</body>
</html>
```

---

## Link Tests

- [Internal link to About](/about/)
- [Internal link to Posts](/post/)
- [External link](https://gohugo.io)
- [Link with title](https://gohugo.io "Hugo Documentation")

---

## Image Tests

![Sample Alt Text](/img/sample.jpg)

---

## Shortcode Tests

### Test Component

{{< test-component />}}

### Test Callout

{{< test-callout type="info" >}}
This is a test callout shortcode. See more examples on the [Shortcode Test page](/_test/shortcode-test/).
{{< /test-callout >}}

---

## Table Test

| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Row 1 A  | Row 1 B  | Row 1 C  |
| Row 2 A  | Row 2 B  | Row 2 C  |
| Row 3 A  | Row 3 B  | Row 3 C  |

---

## Horizontal Rules

Above this line.

---

Below this line.

---

## Special Characters & Entities

- Ampersand: &amp;
- Less than: &lt;
- Greater than: &gt;
- Copyright: &copy;
- Trademark: &trade;
- Em dash: —
- En dash: –

---

## Component Information

**Template Used:** `layouts/_test/list.html` (or fallback `layouts/list.html`)
**Partial Used:** Check sections below for specific partials
**Base Template:** `layouts/baseof.html`

### CSS Classes in Use

- `.post-list` - List styling
- `.post-title` - Title styling
- `.post-meta` - Metadata styling
- `.post-date` - Date styling
- `.content` - Main content area
- `.tags` - Tag list styling
- `.pagination` - Pagination controls

---

## End of Test Suite

Return to [homepage](/) or browse [all posts](/post/).
