Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B11DC433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 16:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C47B2408E1;
	Wed, 23 Feb 2022 16:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fS6EXdirlM2x; Wed, 23 Feb 2022 16:09:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 36CC5400CD;
	Wed, 23 Feb 2022 16:09:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8D85C001A;
	Wed, 23 Feb 2022 16:09:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C7ACC0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 16:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A6E54156D
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 16:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qD41ooGQyAlt for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 16:09:39 +0000 (UTC)
X-Greylist: delayed 00:05:50 by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55C4C402E9
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 16:09:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 4A586CE1BC1;
 Wed, 23 Feb 2022 16:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0674DC340E7;
 Wed, 23 Feb 2022 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1645632223;
 bh=jWeqBXnmhv/yp6ESTH9OA8NuBmEWEyuUdhFPVPzAZGc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hdc0lrA5dZRtIeA1RbNiQdoue/GFBd1uExyV5sEiImDGn9g8/0gnRnDq0hvxi4n2r
 v9O0f1M7TmK0c8lx+ozjSuDDz9e8c1PY0MtvWUMMlDY8fxkcE+//9igW8MESSZn74/
 uRYM/PUkLjQMaLa4jGCskJB1lUymU+lOib7KSWxA=
Date: Wed, 23 Feb 2022 17:03:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v6 02/11] driver core: Add dma_cleanup callback in bus_type
Message-ID: <YhZa3D5Xwv5oZm7L@kroah.com>
References: <1acb8748-8d44-688d-2380-f39ec820776f@arm.com>
 <20220222151632.GB10061@nvidia.com>
 <3d4c3bf1-fed6-f640-dc20-36d667de7461@arm.com>
 <20220222235353.GF10061@nvidia.com>
 <171bec90-5ea6-b35b-f027-1b5e961f5ddf@linux.intel.com>
 <880a269d-d39d-bab3-8d19-b493e874ec99@arm.com>
 <20220223134627.GO10061@nvidia.com> <YhY/a9wTjmYXsuwt@kroah.com>
 <20220223140901.GP10061@nvidia.com>
 <20220223143011.GQ10061@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220223143011.GQ10061@nvidia.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, Feb 23, 2022 at 10:30:11AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 23, 2022 at 10:09:01AM -0400, Jason Gunthorpe wrote:
> > On Wed, Feb 23, 2022 at 03:06:35PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Feb 23, 2022 at 09:46:27AM -0400, Jason Gunthorpe wrote:
> > > > On Wed, Feb 23, 2022 at 01:04:00PM +0000, Robin Murphy wrote:
> > > > 
> > > > > 1 - tmp->driver is non-NULL because tmp is already bound.
> > > > >   1.a - If tmp->driver->driver_managed_dma == 0, the group must currently be
> > > > > DMA-API-owned as a whole. Regardless of what driver dev has unbound from,
> > > > > its removal does not release someone else's DMA API (co-)ownership.
> > > > 
> > > > This is an uncommon locking pattern, but it does work. It relies on
> > > > the mutex being an effective synchronization barrier for an unlocked
> > > > store:
> > > > 
> > > > 				      WRITE_ONCE(dev->driver, NULL)
> > > 
> > > Only the driver core should be messing with the dev->driver pointer as
> > > when it does so, it already has the proper locks held.  Do I need to
> > > move that to a "private" location so that nothing outside of the driver
> > > core can mess with it?
> > 
> > It would be nice, I've seen a abuse and mislocking of it in drivers
> 
> Though to be clear, what Robin is describing is still keeping the
> dev->driver stores in dd.c, just reading it in a lockless way from
> other modules.

"other modules" should never care if a device has a driver bound to it
because instantly after the check happens, it can change so what ever
logic it wanted to do with that knowledge is gone.

Unless the bus lock is held that the device is on, but that should be
only accessable from within the driver core as it controls that type of
stuff, not any random other part of the kernel.

And in looking at this, ick, there are loads of places in the kernel
that are thinking that this pointer being set to something actually
means something.  Sometimes it does, but lots of places, it doesn't as
it can change.

In a semi-related incident right now, we currently have a syzbot failure
in the usb gadget code where it was manipulating the ->driver pointer
directly and other parts of the kernel are crashing.  See
https://lore.kernel.org/r/PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com
for the thread.

I'll poke at this as a background task to try to clean up over time.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
