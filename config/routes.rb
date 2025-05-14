Rails.application.routes.draw do

  # Routes for the Session resource:

  get("/", { :controller => "sessions", :action => "index" })

  # CREATE
  post("/insert_session", { :controller => "sessions", :action => "create" })
          
  # READ
  get("/sessions", { :controller => "sessions", :action => "index" })
  
  get("/sessions/:path_id", { :controller => "sessions", :action => "show" })
    
  # DELETE
  get("/delete_session/:path_id", { :controller => "sessions", :action => "destroy" })

  #------------------------------

  # Routes for the User resource:

  # CREATE
  post("/insert_user", { :controller => "users", :action => "create" })
          
  # READ
  get("/users", { :controller => "users", :action => "index" })
  
  get("/users/:path_id", { :controller => "users", :action => "show" })
  
  # UPDATE
  
  post("/modify_user/:path_id", { :controller => "users", :action => "update" })
  
  # DELETE
  get("/delete_user/:path_id", { :controller => "users", :action => "destroy" })

  #------------------------------

  # Routes for the Message resource:

  # CREATE
  post("/insert_message", { :controller => "messages", :action => "create" })
          
  # READ
  #get("/messages", { :controller => "messages", :action => "index" })
  
  #get("/messages/:path_id", { :controller => "messages", :action => "show" })
  
  # UPDATE
  
  post("/modify_message/:path_id", { :controller => "messages", :action => "update" })
  
  # DELETE
  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
