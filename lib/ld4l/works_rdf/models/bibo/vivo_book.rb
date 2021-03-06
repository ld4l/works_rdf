module LD4L
  module WorksRDF
    class VivoBook < LD4L::WorksRDF::BiboBook
      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDFVocabularies::VIVO.Book,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :most_specific_type,   :predicate => RDFVocabularies::VITRO.mostSpecificType
      property :date_time_value,      :predicate => RDFVocabularies::VIVO.dateTimeValue,       :cast => false
      property :place_of_publication, :predicate => RDFVocabularies::VIVO.placeOfPublication
      property :publisher,            :predicate => RDFVocabularies::VIVO.publisher,           :class_name => LD4L::FoafRDF::Agent
      property :relatedBy,            :predicate => RDFVocabularies::VIVO.relatedBy,           :class_name => LD4L::WorksRDF::VivoAuthorship       # author
    end
  end
end
