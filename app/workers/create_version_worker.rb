class CreateVersionWorker
	include Sidekiq::Worker
	def perform(id)
		i = Image.find id
		i.file.create_versions = true
		i.file.recreate_versions!
		i.versions_created = true
		i.save
	end
end