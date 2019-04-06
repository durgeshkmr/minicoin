// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef MINICOIN_QT_MINICOINADDRESSVALIDATOR_H
#define MINICOIN_QT_MINICOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class MinicoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MinicoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Minicoin address widget validator, checks for a valid minicoin address.
 */
class MinicoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MinicoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // MINICOIN_QT_MINICOINADDRESSVALIDATOR_H
