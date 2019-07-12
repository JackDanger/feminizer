require 'active_support'
require File.expand_path File.join(File.dirname(__FILE__), '..', 'lib', 'feminizer')

describe Feminizer do

  describe '.feminize_text' do
    subject(:feminize_text) { Feminizer.feminize_text text }

    let(:text) { "The Art of Manliness - by a Man’s man, as his hobby, to him and for masculine men everywhere" }

    it "swaps genders of pronouns" do
      subject.should eq("The Art of Womanliness - by a Woman’s woman, as her hobby, to her and for feminine women everywhere")
    end

    context 'in a small string' do
      let(:text) { 'This string started with Woman in it and should turn into Man' }

      it 'swaps genders' do
        subject.should == 'This string started with Man in it and should turn into Woman'
      end
    end

    context 'between parentheses' do
      let(:text) { "This string started (with Woman) in it and should turn into (Man now)" }

      it 'swaps genders' do
        subject.should include('This string started (with Man) in it and should turn into (Woman now)')
      end
    end

    context "with custom forms" do
      let(:text) { "guhgirl is a made-up feminine term but buhboy is masculine." }

      let(:forms) { {'buhboy' => 'guhgirl'} }

      around do |example|
        Feminizer.forms = forms
        example.run
        Feminizer.forms = nil
      end

      it 'swaps the custom forms in both directions' do
        subject.should eq('buhboy is a made-up feminine term but guhgirl is masculine.')
      end
    end
  end

  context '.feminize_html' do
    subject(:feminize_html) { Feminizer.feminize_html html }

    let(:html) { HTML.dup }

    it "has remote url in original" do
      expect(html).to match(%r{<li><a href="http://artofmanliness.com/man-knowledge">Man Knowledge</a></li>})
    end

    it 'swaps genders in full document' do
      subject.should =~ %r{This string started with Man in it and should turn into Woman}
    end

    it 'replaces link content with feminized text and relative path' do
      subject.should =~ %r{<li><a href="/man-knowledge">Woman Knowledge</a></li>}
    end

    it 'replaces link content when link content is next to an image' do
      subject.should =~ %r{How to Apologize Like a Woman}
    end

    context 'if a period is following the word' do
      let(:html) { File.read(File.expand_path('fixture.html', __dir__)) }

      it 'feminizes even if a period is following the word' do
        subject.should =~ %r{as the cowgirl.}
      end
    end
  end
end

HTML = <<-EOHTML
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://opengraphprotocol.org/schema/" xmlns:fb="http://www.facebook.com/2008/fbml" dir="ltr" lang="en-US"> 
<head profile="http://gmpg.org/xfn/11"> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
<title>The Art of Manliness | Men&#039;s Interests and Lifestyle</title> 
<meta name="robots" content="noodp, noydir" /> 
<meta name="description" content="The Art of Manliness is a men\&#8217;s interest and lifestyle site dedicated to reviving the lost art of manliness." /> 
<meta name="keywords" content="men, man, manliness," /> 
<link rel="stylesheet" href="http://artofmanliness.com/wp-content/themes/thesis_18/style.css?081310-141114" type="text/css" media="screen, projection" /> 
<link rel="stylesheet" href="http://artofmanliness.com/wp-content/themes/thesis_18/custom/layout.css?082310-12445" type="text/css" media="screen, projection" /> 
<!--[if lte IE 8]><link rel="stylesheet" href="http://artofmanliness.com/wp-content/themes/thesis_18/lib/css/ie.css?072510-23516" type="text/css" media="screen, projection" /><![endif]--> 
<link rel="stylesheet" href="http://artofmanliness.com/wp-content/themes/thesis_18/custom/custom.css?091610-211116" type="text/css" media="screen, projection" /> 
<link rel="canonical" href="http://artofmanliness.com/" /> 
<link rel="alternate" type="application/rss+xml" title="The Art of Manliness RSS Feed" href="http://feeds2.feedburner.com/TheArtOfManliness" /> 
<link rel="pingback" href="http://artofmanliness.com/xmlrpc.php" /> 
<link rel="EditURI" type="application/rsd+xml" title="RSD" href="http://artofmanliness.com/xmlrpc.php?rsd" /> 
<script language="Javascript">
<!--
var axel = Math.random() + "";
var ord = axel * 1000000000000000000;
//-->
</script>
<!-- PUT THIS TAG IN THE head SECTION -->
<script type="text/javascript" src="http://partner.googleadservices.com/gampad/google_service.js">
</script>
<script type="text/javascript">
  GS_googleAddAdSenseService("ca-pub-5284223420088782");
  GS_googleEnableAllServices();
</script>
<script type="text/javascript">
  GA_googleAddSlot("ca-pub-5284223420088782", "300x105");
