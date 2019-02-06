use strict;
use warnings ;
#This is an example of aconversation held by Eliza 
#Hello! I'm Eliza the perfect compagnion for you , what's your name ?
#Leila
#Cute name, Leila, How can I help you today ?
#i need supporty
#Tell me more why you need supporty?
#Bcause I feel sad
#Hmm, what is making you feel sad?
#Life in general
#AH? really very interesting
#not very much
#Is that an existential crisis ?
#maybe, I guess
#Is that an existential crisis ?
#I said maybe
#Tell me more
#Life is meaningless anyway
#How can I help you with that?
#I don't know, how you can help me find a meaning
#you don't know, how you can help you find a meaning
#that'somehow true
#Sorry I didn't understand you quite well , could you elaborate ?
#I said there's truth in your speech, I need to find a meaning
#Tell me more why you need to find a meaning?
#to make my life worth living

my %def = (
	Tellmemore =>"Tell me more",
	Tryagain => "Sorry I didn't understand you quite well , could you elaborate ?",
	Interesting => "AH? really very interesting ",
	Help => "How can I help you with that?",
	Existential => "Is that an existential crisis ?"
);
#This is a hash table in case ELiza didn't detect a pattern or any key words
print "Hello! I'm Eliza the perfect compagnion for you , what's your name ? \n" ;
my $fullname ;
#Starting by detecting the name and handling different ways the user enters a name
while(<>){
	$fullname = $_;
	chomp $fullname;
	if($fullname =~ m/[.!?]$/) {chop $fullname ;}
	#cutting off punctuation 
	if($fullname =~ /(My name is |It's |I'm|I am )(\w+)/){
	$fullname =~ s/(My name is |It's |I'm|I am )(\w+)/$2/;
	last;
	}
	elsif($fullname eq ""){
	print "I'm sorry, didn't quite get it ? could you please repeat your name again \n";
}
else{
	last;
}
}
print "Cute name, $fullname, How can I help you today ? \n";
while(<>){
	chomp $_ ;
	if ($_ =~ m/[.!?]$/) { chop $_; }
  $_ =~ s/\bI'm\b/you are/;
  $_ =~ s/\b[Mm]y\b/your/;
  $_ =~ s/\b[Mm]e\b/you/;
  $_ =~ s/\bI\b/you/;
  response($_);
} #replacing certain pronouns to repond back 
my $line ; 
#a sub method used to respond back to the user , it detects certain keywords and patterns and responds back to the user
#ie: 'family' : > How do these people relate to you
sub response{
	$line = $_[0] ;
	 if ($line =~ m/\bneed\b/) {
    $line =~ s/(.*) need (.*)/Tell me more why you need $2\?/;
  }
  elsif ($line =~ m/\bwant\b/) {
    $line =~ s/(.*) want (.*)/Why do you want $2\?/;
  }
  elsif ($line =~ m/likes(s)?/) {
    $line =~ s/(.*)likes (.*)/What is the significance of liking $2\?/;
  }
  elsif ($line =~ m/I think/) {
    $line =~ s/(.*)I think (.*)/Why do you think $2\?/;
  }
  elsif ($line =~ m/I am/) {
    $line =~ s/(.*)I am (.*)/$fullname, why do you think you are $2\?/;
  }
  elsif ($line =~ m/([Tt]hey're|[Tt]hey are)/) {
    $line =~ s/(.*)([Tt]hey're |[Tt]hey are )(.*)/Can you tell me why you think they are $3\?/;
  }
  elsif ($line =~ m/(feel|feeling(s))/) {
    $line =~ s/(.*) (feel|feeling) (.*)/Hmm, what is making you feel $3\?/;
  }
  elsif ($line =~ m/\b(crave|craving)\b/) {
    $line = "Why don't you tell me more about your cravings $fullname?";
  }
  elsif ($line =~ m/\bdesire(s)?\b/) {
    $line =~ s/(.*)desire (.*)/What makes you desire $2\?/;
  }
  elsif ($line =~ m/love/) {
    $line =~ s/(.*) love (.*)/Tell more more about this love you feel./;
  }
  elsif ($line =~ m/don't know/) {
    $line =~ "are you always this uncertain ?";
  }
elsif ($line =~ m/sorry/){
	$line=~ "what feelings do you have when you apologize $fullname ?";
}
elsif ($line =~ m/remember/){
	$line = s/(.*)remember(.*)/Does of $2 bring anything else to mind?\?/ ;
}
elsif ($line =~ m/dream/){
	$line = "What does this dream suggest to you ? ";
}
elsif ($line =~ m/I am sad/){
	$line = "I am sorry to hear that";
}
elsif($line =~ m/I am happy/){
	$line = "GREAT!Happy to hear that as well";
}
elsif($line =~ m/make me/){
	$line = s/(.*)make me(.*)/How can I make you $2\?/ ;
}
elsif ($line =~ m/listen/){
	$line = "I am always here ";
}
elsif ($line =~ m/\b(joke|joking)\b/){
	$line = "I am not really good at telling jokes";
}
elsif ($line =~ m/goodbye/){
	$line = "Goodbye my lover , Goodbye my friend you have been the one .. ";
}
elsif ($line =~ m/\b(thank|thank you)\b/){
	$line = "Ah no need to thank me $fullname, remember we are friends  ";
}
elsif ($line =~ m/\b(fuck|shit|motherfucker|asshole)\b/){
	$line = "Please please no cursing";
}
elsif ($line =~ m/why/){
		$line = s/(.*)why(.*)/why do you think that this is $2\?/ ;
}
  elsif ($line =~ m/(friend(s)?|boyfriend|girlfriend|wife|husband|mom|dad|brother|sister|family)/) {
    $line = "Can you say more about the people you are talking about, what does this person relates to you?";
}
elsif ($line =~ m/(problem(s?)|issue(s?)|been|keep|have)/) {
    $line = "Tell me more about it."
  }
else{
	#throwing a random sentence in case it didn't detect any of these patterns 
 $line = $def{[keys %def]->[int rand keys %def]};

}
print "$line\n" ;
}
