require 'test/unit'
require 'active_support'
require 'open-uri'
require File.expand_path File.join(File.dirname(__FILE__), '..', 'lib', 'feminizer')
require 'shoulda'

class FeminizerTest < Test::Unit::TestCase
  def feminize_text *args
    Feminizer.feminize_text *args
  end
  def feminize_html *args
    Feminizer.feminize_html *args
  end

  context "feminize_text" do
    setup {
      @feminized = feminize_text "The Art of Manliness - by a Man’s man, as his hobby, to him and for masculine men everywhere"
    }
    should "swap genders of pronouns" do
      assert_equal "The Art of Womanliness - by a Woman’s woman, as her hobby, to her and for feminine women everywhere",
                   @feminized
    end
  end
  context "custom forms" do
    setup {
      Feminizer.forms = {'boy-a-boy' => 'girly-girla'}
      @feminized = feminize_text "boy-a-boy is a girl but girly-girla is not."
      Feminizer.forms = nil
    }
    should "turn all girly" do
      assert_equal "girly-girla is a girl but boy-a-boy is not.",
                   @feminized
    end
  end
  context "feminize" do
    setup {
      @feminized = feminize_html HTML.dup
    }
    should "have remote url in original" do
      assert_match %r{<li><a href="http://artofmanliness.com/man-knowledge">Man Knowledge</a></li>}, HTML
    end
    should "replace link content with feminized text and relative path" do
      assert_match %r{<li><a href="/man-knowledge">Woman Knowledge</a></li>}, @feminized
    end
    should "replace link content when it's next to an image" do
      assert_match %r{How to Apologize Like a Woman}, @feminized
    end
    should "swap genders in small string" do
      assert_match %r{This string started with Man in it and should turn into Woman},
                  feminize_html("This string started with Woman in it and should turn into Man")
    end
    should "swap genders in full document" do
      assert_match %r{This string started with Man in it and should turn into Woman}, @feminized
    end
    should "feminize even if a period is following the word" do
      assert_match %r{as the cowgirl.},
                   feminize_html(File.read("./test/fixture.html"))
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

end
