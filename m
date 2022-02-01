Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96CBC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Feb 2022 20:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57A5A40360;
	Tue,  1 Feb 2022 20:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nFhxi1JoPpuv; Tue,  1 Feb 2022 20:59:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B23C1400CC;
	Tue,  1 Feb 2022 20:59:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B3ACC0011;
	Tue,  1 Feb 2022 20:59:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD3DC000B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 20:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46B384019F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 20:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sKOHjbPw-JEK for <iommu@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 20:59:50 +0000 (UTC)
X-Greylist: delayed 00:05:55 by SQLgrey-1.8.0
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CA55400CC
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 20:59:50 +0000 (UTC)
Message-ID: <6c939012-8d68-fbb5-50c6-3fe757a31b48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1643748831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjGXGyT9cU0n88J7maIkJMH0XpBuCFLksmeoO/eBSow=;
 b=QTVQqbWi2zRhOrtcUNxVvD5Rr3ibsGYLNahCRh6KCqybWlqpWImikBdcTwRBGh/fr30CNv
 QCTUATONgqLyqdkR0WxFdVuliEmbtGno10MNUBqi36vEqnMWRyfJ0Okw9E5DXNzvNVS5pg
 NxQV4d29alWIb4bQl861vP8Q04uHK0A=
Date: Tue, 1 Feb 2022 13:53:45 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 08/24] dma-direct: support PCI P2PDMA pages in
 dma-direct map_sg
Content-Language: en-US
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-9-logang@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220128002614.6136-9-logang@deltatee.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
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



On 1/27/2022 5:25 PM, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> A P2PDMA page may have three possible outcomes when being mapped:
>    1) If the data path between the two devices doesn't go through the
>       root port, then it should be mapped with a PCI bus address
>    2) If the data path goes through the host bridge, it should be mapped
>       normally, as though it were a CPU physical address
>    3) It is not possible for the two devices to communicate and thus
>       the mapping operation should fail (and it will return -EREMOTEIO).
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_dma_mark_pci_p2pdma() and are ignored when unmapped.
> 
> P2PDMA mappings are also failed if swiotlb needs to be used on the
> mapping.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   kernel/dma/direct.c | 43 +++++++++++++++++++++++++++++++++++++------
>   kernel/dma/direct.h |  7 ++++++-
>   2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 50f48e9e4598..975df5f3aaf9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -461,29 +461,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>   		arch_sync_dma_for_cpu_all();
>   }
>   
> +/*
> + * Unmaps segments, except for ones marked as pci_p2pdma which do not
> + * require any further action as they contain a bus address.
> + */
>   void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sg(sgl, sg, nents, i)
> -		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
> -			     attrs);
> +	for_each_sg(sgl,  sg, nents, i) {
> +		if (sg_is_dma_bus_address(sg))
> +			sg_dma_unmark_bus_address(sg);
> +		else
> +			dma_direct_unmap_page(dev, sg->dma_address,
> +					      sg_dma_len(sg), dir, attrs);
> +	}
>   }
>   #endif
>   
>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
> -	int i;
> +	struct pci_p2pdma_map_state p2pdma_state = {};
> +	enum pci_p2pdma_map_type map;
>   	struct scatterlist *sg;
> +	int i, ret;
>   
>   	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
> +			switch (map) {
> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				/*
> +				 * Any P2P mapping that traverses the PCI
> +				 * host bridge must be mapped with CPU physical
> +				 * address and not PCI bus addresses. This is
> +				 * done with dma_direct_map_page() below.
> +				 */
> +				break;
> +			default:
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +		}
I'm a little confused about this code. Would there be a case where the mapping needs
to be checked for each sg in the list? And if some sg in the sgl can be mapped
differently, would we want to continue checking the rest of the sg in the sgl instead
of breaking out of the loop completely?

> +
>   		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>   				sg->offset, sg->length, dir, attrs);
> -		if (sg->dma_address == DMA_MAPPING_ERROR)
> +		if (sg->dma_address == DMA_MAPPING_ERROR) {
> +			ret = -EIO;
>   			goto out_unmap;
> +		}
>   		sg_dma_len(sg) = sg->length;
>   	}
>   
> @@ -491,7 +522,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   
>   out_unmap:
>   	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -	return -EIO;
> +	return ret;
>   }
>   
>   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 4632b0f4f72e..a33152d79069 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -87,10 +87,15 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
>   	phys_addr_t phys = page_to_phys(page) + offset;
>   	dma_addr_t dma_addr = phys_to_dma(dev, phys);
>   
> -	if (is_swiotlb_force_bounce(dev))
> +	if (is_swiotlb_force_bounce(dev)) {
> +		if (is_pci_p2pdma_page(page))
> +			return DMA_MAPPING_ERROR;
>   		return swiotlb_map(dev, phys, size, dir, attrs);
> +	}
>   
>   	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> +		if (is_pci_p2pdma_page(page))
> +			return DMA_MAPPING_ERROR;
>   		if (swiotlb_force != SWIOTLB_NO_FORCE)
>   			return swiotlb_map(dev, phys, size, dir, attrs);
>   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
