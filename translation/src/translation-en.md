# Translating and Customizing CUPS

Thanks to its extensive use of templates, images, and message catalogs, CUPS can be easily translated (or customized!) to suit your needs. This help file will guide you through the CUPS localization files so you can get the most out of it.

## Getting Started

Start by downloading the CUPS source code from [www.cups.org](http://www.cups.org/software.php). After you extract the files from the source archive, you will want to copy the following files and directories:

  * desktop/cups.desktop \- the GNOME/KDE desktop file pointing to the CUPS web interface
  * doc/index.html \- the web interface home page
  * locale/cups.pot \- the message catalog
  * templates/*.tmpl \- the web interface template files



With the exception of the message catalogs and desktop file, localization files are placed in subdirectories under the doc and templates using the locale name. Locale names are either ll or ll_CC, where "ll" is the 2-letter language code and "CC" is the 2-letter country code. _CUPS does not currently use or support the newer ll-region syntax for locale names._

All non-image files must be encoded using the UTF-8 character set.

## Submitting a Translation for CUPS

To submit a translation for inclusion in CUPS, translate the desktop file, all of the template files, the index.html.in file, and the message catalog. Place these files in the correct subdirectories in the CUPS source code archive and run the following command to create an archive with your files:
    
    
    tar cvf _ll_CC_.tar.gz desktop/cups.desktop doc/_ll_CC_ \
        locale/cups__ll_CC_.po templates/_ll_CC_
    

Replace "ll_CC" with the locale name for your translation. Once you have created the archive, go to the [CUPS Bugs &amp; Features](http://www.cups.org/str.php) page and submit a bug report, attaching the translation to the report.

## The Desktop File

The desktop/cups.desktop file provides a link to the CUPS web interface from desktop environments such as GNOME and KDE. To translate this file, add two lines to the bottom with the `Name` and `Comment` keys:
    
    
    Name[_ll_CC_]=_Translation of "Manage Printing"_
    Comment[_ll_CC_]=_Translation of "CUPS Web Interface"_
    

## The Home Page

The index.html file is a complete HTML file that is displayed when the user visits "http://localhost:631/". Edit the existing doc/index.html and save it in the doc/ll_CC subdirectory so that the makefile can install it. Run "make install" in the doc subdirectory to test the new home page.

## Message Catalogs

CUPS message catalogs are GNU gettext ".po" text files that provide a list of localized message strings for the CUPS software. Message catalogs are named cups_ll.po or cups_ll_CC.po, where "ll" is the standard 2-letter abbreviation for the language and "CC" is the standard 2-letter abbreviation for the country.

When translating a new message catalog, copy the cups.pot message catalog file in the locale subdirectory of the CUPS source code. For example, to start translating the message catalog to Canadian French, you would type the following commands:
    
    
    cd locale
    cp cups.pot cups_fr_CA.po
    

Alternatively, you can copy the existing cups_fr.po message catalog and then make any necessary changes.

Once you have make your copy of the file, edit it using your favorite text editor or translation program to translate the text to the desired language.

Then validate your translation using the locale/checkpo utility:
    
    
    cd locale
    ./checkpo cups_ll_CC.po
    

After fixing any errors in your translation, add your locale to the `LANGUAGES` variable in the Makedefs file and run the "make install" command in the locale subdirectory to test the translation.

## Template Files

The CUPS scheduler provides a web interface that can be used to do many common printing and administration tasks. The built-in web server supports localization of web pages through the use of subdirectories for each locale, e.g. "fr" for French, "de" for German, "fr_ca" for French in Canada, and so forth.

Template files are HTML files with special formatting characters in them that allow substitution of variables and arrays. The CUPS CGI programs (`admin.cgi`, `classes.cgi`, `help.cgi`, `jobs.cgi`, and `printers.cgi`) use these template file to provide dynamic content for the web interface. Template files are installed in the /usr/share/cups/templates directory by default. Table 2 lists the various template files and their purpose.

Translated versions of the template files should be saved in the templates/ll_CC subdirectory. For example, Canadian French template files should be saved in the templates/fr_CA subdirectory. After you have translated all of the templates, add the locale to the `LANGUAGES` variable in the Makedefs file and run "make install" in the templates subdirectory to test the translation.

Table 2: Web Interface Template Files Filename | Purpose  
---|---  
add-class.tmpl | This is the initial form that is shown to add a new printer class.  
add-printer.tmpl | This is the initial form that is shown to add a new printer.  
add-rss-subscription.tmpl | This is the form that is shown to add a new RSS subscription.  
admin.tmpl | This is the main administration page.  
choose-device.tmpl | This is the form that shows the list of available devices.  
choose-make.tmpl | This is the form that shows the list of available manufacturers.  
choose-model.tmpl | This is the form that shows the list of available printer models/drivers.  
choose-serial.tmpl | This is the form that allows the user to choose a serial port and any options.  
choose-uri.tmpl | This is the form that allows the user to enter a device URI for network printers.  
class-added.tmpl | This template shows the "class added" message.  
class-confirm.tmpl | This is the template used to confirm the deletion of a class.  
class-deleted.tmpl | This template shows the "class deleted" message.  
class-jobs-header.tmpl | This template shows the "jobs" header for jobs in a class.  
class-modified.tmpl | This template shows the "class modified" message.  
classes.tmpl | This template shows one or more printer classes.  
classes-header.tmpl | This template shows the "showing N of M classes" header in the class list.  
edit-config.tmpl | This is the cupsd.conf editor page.  
error.tmpl | This template displays a generic error message.  
error-op.tmpl | This is the "unknown operation" error page.  
header.tmpl | This template is used as the standard header on all dynamic content.  
help-header.tmpl | This is the top part of the help page.  
help-printable.tmpl | This is the standard page header for the printable version of help files.  
job-cancel.tmpl | This template shows "job canceled".  
job-hold.tmpl | This template shows "job held".  
job-move.tmpl | This template shows the move-job form.  
job-moved.tmpl | This template shows "job moved".  
job-release.tmpl | This template shows "job released".  
job-restart.tmpl | This template shows "job reprinted".  
jobs.tmpl | This template is used to list the print jobs on a server, class, or printer.  
jobs-header.tmpl | This template shows the "showing N or M jobs" header in the jobs list.  
list-available-printers.tmpl | This template shows a list of new printers that have been found.  
maintenance.tmpl | This template shows "maintenance commands sent".  
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
printer-accept.tmpl | This template shows "printer now accepting jobs".  
printer-added.tmpl | This template shows "printer added".  
printer-configured.tmpl | This template shows "printer configured".  
printer-confirm.tmpl | This template asks the user to confirm the deletion of a printer.  
printer-default.tmpl | This template shows "default printer set".  
printer-deleted.tmpl | This template shows "printer deleted".  
printer-jobs-header.tmpl | This templates shows the "jobs" header for jobs on a printer.  
printer-modified.tmpl | This template shows "printer modified".  
printer-purge.tmpl | This template shows "printer has been purged of all jobs".  
printer-reject.tmpl | This template shows "printer now rejecting jobs".  
printer-start.tmpl | This template shows "printer started".  
printer-stop.tmpl | This template shows "printer stopped".  
printers.tmpl | This template is used to list information on one or more printers.  
printers-header.tmpl | This template shows the "showing printer N of M" header in the printers list.  
restart.tmpl | This template shows "server restarting".  
samba-export.tmpl | This template shows the export printers to Samba form.  
samba-exported.tmpl | This template shows "printers exported to Samba".  
search.tmpl | This template shows the search form.  
set-printer-options-header.tmpl | This template shows the first part of the set printer options form.  
set-printer-options-trailer.tmpl | This template shows the last part of the set printer options form.  
subscription-added.tmpl | This template shows "subscription ... added".  
subscription-canceled.tmpl | This template shows "subscription #NNN canceled".  
test-page.tmpl | This template shows "test page printed".  
trailer.tmpl | This template is used as the standard trailer on all dynamic content.  
users.tmpl | This template shows the set allowed users form.  
  
### Inserting Attributes and Values

Template files consist of HTML with variable substitutions for named inside curly braces "{name}". Variable names are generally the IPP attribute names with the hyphen ("-") replaced by the underscore ("_") character. For example, the `job-printer-uri` attribute is renamed to `job_printer_uri`.

Curley braces ("{" and "}") to indicate substitutions, and the backslash ("\") character for quoting. To insert any of these special characters as-is you need to use the HTML `&name;` mechanism or prefix each special character with the backslash ("\".)

You substitute the value of a variable using `{NAME}` in your template file. If the variable is undefined then the `{NAME}` string is output as-is.

To substitute an empty string if the variable is undefined, use `{?NAME}` instead.

### Array Substitutions

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

### Conditional Tests

Templates can also test variables against specific values and conditionally include text in the template. The format is:
    
    
    {_variable_?_true_:_false_}
    {_variable_=_value_?_true_:_false_}
    {_variable_!_value_?_true_:_false_}
    {_variable_<_value_?_true_:_false_}
    {_variable_>_value_?_true_:_false_}
    

where true is the text that is included if the condition is true and false is the text that is included if the condition is false. A value of `#` is replaced with the current element number (starting at 1.) The character after the variable name specifies the condition to test. Table 3 shows the available test conditions.

Table 3: Template Substitution Conditions Char | Condition  
---|---  
? | True if variable exists.  
= | True if variable is equal to value.  
! | True if variable is not equal to value.  
&lt; | True if variable is less than value.  
&gt; | True if variable is greater than value.  
  
### CGI Programs

CUPS uses five CGI programs to manage the dynamic web interfaces:

  * `admin.cgi`
  * `classes.cgi`
  * `help.cgi`
  * `jobs.cgi`
  * `printers.cgi`



Each CGI program accepts standard form variables such as `OP` for the operation to perform, `PRINTER_NAME` for the printer or class name to operate on, `QUERY` for any search words, `FIRST` for the first class, job, or printer to display, and `ORDER` to control the order that classes, jobs, or printers are displayed.

In addition, the `classes.cgi`, `jobs.cgi`, and `printers.cgi` programs support a `WHICH_JOBS` variable to control which jobs are displayed. Table 4 lists the supported values.

Table 4: WHICH_JOBS Values WHICH_JOBS Value | Description  
---|---  
all | Show all jobs  
completed | Show completed jobs  
not-completed | Show active jobs  
  
#### admin.cgi

The `admin.cgi` program handles all of the printer and class administration functions and is run for all direct accesses to the /admin resource. For most operations it uses the `PRINTER_NAME` and `OP` form variables to specify the action requested. Table 5 shows the supported `OP` values.

Table 5: admin.cgi OP Values OP Value | Description  
---|---  
accept-jobs | Accepts jobs on the named destination.  
add-class | Adds a new printer class.  
add-printer | Adds a new printer.  
config-server | Configures the server.  
delete-class | Deletes a printer class. The form variable `CONFIRM` may be set to any value to bypass the confirmation page.  
delete-printer | Deletes a printer. The form variable `CONFIRM` may be set to any value to bypass the confirmation page.  
export-samba | Exports printers to Samba.  
find-new-printers | Find new printers that have not yet been added.  
modify-class | Modifies a printer class.  
modify-printer | Modifies a printer.  
purge-jobs | Purges all jobs on the named destination.  
redirect | Redirects the web browser to the location referenced by the URL form variable.  
reject-jobs | Rejects new jobs on the named destination.  
set-allowed-users | Sets the allowed users for a destination.  
set-as-default | Sets the default destination.  
set-printer-options | Sets the default options for a printer.  
set-sharing | Sets the printer-is-shared attribute for a destination.  
start-class | Starts the named class.  
start-printer | Starts the named printer.  
stop-class | Stops the named class.  
stop-printer | Stops the named printer.  
  
#### classes.cgi

The `classes.cgi` program is responsible for listing class information, including jobs destined for that class. It is for all direct accesses to the /classes resource and supports the optional form variables `OP` and `WHICH_JOBS`. If no form variables are supplied then the CGI lists all or a specific class and the active jobs on each class. Table 6 shows the supported `OP` values.

Table 6: classes.cgi OP Values OP Value | Description  
---|---  
move-jobs | Moves the jobs on this class to another destination.  
print-test-page | Prints the standard PostScript test page.  
  
#### help.cgi

The `help.cgi` program handles all of the on-line help functions and is run for all direct accesses to the /help resource.

#### jobs.cgi

The `jobs.cgi` program handles all of the job functions and is run for all direct accesses to the /jobs resource. For most operations it uses the `JOB_ID`, `OP`, and `WHICH_JOBS` form variables to specify the action requested. Table 7 shows the supported `OP` values.

Table 7: jobs.cgi OP Values OP Value | Description  
---|---  
cancel-job | Cancels a job.  
hold-job | Holds a job indefinitely.  
move-job | Moves a job to another destination.  
release-job | Releases a job for printing.  
restart-job | Restarts/reprints a stopped, canceled, completed, or aborted print job.  
  
#### printers.cgi

The `printers.cgi` program is responsible for listing printer information, including jobs destined for that printer. It is for all direct accesses to the /printers resource and supports the optional form variables `OP` and `WHICH_JOBS`. If no form variables are supplied then the CGI lists all printers or a specific printer and the active jobs on that printer. Table 8 shows the supported `OP` values.

Table 8: printers.cgi OP Values OP Value | Description  
---|---  
clean-print-heads | Clean the print heads.  
move-jobs | Move all jobs to a different destination.  
print-self-test-page | Print a printer self-test page.  
print-test-page | Print a PostScript test page.
