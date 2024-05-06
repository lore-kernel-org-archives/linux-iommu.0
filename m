Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467F154C0A
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009773; cv=none; b=SvcXAlPRjj7L2vkzgqPbkuSG+zCZxRr2jbNlZyH6nX3e1VFoE9UOJSgzoLFfYtWQa8owSgRGPcJIGllfpAx3LkUwBxHZtb7YpmaeFNzmjwqtUVPJJ4pRA7xIic8h4UJbJCUswiC06e1OEKBwh1cgWST2prkIXmsvSOcfVdUWMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009773; c=relaxed/simple;
	bh=e68Yh+Qg1Ps+MpD/PAzJroVMEEiFCIXpACgS1u8PGTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m57JAIsmF0Xg6sv1DY9oE+jHgd0hyoY0BMKzus982PqEWMuiJbb1BQUEfRNxxSDcFC7fN1nN+ssLRYmtBPXaMvgUb72uCw+u32th1LvhK5PNU4f3elSA8Klf00tFB6VL0PoiVtvS+UTYmGQSx/3AyELKQnMeaiyY7zYaZLUOHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=KcBAbNef; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="KcBAbNef"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id D62611BDAD9;
	Mon,  6 May 2024 17:36:00 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1715009761; bh=9PdFWcg++iSIYS3ak0VBMnwVN/MLlIYFQAFux6B9M38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KcBAbNefOP2c7ZBclkQ0mP2koZWxiiEgG54z7TjRE3kn1ciXZjNVMinJ0QM6v7imM
	 69s4to8n1w3lSbYPyAowkec/10OMBgLg5/mJ3iyYZMBg8L7/BXCbiLgc35Jjtvuqy/
	 nE7VY+E43DBKSMEjKz49KG1WgtzTERR/hYWsLVbkR21NVXyAwP36vQxLmsGV7NYv8H
	 jieXogVsQ03aNtm786Z6uM6pjSEnIxKmRZCKo/vNDZTCO8JbCQTI+SykDqa4rJb/cG
	 uHAm/XWiDFIBhc5+aO3W/Od2xsxcArsLmWPAU1hvQn4uE+2sQ9I8ct4moR9zCaxW7t
	 yvumtk7HqmKBg==
Date: Mon, 6 May 2024 17:35:59 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jgross@suse.com"
 <jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "roberto.sassu@huaweicloud.com"
 <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH 1/2] swiotlb: Remove alloc_size argument to
 swiotlb_tbl_map_single()
Message-ID: <20240506173559.4e9af047@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB4157FD86DFB5E305836EF209D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240408041142.665563-1-mhklinux@outlook.com>
	<SN6PR02MB4157FD86DFB5E305836EF209D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 15:14:05 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: mhkelley58@gmail.com <mhkelley58@gmail.com>
