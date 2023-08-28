Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5F46BA
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 12:50:37 +0000 (UTC)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0CB8E6606F65;
	Mon, 28 Aug 2023 13:50:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1693227030;
	bh=GkpZeQilxq8R388KfsSV/l5gzxmSC4ts/lkZ0IWgnf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=alNZHdPivwsLQFeRUo7I8JqaBaLtaqIBLFQ+52MtLBxKYDsNqSeFk5xUTawPJVxc/
	 dV3i4qlntm7rLodSlTKHIUs2gRGNy47Vkboy20eNXFI1WWK4YWYqKVANBmAT4o2Yoe
	 FLkZx9aHAWaYe//nn4nnTP/hO+DPR9VjyuDEvb+QZTXvis4lXK04b/Mkmmb653vgv2
	 VmDPRMtpiAqyXbXlbtQabi0ynFEW+y2EGbkUEoedKTnbvJUikmyk3e9e1uOQ7en5BM
	 wiwCaFmaE6EZJQxzxs/DnSnDySmD+NyF+oFkhRYhSVUO+MAn8leyCS5DL+ywh7W90b
	 m9NTQvUXBI2PQ==
Date: Mon, 28 Aug 2023 14:50:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, Rob Clark
 <robdclark@gmail.com>
Subject: Re: [PATCH 2/2] iommu: Extend LPAE page table format to support
 custom allocators
Message-ID: <20230828145027.4d2edb19@collabora.com>
In-Reply-To: <20230809171017.64409d60@collabora.com>
References: <20230809121744.2341454-1-boris.brezillon@collabora.com>
	<20230809121744.2341454-3-boris.brezillon@collabora.com>
	<20230809144720.GA4472@willie-the-truck>
	<20230809171017.64409d60@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Aug 2023 17:10:17 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Wed, 9 Aug 2023 15:47:21 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > On Wed, Aug 09, 2023 at 02:17:44PM +0200, Boris Brezillon wrote:  
> > > We need that in order to implement the VM_BIND ioctl in the GPU driver
> > > targeting new Mali GPUs.
> > > 
> > > VM_BIND is about executing MMU map/unmap requests asynchronously,
> > > possibly after waiting for external dependencies encoded as dma_fences.
> > > We intend to use the drm_sched framework to automate the dependency
> > > tracking and VM job dequeuing logic, but this comes with its own set
> > > of constraints, one of them being the fact we are not allowed to
> > > allocate memory in the drm_gpu_scheduler_ops::run_job() to avoid this
> > > sort of deadlocks:
> > > 
> > > - VM_BIND map job needs to allocate a page table to map some memory
> > >   to the VM. No memory available, so kswapd is kicked
> > > - GPU driver shrinker backend ends up waiting on the fence attached to
> > >   the VM map job or any other job fence depending on this VM operation.
> > > 
> > > With custom allocators, we will be able to pre-reserve enough pages to
> > > guarantee the map/unmap operations we queued will take place without
> > > going through the system allocator. But we can also optimize
> > > allocation/reservation by not free-ing pages immediately, so any
> > > upcoming page table allocation requests can be serviced by some free
> > > page table pool kept at the driver level.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > >  drivers/iommu/io-pgtable-arm.c | 50 +++++++++++++++++++++++-----------
> > >  drivers/iommu/io-pgtable.c     | 12 ++++++++
> > >  2 files changed, 46 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > > index 72dcdd468cf3..c5c04f0106f3 100644
> > > --- a/drivers/iommu/io-pgtable-arm.c
> > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > @@ -188,20 +188,28 @@ static dma_addr_t __arm_lpae_dma_addr(void *pages)
> > >  }
> > >  
> > >  static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
> > > -				    struct io_pgtable_cfg *cfg)
> > > +				    struct io_pgtable_cfg *cfg,
> > > +				    void *cookie)
> > >  {
> > >  	struct device *dev = cfg->iommu_dev;
> > >  	int order = get_order(size);
> > > -	struct page *p;
> > >  	dma_addr_t dma;
> > >  	void *pages;
> > >  
> > >  	VM_BUG_ON((gfp & __GFP_HIGHMEM));
> > > -	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
> > > -	if (!p)
> > > +
> > > +	if (cfg->alloc) {
> > > +		pages = cfg->alloc(cookie, size, gfp | __GFP_ZERO);
> > > +	} else {
> > > +		struct page *p;
> > > +
> > > +		p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
> > > +		pages = p ? page_address(p) : NULL;    
> > 
> > Hmm, so the reason we pass the order is because the pgd may have
> > additional alignment requirements but that's not passed back to your new
> > allocation hook. Does it just return naturally aligned allocations?  
> 
> So, the assumption was that the custom allocator should be aware of
> these alignment constraints. Like, if size > min_granule_sz, then order
> equal get_order(size).
> 
> Right now, I reject any size that's not SZ_4K, because, given the
> VA-space and the pgtable config, I know I'll always end up with 4
> levels and the pgd will fit in a 4k page. But if we ever decide we want
> to support 64k granule or a VA space that's smaller, we'll adjust the
> custom allocator accordingly.
> 
> I'm not sure we discussed this specific aspect with Robin, but his
> point was that the user passing a custom allocator should be aware of
> the page table format and all the allocation constraints that come with
> it.
> 
> > 
> > If you don't care about the pgd (since it's not something that's going
> > to be freed and reallocated during the lifetime of the page-table), then
> > perhaps it would be cleaner to pass in a 'struct kmem_cache' for the
> > non-pgd pages when configuring the page-table, rather than override the
> > allocation function wholesale?  
> 
> I'd be fine with that, but I wasn't sure every one would be okay to use
> a kmem_cache as the page caching mechanism.

My bad, I still need the custom allocator hooks so I can pre-allocate
pages and make sure no allocation happens in the page table update
path (dma-signaling path where no blocking allocations are allowed). I
might be wrong, but I don't think kmem_cache provides such a
reservation mechanism.

> I know Rob was intending to
> use a custom allocator with the MSM MMU to provide the same sort of
> caching for the Adreno GPU driver, so it might be good to have his
> opinion on that.
> 
> > I think that would also mean that all the
> > lowmem assumptions in the code (e.g. use of virt_to_phys()) would be a
> > little less fragile.  
> 
> Well, that would only help if a custom kmem_cache is used, unless you
> want to generalize the kmem_cache approach and force it to all
> io-pgtable-arm users, in which case I probably don't need to pass a
> custom kmem_cache in the first place (mine has nothing special).

