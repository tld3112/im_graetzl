FactoryGirl.define do
  factory :graetzl do
    name { Faker::Address.state }
    area 'POLYGON ((16.4128450657195 48.183551642743, 16.4141410396874 48.1847468254663, 16.4179746804597 48.188336981471, 16.4182949066162 48.1886357007129, 16.4181981794536 48.1887644492203, 16.4210017969166 48.1872171158218, 16.4226078987122 48.1863753964575, 16.4238095283508 48.1882494532502, 16.431040763855 48.1860034381042, 16.4266371308001 48.1796456365342, 16.4266208735803 48.179622163504, 16.4264316836488 48.1796797331962, 16.4255199507791 48.1799385718702, 16.4178210510993 48.1821242180591, 16.4128450657195 48.183551642743))'

    factory :naschmarkt do
      name 'Naschmarkt, Wien'
      area 'POLYGON ((16.3628482818604 48.2017878350298, 16.3661313056946 48.1996782855253, 16.36674284935 48.200035842403, 16.3681483268738 48.1995281108924, 16.3671398162842 48.1958379673246, 16.3661313056946 48.1960024561277, 16.365133523941 48.1963814935332, 16.3624942302704 48.1946007085328, 16.3605844974518 48.1925480803642, 16.3586640357971 48.1917541847011, 16.3581275939941 48.1913751130639, 16.3549196720123 48.1928842306771, 16.3526451587677 48.1932561390921, 16.3505637645722 48.1947222902002, 16.352162361145 48.1968821046768, 16.3538467884064 48.1976187093228, 16.3563358783722 48.1982265789672, 16.3608849048615 48.1998213085758, 16.3628482818604 48.2017878350298))'
    end

    factory :seestadt_aspern do
      name 'Seestadt Aspern, Donaustadt, Wien'
      area 'POLYGON ((16.5121936798096 48.2188970041048, 16.4945125579834 48.222328159191, 16.4999628067017 48.2344497320006, 16.511721611023 48.2350786031843, 16.5151977539062 48.2338208530875, 16.5175580978394 48.2311337379368, 16.5121936798096 48.2188970041048))'
    end

    factory :aspern do
      name 'Aspern, Donaustadt, Wien'
      area 'POLYGON ((16.4661455154419 48.1932132267204, 16.4834403991699 48.1811963488412, 16.490650177002 48.1920688835525, 16.5265274047851 48.2030535230341, 16.527214050293 48.2091169503771, 16.5292739868164 48.2111760642959, 16.5297928033378 48.2115217957377, 16.5297933528197 48.2115221619029, 16.529792917825 48.2115223112455, 16.5195107460022 48.2144361586738, 16.5195107460022 48.2150652758014, 16.5210127830505 48.2159803414607, 16.5275171127969 48.2327023832229, 16.5276741448313 48.2331060308005, 16.5276959510783 48.2331620830527, 16.5277067356429 48.2331898044047, 16.5277121364592 48.2332074930556, 16.5317983480463 48.2471198724891, 16.5323989785812 48.2491645283871, 16.5323953757622 48.2491648611758, 16.5222663891134 48.2497409496417, 16.5094534650539 48.250471345761, 16.4977455494551 48.2511387421498, 16.4976256355213 48.2511426677241, 16.4887833595276 48.251340813712, 16.4886907093209 48.2512431176782, 16.4784228386407 48.2404148914653, 16.4783698752882 48.2403590317645, 16.4775778041584 48.2395236382397, 16.4751791954041 48.2369937541755, 16.4720892906189 48.235850389073, 16.4723896980286 48.2330776225887, 16.4698897749177 48.2301634330478, 16.4698148821481 48.2300760817457, 16.4697766080552 48.2300253571277, 16.4794017443345 48.2219215794251, 16.4837408065796 48.2182679340594, 16.4824533462524 48.2148365068312, 16.4800930023193 48.2129491238258, 16.4761018753052 48.2045408452392, 16.4755803989062 48.20402171708, 16.4727115631103 48.2011657057335, 16.4716673173093 48.2004950028258, 16.4690718594119 48.1988279423719, 16.4687071520869 48.1985936868126, 16.4682550545854 48.1983032980871, 16.4679908752441 48.1981336111358, 16.4666604995727 48.1968749531235, 16.4661462385737 48.193218368637, 16.4661455154419 48.1932132267204))'
    end
  end
end