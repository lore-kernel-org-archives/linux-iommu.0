Return-Path: <SRS0=lDjG=O4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC3DC433EF
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 13:03:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BB361042
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 13:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1BB361042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6058F400E8;
	Fri,  8 Oct 2021 13:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k9XhLuQca6FQ; Fri,  8 Oct 2021 13:03:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0552240122;
	Fri,  8 Oct 2021 13:03:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA7A1C000F;
	Fri,  8 Oct 2021 13:03:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91278C000D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 13:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 694164039D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 13:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mOXX51AtmsRZ for <iommu@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 13:03:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93A1D40397
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 13:03:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDF986D;
 Fri,  8 Oct 2021 06:03:50 -0700 (PDT)
Received: from [10.57.22.120] (unknown [10.57.22.120])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575023F66F;
 Fri,  8 Oct 2021 06:03:48 -0700 (PDT)
Subject: Re: [PATCH v7 3/9] iommu/dma: Introduce generic helper to retrieve
 RMR info
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-4-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <53208fa4-576c-f590-334a-6d1ce8170031@arm.com>
Date: Fri, 8 Oct 2021 14:03:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-4-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 will@kernel.org, wanghuiqiang@huawei.com
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

On 2021-08-05 09:07, Shameer Kolothum wrote:
> Reserved Memory Regions(RMR) associated with an IOMMU can be
> described through ACPI IORT tables in systems with devices
> that require a unity mapping or bypass for those
> regions.
> 
> Introduce a generic interface so that IOMMU drivers can retrieve
> and set up necessary mappings.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 29 +++++++++++++++++++++++++++++
>   include/linux/dma-iommu.h | 13 +++++++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 98ba927aee1a..2fa2445e9070 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -174,6 +174,35 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   }
>   EXPORT_SYMBOL(iommu_put_dma_cookie);
>   
> +/**
> + *
> + * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
> + *                      with a given IOMMU
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @list: RMR list to be populated
> + *
> + */
> +int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *list)
> +{
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(iommu_dma_get_rmrs);
> +
> +/**
> + *
> + * iommu_dma_put_rmrs - Release Reserved Memory Regions(RMRs) associated
> + *                      with a given IOMMU
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @list: RMR list
> + *
> + */
> +void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list)
> +{
> +}
> +EXPORT_SYMBOL(iommu_dma_put_rmrs);

Unless there's something special you expect to need to do here, can we 
just uphold the prevailing expectation that resv_regions are kmalloc()ed 
and can be freed directly by the generic function?

> +
>   /**
>    * iommu_dma_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 758ca4694257..3b7b2d096c6e 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -42,12 +42,16 @@ void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
>   
>   extern bool iommu_dma_forcedac;
>   
> +int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
> +void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct list_head *list);
> +
>   #else /* CONFIG_IOMMU_DMA */
>   
>   struct iommu_domain;
>   struct msi_desc;
>   struct msi_msg;
>   struct device;
> +struct fwnode_handle;
>   
>   static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>   				       u64 dma_limit)
> @@ -83,5 +87,14 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   {
>   }
>   
> +static int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list)
> +{
> +	return -ENODEV;

Hmm, if this needs to be stubbed at all then returning an error seems 
like probably the wrong thing to do. I guess it's for 32-bit builds of 
arm-smmu? It is not an error if the firmware describes no RMRs because 
there are no RMRs, so it hardly deserves to be an error if there are no 
RMRs simply because the firmware isn't ACPI.

Robin.

> +}
> +
> +static void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct list_head *list)
> +{
> +}
> +
>   #endif	/* CONFIG_IOMMU_DMA */
>   #endif	/* __DMA_IOMMU_H */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
