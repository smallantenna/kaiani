require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

get '/' do
  erb :index
end

get '/honyaku' do
  erb :honyaku
end

get '/chizu' do
  erb :chizu
end

get '/wiki' do
  erb :wiki
end

get '/user' do
  erb :user
end

get '/keiji' do
  @posts = Post.all.order(id: "DESC")
  erb :keiji
end

get '/keiji/new' do
  erb :new
end


post '/keijipost' do
  Post.create(title: params[:title], content: params[:content])
  tagname = Tag.where(name: params[:name])
  if tagname.empty?
    Tag.create(name: params[:name])
  end
  page_id2 = Post.last.id
  tag_id2 = tagname.last.id
  PostTag.create!({
    page_id: page_id2,
    tag_id: tag_id2})
  redirect '/keiji'
end

post '/keiji/:id/delete' do
  post = Post.find(params[:id])
  post.destroy
  post_tag = PostTag.find(params[:id])
  post_tag.destroy
  redirect '/keiji'
end

post '/keiji/search/' do
  tags = Tag.where(name: params[:keyword])
  if tags.empty?
    @posts = Post.none
  else
    tagid= tags.last.id
    page_ids = PostTag.where(tag_id: tagid).ids
    @posts = Post.where(id: page_ids)
  end
  erb :keiji
end
