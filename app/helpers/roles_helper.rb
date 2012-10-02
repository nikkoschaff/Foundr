module RolesHelper
    def role_login_path
        url_for :controller => :roles,
                :action => :login
    end

    def role_logout_path
        url_for :controller => :roles,
                :action => :logout
    end

    def role_authenticate_path
        url_for :controller => :roles,
                :action => :authenticate
    end

    def role_signup_path
        url_for :controller => :roles,
                :action => :signup
    end

    def role_index_path
        url_for :controller => :roles,
                :action => :index
    end

    def role_search_path
        url_for :controller => :roles,
                :action => :search
    end

    def role_filter( skills, ambitions, profiles = Array.new )
        good_profiles = Array.new

        profiles.each do |profile| 
            match = true
            #Remove all where ambitions don't match
            unless ambitions.nil?
                ambitions.each do |ambition|
                    unless profile.ambitions.include?(ambition)
                        match = false
                    end
                end
            end

            unless skills.nil?
                #Remove all where skills don't match
                skills.each do |skill| 
                    unless profile.tag_list.include?(skill)
                        match = false
                    end
                end
            end

            if match
                good_profiles.push(profile)
            end
        end
        good_profiles
    end    
end
