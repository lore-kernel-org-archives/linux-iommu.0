From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 3/6] iommu: add ARM short descriptor page table
 allocator.
Date: Tue, 22 Sep 2015 22:12:47 +0800
Message-ID: <1442931167.17514.39.camel@mhfsdcap03>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
	 <1438597279-2937-4-git-send-email-yong.wu@mediatek.com>
	 <20150916155824.GM28771@arm.com> <1442501662.8145.151.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442501662.8145.151.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "youhua.li@mediatek.com" <youhua.li@mediatek.com>, Thierry Reding <treding@nvidia.com>, "k.zhang@mediatek.com" <k.zhang@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Tomasz Figa <tfiga@google.com>, Rob Herring <robh+dt@kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>, "frederic.chen@mediatek.com" <frederic.chen@mediatek.com>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Daniel
List-Id: iommu@lists.linux-foundation.org

> > > +static int arm_short_unmap(struct io_pgtable_ops *ops,
> > > +                          unsigned long iova,
> > > +                          size_t size)
> > > +{
> > > +       struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > > +       struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > > +       arm_short_iopte *pgd, *pte = NULL;
> > > +       arm_short_iopte curpgd, curpte = 0;
> > > +       phys_addr_t paddr;
> > > +       unsigned int iova_base, blk_size = 0;
> > > +       void *cookie = data->iop.cookie;
> > > +       bool pgtablefree = false;
> > > +
> > > +       pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova);
> > > +
> > > +       /* Get block size */
> > > +       if (ARM_SHORT_PGD_TYPE_IS_PGTABLE(*pgd)) {
> > > +               pte = arm_short_get_pte_in_pgd(*pgd, iova);
> > > +
> > > +               if (ARM_SHORT_PTE_TYPE_IS_SMALLPAGE(*pte))
> > > +                       blk_size = SZ_4K;
> > > +               else if (ARM_SHORT_PTE_TYPE_IS_LARGEPAGE(*pte))
> > > +                       blk_size = SZ_64K;
> > > +               else
> > > +                       WARN_ON(1);
> 
> > > +       } else if (ARM_SHORT_PGD_TYPE_IS_SECTION(*pgd)) {
> > > +               blk_size = SZ_1M;
> > > +       } else if (ARM_SHORT_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
> > > +               blk_size = SZ_16M;
> > > +       } else {
> > > +               WARN_ON(1); 
> > > +       }
> > > +
> > > +       iova_base = iova & ~(blk_size - 1);
> > > +       pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova_base);
> > > +       paddr = arm_short_iova_to_phys(ops, iova_base);
> > > +       curpgd = *pgd;
> > > +
> > > +       if (blk_size == SZ_4K || blk_size == SZ_64K) {
> > > +               pte = arm_short_get_pte_in_pgd(*pgd, iova_base);
> > > +               curpte = *pte;
> > > +               __arm_short_set_pte(pte, 0, blk_size / SZ_4K, cfg);
> > > +
> > > +            pgtablefree = _arm_short_whether_free_pgtable(pgd);
> > > +            if (pgtablefree)
> > > +                 __arm_short_set_pte(pgd, 0, 1, cfg);
> > > +       } else if (blk_size == SZ_1M || blk_size == SZ_16M) {
> > > +               __arm_short_set_pte(pgd, 0, blk_size / SZ_1M, cfg);
> > > +       }
> > > +
> > > +    cfg->tlb->tlb_add_flush(iova_base, blk_size, true, cookie);
> > > +    cfg->tlb->tlb_sync(cookie);
> > > +
> > > +       if (pgtablefree)/* Free pgtable after tlb-flush */
> > > +              __arm_short_free_pgtable(ARM_SHORT_GET_PGTABLE_VA(curpgd),
> > > +                                        ARM_SHORT_BYTES_PER_PTE, false, cfg);
> > > +
> > > +       if (blk_size > size) { /* Split the block */
> > > +               return arm_short_split_blk_unmap(
> > > +                               ops, iova, paddr, size,
> > > +                               ARM_SHORT_PGD_GET_PROT(curpgd),
> > > +                               ARM_SHORT_PTE_LARGE_GET_PROT(curpte),
> > > +                               blk_size);
> > > +       } else if (blk_size < size) {
> > > +               /* Unmap the block while remap partial again after split */
> > > +               return blk_size +
> > > +                       arm_short_unmap(ops, iova + blk_size, size - blk_size);

Hi Will, Robin,
     I would like to show you a problem I met, The recursion here may
lead to stack overflow while we test FHD video decode.

    From the log, I get the internal variable in the error case: the
"size" is 0x100000, the "iova" is 0xfea00000, but at that time the
"blk_size" is 0x1000 as it was the map of small-page. so it enter the
recursion here.
    
    After check the unmap flow, there is only a iommu_unmap in
__iommu_dma_unmap, and it won't check the physical address align in
iommu_unmap.
so if the iova and size both are SZ_16M or SZ_1M align by chance, it
also enter the arm_short_unmap even though it was the map of small-page.

    So.
    a) Do we need unmap each sg item while iommu_dma_unmap?, like below:

