import { cva } from 'class-variance-authority'
import { cn } from '../../lib/utils'

const badgeVariants = cva('inline-flex items-center rounded-full px-2.5 py-1 text-xs font-medium ring-1', {
  variants: {
    variant: {
      default: 'bg-gray-100 text-gray-700 ring-gray-200',
      success: 'bg-emerald-50 text-emerald-700 ring-emerald-200',
      warning: 'bg-amber-50 text-amber-700 ring-amber-200',
      danger: 'bg-red-50 text-red-700 ring-red-200',
      info: 'bg-sky-50 text-sky-700 ring-sky-200',
      dark: 'bg-gray-800 text-white ring-gray-700',
      vino: 'bg-vino-50 text-vino-800 ring-vino-200',
    },
  },
  defaultVariants: {
    variant: 'default',
  },
})

export function Badge({ className, variant, ...props }) {
  return <span className={cn(badgeVariants({ variant, className }))} {...props} />
}
