/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,jsx}'],
  theme: {
    extend: {
      colors: {
        vino: {
          50: '#fdf2f4',
          100: '#fbe5ea',
          200: '#f5c0ca',
          300: '#ee96a6',
          400: '#df5f79',
          500: '#c83b59',
          600: '#a92843',
          700: '#8f1d2c',
          800: '#721927',
          900: '#5f1320',
          950: '#3d0b14',
        },
        institutional: {
          red: '#8f1d2c',
          dark: '#5f1320',
          gray: '#f3f4f6',
        },
      },
    },
  },
  plugins: [],
}
