organize
========

Organize your Mac filesystem.

Huh?
----

Organize helps you stay organized on your Mac. It sets up a very simple project
management system that works for me (maybe not you).

Install
-------

    $ gem install organize
    $ organize install

Now you can create some projects!

    $ organize create FOSS
    $ organize create Social
    $ organize create Freelance
    $ organize create ElDorado

What does this do for me?
-------------------------

Organize will create a folder in your home directory called Projects. Inside of
this folder you can place all of your projects. If you've ever used
[Things](http://culturedcode.com/things/) by CulturedCode, think of these
projects like Areas of Responsibility. These are *large* goals in your life that
won't be completed for a couple months or will never be completed. Don't make
too many of them. I usually have around 13 or so.

Inside of each project folder, there are two folders created for you
automatically. The Shared folder links to a folder in your
[Dropbox](http://www.dropbox.com/) of the same name as the project. Anything
that you'd like to share across multiple computers should be placed in here.

The other folder is the Archive folder. Treat this like the Archive folder of
Gmail. Don't delete things that you may possibly need later. Put them in the
Archive for storage.

Organize also creates a couple other folders. The Archive folder located in the
root of the Projects folder are for old projects that you've completed but would
like to still have the file around, just in case something bad happens. The
Inbox folder is a symlink to your Desktop. This folder and its corresponding
Shared folder are for things that you're either too lazy to fit into another
folder or are very temporary things that you'll never need for more than 5 or
ten minutes. Keep your desktop down to 5 or 6 items at all times.

The Other folder links your various home folder sections (like Documents,
Movies, Music, etc.) that don't quite fit into the organization system. The only
things that should go in these folders are resources which transcend the
projects. Your iTunes folder is a prime example, along with [Parallels
VMs](http://www.parallels.com/products/desktop/) and movies you've downloaded.
This folder also has a Shared folder for things like your
[1Password](http://agilewebsolutions.com/products/1Password) keychain.

That's it.

Awesome! How can I make this even cooler?
-----------------------------------------

You can make your life easier by adding a simple little function to your zsh.

    cd ~/Projects/$1;

Ohhh yeahhh!

You can even make it autocomplete!

    #compdef p
    _files -W ~/Projects -/

Crazy!

Just as a small cosmetic enhancement, I like using the icon of the Utilities
folder for my Projects folder. It kinda make it fit in more when viewed in the
Finder.

Note on Patches/Pull Requests
-----------------------------

 * Fork the project.
 * Make your feature addition or bug fix.
 * Add tests for it. This is important so I don’t break it in a future version unintentionally.
 * Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself in another branch so I can ignore when I pull)
 * Send me a pull request. Bonus points for topic branches.

Copyright
---------

See the LICENSE for details.