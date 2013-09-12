$mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
. (Join-Path $mydir 'Microsoft.PowerShell_profile.ps1')

$psISE.Options.FontName = 'Mensch'
$psISE.Options.FontSize = 11



######## Solarized Colors ########
$base03  =   	"#FF002b36"
$base02    	=	"#FF073642"
$base01    	=	"#FF586e75"
$base00    	=	"#FF657b83"
$base0     	=	"#FF839496"
$base1     	=	"#FF93a1a1"
$base2     	=	"#FFeee8d5"
$base3     	=	"#FFfdf6e3"
$yellow    	=	"#FFb58900"
$orange    	=	"#FFcb4b16"
$red       	=	"#FFdc322f"
$magenta 	=	"#FFd33682"
$violet    	=	"#FF6c71c4"
$blue      	=	"#FF268bd2"
$cyan      	=	"#FF2aa198"
$green     	=	"#FF859900"


######## Command and Script - Dark ########
#$psISE.Options.CommandPaneBackgroundColor = $base03
$psISE.Options.ScriptPaneBackgroundColor = $base03

######## Output - Light ########

$psISE.Options.ConsolePaneBackgroundColor = $base02 
$psISE.Options.ConsolePaneTextBackgroundColor = $base03 
$psISE.Options.ConsolePaneForegroundColor = $base01

#Error mesages etc use secondary text background
$psISE.Options.ErrorBackgroundColor = $base02
$psISE.Options.WarningBackgroundColor = $base02
$psISE.Options.VerboseBackgroundColor =  $base02
 $psISE.Options.DebugBackgroundColor = $base02
 #Error messages etc foregrounds
 $psISE.Options.ErrorForegroundColor = $red
 $psISE.Options.WarningForegroundColor = $orange
 $psISE.Options.VerboseForegroundColor = $blue
 $psISE.Options.DebugForegroundColor = $blue
 
 
######## Tokens ########
$psISE.Options.TokenColors.item('Attribute') = $green
$psISE.Options.TokenColors.item('Command') = $red
$psISE.Options.TokenColors.item('CommandArgument') = $base0
$psISE.Options.TokenColors.item('CommandParameter') = $base0
$psISE.Options.TokenColors.item('Comment') = $base01
$psISE.Options.TokenColors.item('GroupEnd') = $base0
$psISE.Options.TokenColors.item('GroupStart') = $base0 
$psISE.Options.TokenColors.item('Keyword') = $yellow
$psISE.Options.TokenColors.item('LineContinuation') = $base0
$psISE.Options.TokenColors.item('LoopLabel') = $base0
$psISE.Options.TokenColors.item('Member') = $base0
$psISE.Options.TokenColors.item('NewLine') = $base0
$psISE.Options.TokenColors.item('Number') = $base01
$psISE.Options.TokenColors.item('Operator') = $base0
$psISE.Options.TokenColors.item('Position') = $base0
$psISE.Options.TokenColors.item('StatementSeparator') = $base0
$psISE.Options.TokenColors.item('String') = $base01
$psISE.Options.TokenColors.item('Type') = $cyan
$psISE.Options.TokenColors.item('Unknown') = $base01
$psISE.Options.TokenColors.item('Variable') = $blue

######## Console Tokens ########
$psISE.Options.ConsoleTokenColors.item('Attribute') = $green
$psISE.Options.ConsoleTokenColors.item('Command') = $red
$psISE.Options.ConsoleTokenColors.item('CommandArgument') = $base0
$psISE.Options.ConsoleTokenColors.item('CommandParameter') = $base0
$psISE.Options.ConsoleTokenColors.item('Comment') = $base01
$psISE.Options.ConsoleTokenColors.item('GroupEnd') = $base0
$psISE.Options.ConsoleTokenColors.item('GroupStart') = $base0 
$psISE.Options.ConsoleTokenColors.item('Keyword') = $yellow
$psISE.Options.ConsoleTokenColors.item('LineContinuation') = $base0
$psISE.Options.ConsoleTokenColors.item('LoopLabel') = $base0
$psISE.Options.ConsoleTokenColors.item('Member') = $base0
$psISE.Options.ConsoleTokenColors.item('NewLine') = $base0
$psISE.Options.ConsoleTokenColors.item('Number') = $base01
$psISE.Options.ConsoleTokenColors.item('Operator') = $base0
$psISE.Options.ConsoleTokenColors.item('Position') = $base0
$psISE.Options.ConsoleTokenColors.item('StatementSeparator') = $base0
$psISE.Options.ConsoleTokenColors.item('String') = $base01
$psISE.Options.ConsoleTokenColors.item('Type') = $cyan
$psISE.Options.ConsoleTokenColors.item('Unknown') = $base01
$psISE.Options.ConsoleTokenColors.item('Variable') = $blue

######## XML Tokens #############

$psISE.Options.XmlTokenColors.item('Comment') = $green
$psISE.Options.XmlTokenColors.item('CommentDelimiter') = $green
$psISE.Options.XmlTokenColors.item('ElementName') = $blue
$psISE.Options.XmlTokenColors.item('MarkupExtension') = $orange
$psISE.Options.XmlTokenColors.item('Attribute') = $cyan
$psISE.Options.XmlTokenColors.item('Quote') = $base0
$psISE.Options.XmlTokenColors.item('QuotedString') = $base0
$psISE.Options.XmlTokenColors.item('Tag') = $base0
$psISE.Options.XmlTokenColors.item('Text') = $base1
$psISE.Options.XmlTokenColors.item('CharacterData') = $base01