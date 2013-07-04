# VATEUD tasks and workflow application: user guide

*by __Svilen Vassilev__, VATEUD7, Web Services Director*

___

## General information

### The essence (tl;dr)

The VATEUD tasks application is essentially a custom-built hybrid between a shared to-do
list and ticketing system, tailored for one particular purpose: workflow management and
collaboration both internally within VATEUD and externally between VATEUD and its vACCs
or other management bodies (VATEUR, BoG, etc).

### Goals

The VATEUD tasks application is designed to achieve the following goals:

* Structuring, organizing and keeping track of all VATEUD related concrete activities
* Coordination and collaboration between VATEUD staff members on individual tasks & projects
* Accountability, responsibility, metrics and audit on all tasks assigned to VATEUD staff
  either internally or by public users (vACC Staff, VATEUR or VATSIM staff)
* Statistics and breakdown of activities for individual VATEUD staff members; full history of
  actions and involvement
* Ability for public users (vACC staff) to assign (delegate) tasks to VATEUD staff members and
  follow up on these tasks' progress
* Ability to publicly receive data feeds (RSS) of all ongoing activities: new tasks, latest comments,
  recently completed tasks

The day-to-day use of the tasks application will result in an environment where:

* each VATEUD staff members is fully aware of all the other staff member activities, their progress
  and status, their estimated completion dates
* each VATEUD staff member can contribute and get involved on tasks that are not directly assigned to
  them, provided their input and cooperation is necessary
* there is full accountability and comprehensive records associated with each task, created internally
  or assigned externally to VATEUD, resulting in better efficiency, higher productivity and shorter
  response times
* vACC staff are given a window into all VATEUD operations and the ability to intervene, provide extra
  input and feedback and directly influence VATEUD schedule and activities by creating and assigning new
  tasks
* vACC staff are given a single "entry point" for anything they want to request from VATEUD. As far as
  concrete, measurable tasks are concerned, this system supersedes traditional forms of communication,
  such as email, instant messaging, forum private messaging, etc as it stimulates responsiveness and
  guarantees no requests will get "lost in transit". It also allows other VATEUD staff members other than
  the assignee to pick up the slack if required and see the assigned task through until its completion
  or cancellation
* transparency and accountability are the new defaults and they elevate the relation between VATEUD and vACC
  staff to a service based link between a service-provider and customer and that connection goes
  both ways. VATEUD provides service and is accountable to vACCs just as much as vACC as vACC are responsible
  for their performance, availability and activity. This openness, mutual understanding and shared agenda
  encourages VATEUD and vACC to work as partners on achieving common goals and managing the available
  resources efficiently.

### Domain and access

