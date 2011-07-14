Fabricator(:product) do
  name 'Foobar'
  url 'http://store.com/product'
  affiliate_uri 'http://network.com?url={url}&epi={epi}'
end
