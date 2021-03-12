Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB08CC433E9
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:53:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7F365034
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7F365034
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CECD84599;
	Fri, 12 Mar 2021 15:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aX2re5vRqwMR; Fri, 12 Mar 2021 15:53:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94EC084563;
	Fri, 12 Mar 2021 15:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80DCDC000B;
	Fri, 12 Mar 2021 15:53:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E078C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 390B343049
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9wlVl_p0pwh0 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A7144017B
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:53:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B81B1063;
 Fri, 12 Mar 2021 07:53:07 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 314293F7D7;
 Fri, 12 Mar 2021 07:53:03 -0800 (PST)
Subject: Re: [RFC PATCH v2 08/11] iommu/dma: Support PCI P2PDMA pages in
 dma-iommu map_sg
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-9-logang@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <accd4187-7a9d-a8fc-f216-98ec24e3411a@arm.com>
Date: Fri, 12 Mar 2021 15:52:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311233142.7900-9-logang@deltatee.com>
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
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.

This misled me at first, but I see the implementation does actually 
appear to accomodate the case of working ACS where P2P *would* still 
need to be mapped at the IOMMU.

> Similar to dma-direct, the sg_mark_pci_p2pdma() flag is used to
> indicate bus address segments. On unmap, P2PDMA segments are skipped
> over when determining the start and end IOVA addresses.
> 
> With this change, the flags variable in the dma_map_ops is
> set to DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for
> P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/iommu/dma-iommu.c | 63 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index af765c813cc8..c0821e9051a9 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -20,6 +20,7 @@
>   #include <linux/mm.h>
>   #include <linux/mutex.h>
>   #include <linux/pci.h>
> +#include <linux/pci-p2pdma.h>
>   #include <linux/swiotlb.h>
>   #include <linux/scatterlist.h>
>   #include <linux/vmalloc.h>
> @@ -846,7 +847,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>    * segment's start address to avoid concatenating across one.
>    */
>   static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
> -		dma_addr_t dma_addr)
> +		dma_addr_t dma_addr, unsigned long attrs)
>   {
>   	struct scatterlist *s, *cur = sg;
>   	unsigned long seg_mask = dma_get_seg_boundary(dev);
> @@ -864,6 +865,20 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>   		sg_dma_len(s) = 0;
>   
> +		if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
> +			if (i > 0)
> +				cur = sg_next(cur);
> +
> +			sg_dma_address(cur) = sg_phys(s) + s->offset -

Are you sure about that? ;)

> +				pci_p2pdma_bus_offset(sg_page(s));

Can the bus offset make P2P addresses overlap with regions of mem space 
that we might use for regular IOVA allocation? That would be very bad...

> +			sg_dma_len(cur) = s->length;
> +			sg_mark_pci_p2pdma(cur);
> +
> +			count++;
> +			cur_len = 0;
> +			continue;
> +		}
> +
>   		/*
>   		 * Now fill in the real DMA data. If...
>   		 * - there is a valid output segment to append to
> @@ -960,11 +975,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct scatterlist *s, *prev = NULL;
> +	struct dev_pagemap *pgmap = NULL;
>   	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
>   	dma_addr_t iova;
>   	size_t iova_len = 0;
>   	unsigned long mask = dma_get_seg_boundary(dev);
> -	int i;
> +	int i, map = -1, ret = 0;
>   
>   	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>   	    iommu_deferred_attach(dev, domain))
> @@ -993,6 +1009,23 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		s_length = iova_align(iovad, s_length + s_iova_off);
>   		s->length = s_length;
>   
> +		if (is_pci_p2pdma_page(sg_page(s))) {
> +			if (sg_page(s)->pgmap != pgmap) {
> +				pgmap = sg_page(s)->pgmap;
> +				map = pci_p2pdma_dma_map_type(dev, pgmap);
> +			}
> +
> +			if (map < 0) {

It rather feels like it should be the job of whoever creates the list in 
the first place not to put unusable pages in it, especially since the 
p2pdma_map_type looks to be a fairly coarse-grained and static thing. 
The DMA API isn't responsible for validating normal memory pages, so 
what makes P2P special?

> +				ret = -EREMOTEIO;
> +				goto out_restore_sg;
> +			}
> +
> +			if (map) {
> +				s->length = 0;

I'm not really thrilled about the idea of passing zero-length segments 
to iommu_map_sg(). Yes, it happens to trick the concatenation logic in 
the current implementation into doing what you want, but it feels fragile.

> +				continue;
> +			}
> +		}
> +
>   		/*
>   		 * Due to the alignment of our single IOVA allocation, we can
>   		 * depend on these assumptions about the segment boundary mask:
> @@ -1015,6 +1048,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		prev = s;
>   	}
>   
> +	if (!iova_len)
> +		return __finalise_sg(dev, sg, nents, 0, attrs);
> +
>   	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
>   	if (!iova)
>   		goto out_restore_sg;
> @@ -1026,19 +1062,19 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
>   		goto out_free_iova;
>   
> -	return __finalise_sg(dev, sg, nents, iova);
> +	return __finalise_sg(dev, sg, nents, iova, attrs);
>   
>   out_free_iova:
>   	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
>   out_restore_sg:
>   	__invalidate_sg(sg, nents);
> -	return 0;
> +	return ret;
>   }
>   
>   static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	dma_addr_t start, end;
> +	dma_addr_t end, start = DMA_MAPPING_ERROR;
>   	struct scatterlist *tmp;
>   	int i;
>   
> @@ -1054,14 +1090,20 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	 * The scatterlist segments are mapped into a single
>   	 * contiguous IOVA allocation, so this is incredibly easy.
>   	 */
> -	start = sg_dma_address(sg);
> -	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
> +	for_each_sg(sg, tmp, nents, i) {
> +		if (sg_is_pci_p2pdma(tmp))

Since the flag is associated with the DMA address which will no longer 
be valid, shouldn't it be cleared? The circumstances in which leaving it 
around could cause a problem are tenuous, but definitely possible.

Robin.

> +			continue;
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
> +		__iommu_dma_unmap(dev, start, end - start);
>   }
>   
>   static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> @@ -1254,6 +1296,7 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>   }
>   
>   static const struct dma_map_ops iommu_dma_ops = {
> +	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
>   	.alloc_pages		= dma_common_alloc_pages,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