//===============
static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t
dma_addr)
{
	/* ...and if we can't, then something is horribly, horribly wrong */
+       for_each_sg(sg, s, nents, i)
		BUG_ON(iommu_unmap(domain, pfn << shift, size) < size);
	__free_iova(iovad, iova);
}
//===============
 
    b). I need to add do-while which was suggested to delete from [1] in
arm_short_unmap for this case.

     After I test locally, I prepare to add the do-while like below:
     
//==============================
static int arm_short_unmap(struct io_pgtable_ops *ops,
			   unsigned long iova,
			   size_t size)
{
	struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
	struct io_pgtable_cfg *cfg = &data->iop.cfg;
	arm_short_iopte *pgd, *pte = NULL;
	arm_short_iopte curpgd, curpte = 0;
	unsigned int blk_base, blk_size;
	int unmap_size = 0;
	bool pgtempty;

	do {
		pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova);
		blk_size = 0;
		pgtempty = false;

		/* Get block size */
		if (ARM_SHORT_PGD_TYPE_IS_PGTABLE(*pgd)) {
			pte = arm_short_get_pte_in_pgd(*pgd, iova);

			if (ARM_SHORT_PTE_TYPE_IS_SMALLPAGE(*pte))
				blk_size = SZ_4K;
			else if (ARM_SHORT_PTE_TYPE_IS_LARGEPAGE(*pte))
				blk_size = SZ_64K;
		} else if (ARM_SHORT_PGD_TYPE_IS_SECTION(*pgd)) {
			blk_size = SZ_1M;
		} else if (ARM_SHORT_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
			blk_size = SZ_16M;
		}

		if (WARN_ON(!blk_size))
			return 0;

		blk_base = iova & ~(blk_size - 1);
		pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(blk_base);
		curpgd = *pgd;

		if (blk_size == SZ_4K || blk_size == SZ_64K) {
			pte = arm_short_get_pte_in_pgd(*pgd, blk_base);
			curpte = *pte;
			__arm_short_set_pte(pte, 0, blk_size / SZ_4K, cfg);

			pgtempty = __arm_short_pgtable_empty(pgd);
			if (pgtempty)
				__arm_short_set_pte(pgd, 0, 1, cfg);
		} else if (blk_size == SZ_1M || blk_size == SZ_16M) {
			__arm_short_set_pte(pgd, 0, blk_size / SZ_1M, cfg);
		}

		cfg->tlb->tlb_add_flush(blk_base, blk_size, true, data->iop.cookie);
		cfg->tlb->tlb_sync(data->iop.cookie);

		if (pgtempty)/* Free lvl2 pgtable after tlb-flush */
			__arm_short_free_pgtable(
					ARM_SHORT_GET_PGTABLE_VA(curpgd),
					ARM_SHORT_BYTES_PER_PTE, false, cfg);

		/*
		 * If the unmap size which is from the pgsize_bitmap is more
		 * than the current blk_size, unmap it continuously.
		 */
		if (blk_size <= size) {
			iova += blk_size;
			size -= blk_size;
			unmap_size += blk_size;
			continue;
		} else { /* Split this block */
			return arm_short_split_blk_unmap(
					ops, iova, size, blk_size,
					ARM_SHORT_PGD_GET_PROT(curpgd),
					ARM_SHORT_PTE_GET_PROT_LARGE(curpte));
		}
	}while (size);

	return unmap_size;
}
//=============================

    Is there any other suggestion?
    Thanks very much.


[1]:http://lists.linuxfoundation.org/pipermail/iommu/2015-June/013322.html

> > > +       }
> > > +
> > > +       return size;
> > > +}
> > > +
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
