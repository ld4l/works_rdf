module LD4L
  module WorksRDF
    class GetMetadataFromVivoModel

      ##
      # Get standard display metadata from an vivo model
      #
      # @param [String, RDF::URI] uri for the work
      # @param [Model] an vivo model
      #
      # @returns an instance of LD4L::WorksRDF::WorkMetadata
      def self.call( uri, model )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

        uri = uri.to_s if uri.kind_of?(RDF::URI)

        # TODO: Determine type of work from the model.  Right now, only processing books.
        metadata = self.populate_with_vivo_book( model )  if
            model.type.include?(RDFVocabularies::BIBO.Book.to_s) || model.type.include?(RDFVocabularies::BIBO.Document.to_s)
        metadata.uri      = uri
        metadata.local_id = URI.parse(uri).path.split('/').last
        metadata
      end

      def self.populate_with_vivo_book( model )
        # TODO: Could reach out to OCLC and get more info OR could make multiple calls to VIVO to get more info
        metadata = LD4L::WorksRDF::WorkMetadata.new(model)
        metadata.set_type_to_book
        if model.title && model.title.size > 0
          metadata.title          = model.title.first
        elsif model.label && model.label.size > 0
          metadata.title          = model.label.first
        end
        metadata.pub_info         = "#{model.place_of_publication.first} : #{model.publisher.first.label.first}"  if
            model.place_of_publication && model.place_of_publication.size > 0 &&
            model.publisher && model.publisher.size > 0 && model.publisher.first.label
        metadata.oclc_id          = model.oclcnum.first                  if model.oclcnum && model.oclcnum.size > 0
        metadata.source           = "VIVO"
        metadata.set_source_to_cornell_vivo
        metadata
      end
    end
  end
end
