From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 3/6] iommu: add ARM short descriptor page table
 allocator.
Date: Wed, 21 Oct 2015 18:34:08 +0800
Message-ID: <1445423648.27202.52.camel@mhfsdcap03>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
	 <1438597279-2937-4-git-send-email-yong.wu@mediatek.com>
	 <20150916155824.GM28771@arm.com> <1442501662.8145.151.camel@mhfsdcap03>
	 <1442931167.17514.39.camel@mhfsdcap03> <20151009155750.GS26278@arm.com>
	 <5617FC5F.60505@arm.com> <20151009181929.GU26278@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151009181929.GU26278-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-10-09 at 19:19 +0100, Will Deacon wrote:
> On Fri, Oct 09, 2015 at 06:41:51PM +0100, Robin Murphy wrote:
> > On 09/10/15 16:57, Will Deacon wrote:
> > >On Tue, Sep 22, 2015 at 03:12:47PM +0100, Yong Wu wrote:
> > >>      I would like to show you a problem I met, The recursion here may
> > >>lead to stack overflow while we test FHD video decode.
> > >>
> > >>     From the log, I get the internal variable in the error case: the
> > >>"size" is 0x100000, the "iova" is 0xfea00000, but at that time the
> > >>"blk_size" is 0x1000 as it was the map of small-page. so it enter the
> > >>recursion here.
> > >>
> > >>     After check the unmap flow, there is only a iommu_unmap in
> > >>__iommu_dma_unmap, and it won't check the physical address align in
> > >>iommu_unmap.
> > >
> > >That sounds like a bug in __iommu_dma_unmap. Robin?
> > 
> > Isn't it just cf27ec930be9 again wearing different trousers? All I do is
> > call iommu_unmap with the same total size that was mapped originally.
> 
> I don't think it's the same as that issue, which was to do with installing
> block mappings over the top of an existing table entry. The problem here
> seems to be that we don't walk the page table properly on unmap.
> 
> The long descriptor code has:
> 
> 	/* If the size matches this level, we're in the right place */
> 	if (size == blk_size) {
> 		__arm_lpae_set_pte(ptep, 0, &data->iop.cfg);
> 
> 		if (!iopte_leaf(pte, lvl)) {
> 			/* Also flush any partial walks */
> 			tlb->tlb_add_flush(iova, size, false, cookie);
> 			tlb->tlb_sync(cookie);
> 			ptep = iopte_deref(pte, data);
> 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
> 		} else {
> 			tlb->tlb_add_flush(iova, size, true, cookie);
> 		}
> 
> 		return size;
> 	} else if (iopte_leaf(pte, lvl)) {
> 		/*
> 		 * Insert a table at the next level to map the old region,
> 		 * minus the part we want to unmap
> 		 */
> 		return arm_lpae_split_blk_unmap(data, iova, size,
> 						iopte_prot(pte), lvl, ptep,
> 						blk_size);
> 	}
> 
> why doesn't something similar work for short descriptors?
> 
> Will

Hi Will,

   There are some different between long and short descriptor, I can not
use it directly.

1. Long descriptor control the blk_size with 3 levels easily whose 
lvl1 is 4KB, lvl2 is 2MB and lvl3 is 1GB in stage 1. It have 3 levels
pagetable, then it use 3 levels block_size here. It is ok.

But I don't use the "level" in short descriptor. At the beginning of
designing short, I planned to use 4 levels whose lvl1 is 4KB, lvl2 is
64KB, lvl3 is 1MB, lvl4 is 16MB in short descriptor. then the code may
be more similar with long descriptor. But there is only 2 levels
pagetable in short. if we use 4 levels here, It may lead to
misunderstand. so I don't use the "level" and list the four case in map
and unmap.
(If you think short-descriptor could use 4 level like above, I can try
it.)

2. Following the unmap in long, if it's not a leaf, we free the
pagetable, then we can delete do-while. I have tested this:
 
