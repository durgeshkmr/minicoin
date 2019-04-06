#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

MINICOIND=${MINICOIND:-$BINDIR/minicoind}
MINICOINCLI=${MINICOINCLI:-$BINDIR/minicoin-cli}
MINICOINTX=${MINICOINTX:-$BINDIR/minicoin-tx}
MINICOINQT=${MINICOINQT:-$BINDIR/qt/minicoin-qt}

[ ! -x $MINICOIND ] && echo "$MINICOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
MNCVER=($($MINICOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for minicoind if --version-string is not set,
# but has different outcomes for minicoin-qt and minicoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$MINICOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $MINICOIND $MINICOINCLI $MINICOINTX $MINICOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${MNCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${MNCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
