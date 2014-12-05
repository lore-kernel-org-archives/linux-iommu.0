From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu: add ARM LPAE page table allocator
Date: Fri, 5 Dec 2014 18:48:02 +0000
Message-ID: <20141205184802.GH1203@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<1417089078-22900-3-git-send-email-will.deacon@arm.com>
	<BN3PR0301MB12198CE5D736CDC6A221EDC2EA790@BN3PR0301MB1219.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BN3PR0301MB12198CE5D736CDC6A221EDC2EA790-CEkquS/Gb81uuip9JPHoc5wN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 05, 2014 at 10:55:11AM +0000, Varun Sethi wrote:
> Hi Will,

Hi Varun,

Thanks for the review!

> +static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
> +                            unsigned long iova, phys_addr_t paddr,
> +                            arm_lpae_iopte prot, int lvl,
> +                            arm_lpae_iopte *ptep)
> +{
> +       arm_lpae_iopte pte = prot;
> +
> +       /* We require an unmap first */
> +       if (iopte_leaf(*ptep, lvl))
> +               return -EEXIST;
> [varun] Instead of returning an error, how about displaying a warning and
> replacing the entry?

I'd be ok with displaying a warning, but I don't think we should just
continue. It indicates a misuse of the IOMMU API and probably a missing
TLBI.

> +static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
> +                         phys_addr_t paddr, size_t size, arm_lpae_iopte prot,
> +                         int lvl, arm_lpae_iopte *ptep)
> +{
> +       arm_lpae_iopte *cptep, pte;
> +       void *cookie = data->iop.cookie;
> +       size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +
> +       /* Find our entry at the current level */
> +       ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
> +
> +       /* If we can install a leaf entry at this level, then do so */
> +       if (size == block_size && (size & data->iop.cfg.pgsize_bitmap))
> +               return arm_lpae_init_pte(data, iova, paddr, prot, lvl, ptep);
> +
> +       /* We can't allocate tables at the final level */
> +       if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
> +               return -EINVAL;
> 
> [varun] A warning message would be helpful.

Sure, I can add one.

> +static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> +                                          int prot)
> +{
> +       arm_lpae_iopte pte;
> +
> +       if (data->iop.fmt == ARM_LPAE_S1) {
> +               pte = ARM_LPAE_PTE_AP_UNPRIV | ARM_LPAE_PTE_nG;
> +
> +               if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> +                       pte |= ARM_LPAE_PTE_AP_RDONLY;
> +
> +               if (prot & IOMMU_CACHE)
> +                       pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
> +                               << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +       } else {
> +               pte = ARM_LPAE_PTE_HAP_FAULT;
> +               if (prot & IOMMU_READ)
> +                       pte |= ARM_LPAE_PTE_HAP_READ;
> +               if (prot & IOMMU_WRITE)
> +                       pte |= ARM_LPAE_PTE_HAP_WRITE;
> +               if (prot & IOMMU_CACHE)
> +                       pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
> +               else
> +                       pte |= ARM_LPAE_PTE_MEMATTR_NC;
> +       }
> +
> +       if (prot & IOMMU_NOEXEC)
> +               pte |= ARM_LPAE_PTE_XN;
> +
> +       return pte;
> +}
> [[varun]] Do you plan to add a flag to indicate device memory? We had a
> discussion about this on the patch submitted by me. May be you can include
> that as a part of this patch.

That needs to go in as a separate patch. I think you should continue to push
that separately!

