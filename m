From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] dma-debug: fix incorrect pfn calculation
Date: Sun, 1 Oct 2017 10:04:49 +0200
Message-ID: <20171001080449.GB11843@lst.de>
References: <1506484087-1177-1-git-send-email-miles.chen@mediatek.com> <273077fd-c5ad-82c8-60aa-cde89355e5e8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <273077fd-c5ad-82c8-60aa-cde89355e5e8@arm.com>
Sender: owner-linux-mm@kvack.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: miles.chen@mediatek.com, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 27, 2017 at 11:23:52AM +0100, Robin Murphy wrote:
> > I found that debug_dma_alloc_coherent() and debug_dma_free_coherent()
> > assume that dma_alloc_coherent() always returns a linear address.
> > However it's possible that dma_alloc_coherent() returns a non-linear
> > address. In this case, page_to_pfn(virt_to_page(virt)) will return an
> > incorrect pfn. If the pfn is valid and mapped as a COW page,
> > we will hit the warning when doing wp_page_copy().

Hmm, can the debug code assume anything?  Right now you're just patching
it from supporting linear and vmalloc.  But what about other
potential mapping types?

> > +	entry->pfn	 = is_vmalloc_addr(virt) ? vmalloc_to_pfn(virt) :
> > +						page_to_pfn(virt_to_page(virt));

Please use normal if/else conditionsals:

	if (is_vmalloc_addr(virt))
		entry->pfn = vmalloc_to_pfn(virt);
	else
		entry->pfn = page_to_pfn(virt_to_page(virt));

> > +		.pfn		= is_vmalloc_addr(virt) ? vmalloc_to_pfn(virt) :
> > +						page_to_pfn(virt_to_page(virt)),

Same here.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
