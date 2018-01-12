json.extract! task, :id, :name, :description, :startdate, :enddate, :status, :project_id, :created_at, :updated_at
json.url task_url(task, format: :json)
