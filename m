Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA129C433F5
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 10:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 585FE60A43;
	Mon, 29 Nov 2021 10:34:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PbCXzJdO6_8S; Mon, 29 Nov 2021 10:34:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 35FE6608AA;
	Mon, 29 Nov 2021 10:34:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15F82C001C;
	Mon, 29 Nov 2021 10:34:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BBA9C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 10:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CAF940535
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 10:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zKalIovx1c4W for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:34:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A4544023B
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 10:34:46 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3FB7BB80E58;
 Mon, 29 Nov 2021 10:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF91C004E1;
 Mon, 29 Nov 2021 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1638182082;
 bh=nsUtuRmqSAZRV1KPWJ/+I0Ioj0cagz0JXdcAo35Ew4w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bKx6n4W8Hl5/MY40EORD0pKOk49Qj+zzSZ1XiYB2e6CWBPHA3Yj20wSC2c4oujZZS
 9OGj+NNIpXp73UDrmyxQD7emWWQu6MYggvcI8LLBhJQCC9CsacRPxu+qCkMBka+eT1
 mUB7O6bQsu12OCzw4VBrjGpU8NgxDz2wE9tOdIQ4=
Date: Mon, 29 Nov 2021 11:34:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 04/17] driver core: platform: Add driver dma ownership
 management
Message-ID: <YaSsv5Z1WS7ldgu3@kroah.com>
References: <20211128025051.355578-1-baolu.lu@linux.intel.com>
 <20211128025051.355578-5-baolu.lu@linux.intel.com>
 <YaM5Zv1RrdidycKe@kroah.com> <20211128231509.GA966332@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211128231509.GA966332@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
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

On Sun, Nov 28, 2021 at 07:15:09PM -0400, Jason Gunthorpe wrote:
> On Sun, Nov 28, 2021 at 09:10:14AM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Nov 28, 2021 at 10:50:38AM +0800, Lu Baolu wrote:
> > > Multiple platform devices may be placed in the same IOMMU group because
> > > they cannot be isolated from each other. These devices must either be
> > > entirely under kernel control or userspace control, never a mixture. This
> > > checks and sets DMA ownership during driver binding, and release the
> > > ownership during driver unbinding.
> > > 
> > > Driver may set a new flag (suppress_auto_claim_dma_owner) to disable auto
> > > claiming DMA_OWNER_DMA_API ownership in the binding process. For instance,
> > > the userspace framework drivers (vfio etc.) which need to manually claim
> > > DMA_OWNER_PRIVATE_DOMAIN_USER when assigning a device to userspace.
> > 
> > Why would any vfio driver be a platform driver?  
> 
> Why not? VFIO implements drivers for most physical device types
> these days. Why wouldn't platform be included?

Because "platform" is not a real device type.  It's a catch-all for
devices that are only described by firmware, so why would you have a
virtual device for that?  Why would that be needed?

> > > diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> > > index 7c96f169d274..779bcf2a851c 100644
> > > +++ b/include/linux/platform_device.h
> > > @@ -210,6 +210,7 @@ struct platform_driver {
> > >  	struct device_driver driver;
> > >  	const struct platform_device_id *id_table;
> > >  	bool prevent_deferred_probe;
> > > +	bool suppress_auto_claim_dma_owner;
> > 
> > What platform driver needs this change?
> 
> It is in patch 12:
> 
> --- a/drivers/vfio/platform/vfio_platform.c
> +++ b/drivers/vfio/platform/vfio_platform.c

Ok, nevermind, you do have a virtual platform device, which personally,
I find crazy as why would firmware export a "virtual device"?

> @@ -76,6 +76,7 @@ static struct platform_driver vfio_platform_driver = {
>         .driver = {
>                 .name   = "vfio-platform",
>         },
> +       .suppress_auto_claim_dma_owner = true,
>  };
> 
> Which is how VFIO provides support to DPDK for some Ethernet
> controllers embedded in a few ARM SOCs.

Ick.  Where does the DT file for these devices live that describe a
"virtual device" to match with this driver?

> It is also used in patch 17 in five tegra platform_drivers to make
> their sharing of an iommu group between possibly related
> platform_driver's safer.

Safer how?

> > >  	USE_PLATFORM_PM_SLEEP_OPS
> > > @@ -1478,7 +1505,8 @@ struct bus_type platform_bus_type = {
> > >  	.probe		= platform_probe,
> > >  	.remove		= platform_remove,
> > >  	.shutdown	= platform_shutdown,
> > > -	.dma_configure	= platform_dma_configure,
> > > +	.dma_configure	= _platform_dma_configure,
> > 
> > What happened to the original platform_dma_configure() function?
> 
> It is still called. The issue here is that platform_dma_configure has
> nothing to do with platform and is being re-used by AMBA.

Ick, why?  AMBA needs to be a real bus type and use their own functions
if needed.  There is nothing here that makes this obvious that someone
else is using those functions and that the platform bus should only be
using these "new" functions.

> Probably the resolution to both remarks is to rename
> platform_dma_configure to something sensible (firwmare dma configure
> maybe?) and use it in all places that do the of & acpi stuff -
> pci/amba/platform at least.

That would be better than what is being proposed here.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
