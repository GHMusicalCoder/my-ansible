# my-ansible
My ansible pull installation for my several computers and servers

## order of operations
1. System setup + system applications

    * Ensure personal directories are configured properly based on machine
    * Configure gitlab and github configuration swapping mechanisms
    * Set up base system items from our included files:
      * before implementing these - I want to clean these up so they are more spaced out as I have some aliases and such that I wouldn't want at the office machine, etc
        * bashrc
        * bashoffice
        * bashfunction
        * bashalias
    * Install additional base system applications
    * Configure and install additional installation programs
      * deb-get + git repo + etc-functions
      * cmk-get
    * Configure NFS Mounts
    * Configure Virtual Machine options
      * VM cleanup
    * Configure Laptop apps
    * Copy files (desktop images and media)
    * Install additional 3rd party "system" applications
2. Install various category applications (apt or deb-get or cmk-get)
   * Accessories
   * Development
     * When installing VS Code Extensions - use redhat.ansible instead of the other ansible
     * Install git configuration manager
   * Games
   * Graphics
   * Internet
   * Multimedia
   * Office
   * Classic Optical

The ultimate goal is to add to this as I install new software (and possibly remove unused software)

