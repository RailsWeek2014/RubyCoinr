class Array

	# group array elements by attribute in hash
	# attribution: http://apidock.com/rails/Enumerable/group_by
	def cluster attr
		cluster = Hash.new

		each do |elt|
			if cluster.has_key? elt[attr]
				cluster[elt[attr]] << elt
			else
				cluster[elt[attr]] = [elt]
			end
		end

		cluster
	end

end