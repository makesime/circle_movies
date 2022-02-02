require 'rails_helper'

describe MoviesController, type: :controller do
  describe "search" do
    context "when there is no query params" do
      it "returns an empty body" do
        get :search, params: {}, format: :json

        expect(response.body).to be_empty
      end
    end

    context "when there is a query params" do
      let(:query_params) { "Star" }

      context "when there is no movies matching the query" do
        it "returns an empty body", :aggregate_failures do
          allow(RestClient).to receive(:get).and_return({})

          get :search, params: { query: query_params }, format: :json

          expect(JSON.parse(response.body)).to be_empty
          expect(RestClient).to have_received(:get).with("https://api.themoviedb.org/3/search/movie?api_key=a99cc60fc2b34dbb18cb806b8a88ed14", { params: {query: query_params}})
        end
      end

      context "when there is a movie matching the query" do
        it "returns an empty body", :aggregate_failures do
          mocked_data = { "title" => 'Star Wars' }

          allow(RestClient).to receive(:get).and_return(mocked_data)

          get :search, params: { query: query_params }, format: :json

          expect(JSON.parse(response.body)).to eq mocked_data
          expect(RestClient).to have_received(:get).with("https://api.themoviedb.org/3/search/movie?api_key=a99cc60fc2b34dbb18cb806b8a88ed14", { params: {query: query_params}})
        end
      end
    end
  end
end