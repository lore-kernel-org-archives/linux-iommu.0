Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC0C433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 12:48:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4BE2337F
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 12:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4BE2337F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 85246871B0;
	Wed, 13 Jan 2021 12:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ybR9Tsd6P4dr; Wed, 13 Jan 2021 12:48:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5BE3887196;
	Wed, 13 Jan 2021 12:48:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DD84C088B;
	Wed, 13 Jan 2021 12:48:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75F0BC013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 12:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 69AD986422
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 12:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xfz_VT1S8uio for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 12:48:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D5DA885815
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 12:48:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id D787F68AFE; Wed, 13 Jan 2021 13:48:47 +0100 (CET)
Date: Wed, 13 Jan 2021 13:48:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [RFC PATCH v3 4/6] swiotlb: Add restricted DMA alloc/free support.
Message-ID: <20210113124847.GC1383@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-5-tientzu@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-5-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 frowand.list@gmail.com, mingo@kernel.org, sstabellini@kernel.org,
 saravanak@google.com, mpe@ellerman.id.au, rafael.j.wysocki@intel.com,
 hch@lst.de, bgolaszewski@baylibre.com, xen-devel@lists.xenproject.org,
 treding@nvidia.com, devicetree@vger.kernel.org, will@kernel.org,
 konrad.wilk@oracle.com, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org, boris.ostrovsky@oracle.com,
 andriy.shevchenko@linux.intel.com, jgross@suse.com, drinkcat@chromium.org,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 xypron.glpk@gmx.de, robin.murphy@arm.com
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

> +#ifdef CONFIG_SWIOTLB
> +	if (unlikely(dev->dma_io_tlb_mem))
> +		return swiotlb_alloc(dev, size, dma_handle, attrs);
> +#endif

Another place where the dma_io_tlb_mem is useful to avoid the ifdef.

> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
> -		size_t mapping_size, size_t alloc_size,
> -		enum dma_data_direction dir, unsigned long attrs)
> +static int swiotlb_tbl_find_free_region(struct device *hwdev,
> +					dma_addr_t tbl_dma_addr,
> +					size_t alloc_size,
> +					unsigned long attrs)

> +static void swiotlb_tbl_release_region(struct device *hwdev, int index,
> +				       size_t size)

This refactoring should be another prep patch.


> +void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		    unsigned long attrs)

I'd rather have the names convey there are for the per-device bounce
buffer in some form.

> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;

While we're at it I wonder if the io_tlb is something we could change
while we're at it.  Maybe replace io_tlb_mem with struct swiotlb
and rename the field in struct device to dev_swiotlb?

> +	int index;
> +	void *vaddr;
> +	phys_addr_t tlb_addr;
> +
> +	size = PAGE_ALIGN(size);
> +	index = swiotlb_tbl_find_free_region(dev, mem->start, size, attrs);
> +	if (index < 0)
> +		return NULL;
> +
> +	tlb_addr = mem->start + (index << IO_TLB_SHIFT);
> +	*dma_handle = phys_to_dma_unencrypted(dev, tlb_addr);
> +
> +	if (!dev_is_dma_coherent(dev)) {
> +		unsigned long pfn = PFN_DOWN(tlb_addr);
> +
> +		/* remove any dirty cache lines on the kernel alias */
> +		arch_dma_prep_coherent(pfn_to_page(pfn), size);

Can we hook in somewhat lower level in the dma-direct code so that all
the remapping in dma-direct can be reused instead of duplicated?  That
also becomes important if we want to use non-remapping uncached support,
e.g. on mips or x86, or the direct changing of the attributes that Will
planned to look into for arm64.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
