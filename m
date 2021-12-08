Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5703FC433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 18:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F01ED607F9;
	Wed,  8 Dec 2021 18:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1CnSPv8GOW7; Wed,  8 Dec 2021 18:11:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7C1366060E;
	Wed,  8 Dec 2021 18:11:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62F78C002F;
	Wed,  8 Dec 2021 18:11:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 983AEC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A87682628
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v3LQV29Bu4Mm for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 18:11:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78D9582612
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:11:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235408321"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="235408321"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 10:11:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="462858988"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 10:11:39 -0800
Date: Wed, 8 Dec 2021 10:15:57 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 0/4] Enable PASID for DMA API users
Message-ID: <20211208101557.0a896d2d@jacob-builder>
In-Reply-To: <20211208131038.GQ6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131038.GQ6385@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar, Sanjay
 K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Barry Song <21cnbao@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

Hi Jason,

Thanks for the quick review.

On Wed, 8 Dec 2021 09:10:38 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Dec 07, 2021 at 05:47:10AM -0800, Jacob Pan wrote:
> > Modern accelerators such as Intel's Data Streaming Accelerator (DSA) can
> > perform DMA requests with PASID, which is a finer granularity than the
> > device's requester ID(RID). In fact, work submissions on DSA shared work
> > queues require PASID.  
> 
> Lets use plain langauge please:
> 
> DSA HW cannot do DMA from its RID, so always requires a PASID, even
> for kernel controlled DMA.
> 
> To allow it to use the DMA API we must associate a PASID with the
> iommu_domain that the DMA API is already using for the device's RID.
> 
> This way DMA tagged with the PASID will be treated exactly the same as
> DMA originating from the RID.
> 
Exactly, will incorporate in the next version.

> > DMA mapping API is the de facto standard for in-kernel DMA. However, it
> > operates on a per device/RID basis which is not PASID-aware.
> > 
> > This patch introduces the following driver facing API that enables DMA
> > API PASID usage: ioasid_t iommu_enable_pasid_dma(struct device *dev);  
> 
> This is the wrong API, IMHO
> 
> It should be more like
> 
> int iommu_get_dma_api_pasid(struct device *dev, ioasid_t *pasid);
This works. I had ioasid_t *pasid in my previous version but thinking we
can simplify the interface since we can have the reserved INVALID_IOASID
for return status.
But it seems to me _get_ does not convey the message that this API
actually enables/attaches the kernel DMA PASID. Perhaps call it
iommu_attach_dma_api_pasid() as you suggested in the ops function?

> void iommu_destroy_dma_api_pasid(struct device *dev);
> 
Sounds good

> > A PASID field is added to struct device for the purposes of storing
> > kernel DMA PASID and flushing device IOTLBs. A separate use case in
> > interrupt  
> 
> And this really should not be touching the struct device at all.
> 
I was thinking RID is per device, this PASID == RID. We could put in pci_dev
but there are non-PCI devices use SSID/PASID.

> At worst the PASID should be stored in the iommu_group.
> 
This also makes sense, default domain is stored per group. To support
multiple devices per group, we still need a per device flag for devTLB
flush. Right?

i.e. while doing iova unmap, IOTLBs are flush for all devices, but we
only need to flush the device TLBs for devices that has kernel DMA PASID.

> > message store (IMS) also hinted adding a PASID field to struct device.
> > https://lore.kernel.org/all/87pmx73tfw.ffs@nanos.tec.linutronix.de/
> > IMS virtualization and DMA API does not overlap.  
> 
> This is under debate, I'm skeptical it will happen considering the new
> direction for this work.
> 
Good to know, thanks.

> > Once enabled, device drivers can continue to use DMA APIs as-is. There
> > is no difference in terms of mapping in dma_handle between without
> > PASID and with PASID.  The DMA mapping performed by IOMMU will be
> > identical for both requests with and without PASID (legacy), let it be
> > IOVA or PA in case of pass-through.  
> 
> In other words all this does is connect the PASID to the normal
> DMA-API owned iommu_domain.
> 
Exactly! will incorporate. 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
