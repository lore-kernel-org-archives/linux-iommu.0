Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B52C43381
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:52:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F0D64FF3
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F0D64FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94C0C84590;
	Fri, 12 Mar 2021 15:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJSWjJqsldec; Fri, 12 Mar 2021 15:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E88884563;
	Fri, 12 Mar 2021 15:52:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E073C000B;
	Fri, 12 Mar 2021 15:52:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD2E6C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE84B43049
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vtG8aEryK6jX for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:52:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF68C4017B
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:52:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D0211B3;
 Fri, 12 Mar 2021 07:52:07 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA3A3F7D7;
 Fri, 12 Mar 2021 07:52:04 -0800 (PST)
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
Date: Fri, 12 Mar 2021 15:52:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311233142.7900-7-logang@deltatee.com>
Content-Language: en-GB
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, Stephen Bates <sbates@raithlin.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

On 2021-03-11 23:31, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   kernel/dma/direct.c  | 35 ++++++++++++++++++++++++++++++++---
>   kernel/dma/mapping.c | 13 ++++++++++---
>   2 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 002268262c9a..f326d32062dd 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/set_memory.h>
>   #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>   #include "direct.h"
>   
>   /*
> @@ -387,19 +388,47 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sg(sgl, sg, nents, i)
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_pci_p2pdma(sg))
> +			continue;
> +
>   		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>   			     attrs);
> +	}
>   }
>   #endif
>   
>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
> -	int i;
> +	struct dev_pagemap *pgmap = NULL;
> +	int i, map = -1, ret = 0;
>   	struct scatterlist *sg;
> +	u64 bus_off;
>   
>   	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			if (sg_page(sg)->pgmap != pgmap) {
> +				pgmap = sg_page(sg)->pgmap;
> +				map = pci_p2pdma_dma_map_type(dev, pgmap);
> +				bus_off = pci_p2pdma_bus_offset(sg_page(sg));
> +			}
> +
> +			if (map < 0) {
> +				sg->dma_address = DMA_MAPPING_ERROR;
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +
> +			if (map) {
> +				sg->dma_address = sg_phys(sg) + sg->offset -
> +					bus_off;
> +				sg_dma_len(sg) = sg->length;
> +				sg_mark_pci_p2pdma(sg);
> +				continue;
> +			}
> +		}
> +
>   		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>   				sg->offset, sg->length, dir, attrs);
>   		if (sg->dma_address == DMA_MAPPING_ERROR)
> @@ -411,7 +440,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   
>   out_unmap:
>   	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -	return 0;
> +	return ret;
>   }
>   
>   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b6a633679933..adc1a83950be 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -178,8 +178,15 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>   
>   /*
> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> - * It should never return a value < 0.
> + * dma_maps_sg_attrs returns 0 on any resource error and > 0 on success.
> + *
> + * If 0 is returned, the mapping can be retried and will succeed once
> + * sufficient resources are available.

That's not a guarantee we can uphold. Retrying forever in the vain hope 
that a device might evolve some extra address bits, or a bounce buffer 
might magically grow big enough for a gigantic mapping, isn't 
necessarily the best idea.

> + *
> + * If there are P2PDMA pages in the scatterlist then this function may
> + * return -EREMOTEIO to indicate that the pages are not mappable by the
> + * device. In this case, an error should be returned for the IO as it
> + * will never be successfully retried.
>    */
>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
> @@ -197,7 +204,7 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
> -	BUG_ON(ents < 0);
> +

This scares me - I hesitate to imagine the amount of driver/subsystem 
code out there that will see nonzero and merrily set off iterating a 
negative number of segments, if we open the floodgates of allowing 
implementations to return error codes here.

Robin.

>   	debug_dma_map_sg(dev, sg, nents, ents, dir);
>   
>   	return ents;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
