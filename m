From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
Date: Tue, 4 Dec 2018 15:22:16 +0100
Message-ID: <20181204142216.GB2618@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-5-hch@lst.de> <20181204100954.GN30658@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204100954.GN30658@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

> > +int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
> > +{
> > +	unsigned int pool_size_order = get_order(atomic_pool_size);
> > +	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
> > +	struct page *page;
> > +	void *addr;
> > +	int ret;
> > +
> > +	if (dev_get_cma_area(NULL))
> > +		page = dma_alloc_from_contiguous(NULL, nr_pages,
> > +						 pool_size_order, false);
> > +	else
> > +		page = alloc_pages(gfp, pool_size_order);
> > +	if (!page)
> > +		goto out;
> > +
> > +	memset(page_address(page), 0, atomic_pool_size);
> 
> Note that this won't work if 'page' is a highmem page - should there
> be a check for that, or a check for the gfp flags?
>
> Also, is this memset() actually useful, or a waste of cycles - when we
> allocate from this pool (see dma_alloc_from_pool()), we always memset()
> the buffer.

Currently there is no user that supports highmem, but yes, the memset
should probably simply be removed.
