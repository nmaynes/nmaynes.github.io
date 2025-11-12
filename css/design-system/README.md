## Hugo Design System

A lightweight, semantic-first CSS design system built for static Hugo sites.

### 🎯 Philosophy

**Semantic-First, Not Utility-First**
- Hugo generates semantic HTML from markdown
- Base styles automatically style markdown elements
- Components provide reusable patterns
- Utilities are helpers, not the primary approach

**CSS Variables for Everything**
- Single source of truth in `tokens.css`
- Easy theming (light/dark included)
- No build process required
- Edit tokens, change entire site

**Inheritance Over Specificity**
- Leverage CSS cascade
- Minimal selector complexity
- No `!important` needed (mostly)
- Predictable styling

### 📁 File Structure

```
design-system/
├── tokens.css       # Design tokens (variables)
├── base.css         # Element defaults (h1, p, a, etc.)
├── layout.css       # Layout primitives (containers, grids)
├── components.css   # UI components (buttons, cards, etc.)
└── utilities.css    # Helper classes (text-center, etc.)
```

### 🚀 Quick Start

**1. Import in your main CSS:**
```css
@import "design-system/tokens.css";
@import "design-system/base.css";
@import "design-system/layout.css";
@import "design-system/components.css";
@import "design-system/utilities.css";
```

**2. Customize tokens:**
```css
:root {
    --color-primary-600: #your-brand-color;
    --font-sans: "Your Font", sans-serif;
    --content-max-width: 900px;
}
```

**3. Use in templates:**
```html
<div class="container">
    <article class="flow">
        <!-- Markdown content automatically styled -->
    </article>
</div>
```

### 🎨 Token Categories

**Colors**
- Palettes: Primary (blue), Neutral (grays)
- Semantic: Success, Warning, Error, Info
- Themes: Light (default) and Dark

**Typography**
- Sizes: xs to 6xl (0.75rem to 3.75rem)
- Families: Sans, Serif, Mono
- Weights: Normal, Medium, Semibold, Bold
- Line heights: Tight to Loose

**Spacing**
- Base unit: 0.25rem (4px)
- Scale: 0 to 24 (0px to 96px)
- Calculated via `calc(var(--space-base) * multiplier)`

**Layout**
- Container: 1200px max
- Content: 800px max
- Sidebar: 300px

### 🧩 Layout Primitives

**Container**
```html
<div class="container">
    <!-- Centered with max-width -->
</div>

<div class="container container-narrow">
    <!-- Narrower content width -->
</div>
```

**Flow (Automatic vertical spacing)**
```html
<div class="flow">
    <h2>Title</h2>
    <p>Paragraph 1</p>
    <p>Paragraph 2</p>
    <!-- Auto-spaced with --flow-space -->
</div>
```

**Stack (Flexbox vertical)**
```html
<div class="stack stack-lg">
    <div>Item 1</div>
    <div>Item 2</div>
    <!-- Consistent gap -->
</div>
```

**Grid (Auto-fit)**
```html
<div class="grid grid-auto">
    <div>Card 1</div>
    <div>Card 2</div>
    <!-- Auto-fits to available space -->
</div>
```

**Cluster (Horizontal wrapping)**
```html
<div class="cluster">
    <span>Tag 1</span>
    <span>Tag 2</span>
    <!-- Wraps with gap -->
</div>
```

### 🎭 Components

**Buttons**
```html
<a href="#" class="btn btn-primary">Primary</a>
<button class="btn btn-secondary btn-sm">Small</button>
```

**Cards**
```html
<div class="card">
    <div class="card-header">
        <h3 class="card-title">Title</h3>
    </div>
    <div class="card-body">Content</div>
</div>
```

**Badges**
```html
<span class="badge badge-primary">New</span>
```

**Alerts**
```html
<div class="alert alert-info">
    Important information
</div>
```

**Post List (Hugo-specific)**
```html
<ul class="post-list">
    <li class="post-list-item">
        <h2 class="post-title">
            <a href="#">Post Title</a>
        </h2>
        <div class="post-meta">
            <time>Jan 1, 2025</time>
        </div>
        <p class="post-excerpt">Summary...</p>
    </li>
</ul>
```

### 🛠️ Utilities

**Use Sparingly** - Prefer semantic classes and components

```html
<!-- Text -->
<p class="text-center text-lg">Centered large text</p>

<!-- Spacing -->
<div class="mt-6 mb-4">Margin top & bottom</div>

<!-- Display -->
<div class="flex items-center gap-4">Flexbox</div>

<!-- Responsive -->
<div class="hide-mobile">Desktop only</div>
```

### 🌗 Dark Mode

```html
<!-- Enable dark theme -->
<html data-theme="dark">
<!-- Or toggle with JavaScript -->
<script>
document.documentElement.dataset.theme = 'dark';
</script>
```

All color tokens automatically adjust based on `data-theme` attribute.

### ✏️ Customization

**Option 1: Override tokens**
```css
:root {
    --color-primary-600: #your-color;
    --font-sans: "Your Font", sans-serif;
}
```

**Option 2: Add site-specific styles**
Put custom styles in `main.css` after imports.

**Option 3: Extend components**
```css
.btn-custom {
    /* Extend .btn with custom styles */
}
```

### 📏 Comparison

| Feature | Tailwind | Hugo Design System |
|---------|----------|-------------------|
| Approach | Utility-first | Semantic-first |
| Build | Required | None |
| Markup | Verbose | Clean |
| Learning | Class names | CSS basics |
| Theming | Config file | CSS variables |
| File size | Tree-shaken | ~15KB (ungzipped) |
| Hugo fit | Overkill | Purpose-built |

### 🎓 Best Practices

1. **Let markdown breathe** - Base styles handle most content
2. **Use layout primitives** - `.flow`, `.stack`, `.grid` for structure
3. **Components for patterns** - `.card`, `.btn` for reuse
4. **Utilities last** - Quick fixes only
5. **Customize tokens** - Don't fight the system, change tokens
6. **Leverage inheritance** - Style parents, not children

### 🔗 Resources

- [Every Layout](https://every-layout.dev/) - Layout primitive inspiration
- [Utopia](https://utopia.fyi/) - Fluid type/space (future enhancement)
- [CSS Variables](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties)
