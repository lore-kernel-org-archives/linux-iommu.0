Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C925C43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 12:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B17584092;
	Wed, 29 Jun 2022 12:13:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B17584092
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oiYWLul2lNX7; Wed, 29 Jun 2022 12:13:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C7A184029;
	Wed, 29 Jun 2022 12:13:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C7A184029
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E7B9C0032;
	Wed, 29 Jun 2022 12:13:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5336CC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 12:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 281338403C
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 12:13:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 281338403C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LAFGMI9clR15 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 12:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0230384029
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0230384029
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 12:13:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3497A152B;
 Wed, 29 Jun 2022 05:13:09 -0700 (PDT)
Received: from [10.57.85.71] (unknown [10.57.85.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEC103F66F;
 Wed, 29 Jun 2022 05:10:30 -0700 (PDT)
Message-ID: <feecc6fe-a16e-11f2-33c8-3de7c96b9ad5@arm.com>
Date: Wed, 29 Jun 2022 13:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 08/21] iommu/dma: support PCI P2PDMA pages in dma-iommu
 map_sg
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-9-logang@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220615161233.17527-9-logang@deltatee.com>
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Jason Ekstrand <jason@jlekstrand.net>,
 Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Stephen Bates <sbates@raithlin.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
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

On 2022-06-15 17:12, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.
> 
> A P2PDMA page may have three possible outcomes when being mapped:
>    1) If the data path between the two devices doesn't go through
>       the root port, then it should be mapped with a PCI bus address
>    2) If the data path goes through the host bridge, it should be mapped
>       normally with an IOMMU IOVA.
>    3) It is not possible for the two devices to communicate and thus
>       the mapping operation should fail (and it will return -EREMOTEIO).
> 
> Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
> indicate bus address segments. On unmap, P2PDMA segments are skipped
> over when determining the start and end IOVA addresses.
> 
> With this change, the flags variable in the dma_map_ops is set to
> DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/dma-iommu.c | 68 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 61 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f90251572a5d..b01ca0c6a7ab 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -21,6 +21,7 @@
>   #include <linux/iova.h>
>   #include <linux/irq.h>
>   #include <linux/list_sort.h>
> +#include <linux/memremap.h>
>   #include <linux/mm.h>
>   #include <linux/mutex.h>
>   #include <linux/pci.h>
> @@ -1062,6 +1063,16 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>   		sg_dma_len(s) = 0;
>   
> +		if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {

Logically, should we not be able to use sg_is_dma_bus_address() here? I 
think it should be feasible, and simpler, to prepare the p2p segments 
up-front, such that at this point all we need to do is restore the 
original length (if even that, see below).

> +			if (i > 0)
> +				cur = sg_next(cur);
> +
> +			pci_p2pdma_map_bus_segment(s, cur);
> +			count++;
> +			cur_len = 0;
> +			continue;
> +		}
> +
>   		/*
>   		 * Now fill in the real DMA data. If...
>   		 * - there is a valid output segment to append to
> @@ -1158,6 +1169,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct scatterlist *s, *prev = NULL;
>   	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
> +	struct dev_pagemap *pgmap = NULL;
> +	enum pci_p2pdma_map_type map_type;
>   	dma_addr_t iova;
>   	size_t iova_len = 0;
>   	unsigned long mask = dma_get_seg_boundary(dev);
> @@ -1193,6 +1206,35 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		s_length = iova_align(iovad, s_length + s_iova_off);
>   		s->length = s_length;
>   
> +		if (is_pci_p2pdma_page(sg_page(s))) {
> +			if (sg_page(s)->pgmap != pgmap) {
> +				pgmap = sg_page(s)->pgmap;
> +				map_type = pci_p2pdma_map_type(pgmap, dev);
> +			}

There's a definite code smell here, but per above and below I think we 
*should* actually call the new helper instead of copy-pasting half of it.

> +
> +			switch (map_type) {
> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				/*
> +				 * A zero length will be ignored by
> +				 * iommu_map_sg() and then can be detected

If that is required behaviour then it needs an explicit check in 
iommu_map_sg() to guarantee (and document) it. It's only by chance that 
__iommu_map() happens to return success for size == 0 *if* all the other 
arguments still line up, which is a far cry from a safe no-op.

However, rather than play yet more silly tricks, I think it would make 
even more sense to make iommu_map_sg() properly aware and able to skip 
direct p2p segments on its own. Once it becomes normal to pass mixed 
scatterlists around, it's only a matter of time until one ends up being 
handed to a driver which manages its own IOMMU domain, and then what?

> +				 * in __finalise_sg() to actually map the
> +				 * bus address.
> +				 */
> +				s->length = 0;
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				/*
> +				 * Mapping through host bridge should be
> +				 * mapped with regular IOVAs, thus we
> +				 * do nothing here and continue below.
> +				 */
> +				break;
> +			default:
> +				ret = -EREMOTEIO;
> +				goto out_restore_sg;
> +			}
> +		}
> +
>   		/*
>   		 * Due to the alignment of our single IOVA allocation, we can
>   		 * depend on these assumptions about the segment boundary mask:
> @@ -1215,6 +1257,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		prev = s;
>   	}
>   
> +	if (!iova_len)
> +		return __finalise_sg(dev, sg, nents, 0);
> +
>   	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
>   	if (!iova) {
>   		ret = -ENOMEM;
> @@ -1236,7 +1281,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   out_restore_sg:
>   	__invalidate_sg(sg, nents);
>   out:
> -	if (ret != -ENOMEM)
> +	if (ret != -ENOMEM && ret != -EREMOTEIO)
>   		return -EINVAL;
>   	return ret;
>   }
> @@ -1244,7 +1289,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	dma_addr_t start, end;
> +	dma_addr_t end, start = DMA_MAPPING_ERROR;

There are several things I don't like about this logic, I'd rather have 
"end = 0" here...

>   	struct scatterlist *tmp;
>   	int i;
>   
> @@ -1260,14 +1305,22 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	 * The scatterlist segments are mapped into a single
>   	 * contiguous IOVA allocation, so this is incredibly easy.
>   	 */

[ This comment rather stops being true :( ]

> -	start = sg_dma_address(sg);
> -	for_each_sg(sg_next(sg), tmp, nents - 1, i) {

...then generalise the first-element special case here into a dedicated 
"walk to the first non-p2p element" loop...

> +	for_each_sg(sg, tmp, nents, i) {
> +		if (sg_is_dma_bus_address(tmp)) {
> +			sg_dma_unmark_bus_address(tmp);

[ Again I question what this actually achieves ]

> +			continue;
> +		}
>   		if (sg_dma_len(tmp) == 0)
>   			break;
> -		sg = tmp;
> +
> +		if (start == DMA_MAPPING_ERROR)
> +			start = sg_dma_address(tmp);
> +
> +		end = sg_dma_address(tmp) + sg_dma_len(tmp);
>   	}
> -	end = sg_dma_address(sg) + sg_dma_len(sg);
> -	__iommu_dma_unmap(dev, start, end - start);
> +
> +	if (start != DMA_MAPPING_ERROR)

...then "if (end)" here.

Thanks,
Robin.

> +		__iommu_dma_unmap(dev, start, end - start);
>   }
>   
>   static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> @@ -1460,6 +1513,7 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>   }
>   
>   static const struct dma_map_ops iommu_dma_ops = {
> +	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
>   	.alloc_pages		= dma_common_alloc_pages,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
