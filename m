Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE99DC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:00:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8867120768
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K45nhmz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8867120768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1E41F886AD;
	Tue, 30 Jun 2020 17:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OKYKNjsNjSGx; Tue, 30 Jun 2020 17:00:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F1DA7884D8;
	Tue, 30 Jun 2020 17:00:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8701C088F;
	Tue, 30 Jun 2020 17:00:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9EEFC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E29952266C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:00:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ShwnXGgETtn for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 17:00:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 9386422001
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:00:24 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 86D562074D;
 Tue, 30 Jun 2020 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593536424;
 bh=OyZ+omFW90H968tlnQPxTsEGQ+ZnRPIJilI6YZvFABE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K45nhmz01hL7sCVhpvbNV5JtcuCc6hXl+kjXibX1Ykjsq5r+dfPQfJXmtFL/Tjt8A
 RKKacGE9MPcunFcTLy3SLGAGLhJuVahoFkd1l3GxQ3hpNOWP2HuvMz2vEdGCLLVEE6
 vOKLRHIFxKeBGjKGSyYZwNfEMXAKP1uS4UeHxB2c=
Date: Tue, 30 Jun 2020 19:00:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
Message-ID: <20200630170012.GB1894898@kroah.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com>
 <20200630125216.GA1109228@kroah.com>
 <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
 <20200630153816.GD1785141@kroah.com>
 <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, lalithambika.krishnakumar@intel.com,
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
 Arnd Bergmann <arnd@arndb.de>, Oliver O'Halloran <oohall@gmail.com>,
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

On Tue, Jun 30, 2020 at 06:08:31PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 30, 2020 at 5:38 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 30, 2020 at 03:00:34PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Jun 30, 2020 at 2:52 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jun 30, 2020 at 01:49:48PM +0300, Heikki Krogerus wrote:
> > > > > On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> > > > > > Add a new (optional) field to denote the physical location of a device
> > > > > > in the system, and expose it in sysfs. This was discussed here:
> > > > > > https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> > > > > >
> > > > > > (The primary choice for attribute name i.e. "location" is already
> > > > > > exposed as an ABI elsewhere, so settled for "site"). Individual buses
> > > > > > that want to support this new attribute can opt-in by setting a flag in
> > > > > > bus_type, and then populating the location of device while enumerating
> > > > > > it.
> > > > >
> > > > > So why not just call it "physical_location"?
> > > >
> > > > That's better, and will allow us to put "3rd blue plug from the left,
> > > > 4th row down" in there someday :)
> > > >
> > > > All of this is "relative" to the CPU, right?  But what CPU?  Again, how
> > > > are the systems with drawers of PCI and CPUs and memory that can be
> > > > added/removed at any point in time being handled here?  What is
> > > > "internal" and "external" for them?
> > > >
> > > > What exactly is the physical boundry here that is attempting to be
> > > > described?
> > >
> > > Also, where is the "physical location" information going to come from?
> >
> > Who knows?  :)
> >
> > Some BIOS seem to provide this, but do you trust that?
> >
> > > If that is the platform firmware (which I suspect is the anticipated
> > > case), there may be problems with reliability related to that.
> >
> > s/may/will/
> >
> > which means making the kernel inact a policy like this patch series
> > tries to add, will result in a lot of broken systems, which is why I
> > keep saying that it needs to be done in userspace.
> >
> > It's as if some of us haven't been down this road before and just keep
> > being ignored...
> >
> > {sigh}
> 
> Well, to be honest, if you are a "vertical" vendor and you control the
> entire stack, *including* the platform firmware, it would be kind of
> OK for you to do that in a product kernel.
> 
> However, this is not a practical thing to do in the mainline kernel
> which must work for everybody, including people who happen to use
> systems with broken or even actively unfriendly firmware on them.
> 
> So I'm inclined to say that IMO this series "as is" would not be an
> improvement from the mainline perspective.

It can be, we have been using this for USB devices for many many years
now, quite successfully.  The key is not to trust that the platform
firmware got it right :)

> I guess it would make sense to have an attribute for user space to
> write to in order to make the kernel reject device plug-in events
> coming from a given port or connector, but the kernel has no reliable
> means to determine *which* ports or connectors are "safe", and even if
> there was a way for it to do that, it still may not agree with user
> space on which ports or connectors should be regarded as "safe".

Again, we have been doing this for USB devices for a very long time, PCI
shouldn't be any different.  Why people keep ignoring working solutions
is beyond me, there's nothing "special" about PCI devices here for this
type of "worry" or reasoning to try to create new solutions.

So, again, I ask, go do what USB does, and to do that, take the logic
out of the USB core, make it bus-agnositic, and _THEN_ add it to the PCI
code.  Why the original submitter keeps ignoring my request to do this
is beyond me, I guess they like making patches that will get rejected :(

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
