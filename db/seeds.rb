Project.project_types.keys.each do |project_type|
  Project.create! project_type: project_type
end
