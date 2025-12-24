Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149C1B0439;
	Wed, 24 Dec 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566310; cv=none; b=QAn6hMFdHAObY01k16xZjzbPH5wq5g9mVP/rdCpSnughqfI0erJXSHAOcWoLD5keXZG6KE9NykHpOxBcj7EEnkieNOhqWFLuQRWCOZJubMbX5VCpur+dEc6Wz6kvmHuAd7KfWp932tXyym+9xX9c+3M4I5ZwK7WSNgNbYDBy4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566310; c=relaxed/simple;
	bh=osSxWKMQD1SgL//TLq1RgpcwAQn0OsX+KRWVMJlqULg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjDO3Xx7/YftJrmzgqFn/dC9HB8PQCyBFvczeyYpE8RsonQNdYHEy7UC5phOKpwGuOhbwyRXPHZPy2pYgwdu8uAKKJoZnvtzRYPu0OTaa87G2b3IBH/Vc0xEhQkMExWPGqD+lq2BUTtaSDoO1s4o2Ma3ABTKYSlV9IvjoEg6hNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLcHgzvP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLcHgzvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70182C4CEFB;
	Wed, 24 Dec 2025 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766566310;
	bh=osSxWKMQD1SgL//TLq1RgpcwAQn0OsX+KRWVMJlqULg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLcHgzvP8JL0/4YUAZblAESLRj8ckRBbAl6beqd2xmIL5og/6jq39IzHDHuYc7L0y
	 YuYhr7L41FjQGESGxB0dLUk70bWTCx99yMhFzPlPzEbK8/ujVO42Gy3z45iKIQOo5O
	 bWMuOey2+VqcvC9TG8QQ2qxwwX6ynq8qjkLlrX4EJV1QOpL23eW7d5J92zq5ejysxt
	 jPrE3Vql6KWGObuuBbFIaQTk6EpRSffs2+/soqS4/7jjZDDV883yiAyMPT1bDQNP8p
	 qxnJBSPlKC/iywgFCCuBVCndQu/0xtdd748K5cViHcnwU0zP0sClYg32/U01UkPXuI
	 APRrfRDrMujRQ==
Date: Wed, 24 Dec 2025 10:51:45 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org,
	catalin.marinas@arm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, maz@kernel.org, robin.murphy@arm.com,
	ryan.roberts@arm.com, surenb@google.com, v-songbaohua@oppo.com,
	will@kernel.org, zhengtangquan@oppo.com
Subject: Re: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if
 supported by the arch
Message-ID: <20251224085145.GF11869@unreal>
References: <20251221115523.GI13030@unreal>
 <20251221192458.1320-1-21cnbao@gmail.com>
 <20251222084921.GA13529@unreal>
 <CAGsJ_4yuvHNqHDi8eN-8UoY2McoXUeCMmbjFAr=jSdv8GpGKeg@mail.gmail.com>
 <20251223141424.GB11869@unreal>
 <CAGsJ_4x9YOT2kG0iWz_5NzRVt2iDN9YeUTknZ2MKg7SwmOGOqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4x9YOT2kG0iWz_5NzRVt2iDN9YeUTknZ2MKg7SwmOGOqg@mail.gmail.com>

