---
title: "Risograph Effect Test"
date: 2025-01-25T10:00:00-05:00
draft: true
type: _test
---

# Risograph Print Style Test

This page demonstrates the Risograph three-color offset effect for post titles.

---

## What is Risograph?

Risograph is a printing technique that uses soy-based inks and creates characteristic color overlays with slight misalignments. Each color is printed as a separate layer, and imperfect registration creates a distinctive aesthetic.

---

## Markdown Heading Render Hook (Recommended) {.riso-title-shadow}

This heading uses markdown attributes! Just add `{.riso-title-shadow}` after the heading text.

### Another Rendered Heading {.riso-title-shadow .riso-scheme-fluor}

You can combine multiple classes like color schemes.

### Classic Colors {.riso-title-shadow .riso-scheme-classic}

Each heading gets unique deterministic offsets based on its text and page URL.

---

## Text-Shadow Method (Simple)

Using CSS `text-shadow` with deterministic offsets:

<h2 class="riso-title-shadow" style="--riso-offset2-x: 2px; --riso-offset2-y: -2px; --riso-offset3-x: -2px; --riso-offset3-y: 2px;">
    Simple Text Shadow Title
</h2>

---

## Pseudo-Element Method (Advanced)

Using `::before` and `::after` with `mix-blend-mode`:

<h2 class="riso-title riso-scheme-classic" data-text="Advanced Pseudo-Element Title" style="--riso-offset2-x: 3px; --riso-offset2-y: -1px; --riso-offset3-x: -2px; --riso-offset3-y: 3px;">
    Advanced Pseudo-Element Title
</h2>

**Note:** The pseudo-element method requires setting `data-text` attribute.

---

## Color Schemes

### Classic Scheme Example {.riso-title-shadow .riso-scheme-classic}

Red, Blue, and Yellow - the classic Risograph color combination.

### Fluorescent Pop {.riso-title-shadow .riso-scheme-fluor}

Bright and vibrant fluorescent colors for maximum impact.

### Cool Tones {.riso-title-shadow .riso-scheme-cool}

Blue, Teal, and Violet create a calm, cool palette.

### Warm Tones {.riso-title-shadow .riso-scheme-warm}

Red, Orange, and Yellow bring warmth and energy.

### Duotone {.riso-title-shadow .riso-scheme-duo}

Just two colors for a simpler, more restrained effect.

---

## Offset Variations

### Small Offset
<h2 class="riso-title-shadow riso-offset-sm" style="--riso-offset2-x: 1px; --riso-offset2-y: -1px; --riso-offset3-x: -1px; --riso-offset3-y: 1px;">
    Subtle Misalignment
</h2>

### Medium Offset
<h2 class="riso-title-shadow riso-offset-md" style="--riso-offset2-x: 2px; --riso-offset2-y: -2px; --riso-offset3-x: -2px; --riso-offset3-y: 2px;">
    Standard Misalignment
</h2>

### Large Offset
<h2 class="riso-title-shadow riso-offset-lg" style="--riso-offset2-x: 4px; --riso-offset2-y: -3px; --riso-offset3-x: -3px; --riso-offset3-y: 4px;">
    Dramatic Misalignment
</h2>

### Extra Large Offset
<h2 class="riso-title-shadow riso-offset-xl" style="--riso-offset2-x: 6px; --riso-offset2-y: -5px; --riso-offset3-x: -4px; --riso-offset3-y: 6px;">
    Extreme Misalignment
</h2>

---

## Randomized Examples

Each title below should have different offsets based on its unique URL:

<h2 class="riso-title-shadow" style="--riso-offset2-x: 3px; --riso-offset2-y: -1px; --riso-offset3-x: -2px; --riso-offset3-y: 2px;">
    Example Post Title One
</h2>

<h2 class="riso-title-shadow" style="--riso-offset2-x: -1px; --riso-offset2-y: 3px; --riso-offset3-x: 2px; --riso-offset3-y: -2px;">
    Example Post Title Two
</h2>

<h2 class="riso-title-shadow" style="--riso-offset2-x: 2px; --riso-offset2-y: 2px; --riso-offset3-x: -3px; --riso-offset3-y: -1px;">
    Example Post Title Three
</h2>

---

## Usage in Templates

### Method 1: Markdown Attributes (Recommended)

The easiest way to add Risograph effects in markdown content:

```markdown
## Your Heading {.riso-title-shadow}

### With Color Scheme {.riso-title-shadow .riso-scheme-fluor}
```

**Syntax:**
- Add `{.classname}` after the heading text
- Separate multiple classes with spaces
- Offsets are automatically calculated for each heading
- Works with all heading levels (h1-h6)

### Method 2: Using Partial

```
{{</* partial "riso-title.html" . */>}}
```