> >   
> 
> Gentle ping ...
> 
> Anyone interested in reviewing this series of two patches?  It fixes
> an edge case bug in the size of the swiotlb request coming from
> dma-iommu, and plugs a hole that allows untrusted devices to see
> kernel data unrelated to the intended DMA transfer.  I think these are
> the last "known bugs" that came out of the extensive swiotlb discussion
> and patches for 6.9.
> 
> Michael
> 
> > Currently swiotlb_tbl_map_single() takes alloc_align_mask and
> > alloc_size arguments to specify an swiotlb allocation that is
> > larger than mapping_size. This larger allocation is used solely
> > by iommu_dma_map_single() to handle untrusted devices that should
> > not have DMA visibility to memory pages that are partially used
> > for unrelated kernel data.
> > 
> > Having two arguments to specify the allocation is redundant. While
> > alloc_align_mask naturally specifies the alignment of the starting
> > address of the allocation, it can also implicitly specify the size
> > by rounding up the mapping_size to that alignment.
> > 
> > Additionally, the current approach has an edge case bug.
> > iommu_dma_map_page() already does the rounding up to compute the
> > alloc_size argument. But swiotlb_tbl_map_single() then calculates
> > the alignment offset based on the DMA min_align_mask, and adds
> > that offset to alloc_size. If the offset is non-zero, the addition
> > may result in a value that is larger than the max the swiotlb can
> > allocate. If the rounding up is done _after_ the alignment offset is
> > added to the mapping_size (and the original mapping_size conforms to
> > the value returned by swiotlb_max_mapping_size), then the max that the
> > swiotlb can allocate will not be exceeded.
> > 
> > In view of these issues, simplify the swiotlb_tbl_map_single() interface
> > by removing the alloc_size argument. Most call sites pass the same
> > value for mapping_size and alloc_size, and they pass alloc_align_mask
> > as zero. Just remove the redundant argument from these callers, as they
> > will see no functional change. For iommu_dma_map_page() also remove
> > the alloc_size argument, and have swiotlb_tbl_map_single() compute
> > the alloc_size by rounding up mapping_size after adding the offset
> > based on min_align_mask. This has the side effect of fixing the
> > edge case bug but with no other functional change.
> > 
> > Also add a sanity test on the alloc_align_mask. While IOMMU code
> > currently ensures the granule is not larger than PAGE_SIZE, if
> > that guarantee were to be removed in the future, the downstream
> > effect on the swiotlb might go unnoticed until strange allocation
> > failures occurred.
> > 
> > Tested on an ARM64 system with 16K page size and some kernel
> > test-only hackery to allow modifying the DMA min_align_mask and
> > the granule size that becomes the alloc_align_mask. Tested these
> > combinations with a variety of original memory addresses and
> > sizes, including those that reproduce the edge case bug:
> > 
> > * 4K granule and 0 min_align_mask
> > * 4K granule and 0xFFF min_align_mask (4K - 1)
> > * 16K granule and 0xFFF min_align_mask
> > * 64K granule and 0xFFF min_align_mask
> > * 64K granule and 0x3FFF min_align_mask (16K - 1)
> > 
> > With the changes, all combinations pass.
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Looks good to me. My previous discussion was not related to this
change; I was merely trying to find an answer to your question whether
anything else should be changed, and IIUC the result was that not.

Reviewed-by: Petr Tesarik <petr@tesarici.cz>

Petr T

