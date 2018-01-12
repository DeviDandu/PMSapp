json.extract! project, :id, :name, :code, :startdate, :enddate, :status, :created_at, :updated_at
json.url project_url(project, format: :json)
