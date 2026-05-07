---
name: playwright
description: Invoke this skill when using Playwright for visual work - verifying UI development, analyzing designs, extracting colors/spacing, or any task requiring screenshots. Optimizes for screenshots over expensive snapshots.
---
# Playwright Visual Mode

You are using Playwright for visual work. This might be verifying your own development (does this UI look right?), analyzing an existing design (what colors and spacing does this site use?), or any task where you need to see what something looks like.

## The Core Principle

Screenshots are your primary tool. You're looking at things. When you need to know what something looks like, take a screenshot and look at it. Store scrrenshots in `/tmp` directory.

## Snapshots: Sparingly and as a Last Resort

The accessibility tree snapshot (`browser_snapshot`) costs 10,000-50,000+ tokens and contains structural information - element roles, labels, states, hierarchy. It tells you nothing about visual appearance. No colors, no fonts, no spacing, no layout.

Snapshots have their place: debugging why an element won't render, finding a selector when the visual isn't giving you enough to go on, understanding complex dynamic state. But these are edge cases. Your default should always be screenshots. If you find yourself reaching for a snapshot, pause and ask whether a screenshot (or a targeted evaluate call) would actually answer your question better.

## The Workflow

### Navigate

```
browser_navigate to your target URL
```

### Wait for Render

Dynamic content and client-side rendering mean the page isn't ready when navigation completes. Wait for network idle with a timeout -- most modern sites never truly go network-idle because analytics scripts, ad networks, and websockets keep connections active indefinitely.

```javascript
async (page) => {
  try {
    await page.waitForLoadState('networkidle', { timeout: 10000 });
  } catch (e) {
    // Network didn't go idle - likely background scripts.
    // For visual work this is usually fine; the render is complete.
  }
  return 'ready';
}
```

If you hit the timeout, take a screenshot and assess. The page is almost always visually complete -- the timeout just means some tracker or websocket is still active in the background. If the screenshot shows a loading spinner or incomplete layout, you have a real problem; otherwise proceed normally.

### Screenshot and Evaluate

Take a screenshot. Look at it. Answer your visual questions from what you see.

### Extract Precise Values When Needed

If you need exact colors, fonts, or spacing (not just "does this look right" but "what exactly is this"), use evaluate to query computed styles:

```javascript
async (page) => {
  const element = await page.locator('.target-element').first();
  const styles = await element.evaluate(el => {
    const computed = window.getComputedStyle(el);
    return {
      backgroundColor: computed.backgroundColor,
      color: computed.color,
      fontFamily: computed.fontFamily,
      fontSize: computed.fontSize,
      padding: computed.padding,
      borderRadius: computed.borderRadius
    };
  });
  return JSON.stringify(styles, null, 2);
}
```

This returns precise CSS values in minimal tokens - far better than a snapshot for design extraction.

### Interact When Needed

To test interactive behavior, use text-based selectors from what you can see:

```javascript
async (page) => {
  await page.getByRole('button', { name: 'Submit' }).click();
  return 'clicked';
}
```

Then screenshot again to see the result.

## Viewport Configuration

The MCP server viewport is configured to match Claude's image processing at 1:1 scale. What you see in the screenshot is pixel-accurate to what the user would see at that viewport size.

If you think it makes sense feel free to resize the viewport, but understand that the final image you're given may be scaled as a result.

Here are the docs describing the exact size constraints:

```
Here is a table of maximum image sizes accepted by our API that will not be resized for common aspect ratios. With Claude Sonnet 4.5, these images use approximately 1,600 tokens and around $4.80/1K images.

Aspect ratio	Image size
1:1	1092x1092 px
3:4	951x1268 px
2:3	896x1344 px
9:16	819x1456 px
1:2	784x1568 px
```

## CAPTCHAs and Auth

If you encounter login screens or CAPTCHAs, handle them. You're acting as the user's agent using their browser.
