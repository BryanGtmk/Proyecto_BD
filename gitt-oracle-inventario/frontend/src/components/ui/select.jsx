import { cn } from '../../lib/utils'

export function Select({ className, children, ...props }) {
  return (
    <select
      className={cn(
        'flex h-10 w-full rounded-md border border-gray-200 bg-white px-3 py-2 text-sm text-gray-900 outline-none focus:border-vino-500 focus:ring-2 focus:ring-vino-100',
        className,
      )}
      {...props}
    >
      {children}
    </select>
  )
}
