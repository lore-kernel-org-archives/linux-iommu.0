Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A428C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 18:32:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49C120675
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 18:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49C120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A90342487;
	Mon, 29 Apr 2019 18:32:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A4EFC1E85
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 09:48:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
	[209.85.167.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3FAAE608
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 09:48:50 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id i68so7317905lfi.10
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 02:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=ATAy9r19kvybs9h4CbAXE4DQCAXKd+gASKqZjx1u6X0=;
	b=MPG3QLzlZWCpkzTD/9frKwgja8+gADnvvh1Rk/kckmwfTeUy9y0WPjap+u7Co4rI02
	iY8NxWo1tBMRSWySIf+ybw2ZtsiFPp+X8GsfNIyaE3z2ilLhg8Lt4mCgRTe3TWBuxr8H
	kvBkR0qOplgcVSZBwYOX+Q9AqR8seHRfMIAFDOxxDOjTUmF/OGJagf8Wf+J2fTNXZGc0
	zXpjoA0FRoQesSgZT7vbZt/u9V7NNAMr0t+JDrUDbLSPSFnOEJcWoe8E/+5WYjSEIr+S
	uwv9WXdVlDf9+JZKg1/is4LWt6m8AMG3svA0xx37B+WGqo9JCyXWUHJksdzQ2jIrXKGM
	+abg==
X-Gm-Message-State: APjAAAW2mqjwSso6WJ9cKAOrOsy4u+R/2yCYoyLdYTrLvc1UpVn/Gjob
	FVrXo8u39FjOE5dkPhRczjE=
X-Google-Smtp-Source: APXvYqy011PAkbtAsn4bkl5G7+pxAxqX4nwh23aFFd9ruDttABIQmwbsCS6IRCiEE1kLq5e3uT0TCQ==
X-Received: by 2002:a19:4b51:: with SMTP id y78mr31346168lfa.152.1556531328610;
	Mon, 29 Apr 2019 02:48:48 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
	[85.230.190.116])
	by smtp.gmail.com with ESMTPSA id m3sm7250676lfh.94.2019.04.29.02.48.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 02:48:47 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
	(envelope-from <johan@kernel.org>)
	id 1hL2tz-00038q-9z; Mon, 29 Apr 2019 11:48:48 +0200
Date: Mon, 29 Apr 2019 11:48:47 +0200
From: Johan Hovold <johan@kernel.org>
To: "StarostaCZ@gmail.com" <starostacz@gmail.com>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on
	AMD boards.
Message-ID: <20190429094847.GI26546@localhost>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Mailman-Approved-At: Mon, 29 Apr 2019 18:32:46 +0000
Cc: linux-usb@vger.kernel.org, iommu@lists.linux-foundation.org,
	Mathias Nyman <mathias.nyman@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429094847.5cRga3ik5MgHzUE9gFJJRMoE9JasOVflu3M2SHQnJCQ@z>

On Fri, Apr 26, 2019 at 03:47:15PM +0200, StarostaCZ@gmail.com wrote:
> Hello all,
> we are development and manufacturing company that use your FT232R serial =

> converter for couple of years with our software. We consume about a =

> hundreds pcs of FT232R per yer. We use FT232R as USB serial converter =

> with direct access (no virtual serial port) and as a "hardware key" =

> using FTDIChip-ID. We operate our software with FT232R converters on =

> Windows and Debian Linux operating system.
> =

> We have used Intel motherboards with Intel processors so far. We want to =

> use AMD motherboards with AMD processors too. *We made a couple of tests =

> on AMD motherboards with AMD processors and Debian Linux 9.6, but we =

> have come across a big problem.
> **When we open internal EEPROM of FT232R for reading, there will arise =

> many error messages in system log files. And then Debian Linux crash =

> after some time!*
> =

> =

> _1) Hardware configurations:_
> - motherboards with AMD A320M chipset:
>  =A0 - MSI A320M PRO-VD PLUS, =

> https://www.msi.com/Motherboard/support/A320M-PRO-VD-PLUS
>  =A0 - ASUS PRIME A320M-K, https://www.asus.com/Motherboards/PRIME-A320M-K
>  =A0 - GIGABYTE A320M-S2H, =

> https://www.gigabyte.com/Motherboard/GA-A320M-S2H-rev-1x#kf
> - latest bios installed, default bios configuration loaded,
> - CPU AMD Athlon 200GE, AMD Ryzen 3 2200G
> - 4GB RAM, SSD drive Kingston A400 120GB
> =

> _2a) Operating system A:_
> - Debian Linux 9.6 64bit, https://www.debian.org/distrib/, =

> https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.6.0-am=
d64-netinst.iso
> - installed from Netinst installer WITHOUT graphic dekstop, default =

> configuration
> - tested kernels
>  =A0 - default kernel 4.9.0.8-amd64, =

> https://packages.debian.org/stretch/linux-image-4.9.0-8-amd64
>  =A0 - backports kernel 4.18.0-0.bpo.1-amd64, =

> https://packages.debian.org/stretch-backports/linux-image-4.18.0-0.bpo.1-=
amd64
> =

> _2b) Operating system B:_
> - Ubuntu server 19.04 64bit, http://releases.ubuntu.com/19.04/, =

> http://releases.ubuntu.com/19.04/ubuntu-19.04-live-server-amd64.iso
> - installed WITHOUT graphic dekstop, default configuration
> - tested kernels
>  =A0 - default kernel 5.0.0-amd64, =

> https://packages.debian.org/stretch/linux-image-4.9.0-8-amd64
>  =A0 - experimental kernel 5.0.9-050009-generic amd64, =

> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0.9/
> =

> _3) Drivers_
> - libftd2xx drivers version 1.4.8, https://www.ftdichip.com/Drivers/D2XX.=
htm
> =

> _4) Performed tests_
> You can repeat this test:
> - connect FT232R into USB2.0 port (not USB3 port!)
> - use examples in directory: ...\libftd2xx-i386-1.4.8.tar\release\example=
s\
> - add parameter "-m32" to "CFLAGS" variable into "Rules.make" file
> - compiled "\examples\EEPROM\user\read\"
> - run script "test.sh" - see attached file
> - *Debian Linux or Ubuntu server crashes after some minutes* - see =

> attached kernel logs from our system
> - see "kern.log" https://paste.ee/p/xxIZ2

So this is a debian 4.18 kernel seemingly crashing due to a xhci or
iommu issue.

Can you reproduce this on a mainline kernel?

If so, please post the corresponding logs to the lists and CC the xhci
and iommu maintainers (added to CC).

> _5) Very important note_
> *This problem occurs when FT232R is connected into USB2.0 port only!*
> When it is connected into USB3 port, all works fine, no error messages, =

> no crash.
> =

> _6) Other test that we made_
> - we made other tests on Windows 10
>  =A0 - same configuration with ASUS PRIME A320M-K motherboard
>  =A0 - latest drivers + latest FTDI drivers
>  =A0 - FT232R connected to USB2.0 or USB3 - no problem
> =

> - we made the same tests on Intel architecture (that we use now)
>  =A0 - motherboard MSI B250M PRO-VH, CPU Intel Pentium G4560, 4GB RAM, SS=
D =

> drive Kingston A400 120GB
>  =A0 - same operating system Debian Linux 9.6 64bit as descripted above
>  =A0 - FT232R connected to USB2.0 or USB3 - no problem

Johan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
