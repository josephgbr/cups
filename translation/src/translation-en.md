# Translating and Customizing CUPS

Thanks to its extensive use of templates, images, and message catalogs, CUPS can be easily translated (or customized!) to suit your needs. This help file will guide you through the CUPS localization files so you can get the most out of it.

## Getting Started

Start by downloading the CUPS source code from [www.cups.org](https://www.cups.org/). After you extract the files from the source archive (or clone the Git repository), you will want to copy the following files and directories:

  * _desktop/cups.desktop_ \- the GNOME/KDE desktop file pointing to the CUPS web interface
  * _doc/index.html.in_ \- the web interface home page
  * _locale/cups.pot_ \- the message catalog
  * _templates/*.tmpl_ and _templates/header.tmpl.in_ \- the web interface template files



With the exception of the message catalogs and desktop file, localization files are placed in subdirectories under the _doc_ and _templates_ using the locale name. Locale names are either _ll_ or _ll_CC_ , where "ll" is the 2-letter language code and "CC" is the 2-letter country code. _CUPS does not currently use or support the newer _ll-region_ syntax for locale names._

All non-image files must be encoded using the UTF-8 character set.

## Submitting a Translation for CUPS

To submit a translation for inclusion in CUPS, translate the desktop file, all of the template files, the _index.html.in_ file, and the message catalog. Place these files in the correct subdirectories in the CUPS source code archive and run the following command to create an archive with your files:
    
    
    tar cvf _ll_CC_.tar.gz desktop/cups.desktop doc/ _ll_CC_ locale/cups_ _ll_CC_.po templates/ _ll_CC_
    

Replace "ll_CC" with the locale name for your translation. Once you have created the archive, go to the [CUPS project page](https://github.com/apple/cups) and submit a bug report, attaching the translation to the report.

Alternately, you can clone the CUPS project on Github, make your changes, and submit a pull request from the same link.

## The Desktop File

The _desktop/cups.desktop_ file provides a link to the CUPS web interface from desktop environments such as GNOME and KDE. To translate this file, add two lines to the bottom with the `Name` and `Comment` keys:
    
    
    Name[ _ll_CC_ ]= _Translation of "Manage Printing"_
    Comment[ _ll_CC_ ]= _Translation of "CUPS Web Interface"_
    

## The Home Page

The _index.html.in_ file is a complete HTML file that is displayed when the user visits "http://localhost:631/". Edit the existing _doc/index.html.in_ and save it in the _doc/ll_CC_ subdirectory so that the configure script can generate it. After configuring, run "make install" in the _doc_ subdirectory to test the new home page.

## Message Catalogs

CUPS message catalogs are GNU gettext ".po" text files that provide a list of localized message strings for the CUPS software. Message catalogs are named _cups_ll.po_ or _cups_ll_CC.po_ , where "ll" is the standard 2-letter abbreviation for the language and "CC" is the standard 2-letter abbreviation for the country.

When translating a new message catalog, copy the _cups.pot_ message catalog file in the _locale_ subdirectory of the CUPS source code. For example, to start translating the message catalog to Canadian French, you would type the following commands:
    
    
    cd locale
    cp cups.pot cups_fr_CA.po
    

Alternatively, you can copy the existing _cups_fr.po_ message catalog and then make any necessary changes.

Once you have make your copy of the file, edit it using your favorite text editor or translation program to translate the text to the desired language.

Then validate your translation using the _locale/checkpo_ utility:
    
    
    cd locale
    ./checkpo cups_ll_CC.po
    

After fixing any errors in your translation, add your locale to the `LANGUAGES` variable in the _Makedefs_ file and run the "make install" command in the _locale_ subdirectory to test the translation. _This variable is automatically updated when you run the configure script._

## Template Files

The CUPS scheduler provides a web interface that can be used to do many common printing and administration tasks. The built-in web server supports localization of web pages through the use of subdirectories for each locale, e.g. "fr" for French, "de" for German, "fr_ca" for French in Canada, and so forth.

Template files are HTML files with special formatting characters in them that allow substitution of variables and arrays. The CUPS CGI programs (`admin.cgi`, `classes.cgi`, `help.cgi`, `jobs.cgi`, and `printers.cgi`) use these template file to provide dynamic content for the web interface. Template files are installed in the _/usr/share/cups/templates_ directory by default. [Table 1](table1) lists the various template files and their purpose.

Translated versions of the template files should be saved in the _templates/ll_CC_ subdirectory. For example, Canadian French template files should be saved in the _templates/fr_CA_ subdirectory. After you have translated all of the templates, add the locale to the `LANGUAGES` variable in the _Makedefs_ file and run "make install" in the _templates_ subdirectory to test the translation.

_Table 1: Web Interface Template Files_

Filename | Purpose  
---|---  
add-class.tmpl | This is the initial form that is shown to add a new printer class.  
add-printer.tmpl | This is the initial form that is shown to add a new printer.  
admin.tmpl | This is the main administration page.  
choose-device.tmpl | This is the form that shows the list of available devices.  
choose-make.tmpl | This is the form that shows the list of available manufacturers.  
choose-model.tmpl | This is the form that shows the list of available printer models/drivers.  
choose-serial.tmpl | This is the form that allows the user to choose a serial port and any options.  
choose-uri.tmpl | This is the form that allows the user to enter a device URI for network printers.  
class.tmpl | This template shows information about a single class.  
class-added.tmpl | This template shows the "class added" message.  
class-confirm.tmpl | This is the template used to confirm the deletion of a class.  
class-deleted.tmpl | This template shows the "class deleted" message.  
class-jobs-header.tmpl | This template shows the "jobs" header for jobs in a class.  
class-modified.tmpl | This template shows the "class modified" message.  
classes.tmpl | This template shows one or more printer classes.  
classes-header.tmpl | This template shows the "showing N of M classes" header in the class list.  
command.tmpl | This template shows the status of a command job.  
edit-config.tmpl | This is the cupsd.conf editor page.  
error.tmpl | This template displays a generic error message.  
error-op.tmpl | This is the "unknown operation" error page.  
header.tmpl(.in) | This template is used as the standard header on all dynamic content. Edit the _header.tmpl.in_ file and let the configure script generate the _header.tmpl_ file.  
help-header.tmpl | This is the top part of the help page.  
help-printable.tmpl | This is the standard page header for the printable version of help files.  
help-trailer.tmpl | This is the bottom part of the help page.  
job-cancel.tmpl | This template shows "job canceled".  
job-hold.tmpl | This template shows "job held".  
job-move.tmpl | This template shows the move-job form.  
job-moved.tmpl | This template shows "job moved".  
job-release.tmpl | This template shows "job released".  
job-restart.tmpl | This template shows "job reprinted".  
jobs.tmpl | This template is used to list the print jobs on a server, class, or printer.  
jobs-header.tmpl | This template shows the "showing N or M jobs" header in the jobs list.  
list-available-printers.tmpl | This template shows a list of new printers that have been found.  
modify-class.tmpl | This template is used as the first form when modifying a class.  
modify-printer.tmpl | This template is used as the first form when modifying a printer.  
norestart.tmpl | This template shows "server not restarted because no changes were made to the configuration".  
option-boolean.tmpl | This template is used to select a boolean PPD option.  
option-conflict.tmpl | This template shows the conflicting options.  
option-header.tmpl | This template is used to start a PPD option group.  
option-pickmany.tmpl | This template is used to select a multi-valued PPD option.  
option-pickone.tmpl | This template is used to select a single-valued PPD option.  
option-trailer.tmpl | This template is used to end a PPD option group.  
pager.tmpl | This template shows the previous/next pager bar.  
printer.tmpl | This template shows information about a single printer.  
printer-accept.tmpl | This template shows "printer now accepting jobs".  
printer-added.tmpl | This template shows "printer added".  
printer-cancel-jobs.tmpl | This template shows "All jobs on printer have been canceled."  
printer-configured.tmpl | This template shows "printer configured".  
printer-confirm.tmpl | This template asks the user to confirm the deletion of a printer.  
printer-default.tmpl | This template shows "default printer set".  
printer-deleted.tmpl | This template shows "printer deleted".  
printer-jobs-header.tmpl | This templates shows the "jobs" header for jobs on a printer.  
printer-modified.tmpl | This template shows "printer modified".  
printer-reject.tmpl | This template shows "printer now rejecting jobs".  
printer-start.tmpl | This template shows "printer started".  
printer-stop.tmpl | This template shows "printer stopped".  
printers.tmpl | This template is used to list information on one or more printers.  
printers-header.tmpl | This template shows the "showing printer N of M" header in the printers list.  
restart.tmpl | This template shows "server restarting".  
search.tmpl | This template shows the search form.  
set-printer-options-header.tmpl | This template shows the first part of the set printer options form.  
set-printer-options-trailer.tmpl | This template shows the last part of the set printer options form.  
test-page.tmpl | This template shows "test page printed".  
trailer.tmpl | This template is used as the standard trailer on all dynamic content.  
users.tmpl | This template shows the set allowed users form.  
  
#### Inserting Attributes and Values

Template files consist of HTML with variable substitutions for named inside curly braces "{name}". Variable names are generally the IPP attribute names with the hyphen ("-") replaced by the underscore ("_") character. For example, the `job-printer-uri` attribute is renamed to `job_printer_uri`.

Curley braces ("{" and "}") to indicate substitutions, and the backslash ("\") character for quoting. To insert any of these special characters as-is you need to use the HTML `&name;` mechanism or prefix each special character with the backslash ("\".)

You substitute the value of a variable using `{NAME}` in your template file. If the variable is undefined then the `{NAME}` string is output as-is.

To substitute an empty string if the variable is undefined, use `{?NAME}` instead.

#### Array Substitutions

The number of array elements can be inserted using `{#NAME}`. If the array is undefined then 0 is output. The current array element (starting at 1) is inserted with `{#}`.

Arrays are handled using `{[NAME]` at the beginning of a section and `}` at the end. The information between the closing bracket ("]") and closing brace ("}") is repeated for as many elements as are in the named array. For example, the following template will display a list of each job in the `job_id` array:
    
    
    <TABLE>
    <TR>
    	<TH>Job ID</TH>
    	<TH>Destination</TH>
    	<TH>Title</TH>
    </TR>
    
    {[job_id]
    <TR>
    	<TD>{?job_id}</TD>
    	<TD>{?job_printer_name}</TD>
    	<TD>{?job_name}</TD>
    </TR>
    }
    </TABLE>
    

Arrays can be nested, however all elements within the curly braces ("{" and "}") are indexed using the innermost array.

#### Conditional Tests

Templates can also test variables against specific values and conditionally include text in the template. The format is:
    
    
    { variable? true : false }
    { variable = value? true : false }
    { variable! value? true : false }
    { variable < value? true : false }
    { variable > value? true : false }
    

where _true_ is the text that is included if the condition is true and _false_ is the text that is included if the condition is false. A value of `#` is replaced with the current element number (starting at 1.) The character after the variable name specifies the condition to test. Table 2 shows the available test conditions.

_Table 2: Template Substitution Conditions_

Char | Condition  
---|---  
? | True if _variable_ exists.  
= | True if _variable_ is equal to _value_.  
! | True if _variable_ is not equal to _value_.  
< | True if _variable_ is less than _value_.  
\> | True if _variable_ is greater than _value_.  
  
#### What to Localize in a Template File

Because HTML contains both markup (that generally is not localized) and text (which _is_ localized), you should carefully avoid changing the markup unless it contains human-readable text. The following HTML examples show how to correctly localize template files:
    
    
    <!-- English table heading -->
    <table class="list" summary="Printer List">
    
    <!-- Correctly localized to French; the class attribute is unchanged but summary is localized -->
    <table class="list" summary="Liste des imprimantes">
    
    <!-- English hyperlink -->
    <li><a {SECTION=help?class="active" :}href="/help/">Help</a></li>
    
    <!-- Correctly localized to Danish; the href attribute is unchanged while the link text is localized -->
    <li><a {SECTION=help?class="active" :}href="/help/">Hjælp</a></li>
    

### CGI Programs

CUPS uses five CGI programs to manage the dynamic web interfaces:

  * `admin.cgi`
  * `classes.cgi`
  * `help.cgi`
  * `jobs.cgi`
  * `printers.cgi`



Each CGI program accepts standard form variables such as `OP` for the operation to perform, `PRINTER_NAME` for the printer or class name to operate on, `QUERY` for any search words,`FIRST` for the first class, job, or printer to display, and `ORDER` to control the order that classes, jobs, or printers are displayed.

In addition, the `classes.cgi`, `jobs.cgi`, and `printers.cgi` programs support a `WHICH_JOBS` variable to control which jobs are displayed. Table 3 lists the supported values.

_Table 3: WHICH_JOBS Values_

WHICH_JOBS Value | Description  
---|---  
all | Show all jobs  
completed | Show completed jobs  
not-completed | Show active jobs  
  
#### admin.cgi

The `admin.cgi` program handles all of the printer and class administration functions and is run for all direct accesses to the _/admin_ resource. For most operations it uses the `PRINTER_NAME` and `OP` form variables to specify the action requested. Table 4 shows the supported `OP` values.

_Table 4: admin.cgi OP Values_

OP Value | Description  
---|---  
add-class | Adds a new printer class.  
add-printer | Adds a new printer.  
config-server | Configures the server.  
delete-class | Deletes a printer class. The form variable `CONFIRM` may be set to any value to bypass the confirmation page.  
delete-printer | Deletes a printer. The form variable `CONFIRM` may be set to any value to bypass the confirmation page.  
find-new-printers | Find new printers that have not yet been added.  
modify-class | Modifies a printer class.  
modify-printer | Modifies a printer.  
redirect | Redirects the web browser to the location referenced by the URL form variable.  
set-allowed-users | Sets the allowed users for a destination.  
set-as-default | Sets the default destination.  
set-printer-options | Sets the default options for a printer.  
set-sharing | Sets the printer-is-shared attribute for a destination.  
  
#### classes.cgi

The `classes.cgi` program is responsible for listing class information, including jobs destined for that class. It is for all direct accesses to the _/classes_ resource and supports the optional form variables `OP` and `WHICH_JOBS`. If no form variables are supplied then the CGI lists all or a specific class and the active jobs on each class. Table 5 shows the supported `OP` values.

_Table 5: classes.cgi OP Values_

OP Value | Description  
---|---  
accept-jobs | Start accepting jobs for a class.  
cancel-jobs | Cancel all jobs for a class.  
move-jobs | Move all jobs to a different destination.  
print-test-page | Print a PostScript test page.  
reject-jobs | Stop accepting jobs for a class.  
start-class | Start processing jobs for a class.  
stop-class | Stop processing jobs for a class.  
  
#### help.cgi

The `help.cgi` program handles all of the on-line help functions and is run for all direct accesses to the _/help_ resource.

#### jobs.cgi

The `jobs.cgi` program handles all of the job functions and is run for all direct accesses to the _/jobs_ resource. For most operations it uses the `JOB_ID`, `OP`, and `WHICH_JOBS` form variables to specify the action requested. Table 6 shows the supported `OP` values.

_Table 6: jobs.cgi OP Values_

OP Value | Description  
---|---  
cancel-job | Cancels a job.  
hold-job | Holds a job indefinitely.  
move-job | Moves a job to another destination.  
release-job | Releases a job for printing.  
restart-job | Restarts/reprints a stopped, canceled, completed, or aborted print job.  
  
#### printers.cgi

The `printers.cgi` program is responsible for listing printer information, including jobs destined for that printer. It is for all direct accesses to the _/printers_ resource and supports the optional form variables `OP` and `WHICH_JOBS`. If no form variables are supplied then the CGI lists all printers or a specific printer and the active jobs on that printer. Table 7 shows the supported `OP` values.

_Table 7: printers.cgi OP Values_

OP Value | Description  
---|---  
accept-jobs | Start accepting jobs for a printer.  
cancel-jobs | Cancel all jobs for a printer.  
clean-print-heads | Clean the print heads.  
move-jobs | Move all jobs to a different destination.  
print-self-test-page | Print a printer self-test page.  
print-test-page | Print a PostScript test page.  
reject-jobs | Stop accepting jobs for a printer.  
start-printer | Start processing jobs for a printer.  
stop-printer | Stop processing jobs for a printer.
