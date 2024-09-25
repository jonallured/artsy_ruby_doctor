require "rspec/core/rake_task"
require "standard/rake"
require "csv"
require "json"
require "./lib/project_loader"
require "./lib/rails_exam"
require "./lib/ruby_exam"
require "./lib/ruby_project"

desc "Clone projects for examination"
task :clone_projects do
  ProjectLoader.clone_all
end

desc "Examine projects"
task :examine do
  projects = ProjectLoader.load_all

  projects.each do |project|
    default_output = {name: project.name}

    exams = [
      RubyExam.new(project),
      RailsExam.new(project)
    ]

    merged_output = exams.each_with_object(default_output) do |exam, memo|
      memo.merge!(exam.results)
    end

    output = merged_output.values.to_csv
    puts output
  end
end

RSpec::Core::RakeTask.new(:spec)
task default: %i[standard spec]
