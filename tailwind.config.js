/** @type {import('tailwindcss').Config} */
export default {
  darkMode: "class",
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      "colors": {
              "inverse-surface": "#dae2fd",
              "on-tertiary-fixed": "#07006c",
              "error": "#ffb4ab",
              "surface-variant": "#2d3449",
              "primary-container": "#22c55e",
              "on-surface": "#dae2fd",
              "surface-tint": "#4ae176",
              "surface-container-highest": "#2d3449",
              "surface-container-high": "#222a3d",
              "surface": "#0b1326",
              "primary-fixed-dim": "#4ae176",
              "primary-fixed": "#6bff8f",
              "secondary": "#adc6ff",
              "secondary-fixed-dim": "#adc6ff",
              "surface-dim": "#0b1326",
              "surface-container-low": "#131b2e",
              "surface-container-lowest": "#060e20",
              "background": "#0b1326",
              "secondary-fixed": "#d8e2ff",
              "outline": "#869585",
              "tertiary": "#c1c2ff",
              "on-error": "#690005",
              "surface-bright": "#31394d",
              "inverse-primary": "#006e2f",
              "on-primary-container": "#004b1e",
              "on-background": "#dae2fd",
              "on-primary": "#003915",
              "on-surface-variant": "#bccbb9",
              "on-tertiary": "#1000a9",
              "on-error-container": "#ffdad6",
              "surface-container": "#171f33",
              "on-primary-fixed-variant": "#005321",
              "on-tertiary-container": "#2623b8",
              "on-primary-fixed": "#002109",
              "inverse-on-surface": "#283044",
              "on-secondary": "#002e6a",
              "on-tertiary-fixed-variant": "#2f2ebe",
              "on-secondary-fixed": "#001a42"
      },
      "borderRadius": {
              "DEFAULT": "0.25rem",
              "lg": "0.5rem",
              "xl": "0.75rem",
              "full": "9999px"
      },
      "spacing": {
              "margin-desktop": "48px",
              "gutter": "24px",
              "margin-mobile": "16px",
              "container-max": "1280px",
              "unit": "8px"
      },
      "fontFamily": {
              "headline-xl": ["Lexend"],
              "headline-md": ["Lexend"],
              "body-lg": ["Inter"],
              "headline-lg": ["Lexend"],
              "label-bold": ["Inter"],
              "body-md": ["Inter"]
      },
      "fontSize": {
              "headline-xl": ["48px", {"lineHeight": "1.1", "letterSpacing": "-0.04em", "fontWeight": "800"}],
              "headline-md": ["24px", {"lineHeight": "1.3", "fontWeight": "600"}],
              "body-lg": ["18px", {"lineHeight": "1.6", "fontWeight": "400"}],
              "headline-lg": ["32px", {"lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "700"}],
              "label-bold": ["14px", {"lineHeight": "1", "letterSpacing": "0.05em", "fontWeight": "600"}],
              "body-md": ["16px", {"lineHeight": "1.5", "fontWeight": "400"}]
      }
    },
  },
  plugins: [],
}
