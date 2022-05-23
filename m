Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA779C433F5
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 15:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D19140B61;
	Mon, 23 May 2022 15:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YvPLKkkAJ-xP; Mon, 23 May 2022 15:20:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0BC3740017;
	Mon, 23 May 2022 15:20:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEC31C0032;
	Mon, 23 May 2022 15:20:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14CA7C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 15:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 031C740B4D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 15:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tJyVVbD1Xo-y for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 15:20:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFE0040017
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653319207; x=1684855207;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PbNyLowZXXyeR9OxM1xpX367cO5XzR8kGQzWfh6uwwU=;
 b=W/YY8/PECOJKL7iU21kDnCHLTzwA63tY8w9AnEEjlvuOlfPksgCzTXkS
 A9BSyrpx8E5VyYsRhzBNmEyJ90Xd60hb7wMz5RfxTFsGwH4q9AeyGPCLH
 7IsGxLK7wSH+vgwhXDhD2chjE2CNiFT7Ht5syXExJetPtdmOfh/eGvwg+
 RHs4eJN8cxBqBWHOixVXWNHww+lG3EbIuxOLclqAnoSoMf3lj862hI94y
 FtDhCTA7MvWbs8jbWR3YOUkrSMKUnSe7PqAxVHhk8LP6VkOODiZ7Z916m
 O0nSZHIWqDbTlGp02xYcP486prLneYcj+KH/E5M4sXUr280miuS5uqH57 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="270824337"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; d="scan'208";a="270824337"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 08:20:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; d="scan'208";a="548021388"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 08:20:07 -0700
Date: Mon, 23 May 2022 08:23:59 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v4 4/6] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220523082359.74fb435b@jacob-builder>
In-Reply-To: <BL1PR11MB5271E995E160E0C6A6C0C89A8CD49@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-5-jacob.jun.pan@linux.intel.com>
 <BL1PR11MB5271E995E160E0C6A6C0C89A8CD49@BL1PR11MB5271.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "will@kernel.org" <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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

Hi Kevin,

On Mon, 23 May 2022 08:25:33 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, May 19, 2022 2:21 AM
> > 
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
> >  drivers/iommu/dma-iommu.c | 114
> > ++++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-iommu.h |   3 +
> >  2 files changed, 117 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 1ca85d37eeab..6ad7ba619ef0 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -34,6 +34,8 @@ struct iommu_dma_msi_page {
> >  	phys_addr_t		phys;
> >  };
> > 
> > +static DECLARE_IOASID_SET(iommu_dma_pasid);
> > +
> >  enum iommu_dma_cookie_type {
> >  	IOMMU_DMA_IOVA_COOKIE,
> >  	IOMMU_DMA_MSI_COOKIE,
> > @@ -370,6 +372,118 @@ void iommu_put_dma_cookie(struct
> > iommu_domain *domain)
> >  	domain->iova_cookie = NULL;
> >  }
> > 
> > +/* Protect iommu_domain DMA PASID data */
> > +static DEFINE_MUTEX(dma_pasid_lock);
> > +/**
> > + * iommu_attach_dma_pasid --Attach a PASID for in-kernel DMA. Use the
> > device's
> > + * DMA domain.
> > + * @dev: Device to be enabled
> > + * @pasid: The returned kernel PASID to be used for DMA
> > + *
> > + * DMA request with PASID will be mapped the same way as the legacy
> > DMA.
> > + * If the device is in pass-through, PASID will also pass-through. If
> > the
> > + * device is in IOVA, the PASID will point to the same IOVA page table.
> > + *
> > + * @return err code or 0 on success
> > + */
> > +int iommu_attach_dma_pasid(struct device *dev, ioasid_t *pasid)  
> 
> iommu_attach_dma_domain_pasid? 'dma_pasid' is too broad from
> a API p.o.v.
> 
I agree dma_pasid is too broad, technically it is dma_api_pasid but seems
too long.
My concern with dma_domain_pasid is that the pasid can also be used for
identity domain.

> > +{
> > +	struct iommu_domain *dom;
> > +	ioasid_t id, max;
> > +	int ret = 0;
> > +
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> > +		return -ENODEV;
> > +
> > +	/* Only support domain types that DMA API can be used */
> > +	if (dom->type == IOMMU_DOMAIN_UNMANAGED ||
> > +	    dom->type == IOMMU_DOMAIN_BLOCKED) {
> > +		dev_warn(dev, "Invalid domain type %d", dom->type);
> > +		return -EPERM;
> > +	}  
> 
> WARN_ON.
> 
> and probably we can just check whether domain is default domain here.
> 
good point, I will just use
struct iommu_domain *def_domain = iommu_get_dma_domain(dev);

> > +
> > +	mutex_lock(&dma_pasid_lock);
> > +	id = dom->dma_pasid;
> > +	if (!id) {
> > +		/*
> > +		 * First device to use PASID in its DMA domain,
> > allocate
> > +		 * a single PASID per DMA domain is all we need, it is
> > also
> > +		 * good for performance when it comes down to IOTLB
> > flush.
> > +		 */
> > +		max = 1U << dev->iommu->pasid_bits;
> > +		if (!max) {
> > +			ret = -EINVAL;
> > +			goto done_unlock;
> > +		}
> > +
> > +		id = ioasid_alloc(&iommu_dma_pasid, 1, max, dev);
> > +		if (id == INVALID_IOASID) {
> > +			ret = -ENOMEM;
> > +			goto done_unlock;
> > +		}
> > +
> > +		dom->dma_pasid = id;
> > +		atomic_set(&dom->dma_pasid_users, 1);  
> 
> this is always accessed with lock held hence no need to be atomic.
> 
good catch, will fix

> > +	}
> > +
> > +	ret = iommu_attach_device_pasid(dom, dev, id);
> > +	if (!ret) {
> > +		*pasid = id;
> > +		atomic_inc(&dom->dma_pasid_users);
> > +		goto done_unlock;
> > +	}
> > +
> > +	if (atomic_dec_and_test(&dom->dma_pasid_users)) {
> > +		ioasid_free(id);
> > +		dom->dma_pasid = 0;
> > +	}
> > +done_unlock:
> > +	mutex_unlock(&dma_pasid_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(iommu_attach_dma_pasid);
> > +
> > +/**
> > + * iommu_detach_dma_pasid --Disable in-kernel DMA request with PASID
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
> > + */
> > +void iommu_detach_dma_pasid(struct device *dev)
> > +{
> > +	struct iommu_domain *dom;
> > +	ioasid_t pasid;
> > +
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (WARN_ON(!dom || !dom->ops || !dom->ops->detach_dev_pasid))
> > +		return;
> > +
> > +	/* Only support DMA API managed domain type */
> > +	if (WARN_ON(dom->type == IOMMU_DOMAIN_UNMANAGED ||
> > +		    dom->type == IOMMU_DOMAIN_BLOCKED))
> > +		return;
> > +
> > +	mutex_lock(&dma_pasid_lock);
> > +	pasid = iommu_get_pasid_from_domain(dev, dom);
> > +	if (!pasid || pasid == INVALID_IOASID) {
> > +		dev_err(dev, "No valid DMA PASID attached\n");
> > +		mutex_unlock(&dma_pasid_lock);
> > +		return;
> > +	}  
> 
> here just use dom->dma_pasid and let iommu driver to figure out
> underlying whether this device has been attached to the domain
> with the said pasid.
> 
Yeah, I am checking the pasid matching in the iommu driver. My thinking is
that here is a quick sanity check in the common code to rule out invalid value.


Thanks a lot!


Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
