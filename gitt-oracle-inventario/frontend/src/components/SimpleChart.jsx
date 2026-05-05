export default function SimpleChart({ data }) {
  const max = Math.max(...data.map((item) => item.total))
  return (
    <div className="space-y-4">
      {data.map((item) => (
        <div key={item.estado}>
          <div className="mb-1 flex justify-between text-sm">
            <span className="font-medium text-gray-700">{item.estado}</span>
            <span className="text-gray-500">{item.total}</span>
          </div>
          <div className="h-3 rounded-full bg-gray-100">
            <div className={`h-3 rounded-full ${item.color}`} style={{ width: `${(item.total / max) * 100}%` }} />
          </div>
        </div>
      ))}
    </div>
  )
}
