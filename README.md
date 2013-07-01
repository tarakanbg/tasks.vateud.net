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
* authentication  
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
All times recorded and displayed by the application use the zero meridian (zulu) time!
 
## Concepts
As this application supersedes previous experiments and collaboration attempts based on other platforms
and solutions, it has been intentionally designed with maximum simplicity and usability and minimum
learning curve. Hence the number of concepts and amount of logic involved are limited to the practical
minimums. As a single-purpose application it lacks versatility and customization options, but is concise
and powerful in serving the objectives it was designed to handle.

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

* New
* Accepted
* In progress
* Halted
* Completed
* Cancelled