Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B280C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 21:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CACFC4029F;
	Mon, 28 Mar 2022 21:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0oqvt4SqwTSD; Mon, 28 Mar 2022 21:41:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 44C194016C;
	Mon, 28 Mar 2022 21:41:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33775C001D;
	Mon, 28 Mar 2022 21:41:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D177C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 21:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0CEFA40273
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 21:41:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kOfIkP_zqwtl for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:41:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5EE24016C
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 21:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648503661; x=1680039661;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gg5QwhP4YCgK1cnFnIvMFqJVjZwNm4QeiHPCuwP2Rc8=;
 b=TzS1mKEs+17vHHA2TiUyBSRi/DKvdyBMlhcMq8EQRux9shv4WlwDy/bz
 mzQU+BrhasiPMSEdZseqdcwaIxuJgZ6OuVXTF/tV9VofDYQsJcKrdliIq
 p5XdcOkkumTeS+1uWHkbKASrY8DH9nLpW45DpQp0xZrcevQz8msH2p3Qw
 O/HxejQWqk/YJK7URw82lu8/mlExQ0GFMco36gigEketPetgldb7BlirB
 LzSr92aEqlqAqtAtoYfXVayr2+UNgqzsj/Gxr+morpS8nsEMTIUm5uD4A
 CLJjZfh6WSgJkR90+Ssrt/pQD9/SFA6cVMW1ADpFbXEzLCMaHLszlcpzf A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="241262679"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; d="scan'208";a="241262679"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 14:41:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; d="scan'208";a="617924058"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 14:41:00 -0700
Date: Mon, 28 Mar 2022 14:44:23 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220328144423.39ba9b9b@jacob-builder>
In-Reply-To: <12390112-c497-1f02-5ddc-ad8ee3645347@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <12390112-c497-1f02-5ddc-ad8ee3645347@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi, 
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi BaoLu,

