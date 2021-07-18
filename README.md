# Dockerfile for building rustc

Dockerfile for building rust compiler in Windows container.

## Build Docker Image

```bash
git clone git@github.com:kiripon/rust-windows-builder.git
cd rust-windows-builder
make
```

## Run Container

```bash
cd rust-windows-builder
make run
```

## Why not use winget?

In the rustc dev guide, windows user are told to use winget.
https://rustc-dev-guide.rust-lang.org/building/prerequisites.html#windows

But, winget is still in Preview, and it is not available in docker environment.
So I decided to use Chocolatey package manager instead.