Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A194C433E2
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 16:02:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BFC208B3
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 16:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUazJfy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BFC208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D87AD87A1A;
	Thu, 18 Jun 2020 16:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OehBuatWsQu7; Thu, 18 Jun 2020 16:02:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A79C38783E;
	Thu, 18 Jun 2020 16:02:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BEF9C088C;
	Thu, 18 Jun 2020 16:02:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D6C6C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 16:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 56C1488A00
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 16:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4HeE6EEYakJQ for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 16:02:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B167A889F6
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 16:02:20 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A19652075E;
 Thu, 18 Jun 2020 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592496140;
 bh=rqbQaxwYHVSog/6s0s06FTodGO8kQeNqtyZySUvpN6w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UUazJfy9+SSUKCLNfartxWy/emm+rlRyoRqcnyXex7QUgkrv8PbuxpR4XPTWliD9o
 JHrAaV6k7Rf0xEMIQqZ/A15hvXhqg5bAUs3F0/ERSZnyaZRws0u88T0CPjbT/qHzxL
 PJBFDWfUW4gUM4BGCg7YrDz1p0BYoXuWrU7avDc0=
Date: Thu, 18 Jun 2020 18:02:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
Message-ID: <20200618160212.GB3076467@kroah.com>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com>
 <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
 <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
 Benson Leung <bleung@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Alex Levin <levinale@google.com>
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

On Thu, Jun 18, 2020 at 08:03:49AM -0700, Rajat Jain wrote:
> Hello,
> 
> On Thu, Jun 18, 2020 at 2:14 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > > > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > ...
> > > >
> > > > > (and likely call it "external" instead of "untrusted".
> > > >
> > > > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > > > chosen by the meaning of it.
> > > > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > > > tables, but I can replace it.
> > >
> > > Then your ACPI tables should show this, there is an attribute for it,
> > > right?
> >
> > There is a _PLD() method, but it's for the USB devices (or optional
> > for others, I don't remember by heart). So, most of the ACPI tables,
> > alas, don't show this.
> >
> > > > This is only one example. Or if firmware of some device is altered,
> > > > and it's internal (whatever it means) is it trusted or not?
> > >
> > > That is what people are using policy for today, if you object to this,
> > > please bring it up to those developers :)
> >
> > > > So, please leave it as is (I mean name).
> > >
> > > firmware today exports this attribute, why do you not want userspace to
> > > also know it?
> 
> To clarify, the attribute exposed by the firmware today is
> "ExternalFacingPort" and "external-facing" respectively:
> 
> 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> 9cb30a71ac45d("PCI: OF: Support "external-facing" property")
> 
> The kernel flag was named "untrusted" though, hence the assumption
> that "external=untrusted" is currently baked into the kernel today.
> IMHO, using "external" would fix that (The assumption can thus be
> contained in the IOMMU drivers) and at the same time allow more use of
> this attribute.
> 
> > >
> > > Trust is different, yes, don't get the two mixed up please.  That should
> > > be a different sysfs attribute for obvious reasons.
> >
> > Yes, as a bottom line that's what I meant as well.
> 
> So what is the consensus here? I don't have a strong opinion - but it
> seemed to me Greg is saying "external" and Andy is saying "untrusted"?

Those two things are totally separate things when it comes to a device.

One (external) describes the location of the device in the system.

The other (untrusted) describes what you want the kernel to do with this
device (trust or not trust it).

One you can change (from trust to untrusted or back), the other you can
not, it is a fixed read-only property that describes the hardware device
as defined by the firmware.

Depending on the policy you wish to define, you can use the location of
the device to determine if you want to trust the device or not.

Again, this is what USB does, but I'm getting really tired of saying
this, so I'm going to stop now...

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
