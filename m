Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE99C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 13:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C38C4605C9;
	Mon,  6 Dec 2021 13:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5JFjEPGC0VgI; Mon,  6 Dec 2021 13:36:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 908F860C0A;
	Mon,  6 Dec 2021 13:36:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51ACFC002F;
	Mon,  6 Dec 2021 13:36:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 276A7C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 13:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13534400D1
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 13:36:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XnOsE85qr9z7 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 13:36:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38582400C9
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 13:36:02 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A88E1396; Mon,  6 Dec 2021 14:35:58 +0100 (CET)
Date: Mon, 6 Dec 2021 14:35:55 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 01/18] iommu: Add device dma ownership set/release
 interfaces
Message-ID: <Ya4Ru/GtILJYzI6j@8bytes.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206015903.88687-2-baolu.lu@linux.intel.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, Dec 06, 2021 at 09:58:46AM +0800, Lu Baolu wrote:
> >From the perspective of who is initiating the device to do DMA, device
> DMA could be divided into the following types:
> 
>         DMA_OWNER_DMA_API: Device DMAs are initiated by a kernel driver
> 			through the kernel DMA API.
>         DMA_OWNER_PRIVATE_DOMAIN: Device DMAs are initiated by a kernel
> 			driver with its own PRIVATE domain.
> 	DMA_OWNER_PRIVATE_DOMAIN_USER: Device DMAs are initiated by
> 			userspace.

I have looked at the other iommu patches in this series, but I still
don't quite get what the difference in the code flow is between
DMA_OWNER_PRIVATE_DOMAIN and DMA_OWNER_PRIVATE_DOMAIN_USER. What are the
differences in the iommu core behavior based on this setting?

>         int iommu_device_set_dma_owner(struct device *dev,
>                 enum iommu_dma_owner type, void *owner_cookie);
>         void iommu_device_release_dma_owner(struct device *dev,
>                 enum iommu_dma_owner type);

It the owner is a group-wide setting, it should be called with the group
instead of the device. I have seen the group-specific funcitons are
added later, but that leaves the question why the device-specific ones
are needed at all.

> +	enum iommu_dma_owner dma_owner;
> +	refcount_t owner_cnt;
> +	void *owner_cookie;
>  };

I am also not quite happy yet with calling this dma_owner, but can't
come up with a better name yet.

>  
>  struct group_device {
> @@ -621,6 +624,7 @@ struct iommu_group *iommu_group_alloc(void)
>  	INIT_LIST_HEAD(&group->devices);
>  	INIT_LIST_HEAD(&group->entry);
>  	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
> +	group->dma_owner = DMA_OWNER_NONE;


DMA_OWNER_NONE is also questionable. All devices are always in one
domain, and the default domain is always the one used for DMA-API, so
why isn't the initial value DMA_OWNER_DMA_API?

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
