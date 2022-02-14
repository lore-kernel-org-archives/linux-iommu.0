Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA31C43219
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 13:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F7EC8191E;
	Mon, 14 Feb 2022 13:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAeSuf1vcxIf; Mon, 14 Feb 2022 13:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 60B578140B;
	Mon, 14 Feb 2022 13:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39D32C001A;
	Mon, 14 Feb 2022 13:39:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7932C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A454F4015E
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VryXHrhfNvEw for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 13:39:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99C9D400E0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:39:22 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8D8D8614DC;
 Mon, 14 Feb 2022 13:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426C2C340E9;
 Mon, 14 Feb 2022 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1644845961;
 bh=4U+A1gw9pHI8+F1lRx72vcSbg59p+z2E+RDWPKyoPxk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VvTuMQbyYZ+oxoBg9e7TOef1M4ivC4+20f8nXQhpZ/l1FFQB8pk4gMFSguknC5UTG
 DDMjq9zO15j6PI+WRGN+ygfcoJnD4iUh/bCu00K998ZP92NBi7im/xSt+51loqvxdd
 ObfQNYeFBG3xEAgCtvkEmb/rUjEPZ4Ug1Ji9f83o=
Date: Mon, 14 Feb 2022 14:39:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 07/14] PCI: Add driver dma ownership management
Message-ID: <YgpbhlPOZsLFm4It@kroah.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-8-baolu.lu@linux.intel.com>
 <Ygoo/lCt/G6tWDz9@kroah.com> <20220214123842.GT4160@nvidia.com>
 <YgpQOmBA7QJJu+2E@kroah.com> <20220214131117.GW4160@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220214131117.GW4160@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
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

On Mon, Feb 14, 2022 at 09:11:17AM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 01:51:06PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 14, 2022 at 08:38:42AM -0400, Jason Gunthorpe wrote:
> > > On Mon, Feb 14, 2022 at 11:03:42AM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Jan 04, 2022 at 09:56:37AM +0800, Lu Baolu wrote:
> > > > > Multiple PCI devices may be placed in the same IOMMU group because
> > > > > they cannot be isolated from each other. These devices must either be
> > > > > entirely under kernel control or userspace control, never a mixture. This
> > > > > checks and sets DMA ownership during driver binding, and release the
> > > > > ownership during driver unbinding.
> > > > > 
> > > > > The device driver may set a new flag (no_kernel_api_dma) to skip calling
> > > > > iommu_device_use_dma_api() during the binding process. For instance, the
> > > > > userspace framework drivers (vfio etc.) which need to manually claim
> > > > > their own dma ownership when assigning the device to userspace.
> > > > > 
> > > > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > > >  include/linux/pci.h      |  5 +++++
> > > > >  drivers/pci/pci-driver.c | 21 +++++++++++++++++++++
> > > > >  2 files changed, 26 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > index 18a75c8e615c..d29a990e3f02 100644
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -882,6 +882,10 @@ struct module;
> > > > >   *              created once it is bound to the driver.
> > > > >   * @driver:	Driver model structure.
> > > > >   * @dynids:	List of dynamically added device IDs.
> > > > > + * @no_kernel_api_dma: Device driver doesn't use kernel DMA API for DMA.
> > > > > + *		Drivers which don't require DMA or want to manually claim the
> > > > > + *		owner type (e.g. userspace driver frameworks) could set this
> > > > > + *		flag.
> > > > 
> > > > Again with the bikeshedding, but this name is a bit odd.  Of course it's
> > > > in the kernel, this is all kernel code, so you can drop that.  And
> > > > again, "negative" flags are rough.  So maybe just "prevent_dma"?
> > > 
> > > That is misleading too, it is not that DMA is prevented, but that the
> > > kernel's dma_api has not been setup.
> > 
> > "has not been" or "will not be"?
> 
> "has not been" as that action was supposed to happen before probe(),
> but the flag skips it.
> 
> A driver that sets this flag can still decide to enable the dma API on
> its own. eg tegra drivers do this.

So you are just forcing the driver to manage this all on their own, so
how about, "driver_managed_dma", or even shorter "managed_dma"?

> > What you want to prevent is the iommu core claiming the device
> > automatically, right?  So how about "prevent_iommu_dma"?
> 
> "claim" is not a good description. iommu always "claims" the device -
> eg sets a domain, sets the dev and bus parameters, etc.
> 
> This really is only about setting up the in-kernel dma api, eg
> allowing dma_map_sg()/etc to work.
> 
> dma api is just one way to operate the iommu, there are others too.
> 
> Think of this flag as 
>   false = the driver is going to use the dma api (most common)
>   true = the driver will decide how to use the iommu by itself
> 
> Does it help think of a clearer name?

See above, you want a driver author to know instantly what this is and
not have to look anything up.
"I_will_manage_the_dma_myself_as_I_really_know_what_I_am_doing" might be
good, but a bit too long :)

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
