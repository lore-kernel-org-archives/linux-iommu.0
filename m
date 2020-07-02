Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3F2C433E2
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 08:52:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A61E2089D
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 08:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV71bDmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A61E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 25BCD8A8B2;
	Thu,  2 Jul 2020 08:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q3GRpHwO7zr0; Thu,  2 Jul 2020 08:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 78BA98A636;
	Thu,  2 Jul 2020 08:52:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C83FC0890;
	Thu,  2 Jul 2020 08:52:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35B54C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 08:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 23BE389186
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 08:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KCAw2r8l91Rg for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 08:52:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8ACD68900C
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 08:52:09 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8F8EC2088E;
 Thu,  2 Jul 2020 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593679929;
 bh=64soL0tpbUuYgXGJqe7C5+8BD4CFUcTKY7CsglwFpHA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bV71bDmCWLpYhjJuusNikY/jpLjKUstYQQSuTe+EzDvYkEsEVjHagEuzrCMiXRLSe
 Xy23RtBHyDSEkDtkx8ct96dxIocLXlrDZA1kczoAmy5YtvAR5XXnfGzwD3F1cL8JB+
 DnMfMwIC8yJTQEzUiOyQEoU7mF3gN5VLnBuJfCRo=
Date: Thu, 2 Jul 2020 10:52:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
Message-ID: <20200702085212.GA1089671@kroah.com>
References: <20200630104948.GC856968@kuha.fi.intel.com>
 <20200630125216.GA1109228@kroah.com>
 <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
 <20200630153816.GD1785141@kroah.com>
 <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
 <20200630170012.GB1894898@kroah.com>
 <CACK8Z6Fcrb8PtmbUJLn8RgiGnC8eqTC9GjsgjPmQgU212WPU0Q@mail.gmail.com>
 <CAOSf1CEZ82iXhYnig0UScS+oRRaxHzSCge9LbA1hW3NaQAiSxQ@mail.gmail.com>
 <20200702073226.GB1073011@kroah.com>
 <24f56c0ed6d10ef565cf83d47d0538d37ac0d8ef.camel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <24f56c0ed6d10ef565cf83d47d0538d37ac0d8ef.camel@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Todd Broch <tbroch@google.com>, Diego Rivas <diegorivas@google.com>,
 Rajat Jain <rajatja@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Benson Leung <bleung@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Alex Levin <levinale@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jul 02, 2020 at 06:40:09PM +1000, Oliver O'Halloran wrote:
> On Thu, 2020-07-02 at 09:32 +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jul 02, 2020 at 03:23:23PM +1000, Oliver O'Halloran wrote:
> > > Yep, that's a problem. If we want to provide a useful mechanism to
> > > userspace then the default behaviour of the kernel can't undermine
> > > that mechanism. If that means we need another kernel command line
> > > parameter then I guess we just have to live with it.
> > 
> > I really do not want yet-another-kernel-command-line-option if we can
> > help it at all.  Sane defaults are the best thing to do here.  Userspace
> > comes up really early, put your policy in there, not in blobs passed
> > from your bootloader.
> 
> Userspace comes up early, but builtin drivers will bind before init is
> started. e.g.
> 
> # dmesg | egrep '0002:01:00.0|/init'
> [    0.976800][    T1] pci 0002:01:00.0: [8086:1589] type 00 class 0x020000
> [    0.976923][    T1] pci 0002:01:00.0: reg 0x10: [mem 0x220000000000-0x2200007fffff 64bit pref]
> [    0.977004][    T1] pci 0002:01:00.0: reg 0x1c: [mem 0x220002000000-0x220002007fff 64bit pref]
> [    0.977068][    T1] pci 0002:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
> [    0.977122][    T1] pci 0002:01:00.0: BAR3 [mem size 0x00008000 64bit pref]: requesting alignment to 0x10000
> [    0.977401][    T1] pci 0002:01:00.0: PME# supported from D0 D3hot
> [    1.011929][    T1] pci 0002:01:00.0: BAR 0: assigned [mem 0x220000000000-0x2200007fffff 64bit pref]
> [    1.012085][    T1] pci 0002:01:00.0: BAR 6: assigned [mem 0x3fe100000000-0x3fe10007ffff pref]
> [    1.012127][    T1] pci 0002:01:00.0: BAR 3: assigned [mem 0x220002000000-0x220002007fff 64bit pref]
> [    4.399588][   T12] i40e 0002:01:00.0: enabling device (0140 -> 0142)
> [    4.410891][   T12] i40e 0002:01:00.0: fw 5.1.40981 api 1.5 nvm 5.03 0x80002469 1.1313.0 [8086:1589] [15d9:0000]
> [    4.647524][   T12] i40e 0002:01:00.0: MAC address: 0c:c4:7a:b7:fc:74
> [    4.647685][   T12] i40e 0002:01:00.0: FW LLDP is enabled
> [    4.653918][   T12] i40e 0002:01:00.0 eth0: NIC Link is Up, 1000 Mbps Full Duplex, Flow Control: None
> [    4.655552][   T12] i40e 0002:01:00.0: PCI-Express: Speed 8.0GT/s Width x8
> [    4.656071][   T12] i40e 0002:01:00.0: Features: PF-id[0] VSIs: 34 QP: 80 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
> [   13.803709][    T1] Run /init as init process
> [   13.963242][  T711] i40e 0002:01:00.0 enP2p1s0f0: renamed from eth0
> 
> Building everything into the kernel is admittedly pretty niche. I only
> do it to avoid re-building the initramfs for my test kernels. It does
> seem relatively common on embedded systems, but I'm not sure how many
> of those care about PCIe. It would be nice to provide *something* to
> cover that case for the people who care.

Those people who care should not build those drivers into their kernel :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
