require 'spec_helper'

describe 'LD4L::WorksRDF::GetModelFromURI' do

  describe "#call" do
    xit "should return nil if no triples found for uri" do
    end

    xit "should return nil when triples don't match any of the available models" do
    end

    it "should return instance of VivoBook when URI is from VIVO" do
      # uri = "http://vivo.cornell.edu/individual/n56611/n56611.ttl"
      uri = "http://vivo.cornell.edu/individual/n56611"
      generic_work = LD4L::WorksRDF::GetModelFromURI.call(uri)

      expect(generic_work).to be_kind_of LD4L::WorksRDF::VivoBook
      expect(generic_work.type).to include RDFVocabularies::BIBO.Book
      expect(generic_work.rdf_subject.to_s).to eq uri
    end

    it "should return instance of SchemaBook when URI is from Worldcat OCLC" do
      # uri = "http://vivo.cornell.edu/individual/n56611/n56611.ttl"
      uri = "http://www.worldcat.org/oclc/276976"
      generic_work = LD4L::WorksRDF::GetModelFromURI.call(uri)

      expect(generic_work).to be_kind_of LD4L::WorksRDF::SchemaBook
      expect(generic_work.type).to include RDF::SCHEMA.Book
      expect(generic_work.rdf_subject.to_s).to eq uri
    end


  end
end
