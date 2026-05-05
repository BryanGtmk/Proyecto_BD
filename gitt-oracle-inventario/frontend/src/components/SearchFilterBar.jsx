import { Filter, Search } from 'lucide-react'
import { Input } from './ui/input'
import { Select } from './ui/select'

export default function SearchFilterBar({ search, onSearch, filters = [], placeholder = 'Buscar por código, nombre o serie' }) {
  return (
    <div className="rounded-lg border border-gray-200 bg-white p-4 shadow-sm">
      <div className="mb-3 flex items-center gap-2 text-sm font-medium text-gray-700">
        <Filter className="h-4 w-4 text-vino-700" />
        Búsqueda y filtros
      </div>
      <div className="grid gap-3 md:grid-cols-2 xl:grid-cols-[minmax(260px,1fr)_repeat(4,minmax(150px,190px))]">
        <div className="relative">
          <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" />
          <Input className="pl-9" placeholder={placeholder} value={search} onChange={(event) => onSearch(event.target.value)} />
        </div>
        {filters.map((filter) => (
          <label key={filter.label} className="block">
            <span className="sr-only">{filter.label}</span>
            <Select value={filter.value} onChange={(event) => filter.onChange(event.target.value)}>
              {filter.options.map((option) => (
                <option key={option} value={option}>
                  {option}
                </option>
              ))}
            </Select>
          </label>
        ))}
      </div>
    </div>
  )
}
