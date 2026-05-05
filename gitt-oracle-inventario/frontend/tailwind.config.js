/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,jsx}'],
  theme: {
    extend: {
      colors: {
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
