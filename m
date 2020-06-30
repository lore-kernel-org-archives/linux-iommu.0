Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C256C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 16:08:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD5E20759
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 16:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD5E20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D7BCF8750E;
	Tue, 30 Jun 2020 16:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4eYriiyzuLvV; Tue, 30 Jun 2020 16:08:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F3F5E873FD;
	Tue, 30 Jun 2020 16:08:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBCC6C0865;
	Tue, 30 Jun 2020 16:08:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 721ECC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 16:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 695BF20353
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 16:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DJVIiqTfU2w2 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 16:08:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 83C48228DB
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 16:08:43 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id 76so4409952otu.9
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jQDz/WabqYjbF35ePxjq+94tU34dFjVcRR53QQxEhIE=;
 b=Bzq7iwrK7uzjCTctU3sxCBH//zbFXMMHfUusOjl39YO38f8b27aAnggGJmV5AnUnIG
 dFTWg24a+WLikr5u/vmgF1jNdDoJfJCV5whax+KNzbeZEMPSGDaLrBvkBaBCeEWK5brd
 jXRlU66plZRLab9u9/Bllp0OCxiw7R0na2CBR6/Q7TCvEpFslppjPECDJZs8GUcYenOH
 qN8tGAyFl3kouWbcio6zJI71O7cD0LUUZ2faU7tRgs4m4evG6jMAmUy+XeiH8nPqXIXL
 2XmylkrS6RPU51UxkXSqIlAqdxBKkA8e+2YGHBSDl1IhaGXpQgxddKwoc4CB4i2bhyjt
 w+VQ==
X-Gm-Message-State: AOAM5302Jnj4VrkW/TLiJlnkPlaH84tR2fb1yiYOv1eccryRggtn7pEa
 0u8Iyy/66jqGGbPPcL3d8W1RpoZ7izH61gAqHpw=
X-Google-Smtp-Source: ABdhPJxaWnX9yrMQHErQh8Vw+ezc/MNNEhYcKVhPEqUi65LAtj57f/zeJ/ze1v+SS/GdZrhEkvjMvThwgj4FoHTcVQM=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr1108124ota.167.1593533322766; 
 Tue, 30 Jun 2020 09:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com>
 <20200630125216.GA1109228@kroah.com>
 <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
 <20200630153816.GD1785141@kroah.com>
In-Reply-To: <20200630153816.GD1785141@kroah.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jun 2020 18:08:31 +0200
Message-ID: <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 lalithambika.krishnakumar@intel.com, Todd Broch <tbroch@google.com>,
 Diego Rivas <diegorivas@google.com>, Rajat Jain <rajatja@google.com>,
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

On Tue, Jun 30, 2020 at 5:38 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 30, 2020 at 03:00:34PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 30, 2020 at 2:52 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jun 30, 2020 at 01:49:48PM +0300, Heikki Krogerus wrote:
> > > > On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> > > > > Add a new (optional) field to denote the physical location of a device
> > > > > in the system, and expose it in sysfs. This was discussed here:
> > > > > https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> > > > >
> > > > > (The primary choice for attribute name i.e. "location" is already
> > > > > exposed as an ABI elsewhere, so settled for "site"). Individual buses
> > > > > that want to support this new attribute can opt-in by setting a flag in
> > > > > bus_type, and then populating the location of device while enumerating
> > > > > it.
> > > >
> > > > So why not just call it "physical_location"?
> > >
> > > That's better, and will allow us to put "3rd blue plug from the left,
> > > 4th row down" in there someday :)
> > >
> > > All of this is "relative" to the CPU, right?  But what CPU?  Again, how
> > > are the systems with drawers of PCI and CPUs and memory that can be
> > > added/removed at any point in time being handled here?  What is
> > > "internal" and "external" for them?
> > >
> > > What exactly is the physical boundry here that is attempting to be
> > > described?
> >
> > Also, where is the "physical location" information going to come from?
>
> Who knows?  :)
>
> Some BIOS seem to provide this, but do you trust that?
>
> > If that is the platform firmware (which I suspect is the anticipated
> > case), there may be problems with reliability related to that.
>
> s/may/will/
>
> which means making the kernel inact a policy like this patch series
> tries to add, will result in a lot of broken systems, which is why I
> keep saying that it needs to be done in userspace.
>
> It's as if some of us haven't been down this road before and just keep
> being ignored...
>
> {sigh}

Well, to be honest, if you are a "vertical" vendor and you control the
entire stack, *including* the platform firmware, it would be kind of
OK for you to do that in a product kernel.

However, this is not a practical thing to do in the mainline kernel
which must work for everybody, including people who happen to use
systems with broken or even actively unfriendly firmware on them.

So I'm inclined to say that IMO this series "as is" would not be an
improvement from the mainline perspective.

I guess it would make sense to have an attribute for user space to
write to in order to make the kernel reject device plug-in events
coming from a given port or connector, but the kernel has no reliable
means to determine *which* ports or connectors are "safe", and even if
there was a way for it to do that, it still may not agree with user
space on which ports or connectors should be regarded as "safe".

Cheers!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
