export default function StatCard({ label, value, tone = 'red' }) {
  const tones = {
    red: 'border-institutional-red text-institutional-red',
    gray: 'border-gray-400 text-gray-700',
    dark: 'border-institutional-dark text-institutional-dark',
  }

  return (
    <div className={`rounded-lg border-l-4 bg-white p-5 shadow-sm ${tones[tone]}`}>
      <p className="text-sm font-medium text-gray-500">{label}</p>
      <p className="mt-2 text-3xl font-semibold">{value ?? 0}</p>
    </div>
  )
}
