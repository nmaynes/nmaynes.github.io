---
title: "Shortcode Test"
date: 2025-01-18T10:00:00-05:00
draft: true
type: _test
categories:
  - Testing
tags:
  - shortcodes
---

# Shortcode Test Page

This page demonstrates custom shortcodes. Each shortcode is labeled with its file location and usage.

---

## Test Component Shortcode

{{< test-component />}}

### With Inner Content

{{< test-component >}}
This is inner content passed to the shortcode!
{{< /test-component >}}

---

## Test Callout Shortcode

### Info Callout (Default)

{{< test-callout type="info" >}}
This is an **info** callout. It uses the default blue color scheme.
{{< /test-callout >}}

### Warning Callout

{{< test-callout type="warning" >}}
This is a **warning** callout. It uses an orange color scheme.
{{< /test-callout >}}

### Danger Callout

{{< test-callout type="danger" >}}
This is a **danger** callout. It uses a red color scheme.
{{< /test-callout >}}

### Success Callout

{{< test-callout type="success" >}}
This is a **success** callout. It uses a green color scheme.
{{< /test-callout >}}

---

## Nested Shortcodes

{{< test-callout type="info" >}}
Outer callout with nested component:

{{< test-component >}}
Nested shortcode inside callout!
{{< /test-component >}}
{{< /test-callout >}}

---

## List-Table Shortcode

The `list-table` shortcode creates tables from plain text data.

{{< list-table header="true" caption="Sample Data Table" >}}
Header 1
Header 2
Header 3

Row 1 Cell 1
Row 1 Cell 2
100

Row 2 Cell 1
Row 2 Cell 2
200
{{< /list-table >}}

---

## Shortcode Documentation

### test-component

**File:** `layouts/_shortcodes/test-component.html`

**Usage:**
```
{{</* test-component */>}}
```

With inner content:
```
{{</* test-component */>}}
Inner content here
{{</* /test-component */>}}
```

### test-callout

**File:** `layouts/_shortcodes/test-callout.html`

**Usage:**
```
{{</* test-callout type="info" */>}}
Your message here
{{</* /test-callout */>}}
```

**Types:** `info`, `warning`, `danger`, `success`

### list-table

**File:** `layouts/_shortcodes/list-table.html`

**Usage:**
```
{{</* list-table header="true" caption="My Table" */>}}
Header 1
Header 2

Cell 1
Cell 2

Cell 3
Cell 4
{{</* /list-table */>}}
```

**Parameters:**
- `header` - Set to "true" to use first row as headers
- `caption` - Optional table caption

---

## Directory Structure

Shortcodes are located in: **`layouts/_shortcodes/`**

Note: The old `layouts/shortcodes/` directory (without underscore) is deprecated in Hugo v0.146.0+ but kept for reference.

---

[← Back to Test Suite](../)
