import { Button } from './ui/button'

export default function PageHeader({ title, description, actionLabel, icon: Icon, onAction }) {
  return (
    <div className="flex flex-col gap-3 rounded-lg border border-gray-200 bg-white px-5 py-4 shadow-sm sm:flex-row sm:items-center sm:justify-between">
      <div className="min-w-0">
        <div className="mb-2 h-1 w-14 rounded-full bg-vino-700" />
        <h1 className="text-2xl font-semibold text-gray-950">{title}</h1>
        {description && <p className="mt-1 text-sm text-gray-500">{description}</p>}
      </div>
      {actionLabel && (
        <Button onClick={onAction}>
          {Icon && <Icon className="h-4 w-4" />}
          {actionLabel}
        </Button>
      )}
    </div>
  )
}
