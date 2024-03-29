## Goal
This is my "20 minutes" script to be up and running on any ubuntu computer.  This is not meant to work with other envs as i don't care.

## Contribution
I have no problems with contributions for any glaring bugs, everything else, all other features / things i should definitely have, please don't.  Just annoying and noisy.  I don't like your setup, i like mine.

## How To Setup Env
1. Get ansible on your system asap.  I'll make this process easier and eventually will have dev.theprimeagen.com just emit out this little script so its simple to start with

Run this in the directory you wish to clone down theprimeagen dev

```
mkdir personal
cd personal
curl https://raw.githubusercontent.com/ThePrimeagen/dev/master/resources/setup | sh
```

## TODO
1. neovim
1. make a small subdomain off of theprimeagen.com with the aforementioned setup script that way i can do something like `curl https://dev.theprimeagen.com | sh`.  Tiz would be cooler

## Things Needing Investigation
I did not log out / back in to see if zsh shell stuck upon chsh via ansible...

## Done

1. Install docker and ensure user crap is done 
1. cp over keyboard config and layout into xkb
1. zsh
1. i3 -- pretty shotty playbook, but it works.
1. core utils that i love
1. tmux
1. tmux-sessionizer

## Ponderings
Should I have languages be installed or just assume those are things i'll let myself figure out later.  Such as installing `n` and node or golang.  Rust is pretty easy because it self updates 