//===========================
static int arm_short_unmap(struct io_pgtable_ops *ops,
			   unsigned long iova,
			   size_t size)
{
	struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
	struct io_pgtable_cfg *cfg = &data->iop.cfg;
	void *cookie = data->iop.cookie;
	arm_short_iopte *pgd, *pte = NULL;
	arm_short_iopte pgd_tmp, pte_tmp = 0;
	unsigned int blk_size = 0, blk_base;
	bool empty = false, split = false;
	int i;

	blk_size = arm_short_iova_to_blk_size(ops, iova);
	if (WARN_ON(!blk_size))
		return 0;

	blk_base = iova & ~(blk_size - 1);
	pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(blk_base);

	if (size == SZ_1M || size == SZ_16M) {/* section or supersection */
		for (i = 0; i < size/SZ_1M; i++, pgd++, blk_base += SZ_1M) {
			pgd_tmp = *pgd;
			__arm_short_set_pte(pgd, 0, 1, cfg);

			cfg->tlb->tlb_add_flush(blk_base, SZ_1M, true, cookie);
			cfg->tlb->tlb_sync(cookie);

			/* Lvl2 pgtable should be freed while current is pgtable */
			if (ARM_SHORT_PGD_TYPE_IS_PGTABLE(pgd_tmp))
				__arm_short_free_pgtable(
					ARM_SHORT_GET_PGTABLE_VA(pgd_tmp),
					ARM_SHORT_BYTES_PER_PTE, false, cfg);

			/* Split is needed while unmap 1M in supersection */
			if (size == SZ_1M && blk_size == SZ_16M)
				split = true;
		}
	} else if (size == SZ_4K || size == SZ_64K) {/* page or large page */
		pgd_tmp = *pgd;

		/* Unmap the current node */
		if (blk_size == SZ_4K || blk_size == SZ_64K) {
			pte = arm_short_get_pte_in_pgd(*pgd, blk_base);
			pte_tmp = *pte;
			__arm_short_set_pte(
				pte, 0, max_t(size_t, size, blk_size) / SZ_4K, cfg);

			empty = __arm_short_pgtable_empty(pgd);
			if (empty)
				__arm_short_set_pte(pgd, 0, 1, cfg);
		} else if (blk_size == SZ_1M || blk_size == SZ_16M) {
			__arm_short_set_pte(pgd, 0, blk_size / SZ_1M, cfg);
		}

		cfg->tlb->tlb_add_flush(blk_size, size, true, cookie);
		cfg->tlb->tlb_sync(cookie);

		if (empty)/* Free lvl2 pgtable */
			__arm_short_free_pgtable(
					ARM_SHORT_GET_PGTABLE_VA(pgd_tmp),
					ARM_SHORT_BYTES_PER_PTE, false, cfg);

		if (blk_size > size)
			split = true;

	} else {
		return 0;/* Unmapped size */
	}

	if (split)/* Split while blk_size > size */
		return arm_short_split_blk_unmap(
				ops, iova, size, blk_size,
				ARM_SHORT_PGD_GET_PROT(pgd_tmp),
				ARM_SHORT_PTE_GET_PROT_LARGE(pte_tmp));

	return size;
}
//===========================
This look also not good. The do-while in our v5 maybe better than this
one. what's your opinion?

3. (Also add Joerg)There is a line in iommu_map:
size_t pgsize = iommu_pgsize(domain, iova | paddr, size);

   And there is a line in iommu_unmap:
size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);

   Is it possible to change like this:
phys_addr_t paddr = domain->ops->iova_to_phys(domain, iova);
size_t pgsize = iommu_pgsize(domain, iova | paddr, size - unmapped);

   If we add physical address align check in iommu_unmap, then it may be
simpler in the unmap flow.
   I think iommu_map&iommu_unmap both should be atmoic map/unmap,
iommu_map check the physical address, Why iommu_unmap don't check the
physical address?


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
