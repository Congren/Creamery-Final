json.array!(@shift_jobs) do |shift_job|
  json.extract! shift_job, :id, :job_id, :shift_id
  json.url shift_job_url(shift_job, format: :json)
end
