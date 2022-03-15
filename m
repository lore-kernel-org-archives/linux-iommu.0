Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710DCC433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 11:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E460D40A0D;
	Tue, 15 Mar 2022 11:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fqqSVGH9UOKT; Tue, 15 Mar 2022 11:16:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1316A409FB;
	Tue, 15 Mar 2022 11:16:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4796C0012;
	Tue, 15 Mar 2022 11:16:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F76EC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 11:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFA1B60F9D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 11:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IfuAIekzu_Vm for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 11:16:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D69C60F94
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 11:16:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BEB01474;
 Tue, 15 Mar 2022 04:16:45 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4B53F66F;
 Tue, 15 Mar 2022 04:16:42 -0700 (PDT)
Message-ID: <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
Date: Tue, 15 Mar 2022 11:16:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Content-Language: en-GB
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Dan Williams <dan.j.williams@intel.com>
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

On 2022-03-15 05:07, Jacob Pan wrote:
> DMA mapping API is the de facto standard for in-kernel DMA. It operates
> on a per device/RID basis which is not PASID-aware.
> 
> Some modern devices such as Intel Data Streaming Accelerator, PASID is
> required for certain work submissions. To allow such devices use DMA
> mapping API, we need the following functionalities:
> 1. Provide device a way to retrieve a PASID for work submission within
> the kernel
> 2. Enable the kernel PASID on the IOMMU for the device
> 3. Attach the kernel PASID to the device's default DMA domain, let it
> be IOVA or physical address in case of pass-through.
> 
> This patch introduces a driver facing API that enables DMA API
> PASID usage. Once enabled, device drivers can continue to use DMA APIs as
> is. There is no difference in dma_handle between without PASID and with
> PASID.

Surely the main point of PASIDs is to be able to use more than one of 
them? The way I expected this to work is that iommu_enable_pasid_dma() 
returns a *new* struct device representing the dev+PASID combination, 
and the driver can then pass that to subsequent DMA API and/or IOMMU API 
calls as normal, and they know to do the right thing. Automatically 
inferring a PASID for the original physical device clearly can't scale, 
and seems like a dead-end approach that only helps this one niche use-case.

Either way, I think this is also still fundamentally an IOMMU API 
operation that belongs in iommu.[ch] - since the iommu_dma_ops 
consolidation I'd prefer to continue working towards making dma-iommu.h 
a private header just for IOMMU API internal helpers.

Thanks,
Robin.

> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++++++++++++++++++++
>   include/linux/dma-iommu.h |  7 +++++
>   include/linux/iommu.h     |  9 ++++++
>   3 files changed, 81 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index b22034975301..d0ff1a34b1b6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -39,6 +39,8 @@ enum iommu_dma_cookie_type {
>   	IOMMU_DMA_MSI_COOKIE,
>   };
>   
> +static DECLARE_IOASID_SET(iommu_dma_pasid);
> +
>   struct iommu_dma_cookie {
>   	enum iommu_dma_cookie_type	type;
>   	union {
> @@ -370,6 +372,69 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   	domain->iova_cookie = NULL;
>   }
>   
> +/**
> + * iommu_enable_pasid_dma --Enable in-kernel DMA request with PASID
> + * @dev:	Device to be enabled
> + *
> + * DMA request with PASID will be mapped the same way as the legacy DMA.
> + * If the device is in pass-through, PASID will also pass-through. If the
> + * device is in IOVA map, the supervisor PASID will point to the same IOVA
> + * page table.
> + *
> + * @return the kernel PASID to be used for DMA or INVALID_IOASID on failure
> + */
> +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid)
> +{
> +	struct iommu_domain *dom;
> +	ioasid_t id, max;
> +	int ret;
> +
> +	dom = iommu_get_domain_for_dev(dev);
> +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> +		return -ENODEV;
> +	max = iommu_get_dev_pasid_max(dev);
> +	if (!max)
> +		return -EINVAL;
> +
> +	id = ioasid_alloc(&iommu_dma_pasid, 1, max, dev);
> +	if (id == INVALID_IOASID)
> +		return -ENOMEM;
> +
> +	ret = dom->ops->attach_dev_pasid(dom, dev, id);
> +	if (ret) {
> +		ioasid_put(id);
> +		return ret;
> +	}
> +	*pasid = id;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(iommu_enable_pasid_dma);
> +
> +/**
> + * iommu_disable_pasid_dma --Disable in-kernel DMA request with PASID
> + * @dev:	Device's PASID DMA to be disabled
> + *
> + * It is the device driver's responsibility to ensure no more incoming DMA
> + * requests with the kernel PASID before calling this function. IOMMU driver
> + * ensures PASID cache, IOTLBs related to the kernel PASID are cleared and
> + * drained.
> + *
> + * @return 0 on success or error code on failure
> + */
> +void iommu_disable_pasid_dma(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *dom;
> +
> +	/* TODO: check the given PASID is within the ioasid_set */
> +	dom = iommu_get_domain_for_dev(dev);
> +	if (!dom->ops->detach_dev_pasid)
> +		return;
> +	dom->ops->detach_dev_pasid(dom, dev, pasid);
> +	ioasid_put(pasid);
> +}
> +EXPORT_SYMBOL(iommu_disable_pasid_dma);
> +
>   /**
>    * iommu_dma_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 24607dc3c2ac..e6cb9b52a420 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -18,6 +18,13 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
>   int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
>   void iommu_put_dma_cookie(struct iommu_domain *domain);
>   
> +/*
> + * For devices that can do DMA request with PASID, setup a system PASID.
> + * Address modes (IOVA, PA) are selected by the platform code.
> + */
> +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid);
> +void iommu_disable_pasid_dma(struct device *dev, ioasid_t pasid);
> +
>   /* Setup call for arch DMA mapping code */
>   void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
>   int iommu_dma_init_fq(struct iommu_domain *domain);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fde5b933dbe3..fb011722e4f8 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -395,6 +395,15 @@ static inline void iommu_set_dev_pasid_max(struct device *dev,
>   
>   	param->pasid_max = max;
>   }
> +static inline ioasid_t iommu_get_dev_pasid_max(struct device *dev)
> +{
> +	struct dev_iommu *param = dev->iommu;
> +
> +	if (WARN_ON(!param))
> +		return 0;
> +
> +	return param->pasid_max;
> +}
>   
>   int iommu_device_register(struct iommu_device *iommu,
>   			  const struct iommu_ops *ops,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