> +static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
> +                                   unsigned long iova, size_t size,
> +                                   arm_lpae_iopte prot, int lvl,
> +                                   arm_lpae_iopte *ptep, size_t blk_size) {
> +       unsigned long blk_start, blk_end;
> +       phys_addr_t blk_paddr;
> +       arm_lpae_iopte table = 0;
> +       void *cookie = data->iop.cookie;
> +       struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> +
> +       blk_start = iova & ~(blk_size - 1);
> +       blk_end = blk_start + blk_size;
> +       blk_paddr = iopte_to_pfn(*ptep, data) << data->pg_shift;
> +
> +       for (; blk_start < blk_end; blk_start += size, blk_paddr += size) {
> +               arm_lpae_iopte *tablep;
> +
> +               /* Unmap! */
> +               if (blk_start == iova)
> +                       continue;
> +
> +               /* __arm_lpae_map expects a pointer to the start of the table */
> +               tablep = &table - ARM_LPAE_LVL_IDX(blk_start, lvl, data);
> 
> 
> [[varun]] Not clear what's happening here. May be I am missing something,
> but where is the table allocated?

It is allocated in __arm_lpae_map, because the pte will be 0. The
subtraction above is to avoid us having to allocate a whole level, just for
a single invalid pte.
> 
> +               if (__arm_lpae_map(data, blk_start, blk_paddr, size, prot, lvl,
> +                                  tablep) < 0) {
> 
> 
> [[varun]] Again not clear how are we unmapping the range. Index at the
> current level should point to a page table (with contiguous block
> mappings). Unmap would applied to the mappings at the next level. Unmap
> can happen anywhere in the contiguous range. It seems that you are just
> creating a subset of the block mapping.

We will be unmapping a single entry at the next level, so we basically
create a table, then map everything at the next level apart from the part we
need to unmap.

> +static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> +                           unsigned long iova, size_t size, int lvl,
> +                           arm_lpae_iopte *ptep)
> +{
> +       arm_lpae_iopte pte;
> +       struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> +       void *cookie = data->iop.cookie;
> +       size_t blk_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +
> +       ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
> +       pte = *ptep;
> +
> +       /* Something went horribly wrong and we ran out of page table */
> +       if (WARN_ON(!pte || (lvl == ARM_LPAE_MAX_LEVELS)))
> +               return 0;
> +
> +       /* If the size matches this level, we're in the right place */
> +       if (size == blk_size) {
> +               *ptep = 0;
> +               tlb->flush_pgtable(ptep, sizeof(*ptep), cookie);
> +
> +               if (!iopte_leaf(pte, lvl)) {
> +                       /* Also flush any partial walks */
> +                       tlb->tlb_add_flush(iova, size, false, cookie);
> +                       tlb->tlb_sync(data->iop.cookie);
> +                       ptep = iopte_deref(pte, data);
> +                       __arm_lpae_free_pgtable(data, lvl + 1, ptep);
> +               } else {
> +                       tlb->tlb_add_flush(iova, size, true, cookie);
> +               }
> +
> +               return size;
> +       } else if (iopte_leaf(pte, lvl)) {
> +               /*
> +                * Insert a table at the next level to map the old region,
> +                * minus the part we want to unmap
> +                */
> [[varun]]  Minus could be somwhere in between the contiguous chunk? We
> should first break the entire block mapping in to a next level page
> mapping and then unmap a chunk.

The amount to unmap will match exactly one entry at the next level -- that's
enforced by the IOMMU API (and it will also be aligned as such).

> +static struct arm_lpae_io_pgtable *
> +arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg) {
> +       unsigned long va_bits;
> +       struct arm_lpae_io_pgtable *data;
> +
> +       arm_lpae_restrict_pgsizes(cfg);
> +
> +       if (!(cfg->pgsize_bitmap & (SZ_4K | SZ_16K | SZ_64K)))
> +               return NULL;
> +
> +       if (cfg->ias > ARM_LPAE_MAX_ADDR_BITS)
> +               return NULL;
> +
> +       if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
> +               return NULL;
> +
> +       data = kmalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return NULL;
> +
> +       data->pages_per_pgd = 1;
> +       data->pg_shift = __ffs(cfg->pgsize_bitmap);
> +       data->bits_per_level = data->pg_shift - ilog2(sizeof(arm_lpae_iopte));
> +
> +       va_bits = cfg->ias - data->pg_shift;
> +       data->levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
> 
> [[varun]]  Not related to the patch, but this would be applicable to the
> CPU tables as well i.e, we can't support 48bit VA with 64 KB page tables,
> right? The AR64 memory maps shows possibility of using 6 bits for the
> first level page table.

Sure we can support 48-bit VAs with 64k pages. Why do you think we can't?

> +static struct io_pgtable *arm_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg,
> +                                                   void *cookie)
> +{
> +       u64 reg, sl;
> +       size_t pgd_size;
> +       struct arm_lpae_io_pgtable *data = arm_lpae_alloc_pgtable(cfg);
> +
> +       if (!data)
> +               return NULL;
> +
> +       /*
> +        * Concatenate PGDs at level 1 if possible in order to reduce
> +        * the depth of the stage-2 walk.
> +        */
> +       if (data->levels == ARM_LPAE_MAX_LEVELS) {
> +               unsigned long pgd_bits, pgd_pages;
> +               unsigned long va_bits = cfg->ias - data->pg_shift;
> +
> +               pgd_bits = data->bits_per_level * (data->levels - 1);
> +               pgd_pages = 1 << (va_bits - pgd_bits);
> +               if (pgd_pages <= ARM_LPAE_S2_MAX_CONCAT_PAGES) {
> +                       data->pages_per_pgd = pgd_pages;
> +                       data->levels--;
> +               }
> +       }
> +
> [[varun]] Can you point me to some documentation regarding stage 2 page
> concatenation. Not sure why this is required?

It's all in the ARM ARM. The idea is to reduce the depth of the stage-2
walk, since that can have an impact on performance when it gets too deep
(remember that stage-1 table walks are themselves subjected to stage-2
translation).

Will
