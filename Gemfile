# coding: utf-8

ruby '2.2.5'

source "https://ruby.taobao.org"

gem "rails", "5.0.0.1"
gem 'sass-rails', '~> 5.0.6'
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "turbolinks"
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'therubyracer', platforms: :ruby

group :development do
  # 去除测试环境 assets提示
  #gem 'quiet_assets'
  gem 'pry-rails'

  # 报错时，浏览器直接执行命令DEBUG
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem "spring"
  gem "pry"
  gem "pry-byebug"

  # 完善rspec for rails测试
  gem 'shoulda-matchers'
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem "database_cleaner", "~> 1.5.3"
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'headless'
  gem 'selenium-webdriver'
end

# -------------

gem "figaro", "~> 1.1.1"
gem "devise", "4.2.0"
gem "kaminari", "~> 0.15.1"
gem "haml"
gem "mongoid",# "6.0.0.rc0"
  github: "mongodb/mongoid",
  tag: "v6.0.0"
#gem "bson_ext"
gem "unicorn"
gem "streamio-ffmpeg"
gem 'redis', '~>3.2'
gem 'enumerize', "2.0.0"
# -------------
gem "mina", "0.3.7"

# --------------------------------------

# 全文搜索
gem "elasticsearch-simple",
    github: "mindpin/elasticsearch-simple",
    ref: '9697be2'

# 支持分段上传的文件持久化
gem 'file-part-upload',
    github: "mindpin/file-part-upload",
    ref: "dc2ef6c"

# -----金融学院相关
gem 'kc_courses',
    github: 'mindpin/kc_courses',
    ref: "30146cb"

gem 'bank',
    github: "mindpin/bank",
    ref: "e740302"

gem 'enterprise_position_level',
    github: "mindpin/enterprise_position_level",
    ref: "a7c73e6"

gem 'question_mod',
    github: "fushang318/question_mod",
    ref: "dc5c9ea"

gem 'mongoid-simple-redis-cache',
    github: "mindpin/mongoid-simple-redis-cache",
    ref: "dc893d1"

# gem 'mongoid-simple-redis-cache', path: "/home/mindpin/mongoid-simple-redis-cache"

gem 'phone_number_check_mod',
  :github => 'kc-train/phone_number_check_mod',
  :tag => '0.0.2'
# ----------------------------------

gem 'sprockets', '3.4.0'
gem 'sprockets-rails', '2.3.3'

gem 'react-rails', '~> 1.8.0'
gem 'sprockets-coffee-react', '3.0.1'

# 控制台
#gem 'web-console', '~> 2.3.0'

# 去除静态资源指纹
gem 'non-stupid-digest-assets'

gem "pundit", "1.1.0"

# 手脚架
gem 'mongoid_react_scaffold',
  github: 'mindpin/mongoid_react_scaffold',
  ref: "3c6a8b7"

# 以下为其余依赖项
# for semantic
gem 'semantic-ui-sass', '~> 2.2.2.2'

#omniauth 微信登录
gem 'omniauth'
gem 'omniauth-oauth2'#, git: 'git://github.com/intridea/omniauth-oauth2.git'
gem "omniauth-wechat-oauth2"
# 浏览器类型判断, 判断是微信则自动跳转登录需要
gem 'agent_orange'
# 微信回复处理
gem 'weixin_rails_middleware', '~> 1.3.2'

# 通过 rails assets 服务加载前端包
source 'https://rails-assets.org'
gem 'rails-assets-semantic'

#http://medialize.github.io/URI.js/
gem 'rails-assets-URIjs'
# http://facebook.github.io/immutable-js/
gem 'rails-assets-immutable'
# https://github.com/Olical/EventEmitter/blob/master/docs/guide.md
gem 'rails-assets-eventEmitter'
# https://github.com/chjj/marked
gem 'rails-assets-marked'
# 滚动翻页
# https://github.com/seatgeek/react-infinite
gem 'rails-assets-react-infinite'
