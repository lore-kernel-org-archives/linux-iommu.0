Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F3BCCA480
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 11:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D902E830E6;
	Tue, 28 Jun 2022 11:23:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D902E830E6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m2L5SF9MHDtB; Tue, 28 Jun 2022 11:23:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 84813815AD;
	Tue, 28 Jun 2022 11:23:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84813815AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CABFC0032;
	Tue, 28 Jun 2022 11:23:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6017EC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47C7840598
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:23:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47C7840598
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jnP6TF-aTs_H for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 11:23:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40309400BF
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40309400BF
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:23:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3284152B;
 Tue, 28 Jun 2022 04:23:08 -0700 (PDT)
Received: from [10.57.85.130] (unknown [10.57.85.130])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4E43F5A1;
 Tue, 28 Jun 2022 04:23:05 -0700 (PDT)
Message-ID: <bbca5df5-8681-d6d9-201d-3d48b34e3001@arm.com>
Date: Tue, 28 Jun 2022 12:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/5] dma-mapping: Add dma_opt_mapping_size()
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, damien.lemoal@opensource.wdc.com,
 joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hch@lst.de, m.szyprowski@samsung.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-2-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1656343521-62897-2-git-send-email-john.garry@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

On 2022-06-27 16:25, John Garry wrote:
> Streaming DMA mapping involving an IOMMU may be much slower for larger
> total mapping size. This is because every IOMMU DMA mapping requires an
> IOVA to be allocated and freed. IOVA sizes above a certain limit are not
> cached, which can have a big impact on DMA mapping performance.
> 
> Provide an API for device drivers to know this "optimal" limit, such that
> they may try to produce mapping which don't exceed it.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   Documentation/core-api/dma-api.rst |  9 +++++++++
>   include/linux/dma-map-ops.h        |  1 +
>   include/linux/dma-mapping.h        |  5 +++++
>   kernel/dma/mapping.c               | 12 ++++++++++++
>   4 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index 6d6d0edd2d27..b3cd9763d28b 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -204,6 +204,15 @@ Returns the maximum size of a mapping for the device. The size parameter
>   of the mapping functions like dma_map_single(), dma_map_page() and
>   others should not be larger than the returned value.
>   
> +::
> +
> +	size_t
> +	dma_opt_mapping_size(struct device *dev);
> +
> +Returns the maximum optimal size of a mapping for the device. Mapping large
> +buffers may take longer so device drivers are advised to limit total DMA
> +streaming mappings length to the returned value.

Nit: I'm not sure "advised" is necessarily the right thing to say in 
general - that's only really true for a caller who cares about 
throughput of churning through short-lived mappings more than anything 
else, and doesn't take a significant hit overall from splitting up 
larger requests. I do think it's good to clarify the exact context of 
"optimal" here, but I'd prefer to be objectively clear that it's for 
workloads where the up-front mapping overhead dominates.

Thanks,
Robin.

> +
>   ::
>   
>   	bool
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 0d5b06b3a4a6..98ceba6fa848 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -69,6 +69,7 @@ struct dma_map_ops {
>   	int (*dma_supported)(struct device *dev, u64 mask);
>   	u64 (*get_required_mask)(struct device *dev);
>   	size_t (*max_mapping_size)(struct device *dev);
> +	size_t (*opt_mapping_size)(void);
>   	unsigned long (*get_merge_boundary)(struct device *dev);
>   };
>   
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index dca2b1355bb1..fe3849434b2a 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -144,6 +144,7 @@ int dma_set_mask(struct device *dev, u64 mask);
>   int dma_set_coherent_mask(struct device *dev, u64 mask);
>   u64 dma_get_required_mask(struct device *dev);
>   size_t dma_max_mapping_size(struct device *dev);
> +size_t dma_opt_mapping_size(struct device *dev);
>   bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
>   unsigned long dma_get_merge_boundary(struct device *dev);
>   struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
> @@ -266,6 +267,10 @@ static inline size_t dma_max_mapping_size(struct device *dev)
>   {
>   	return 0;
>   }
> +static inline size_t dma_opt_mapping_size(struct device *dev)
> +{
> +	return 0;
> +}
>   static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>   {
>   	return false;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index db7244291b74..1bfe11b1edb6 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -773,6 +773,18 @@ size_t dma_max_mapping_size(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>   
> +size_t dma_opt_mapping_size(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	size_t size = SIZE_MAX;
> +
> +	if (ops && ops->opt_mapping_size)
> +		size = ops->opt_mapping_size();
> +
> +	return min(dma_max_mapping_size(dev), size);
> +}
> +EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
> +
>   bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
