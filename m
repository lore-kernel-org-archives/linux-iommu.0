Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCE2C433EF
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 18:35:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B82861A6C
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 18:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B82861A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11DA080CFC;
	Mon, 15 Nov 2021 18:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sb5nC06p1HM6; Mon, 15 Nov 2021 18:35:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E0E4C80CD1;
	Mon, 15 Nov 2021 18:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC7C3C001E;
	Mon, 15 Nov 2021 18:35:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43AB2C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F73E60785
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eql8AnwO4lYP for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 18:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 282F860763
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:35:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62236D6E;
 Mon, 15 Nov 2021 10:35:47 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4A423F70D;
 Mon, 15 Nov 2021 10:35:44 -0800 (PST)
Message-ID: <cc9878ae-df49-950c-f4f8-2e6ba545079b@arm.com>
Date: Mon, 15 Nov 2021 18:35:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 02/11] driver core: Set DMA ownership during driver
 bind/unbind
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-3-baolu.lu@linux.intel.com>
 <YZJeRomcJjDqDv9q@infradead.org> <20211115132442.GA2379906@nvidia.com>
 <8499f0ab-9701-2ca2-ac7a-842c36c54f8a@arm.com>
 <20211115155613.GA2388278@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211115155613.GA2388278@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-11-15 15:56, Jason Gunthorpe via iommu wrote:
> On Mon, Nov 15, 2021 at 03:37:18PM +0000, Robin Murphy wrote:
> 
>> IOMMUs, and possibly even fewer of them support VFIO, so I'm in full
>> agreement with Greg and Christoph that this absolutely warrants being scoped
>> per-bus. I mean, we literally already have infrastructure to prevent drivers
>> binding if the IOMMU/DMA configuration is broken or not ready yet; why would
>> we want a totally different mechanism to prevent driver binding when the
>> only difference is that that configuration *is* ready and working to the
>> point that someone's already claimed it for other purposes?
> 
> I see, that does make sense
> 
> I see these implementations:
> 
> drivers/amba/bus.c:     .dma_configure  = platform_dma_configure,
> drivers/base/platform.c:        .dma_configure  = platform_dma_configure,
> drivers/bus/fsl-mc/fsl-mc-bus.c:        .dma_configure  = fsl_mc_dma_configure,
> drivers/pci/pci-driver.c:       .dma_configure  = pci_dma_configure,
> drivers/gpu/host1x/bus.c:       .dma_configure = host1x_dma_configure,
> 
> Other than host1x they all work with VFIO.
> 
> Also, there is no bus->dma_unconfigure() which would be needed to
> restore the device as well.

Not if we reduce the notion of "ownership" down to 
"dev->iommu_group->domain != dev->iommu_group->default_domain", which 
I'm becoming increasingly convinced is all we actually need here.

> So, would you rather see duplicated code into the 4 drivers, and a new
> bus op to 'unconfigure dma'

The .dma_configure flow is unavoidably a bit boilerplatey already, so 
personally I'd go for having the implementations call back into a common 
check, similarly to their current flow. That also leaves room for the 
bus code to further refine the outcome based on what it might know, 
which I can particularly imagine for cleverer buses like fsl-mc and 
host1x which can have lots of inside knowledge about how their devices 
may interact.

Robin.

> Or, a 'dev_configure_dma()' function that is roughly:
> 
>          if (dev->bus->dma_configure) {
>                  ret = dev->bus->dma_configure(dev);
>                  if (ret)
>                          return ret;
>                  if (!drv->suppress_auto_claim_dma_owner) {
>                         ret = iommu_device_set_dma_owner(dev, DMA_OWNER_KERNEL,
>                                                          NULL);
>                         if (ret)
>                                 ret;
>                  }
>           }
> 
> And a pair'd undo.
> 
> This is nice because we can enforce dev->bus->dma_configure when doing
> a user bind so everything holds together safely without relying on
> each bus_type to properly implement security.
> 
> Jason
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