On Wed, Dec 24, 2025 at 02:29:13PM +1300, Barry Song wrote:
> On Wed, Dec 24, 2025 at 3:14 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Dec 23, 2025 at 01:02:55PM +1300, Barry Song wrote:
> > > On Mon, Dec 22, 2025 at 9:49 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Mon, Dec 22, 2025 at 03:24:58AM +0800, Barry Song wrote:
> > > > > On Sun, Dec 21, 2025 at 7:55 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > [...]
> > > > > > > +
> > > > > >
> > > > > > I'm wondering why you don't implement this batch‑sync support inside the
> > > > > > arch_sync_dma_*() functions. Doing so would minimize changes to the generic
> > > > > > kernel/dma/* code and reduce the amount of #ifdef‑based spaghetti.
> > > > > >
> > > > >
> > > > > There are two cases: mapping an sg list and mapping a single
> > > > > buffer. The former can be batched with
> > > > > arch_sync_dma_*_batch_add() and flushed via
> > > > > arch_sync_dma_batch_flush(), while the latter requires all work to
> > > > > be done inside arch_sync_dma_*(). Therefore,
> > > > > arch_sync_dma_*() cannot always batch and flush.
> > > >
> > > > Probably in all cases you can call the _batch_ variant, followed by _flush_,
> > > > even when handling a single page. This keeps the code consistent across all
> > > > paths. On platforms that do not support _batch_, the _flush_ operation will be
> > > > a NOP anyway.
> > >
> > > We have a lot of code outside kernel/dma that also calls
> > > arch_sync_dma_for_* such as arch/arm, arch/mips, drivers/xen,
> > > I guess we don’t want to modify so many things?
> >
> > Aren't they using internal, arch specific, arch_sync_dma_for_* implementations?
> 
> for arch/arm, arch/mips, they are arch-specific implementations.
> xen is an exception:

Right, and this is the only location outside of kernel/dma where you need to
invoke arch_sync_dma_flush().

> 
> static void xen_swiotlb_unmap_phys(struct device *hwdev, dma_addr_t dev_addr,
>                 size_t size, enum dma_data_direction dir, unsigned long attrs)
> {
>         phys_addr_t paddr = xen_dma_to_phys(hwdev, dev_addr);
>         struct io_tlb_pool *pool;
> 
>         BUG_ON(dir == DMA_NONE);
> 
>         if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
>                 if (pfn_valid(PFN_DOWN(dma_to_phys(hwdev, dev_addr))))
>                         arch_sync_dma_for_cpu(paddr, size, dir);
>                 else
>                         xen_dma_sync_for_cpu(hwdev, dev_addr, size, dir);
>         }
> 
>         /* NOTE: We use dev_addr here, not paddr! */
>         pool = xen_swiotlb_find_pool(hwdev, dev_addr);
>         if (pool)
>                 __swiotlb_tbl_unmap_single(hwdev, paddr, size, dir,
>                                            attrs, pool);
> }
> 
> >
> > >
> > > for kernel/dma, we have two "single" callers only:
> > > kernel/dma/direct.h, kernel/dma/swiotlb.c.  and they looks quite
> > > straightforward:
> > >
> > > static inline void dma_direct_sync_single_for_device(struct device *dev,
> > >                 dma_addr_t addr, size_t size, enum dma_data_direction dir)
> > > {
> > >         phys_addr_t paddr = dma_to_phys(dev, addr);
> > >
> > >         swiotlb_sync_single_for_device(dev, paddr, size, dir);
> > >
> > >         if (!dev_is_dma_coherent(dev))
> > >                 arch_sync_dma_for_device(paddr, size, dir);
> > > }
> > >
> > > I guess moving to arch_sync_dma_for_device_batch + flush
> > > doesn’t really look much better, does it?
> > >
> > > >
> > > > I would also rename arch_sync_dma_batch_flush() to arch_sync_dma_flush().
> > >
> > > Sure.
> > >
> > > >
> > > > You can also minimize changes in dma_direct_map_phys() too, by extending
> > > > it's signature to provide if flush is needed or not.
> > >
> > > Yes. I have
> > >
> > > static inline dma_addr_t __dma_direct_map_phys(struct device *dev,
> > >                 phys_addr_t phys, size_t size, enum dma_data_direction dir,
> > >                 unsigned long attrs, bool flush)
> >
> > My suggestion is to use it directly, without wrappers.
> >
> > >
> > > and two wrappers:
> > > static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> > >                 phys_addr_t phys, size_t size, enum dma_data_direction dir,
> > >                 unsigned long attrs)
> > > {
> > >         return __dma_direct_map_phys(dev, phys, size, dir, attrs, true);
> > > }
> > >
> > > static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *dev,
> > >                 phys_addr_t phys, size_t size, enum dma_data_direction dir,
> > >                 unsigned long attrs)
> > > {
> > >         return __dma_direct_map_phys(dev, phys, size, dir, attrs, false);
> > > }
> > >
> > > If you prefer exposing "flush" directly in dma_direct_map_phys()
> > > and updating its callers with flush=true, I think that’s fine.
> >
> > Yes
> >
> 
> OK. Could you take a look at [1] and see if any further
> improvements are needed before I send v2?

Everything looks ok, except these renames:
-			arch_sync_dma_for_cpu(paddr, sg->length, dir);
+			arch_sync_dma_for_cpu_batch_add(paddr, sg->length, dir);

Thanks

> 
> [1] https://lore.kernel.org/lkml/20251223023648.31614-1-21cnbao@gmail.com/
> 
> Thanks
> Barry
> 