* The application resides at [tasks.vateud.net](http://tasks.vateud.net/)
* __RSS feeds__ are available at [tasks.vateud.net](http://tasks.vateud.net/) and require no accounts or
  authentication  
  ![RSS Feeds](http://i.imgur.com/FARLZs8.png)
* For accessing the interface and for posting new tasks a __sign-up__ is required. The registration form
  is publicly open, however newly created accounts require manual review and __activation__ by an admin.
  Email notification will be sent to the user when their account has been enabled.  
  ![Registration form](http://i.imgur.com/505u1RO.png)

### User eligibility
Account creation and task delegation is allowed for all vACC staff on the discretion of the vACC director.
Much like with the forums, the application admins won't refuse an account for an active vACC staff member,
if that's in agreement with the vACC director.
Staff accounts are provided to all VATEUD staff members (mandatory) and to any VATEUR or BoG staff member
(optionally upon request).

### Account deletion and credentials storage
* Accounts may be disabled for users vacating their VATEUD or vACC staff positions. This will prevent the
  user logging into the application. However no user records are ever deleted and all data and activity
  associated with those records is retained indefinitely.
* Passwords are stored as a random-salted SHA1 hash. No sensitive data is stored in plain text. Password
  reset tool is provided, associated with the registered email address.

### Access levels
In its current implementation the app has 4 levels of access with the following permission sets:

1. __Public__: can access the RSS feeds. Can access the sign-up and sign-in forms.
2. __User__: everything in 1. plus: can login and use the app interface, can create and delegate new tasks,
   can use the comments system without limitations
3. __Staff__: everything in 2. plus: can view _private_ tasks and comments, can be assigned to tasks,
   has full authority and editing permissions over their accepted tasks
4. __Admin__: everything in 3. plus: can edit or delete any task; can enable or disable user accounts;
   can promote and demote users from staff position

### Timestamps
All times recorded and displayed by the application use the zero meridian (__zulu__) time!
 
## Concepts
As this application supersedes previous experiments and collaboration attempts based on other platforms
and solutions, it has been intentionally designed with maximum simplicity and usability and minimum
learning curve. Hence the number of concepts and amount of logic involved are limited to the practical
minimums. As a single-purpose application it lacks versatility and customization options, but is (hopefully)
concise and powerful in serving the objectives it was designed to handle.

### The task
The entire application revolves and is centered around the concept of a task: each item created is a task
and tasks can be assigned (delegated) to staff members, edited, managed and organized in a hierarchy. More
complex concepts such as projects have been avoided in a favour of a flexible, tree-like structure of
nested tasks. 

### The nested tree design
If we think about what a project is: it's nothing but a task, composed of multiple subtasks, each of which
has - in turn - its own subtasks. The VATEUD tasks app replicates this concept by allowing nesting of tasks
in a tree-like hierarchy: each task can have an arbitrary number of "children" tasks (or "subtasks"), each
of them can in turn, have their own "children" or "branches" and this hierarchy can reach as deep as needed,
there are no imposed limitations. Hence complex tasks can have a complex tree of descendants below them if
necessary. The app interface for browsing those trees is very visual and intuitive, borrowing from the familiar
old computer file browsers:  

![Task tree](http://i.imgur.com/byGYw0U.png)

The mini arrows on the left of each task allow to easily expand and collapse the branches and the icons for
each task use a familiar analogy: tasks marked with a folder icon suggest that there is nested content (subtasks)
below that task, while the tasks marked with a standalone sheet of paper indicate no descendants.

### Task properties

Each task has the following properties:

* name: a short descriptive task name
* author: the name of the user, creating the task (recorded automatically)
* due date: by default is set 1 week ahead, but can be overridden by any future value
* assignees: any number of EUD/EUR staff members, selectable by name
* description: the actual description of the task, supports rich text formatting
* private: a private flag, see the "Private Tasks" section below
* status: the current status of the task, see "Task statuses" section below
* creation date/time: recorded automatically

### Task statuses

Each task goes through several different statuses within its life-cycle. The possible task statuses are:

* __New__: the default for each newly created task
* __Accepted__: the task has been reviewed and acknowledged by its assignee(s)
* __In progress__: the task is being worked on
* __Halted__: the task has been temporarily paused by the assignee(s)
* __Completed__: self explanatory
* __Cancelled__: self explanatory

Task statuses can be manipulated by the task assignee(s) following a logical pattern, i.e. a "new" task
can only be marked as "accepted" or "cancelled", a task can only be marked as "halted" if it was previously
"in progress" and so on.

For each status change, notification emails are sent to the task's author if the author __is not__ among the
assignees.

### Private tasks

Upon creation or editing, a task can be flagged as __private__. This means it will only be visible to user with
staff-level accounts (EUD/EUR) and __will not__ be available for public users:  

![Private tasks](http://i.imgur.com/oI632nU.png)

Private tasks are marked with an "eye" symbol inside the tasks tree for easy identification:  

![Private eye](http://i.imgur.com/mEUWy3o.png)

Even though we default to openness and transparency, there might be cases when sensitive issues are being dealt
with: DCRM topics, rating downgrades, CERT issues, other disputes, etc. The option is here to "draw the curtains"
over certain tasks and their associated comments, however use it on discretion and with common sense and only when
really necessary.

### Active and archived tasks

The app interface distinguishes between __active__ and __archived__ tasks.

* __Active__ tasks: with a status of "new", "accepted", "in progress" or "halted"
* __Archived__ tasks: with a status of "completed" or "cancelled"

### Attachments

Each task supports an arbitrary number of __attachments__: these can be any type of files, relevant to the task:
external documents, diagrams, images, etc. Attachments can be uploaded by the task's author while the task
is still "new", or later on by the task assignee(s). Attachments can be edited or deleted if necessary.

![Task attachments](http://i.imgur.com/M0UYKtb.png)

### Comments

Comments can be posted below each task as a way of communication between the task author and the assignee(s).
The comments system can be used by the task authors as a means of following up with the task, providing 
additional input, clarification, etc. Comments system is open to everybody, meaning that public-level accounts 
and non-assignees can also comment on any task (as long as it's not private.) Just like the task descriptions,
comments support rich text formatting and can be edited or deleted by their authors if needed. Mini buttons 
positioned to the right of the comments details can be clicked to trigger the edit or delete actions:

![Comments mini buttons](http://i.imgur.com/8FpPIo3.png)

### Action history

Each write action into the database is logged and displayed for reference and workflow awareness. The actions
logged include: task and comments creation, updates or deletion, user account manipulation, etc. For each
such change, the captured data includes:

* the user executing the change
* the date and time of the change
* the type of change (create, update, delete)
* the old value
* the new value

The diff sets for each change (or record version) are stored in the database in a serialized object notation and
the histories are displayed in reverse chronological order:

* on each individual task page (scoped for the particular task)
* on each individual user profile (scoped for the particular user)

Currently the changesets are displayed in their raw (and probably somewhat cryptic) json format, but more advanced
and user friendly parsing might be implemented later on if there's sufficient demand for it.  

![Task history](http://i.imgur.com/oUS6ht0.png)

## The user interface

### The log in screen

All parts of the application, apart from the RSS feeds in the footer and the help section, require authentication.
Hence the log-in screen is the first thing the visitor sees. The sign-up link should be used for new registrations
and the password reset form is available for emergencies.

![Login screen](http://i.imgur.com/5natrkD.png)

### Active tasks screen

#### The tasks list

The __Active tasks__ screen shows a paginated tree-list of all currently active tasks.

![Active tasks](http://i.imgur.com/TakyGNt.png)

This list contains the following elements:

* __tree icons and navigation controls__: tasks that have no descendants are indicated with a "sheet" icon,
  tasks containing nested tasks (children) are indicated by a "folder" icon. The mini-arrows in front of those
  icons are clickable and allow collapsing and folding of the nested branches
* __task name__: the task name is automatically trimmed to a certain length in this view, to avoid breaking the
  layout. It's also clickable and points to the task's details page
* __task status__: the different statuses are color coded for easier visual identification
* __private flag__: private tasks are denoted by the "eye" symbol
* __due date__: due dates are also color coded. They are black by default, but if a due date is less than a week
  in the future, then it's displayed in yellow and if the task is overdue (due date in the past), then it's shown
  in red
* __assignees__: the names of the task's assignee(s), also trimmed to a certain length to avoid over-stretching
* __actions mini-buttons__: shortcuts to the available actions for the particular task. The number and type of these
  buttons depends on the affiliation of the user viewing the page to the task in question, and also to some extent - 
  on the user's rank. For example the "show" action is available to all users and all tasks, however the "accept"
  action is only available to assignees of the task and only while the task status is "new". The types of actions
  and their availability is described in detail in the "Task actions" section below. All the mini-buttons here 
  display an explanatory tooltip on hover.

#### Sorting & Column headers

By default the list of tasks is sorted in reverse chronological order with the recently created or updated
tasks being shown on top.

The headers of most columns in the list are clickable to allow sorting of the entire list by the selected column.
Thus for example clicking on the "Name" label will sort all tasks in ascending alphabetical order. A mini-arrow will
appear next to the label to indicate the chosen sorting and its direction:  

![List alphabetical](http://i.imgur.com/u36iA3d.png)

Clicking again on the sane label, in our example it's the "Name", will reverse the sorting order, so all tasks will
be sorted in descending alphabetical order, also indicated by the reversed direction of the mini-arrow:  

![List reverse alphabetical](http://i.imgur.com/vZdWSgc.png)

#### Searching / filtering

The number of tasks displayed may be reduced by using a search (or filter). The filter button is on the top right
of the page, next to the title:

![Filter tasks](http://i.imgur.com/uaV99QN.png)

The button will trigger a modal dialog with the following available search fields:

* Name contains...
* Status is...
* Description contains...
* Assignee(s) names contain...
* Comments contain...

Combined searches are supported meaning tasks can be matched based on a single criteria or a combination.

![Filter modal](http://i.imgur.com/s9BoMfd.png)

### My tasks screen

The __My tasks__ screen has the same logic and elements like the "All tasks" screen. The only difference being
that here the tasks displayed are scoped through the user accessing the page in the following manner:

* for staff-level accounts the "My tasks" page displays the list of tasks that the user is assigned to (is assignee).
* for public-level accounts the "My tasks" page displays the list of tasks that the use has created (is author).

This difference is consequential to the fact that public-level accounts can create (delegate) tasks, but cannot
be assigned to tasks (can't be assignees). For public users this is also a convenient overview to keep track on the
tasks they've created and assigned and of their progress.

One more difference here is the ___"Switch to archived tasks"___  button:  

![Switch archived](http://i.imgur.com/Tl8e3sM.png)

When pressed in displays a view of all the archived (completed & cancelled) tasks, once again scoped via the user
as described above:  

![Archived user](http://i.imgur.com/UspQYSx.png)

### Archive screen

The archive screen follows the same layout and logic as described for the "Active tasks" screen, however it shows
a list of the already completed or cancelled tasks. Because of that you will notice that the actions available
for each task on the right (the mini-buttons) are also very limited.

![Archive view](http://i.imgur.com/AhAOpTr.png)


### New task screen

The "new task" form is straightforward: it requires filling-in the task's name, picking assignee(s) from the dropdown
menu (multiple assignees can be selected), picking a due date from the datepicker and entering the task description
(optional). The description field supports basic formatting and is enclosed in a simple WYSIWYG editor, much like
those familiar from forums and CMS apps. Notably the WYSIWYG editor supports the common keyboard shortcuts such as
_Ctrl-B_ for bold, _Ctrl-I_ for italic, etc.

![New task](http://i.imgur.com/ZMYMDDV.png)

### Task details screen

Clicking the task name or the "Task Details" mini-button opens the task details page. It shows the following elements
(refer to the screenshot below):

* Primary task attributes: author, name, due date, assignees, creation date/time, status, private flag, parent task (if any)
* Formatted task description
* Tree-style listing of the __active__ subtasks (if any)
* Tree-style listing of the __archived__ subtasks (if any)
* Task action buttons
* Task attachments (if any)
* Comment entry field
* List of comments (if any)
* Task history

![Task details](http://i.imgur.com/oiTcpCx.png)

#### Task actions

Several different types of actions are available for each task, based on the task's status, on the relation of the
logged user to the task and on the user's rank. These actions are accessible from the task's details page and 
from the mini-buttons in the task listing pages. Here's a breakdown of all possibilities:

* __Edit__: available for task's author while the task is with "new" status. Thereafter, when status changes to
 "accepted" and beyond, this is only available to the assignees. Always available to application admins.
* __Upload attachment__: available for task's author while the task is with "new status". Thereafter, when status changes to
 "accepted" and beyond, this is only available to the assignees.
* __Accept task__: changes the task status to accepted. Only available to assignees for tasks with "new" status.
* __Create subtask__: available for task's author while the task is with "new status". Thereafter, when status changes to
 "accepted" and beyond, this is only available to the assignees.
* __Mark in progress__: changes the task status to "in progress". Only available to assignees and for tasks with 
  a status of "accepted" or "halted"
* __Mark halted__: changes the task status to "halted". Only available to assignees for tasks marked as "in progress"
* __Mark Completed__: changes the task status to "completed". Only available to assignees
* __Mark Cancelled__: changes the task status to "cancelled". Available to authors while the task is still "new". 
  Thereafter only available to assignees.
* __Delete task__: only available to application admins. Non-reversible.  

#### Uploading attachments

Any type of file can be uploaded as an attachment to a task either by the author while the task is still new, or
by the assignees thereafter. Attachments can be edited and deleted by the assignees:

![Listed attachments](http://i.imgur.com/vNcyGaO.png)

#### Posting comments

The comments system is open to all account types on any task. Comments are listed in chronological order (oldest
on top, newest on bottom) and can be edited and deleted, but only by their respective author. Rich text formatting
is supported.

![Comments form](http://i.imgur.com/FAlfGfi.png)

### Edit task screen

Editing a task is very much like creating a task: the form and layout is the same, however there are 2 extra fields:

* Parent task selector: allows nesting the task below another task
* Status dropdown: allows overriding of the current task status

### Comments screen

The comments page gives a paginated list of all comments in reverse chronological order (newest on top). Useful
for a quick overview and locating of all recent discussions that have taken place.
Contains the following columns: 

* User (comment author, links to the user's profile)
* Date and time (of posting the comment)
* Private flag (if the related task is marked as private)
* Task name (links to the related task's details page)
* Comment text (trimmed to a certain length to fit on the page)
* Actions (mini buttons): for showing the comment, editing or deleting it (when applicable)

![Comments screen](http://i.imgur.com/SsH4WW4.png)

### User lists

2 types of user lists are available via the __User__ menu:

* __Staff list__: all application users with staff-level accounts
* __Public Users list__: all non-staff app users

These lists share common layout and information:

* User's name (linked to user's profile), email and status
* Basic statistics: assigned, active, created, completed and cancelled tasks
* Total number of sign-ins and date of last sign-in
* Actions (mini-buttons): available to admins

![Staff list](http://i.imgur.com/D7OXeMk.png)

#### User profiles

Clicking on a user's name from any page brings up the user's profile. It gives the basic details for that
user: name, email, vatsim id, vacc, staff position, etc and it also give a listing of this person's active
tasks and the recent actions history. A button in the top right allows switching the view to show that person's
archived (completed & cancelled) tasks.

![User profile](http://i.imgur.com/k06b5jJ.png)

#### User actions

Several actions are available to admins for each user via the mini-buttons on the right (tooltips on hover):

* enable or disable user account
* promote or demote from staff

![User actions](http://i.imgur.com/mPw0JTF.png)

## Additional functionality

### Email notifications

Email notifications are automatically sent to users in the following situations:

* Newly signed users receive a notification when their account has been enabled
* Assignees receive an email whenever they're assigned to a task (unless the author of the task is also an
  assignee: in thac case he won't receive an email, as the presumption is he's already aware of the assignment)
* Assignees receive an email whenever a new comment is posted to a task they're assigned to
* Task authors receive an email whenever the task status changes (unless the author is also among the task
  assignees)  

### The difference between staff accounts and public accounts

Staff accounts and public user accounts share mostly the same functionality with the following exceptions:

* Staff accounts can see private tasks and their related comments; public accounts can't
* On the "My tasks" page staff accounts see the tasks they have been assigned to and public
  accounts see the tasks they have created
* Only staff accounts can be used as task assignees

### Admin privileges

An application admin has the following privileges:

* can enable and disable user accounts
* can promote or demote from staff
* can edit all tasks
* can permanently delete a task

### RSS feeds

The application provides 3 public RSS feeds, no account or authentication required:

* Newest tasks
* Recently completed tasks
* Latest comments

The links to these feeds are available in the app footer.