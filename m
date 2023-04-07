Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9877B
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 05:55:53 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9128F68AA6; Fri,  7 Apr 2023 07:55:48 +0200 (CEST)
Date: Fri, 7 Apr 2023 07:55:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Kim Phillips <kim.phillips@amd.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz,
	Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce
 buffers
Message-ID: <20230407055548.GC6803@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com> <20230328040724.GB25506@lst.de> <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 28, 2023 at 09:54:35AM +0200, Petr Tesarik wrote:
> I tend to agree here. However, it's the DMABUF design itself that causes
> some trouble. The buffer is allocated by the v3d driver, which does not
> have the restriction, so the DMA API typically allocates an address
> somewhere near the 4G boundary. Userspace then exports the buffer, sends
> it to another process as a file descriptor and imports it into the vc4
> driver, which requires DMA below 1G. In the beginning, v3d had no idea
> that the buffer would be exported to userspace, much less that it would
> be later imported into vc4.

Then we need to either:

 a) figure out a way to communicate these addressing limitations
 b) find a way to migrate a buffer into other memory, similar to
    how page migration works for page cache

> BTW my testing also suggests that the streaming DMA API is quite
> inefficient, because UAS performance _improved_ with swiotlb=force.
> Sure, this should probably be addressed in the UAS and/or xHCI driver,
> but what I mean is that moving away from swiotlb may even cause
> performance regressions, which is counter-intuitive. At least I would
> _not_ have expected it.

That is indeed very odd.  Are you running with a very slow iommu
driver there?   Or what is the actual use case there in general?

> >> +	gfp = (attrs & DMA_ATTR_MAY_SLEEP) ? GFP_KERNEL : GFP_NOWAIT;
> >> +	slot = kmalloc(sizeof(*slot), gfp | __GFP_NOWARN);
> >> +	if (!slot)
> >> +		goto err;
> >> +
> >> +	slot->orig_addr = orig_addr;
> >> +	slot->alloc_size = alloc_size;
> >> +	slot->page = dma_direct_alloc_pages(dev, PAGE_ALIGN(alloc_size),
> >> +					    &slot->dma_addr, dir,
> >> +					    gfp | __GFP_NOWARN);
> >> +	if (!slot->page)
> >> +		goto err_free_slot;
> > 
> > Without GFP_NOIO allocations this will deadlock eventually.
> 
> Ah, that would affect the non-sleeping case (GFP_KERNEL), right?

Yes.