</script>
<script type="text/javascript">
  GA_googleFetchAds();
</script>
<!-- END OF TAG FOR head SECTION -->
<script type="text/javascript">
(function() {
var s = document.createElement('SCRIPT'), s1 = document.getElementsByTagName('SCRIPT')[0];
s.type = 'text/javascript';
s.src = 'http://widgets.digg.com/buttons.js';
s1.parentNode.insertBefore(s, s1);
})();
</script>
<script type="text/javascript">var _sf_startpt=(new Date()).getTime()</script>
<meta name="verify-postrank" content="7pljxog" /> 
<link rel='stylesheet' id='slideshow-gallery-css'  href='http://artofmanliness.com/wp-content/plugins/slideshow-gallery/css/gallery-css.php?1=1&amp;resizeimages=Y&amp;width=618&amp;height=336&amp;border&amp;background=%23000000&amp;infobackground=%23000000&amp;infocolor=%23FFFFFF&#038;ver=1.0' type='text/css' media='screen' /> 
<link rel='stylesheet' id='wp-email-css'  href='http://artofmanliness.com/wp-content/plugins/wp-email/email-css.css?ver=2.50' type='text/css' media='all' /> 
<script type='text/javascript' src='http://artofmanliness.com/wp-includes/js/jquery/jquery.js?ver=1.4.2'></script> 
<script type='text/javascript' src='http://artofmanliness.com/wp-content/plugins/slideshow-gallery/js/gallery.js?ver=1.0'></script> 
<meta property="fb:admins" content="9604892"/><meta property="og:site_name" content="The Art of Manliness"/><meta property="og:url" content="http://artofmanliness.com/"/><meta property="og:type" content="blog"/><!-- tweet this -->
<!-- End tweet this -->

<link rel=”shortcut icon” href=”http://artofmanliness.com/favicon.ico”>
<meta name="verify-v1" content="4RSETFIMUwgS0VJ1XssuMNE1blUbrfpZHAb6qTSZde0=" >
		<style type="text/css"> 
						ol.footnotes li {list-style-type:decimal;}
						ol.footnotes{font-size:0.8em; color:#666666;}		</style> 
		</head> 
<body class="custom"> 
<div id="header_area" class="full_width"> 
<div class="page"> 
<div id="topad">
<!-- FM Leaderboard 1 Zone -->
<script type='text/javascript' src='http://static.fmpub.net/zone/3323'></script>
<!-- FM Leaderboard 1 Zone -->
</div>	<div id="header"> 
		<p id="logo"><a href="http://artofmanliness.com">The Art of Manliness</a></p> 
		<h1 id="tagline">Men&#039;s Interests and Lifestyle</h1> 
	</div> 
<ul class="menu"> 
<li class="tab tab-home current"><a href="http://artofmanliness.com" rel="nofollow">Home</a></li> 
	<li class="cat-item cat-item-3"><a href="http://artofmanliness.com/category/a-mans-life/" title="View all posts filed under A Man&#039;s Life">A Man&#039;s Life</a> 
</li> 
	<li class="cat-item cat-item-5"><a href="http://artofmanliness.com/category/dress-grooming/" title="View all posts filed under Dress &amp; Grooming">Dress &amp; Grooming</a> 
</li> 
	<li class="cat-item cat-item-7"><a href="http://artofmanliness.com/category/health-sports/" title="View all posts filed under Health &amp; Sports">Health &amp; Sports</a> 
</li> 
	<li class="cat-item cat-item-11"><a href="http://artofmanliness.com/category/manly-skills/" title="View all posts filed under Manly Skills">Manly Skills</a> 
</li> 
	<li class="cat-item cat-item-12"><a href="http://artofmanliness.com/category/money-career/" title="View all posts filed under Money &amp; Career">Money &amp; Career</a> 
</li> 
	<li class="cat-item cat-item-65"><a href="http://artofmanliness.com/category/relationships-family/" title="View all posts filed under Relationships &amp; Family">Relationships &amp; Family</a> 
</li> 
<li><a href="http://community.artofmanliness.com">Community</a></li> 
<li><a href="http://artofmanliness.com/man-knowledge">Man Knowledge</a></li> 
</ul> 
</div> 
</div>
</div>
  <span>This string started with Woman in it and should turn into Man</span>
  <span>I love me that cowboy.</span>
  <a href="/2009/08/23/how-to-apologize-like-a-man/" rel="bookmark">
    <img src="http://content.artofmanliness.com/uploads/2009/thumbnails/apologizethumb.jpg" alt="How to Apologize Like a Man">
    How to Apologize Like a Man
  </a>
</body>
</html>
EOHTML
