# Capistranoのバージョンを指定（初期から記入済み）
lock "~> 3.16.0"

# アプリケーションの指定
set :application, 'レポジトリ名'
set :repo_url,  'git@github.com:Githubのユーザー名/レポジトリ名.git'

# sharedディレクトリに入れるファイルを指定
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"public/uploads}

# SSH接続設定
set :ssh_options, {
  auth_methods: ['publickey'], 
  keys: ['~/.ssh/プライベートキーの名前.pem'] 
}

# 保存しておく世代の設定
set :keep_releases, 5

# rbenvの設定
set :rbenv_type, :user
set :rbenv_ruby, 'アプリで使用しているrubyのバージョン'

# ここからUnicornの設定
# Unicornのプロセスの指定
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの指定
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }

# Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end