On Fri, 18 Mar 2022 20:43:54 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> On 2022/3/15 13:07, Jacob Pan wrote:
> > DMA mapping API is the de facto standard for in-kernel DMA. It operates
> > on a per device/RID basis which is not PASID-aware.
> > 
> > Some modern devices such as Intel Data Streaming Accelerator, PASID is
> > required for certain work submissions. To allow such devices use DMA
> > mapping API, we need the following functionalities:
> > 1. Provide device a way to retrieve a PASID for work submission within
> > the kernel
> > 2. Enable the kernel PASID on the IOMMU for the device
> > 3. Attach the kernel PASID to the device's default DMA domain, let it
> > be IOVA or physical address in case of pass-through.
> > 
> > This patch introduces a driver facing API that enables DMA API
> > PASID usage. Once enabled, device drivers can continue to use DMA APIs
> > as is. There is no difference in dma_handle between without PASID and
> > with PASID.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++++++++++++++++++++
> >   include/linux/dma-iommu.h |  7 +++++
> >   include/linux/iommu.h     |  9 ++++++
> >   3 files changed, 81 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index b22034975301..d0ff1a34b1b6 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -39,6 +39,8 @@ enum iommu_dma_cookie_type {
> >   	IOMMU_DMA_MSI_COOKIE,
> >   };
> >   
> > +static DECLARE_IOASID_SET(iommu_dma_pasid);
> > +
> >   struct iommu_dma_cookie {
> >   	enum iommu_dma_cookie_type	type;
> >   	union {
> > @@ -370,6 +372,69 @@ void iommu_put_dma_cookie(struct iommu_domain
> > *domain) domain->iova_cookie = NULL;
> >   }
> >   
> > +/**
> > + * iommu_enable_pasid_dma --Enable in-kernel DMA request with PASID
> > + * @dev:	Device to be enabled
> > + *
> > + * DMA request with PASID will be mapped the same way as the legacy
> > DMA.
> > + * If the device is in pass-through, PASID will also pass-through. If
> > the
> > + * device is in IOVA map, the supervisor PASID will point to the same
> > IOVA
> > + * page table.
> > + *
> > + * @return the kernel PASID to be used for DMA or INVALID_IOASID on
> > failure  
> 
> The comment on the return value should be rephrased according to the
> real code.
> 
yes, will do.

> > + */
> > +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid)
> > +{
> > +	struct iommu_domain *dom;
> > +	ioasid_t id, max;
> > +	int ret;
> > +
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> > +		return -ENODEV;
> > +	max = iommu_get_dev_pasid_max(dev);
> > +	if (!max)
> > +		return -EINVAL;
> > +
> > +	id = ioasid_alloc(&iommu_dma_pasid, 1, max, dev);
> > +	if (id == INVALID_IOASID)
> > +		return -ENOMEM;
> > +
> > +	ret = dom->ops->attach_dev_pasid(dom, dev, id);
> > +	if (ret) {
> > +		ioasid_put(id);
> > +		return ret;
> > +	}
> > +	*pasid = id;
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(iommu_enable_pasid_dma);
> > +
> > +/**
> > + * iommu_disable_pasid_dma --Disable in-kernel DMA request with PASID
> > + * @dev:	Device's PASID DMA to be disabled
> > + *
> > + * It is the device driver's responsibility to ensure no more incoming
> > DMA
> > + * requests with the kernel PASID before calling this function. IOMMU
> > driver
> > + * ensures PASID cache, IOTLBs related to the kernel PASID are cleared
> > and
> > + * drained.
> > + *
> > + * @return 0 on success or error code on failure  
> 
> Ditto.
> 
same

> > + */
> > +void iommu_disable_pasid_dma(struct device *dev, ioasid_t pasid)
> > +{
> > +	struct iommu_domain *dom;
> > +
> > +	/* TODO: check the given PASID is within the ioasid_set */
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (!dom->ops->detach_dev_pasid)
> > +		return;
> > +	dom->ops->detach_dev_pasid(dom, dev, pasid);
> > +	ioasid_put(pasid);
> > +}
> > +EXPORT_SYMBOL(iommu_disable_pasid_dma);
> > +
> >   /**
> >    * iommu_dma_get_resv_regions - Reserved region driver helper
> >    * @dev: Device from iommu_get_resv_regions()
> > diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> > index 24607dc3c2ac..e6cb9b52a420 100644
> > --- a/include/linux/dma-iommu.h
> > +++ b/include/linux/dma-iommu.h
> > @@ -18,6 +18,13 @@ int iommu_get_dma_cookie(struct iommu_domain
> > *domain); int iommu_get_msi_cookie(struct iommu_domain *domain,
> > dma_addr_t base); void iommu_put_dma_cookie(struct iommu_domain
> > *domain); 
> > +/*
> > + * For devices that can do DMA request with PASID, setup a system
> > PASID.
> > + * Address modes (IOVA, PA) are selected by the platform code.
> > + */  
> 
> No need for a comment here. Or move it to the function if need.
> 
right, this comment is obsolete. will remove.

> > +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid);
> > +void iommu_disable_pasid_dma(struct device *dev, ioasid_t pasid);
> > +
> >   /* Setup call for arch DMA mapping code */
> >   void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64
> > dma_limit); int iommu_dma_init_fq(struct iommu_domain *domain);
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index fde5b933dbe3..fb011722e4f8 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -395,6 +395,15 @@ static inline void iommu_set_dev_pasid_max(struct
> > device *dev, 
> >   	param->pasid_max = max;
> >   }
> > +static inline ioasid_t iommu_get_dev_pasid_max(struct device *dev)
> > +{
> > +	struct dev_iommu *param = dev->iommu;
> > +
> > +	if (WARN_ON(!param))
> > +		return 0;
> > +
> > +	return param->pasid_max;
> > +}
> >   
> >   int iommu_device_register(struct iommu_device *iommu,
> >   			  const struct iommu_ops *ops,  
> 
> Best regards,
> baolu


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
