Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB84372
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 14:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C9DC433C7;
	Wed,  9 Aug 2023 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691592445;
	bh=VomkytXI8p5ZDy7aIFBaDoQO5+JY1tLyWAMjMMQ5sF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ueBgAbLUO176EmG8tDm6wy4qk/E4G0PmoQbNWC8N4lyG8nusAIel3SPmKd4+SmixL
	 orWyCDqwxYIMiRglqjM41stfde4kBQ589JNd65v6SidUYXT7JoJwaaaeVWHSVj7vuD
	 lIqS+o5LxNtaH8DkCvQJnIsksPMUIlAn67ZOptuAzP0EfMAdq1OPFJyST/GMIhX+8+
	 bXkOWGuzQAIl+Xq4eKoaFaJsSX+ozVAPm3yBzHhHX/KlTtyqP0g30IM34fKdQr2Ct7
	 OxrDTVRdgIwrRXSxbaFASfec6E1y7gXLIqf6ZPQk4RVlfb7wWVk8QM6SI9tPizIm8B
	 UIkqmp0n4FAHQ==
Date: Wed, 9 Aug 2023 15:47:21 +0100
From: Will Deacon <will@kernel.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 2/2] iommu: Extend LPAE page table format to support
 custom allocators
Message-ID: <20230809144720.GA4472@willie-the-truck>
References: <20230809121744.2341454-1-boris.brezillon@collabora.com>
 <20230809121744.2341454-3-boris.brezillon@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809121744.2341454-3-boris.brezillon@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 09, 2023 at 02:17:44PM +0200, Boris Brezillon wrote:
> We need that in order to implement the VM_BIND ioctl in the GPU driver
> targeting new Mali GPUs.
> 
> VM_BIND is about executing MMU map/unmap requests asynchronously,
> possibly after waiting for external dependencies encoded as dma_fences.
> We intend to use the drm_sched framework to automate the dependency
> tracking and VM job dequeuing logic, but this comes with its own set
> of constraints, one of them being the fact we are not allowed to
> allocate memory in the drm_gpu_scheduler_ops::run_job() to avoid this
> sort of deadlocks:
> 
> - VM_BIND map job needs to allocate a page table to map some memory
>   to the VM. No memory available, so kswapd is kicked
> - GPU driver shrinker backend ends up waiting on the fence attached to
>   the VM map job or any other job fence depending on this VM operation.
> 
> With custom allocators, we will be able to pre-reserve enough pages to
> guarantee the map/unmap operations we queued will take place without
> going through the system allocator. But we can also optimize
> allocation/reservation by not free-ing pages immediately, so any
> upcoming page table allocation requests can be serviced by some free
> page table pool kept at the driver level.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 50 +++++++++++++++++++++++-----------
>  drivers/iommu/io-pgtable.c     | 12 ++++++++
>  2 files changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 72dcdd468cf3..c5c04f0106f3 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -188,20 +188,28 @@ static dma_addr_t __arm_lpae_dma_addr(void *pages)
>  }
>  
>  static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
> -				    struct io_pgtable_cfg *cfg)
> +				    struct io_pgtable_cfg *cfg,
> +				    void *cookie)
>  {
>  	struct device *dev = cfg->iommu_dev;
>  	int order = get_order(size);
> -	struct page *p;
>  	dma_addr_t dma;
>  	void *pages;
>  
>  	VM_BUG_ON((gfp & __GFP_HIGHMEM));
> -	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
> -	if (!p)
> +
> +	if (cfg->alloc) {
> +		pages = cfg->alloc(cookie, size, gfp | __GFP_ZERO);
> +	} else {
> +		struct page *p;
> +
> +		p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
> +		pages = p ? page_address(p) : NULL;

Hmm, so the reason we pass the order is because the pgd may have
additional alignment requirements but that's not passed back to your new
allocation hook. Does it just return naturally aligned allocations?

If you don't care about the pgd (since it's not something that's going
to be freed and reallocated during the lifetime of the page-table), then
perhaps it would be cleaner to pass in a 'struct kmem_cache' for the
non-pgd pages when configuring the page-table, rather than override the
allocation function wholesale? I think that would also mean that all the
lowmem assumptions in the code (e.g. use of virt_to_phys()) would be a
little less fragile.

Will
