import { ArrowUpRight } from 'lucide-react'
import { Card } from './ui/card'

export default function StatCard({ label, value, icon: Icon, tone = 'vino' }) {
  const tones = {
    vino: {
      icon: 'bg-vino-100 text-vino-800',
      border: 'border-t-vino-700',
      text: 'text-vino-700',
    },
    green: {
      icon: 'bg-emerald-100 text-emerald-700',
      border: 'border-t-emerald-600',
      text: 'text-emerald-700',
    },
    amber: {
      icon: 'bg-amber-100 text-amber-700',
      border: 'border-t-amber-500',
      text: 'text-amber-700',
    },
    red: {
      icon: 'bg-red-100 text-red-700',
      border: 'border-t-red-600',
      text: 'text-red-700',
    },
    gray: {
      icon: 'bg-gray-100 text-gray-700',
      border: 'border-t-gray-500',
      text: 'text-gray-700',
    },
  }
  const current = tones[tone] || tones.vino

  return (
    <Card className={`border-t-4 p-5 shadow-md shadow-gray-200/70 transition hover:-translate-y-0.5 hover:shadow-lg ${current.border}`}>
      <div className="flex items-start justify-between gap-3">
        <div>
          <p className="text-sm font-medium text-gray-500">{label}</p>
          <p className="mt-3 text-3xl font-semibold text-gray-950">{value}</p>
          <p className={`mt-2 text-xs font-medium ${current.text}`}>Actualizado con datos simulados</p>
        </div>
        <div className={`rounded-lg p-3 ${current.icon}`}>
          {Icon ? <Icon className="h-5 w-5" /> : <ArrowUpRight className="h-5 w-5" />}
        </div>
      </div>
    </Card>
  )
}