### Method 3: Inline in Template

```html
<h1 class="riso-title-shadow" style="
    --riso-offset2-x: {{ $offset1 }}px;
    --riso-offset2-y: {{ $offset2 }}px;
    --riso-offset3-x: {{ $offset3 }}px;
    --riso-offset3-y: {{ $offset4 }}px;
">{{ .Title }}</h1>
```

---

## Technical Details

**How it works:**
1. MD5 hash of page URL creates deterministic seed
2. First 3 hex characters map to offset values
3. Offsets range from -3px to +3px for each axis
4. CSS custom properties apply offsets
5. `text-shadow` or pseudo-elements create layers

**Benefits:**
- ✅ Deterministic - same result every page load
- ✅ Variable - different for each post
- ✅ No JavaScript required
- ✅ Accessible - real text, not images
- ✅ Customizable colors via CSS variables

---

## Risograph Blob Decorations

Decorative organic blob shapes with three-color risograph offset effect. These are easier to read than text effects and add visual interest.

### Classic Blob

{{< riso-blob >}}

This blob uses the default classic color scheme (red, blue, yellow). Each page gets a unique deterministic blob shape.

### Fluorescent Blob

{{< riso-blob scheme="fluor" >}}

Bright and vibrant fluorescent colors for maximum visual impact.

### Cool Tones Blob

{{< riso-blob scheme="cool" >}}

Blue, teal, and violet create a calm aesthetic.

### Warm Tones Blob

{{< riso-blob scheme="warm" >}}

Red, orange, and yellow bring warmth and energy.

### Earthy Blob

{{< riso-blob scheme="earth" >}}

Burgundy, green, and orange for a natural feel.

### Usage

Add a blob decoration after your post title or at the end of content:

```markdown
## My Blog Post Title

{{</* riso-blob */>}}

Post content goes here...

---

{{</* riso-blob scheme="fluor" */>}}
```

**Available schemes:**
- `classic` (default) - Red, Blue, Yellow
- `fluor` - Fluorescent Pink, Orange, Yellow
- `cool` - Blue, Teal, Violet
- `warm` - Red, Orange, Yellow
- `duo` - Red and Blue only
- `earth` - Burgundy, Green, Orange
- `mono` - Grayscale

**Parameters:**
- Each blob is unique per page (deterministic)
- Randomness: 4-7
- Complexity (edges): 4-14
- Width: 1/3 of container, centered
- Responsive: 50% width on mobile

---

## Risograph Dropcaps

Decorative first letters with risograph blob backgrounds. Perfect for starting articles and sections.

### Classic Dropcap

{{< riso-dropcap letter="T" >}}his is an example of a risograph dropcap with the classic color scheme. The white letter sits on top of a colorful blob that floats to the left of the paragraph. Notice how the text wraps naturally around the decorative initial letter, creating an elegant opening to your content. When a paragraph is sufficiently long, it should wrap underneath the drop cap, creating an effect like an ancient text, handwritten by monks who have dedicated their lives to copying important texts.

### Fluorescent Dropcap

{{< riso-dropcap letter="F" scheme="fluor" >}}luorescent colors create a vibrant and eye-catching dropcap. This scheme uses bright pink, orange, and yellow colors that really pop off the page. The three-color risograph offset effect adds depth and character to the initial letter.

### Cool Tones Dropcap

{{< riso-dropcap letter="C" scheme="cool" >}}ool blue tones create a calm and sophisticated dropcap. The combination of blue, teal, and violet gives this initial letter a professional yet artistic appearance. This color scheme works particularly well for technology and design-focused content.

### Warm Tones Dropcap

{{< riso-dropcap letter="W" scheme="warm" >}}arm colors bring energy and enthusiasm to your opening paragraph. Red, orange, and yellow combine to create a welcoming and friendly initial letter that draws readers into your content.

### Usage

Add a dropcap at the start of your post or section:

```markdown
{{</* riso-dropcap letter="T" */>}}his is the first paragraph of your post...

{{</* riso-dropcap letter="F" scheme="fluor" */>}}or a different color scheme...
```

**Available schemes:**
- `classic` (default) - Red, Blue, Yellow
- `fluor` - Fluorescent Pink, Orange, Yellow
- `cool` - Blue, Teal, Violet
- `warm` - Red, Orange, Yellow
- `duo` - Red and Blue
- `earth` - Burgundy, Green, Orange
- `mono` - Grayscale

**Features:**
- White letter with subtle shadow for readability
- Floats left with text wrapping
- Unique blob shape per letter and page
- Fully responsive (scales on mobile)
- 120px × 120px on desktop
- 90px × 90px on tablet
- 70px × 70px on mobile

[← Back to Test Suite](../)
