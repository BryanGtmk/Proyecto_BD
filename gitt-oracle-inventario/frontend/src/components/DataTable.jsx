import { ChevronLeft, ChevronRight } from 'lucide-react'
import { cn } from '../lib/utils'
import { Button } from './ui/button'

export default function DataTable({ columns, data, emptyText = 'No hay registros para mostrar', caption }) {
  const totalPages = Math.max(1, Math.ceil(data.length / 8))

  return (
    <div className="overflow-hidden rounded-lg border border-gray-200 bg-white shadow-sm">
      {caption ? (
        <div className="flex items-center justify-between border-b border-gray-100 bg-gray-50/70 px-4 py-3">
          <p className="text-sm font-medium text-gray-700">{caption}</p>
          <span className="rounded-full bg-white px-2.5 py-1 text-xs font-medium text-gray-500 ring-1 ring-gray-200">
            {data.length} registros
          </span>
        </div>
      ) : null}
      <div className="overflow-x-auto">
        <table className="min-w-full divide-y divide-gray-200 text-sm">
          <thead className="bg-gray-50">
            <tr>
              {columns.map((column) => (
                <th key={column.key} className={cn('whitespace-nowrap px-4 py-3 text-left text-xs font-semibold uppercase text-gray-500', column.className)}>
                  {column.label}
                </th>
              ))}
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {data.length ? (
              data.map((row, index) => (
                <tr key={row.id || row.codigo || row.correo || index} className="transition-colors hover:bg-vino-50/35">
                  {columns.map((column) => (
                    <td key={column.key} className={cn('px-4 py-3 align-middle text-gray-700', column.cellClassName)}>
                      {column.render ? column.render(row, index) : row[column.key]}
                    </td>
                  ))}
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan={columns.length} className="px-4 py-8 text-center text-gray-500">
                  {emptyText}
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
      <div className="flex flex-col gap-3 border-t border-gray-100 bg-gray-50/70 px-4 py-3 sm:flex-row sm:items-center sm:justify-between">
        <p className="text-xs text-gray-500">
          Mostrando <span className="font-medium text-gray-700">{data.length ? 1 : 0}</span> a{' '}
          <span className="font-medium text-gray-700">{Math.min(data.length, 8)}</span> de{' '}
          <span className="font-medium text-gray-700">{data.length}</span> registros
        </p>
        <div className="flex items-center gap-2">
          <Button variant="outline" size="sm" disabled>
            <ChevronLeft className="h-4 w-4" />
            Anterior
          </Button>
          <span className="rounded-md bg-white px-3 py-1.5 text-xs font-medium text-gray-600 ring-1 ring-gray-200">
            Página 1 de {totalPages}
          </span>
          <Button variant="outline" size="sm" disabled={totalPages === 1}>
            Siguiente
            <ChevronRight className="h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  )
}
