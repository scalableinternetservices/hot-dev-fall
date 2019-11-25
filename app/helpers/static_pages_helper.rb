module StaticPagesHelper
    def cache_key_for_share_requests(share_requests)
        max_update = share_requests.map(&:updated_at).max
        key = "#{@user.id}-ShareRequests-#{share_requests.count}-#{max_update}"
        puts "Fragment Cache: #{key}"
        return key
    end

    def cache_key_for_join_requests(join_requests)
        max_update = join_requests.map(&:updated_at).max
        key = "#{@user.id}-JoinRequests-#{join_requests.count}-#{max_update}"
        puts "Fragment Cache: #{key}"
        return key
    end

end
