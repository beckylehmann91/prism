desc "You Only Live Once"
task 'yolo' => ['db:drop', 'db:create', 'db:migrate', 'db:seed'] do
  exec "bundle exec rails s"
end