> > ---
> > I've haven't used any "Fixes:" tags. This patch really should be
> > backported only if all the other recent swiotlb fixes get backported,
> > and I'm unclear on whether that will happen.
> > 
> > I saw the brief discussion about removing the "dir" parameter from
> > swiotlb_tbl_map_single(). That removal could easily be done as part
> > of this patch, since it's already changing the swiotlb_tbl_map_single()
> > parameters. But I think the conclusion of the discussion was to leave
> > the "dir" parameter for symmetry with the swiotlb_sync_*() functions.
> > Please correct me if that's wrong, and I'll respin this patch to do
> > the removal.
> > 
> >  drivers/iommu/dma-iommu.c |  2 +-
> >  drivers/xen/swiotlb-xen.c |  2 +-
> >  include/linux/swiotlb.h   |  2 +-
> >  kernel/dma/swiotlb.c      | 56 +++++++++++++++++++++++++++++----------
> >  4 files changed, 45 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 07d087eecc17..c21ef1388499 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1165,7 +1165,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >  		trace_swiotlb_bounced(dev, phys, size);
> > 
> >  		aligned_size = iova_align(iovad, size);
> > -		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
> > +		phys = swiotlb_tbl_map_single(dev, phys, size,
> >  					      iova_mask(iovad), dir, attrs);
> > 
> >  		if (phys == DMA_MAPPING_ERROR)
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index 1c4ef5111651..6579ae3f6dac 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -216,7 +216,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
> >  	 */
> >  	trace_swiotlb_bounced(dev, dev_addr, size);
> > 
> > -	map = swiotlb_tbl_map_single(dev, phys, size, size, 0, dir, attrs);
> > +	map = swiotlb_tbl_map_single(dev, phys, size, 0, dir, attrs);
> >  	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
> >  		return DMA_MAPPING_ERROR;
> > 
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index ea23097e351f..14bc10c1bb23 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -43,7 +43,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
> >  extern void __init swiotlb_update_mem_attributes(void);
> > 
> >  phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
> > -		size_t mapping_size, size_t alloc_size,
> > +		size_t mapping_size,
> >  		unsigned int alloc_aligned_mask, enum dma_data_direction dir,
> >  		unsigned long attrs);
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index a5e0dfc44d24..046da973a7e2 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -1340,15 +1340,40 @@ static unsigned long mem_used(struct io_tlb_mem
> > *mem)
> > 
> >  #endif /* CONFIG_DEBUG_FS */
> > 
> > +/**
> > + * swiotlb_tbl_map_single() - bounce buffer map a single contiguous physical area
> > + * @dev:		Device which maps the buffer.
> > + * @orig_addr:		Original (non-bounced) physical IO buffer address
> > + * @mapping_size:	Requested size of the actual bounce buffer, excluding
> > + *			any pre- or post-padding for alignment
> > + * @alloc_align_mask:	Required start and end alignment of the allocated buffer
> > + * @dir:		DMA direction
> > + * @attrs:		Optional DMA attributes for the map operation
> > + *
> > + * Find and allocate a suitable sequence of IO TLB slots for the request.
> > + * The allocated space starts at an alignment specified by alloc_align_mask,
> > + * and the size of the allocated space is rounded up so that the total amount
> > + * of allocated space is a multiple of (alloc_align_mask + 1). If
> > + * alloc_align_mask is zero, the allocated space may be at any alignment and
> > + * the size is not rounded up.
> > + *
> > + * The returned address is within the allocated space and matches the bits
> > + * of orig_addr that are specified in the DMA min_align_mask for the device. As
> > + * such, this returned address may be offset from the beginning of the allocated
> > + * space. The bounce buffer space starting at the returned address for
> > + * mapping_size bytes is initialized to the contents of the original IO buffer
> > + * area. Any pre-padding (due to an offset) and any post-padding (due to
> > + * rounding-up the size) is not initialized.
> > + */
> >  phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> > -		size_t mapping_size, size_t alloc_size,
> > -		unsigned int alloc_align_mask, enum dma_data_direction dir,
> > -		unsigned long attrs)
> > +		size_t mapping_size, unsigned int alloc_align_mask,
> > +		enum dma_data_direction dir, unsigned long attrs)
> >  {
> >  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> >  	unsigned int offset;
> >  	struct io_tlb_pool *pool;
> >  	unsigned int i;
> > +	size_t size;
> >  	int index;
> >  	phys_addr_t tlb_addr;
> >  	unsigned short pad_slots;
> > @@ -1362,20 +1387,24 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> >  		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
> > 
> > -	if (mapping_size > alloc_size) {
> > -		dev_warn_once(dev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
> > -			      mapping_size, alloc_size);
> > -		return (phys_addr_t)DMA_MAPPING_ERROR;
> > -	}
> > +	/*
> > +	 * The default swiotlb memory pool is allocated with PAGE_SIZE
> > +	 * alignment. If a mapping is requested with larger alignment,
> > +	 * the mapping may be unable to use the initial slot(s) in all
> > +	 * sets of IO_TLB_SEGSIZE slots. In such case, a mapping request
> > +	 * of or near the maximum mapping size would always fail.
> > +	 */
> > +	dev_WARN_ONCE(dev, alloc_align_mask > ~PAGE_MASK,
> > +		"Alloc alignment may prevent fulfilling requests with max mapping_size\n");
> > 
> >  	offset = swiotlb_align_offset(dev, alloc_align_mask, orig_addr);
> > -	index = swiotlb_find_slots(dev, orig_addr,
> > -				   alloc_size + offset, alloc_align_mask, &pool);
> > +	size = ALIGN(mapping_size + offset, alloc_align_mask + 1);
> > +	index = swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &pool);
> >  	if (index == -1) {
> >  		if (!(attrs & DMA_ATTR_NO_WARN))
> >  			dev_warn_ratelimited(dev,
> >  	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
> > -				 alloc_size, mem->nslabs, mem_used(mem));
> > +				 size, mem->nslabs, mem_used(mem));
> >  		return (phys_addr_t)DMA_MAPPING_ERROR;
> >  	}
> > 
> > @@ -1388,7 +1417,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >  	offset &= (IO_TLB_SIZE - 1);
> >  	index += pad_slots;
> >  	pool->slots[index].pad_slots = pad_slots;
> > -	for (i = 0; i < nr_slots(alloc_size + offset); i++)
> > +	for (i = 0; i < (nr_slots(size) - pad_slots); i++)
> >  		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
> >  	tlb_addr = slot_addr(pool->start, index) + offset;
> >  	/*
> > @@ -1543,8 +1572,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
> > 
> >  	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
> > 
> > -	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, 0, dir,
> > -			attrs);
> > +	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
> >  	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
> >  		return DMA_MAPPING_ERROR;
> > 
> > --
> > 2.25.1
> >   
> 

