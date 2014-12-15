From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu: add ARM LPAE page table allocator
Date: Mon, 15 Dec 2014 13:30:21 +0000
Message-ID: <20141215133020.GJ20738@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<1417089078-22900-3-git-send-email-will.deacon@arm.com>
	<BN3PR0301MB12198CE5D736CDC6A221EDC2EA790@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<20141205184802.GH1203@arm.com>
	<BN3PR0301MB1219D3161E4E9DB314FDD8FAEA6E0@BN3PR0301MB1219.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BN3PR0301MB1219D3161E4E9DB314FDD8FAEA6E0-CEkquS/Gb81uuip9JPHoc5wN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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

On Sun, Dec 14, 2014 at 05:45:49PM +0000, Varun Sethi wrote:
> Please find my response inline. Search for "varun".

This is getting fiddly now that you've already replied once. Any chance you
could sort your mail client out, please?

> > +static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
> > +                            unsigned long iova, phys_addr_t paddr,
> > +                            arm_lpae_iopte prot, int lvl,
> > +                            arm_lpae_iopte *ptep) {
> > +       arm_lpae_iopte pte = prot;
> > +
> > +       /* We require an unmap first */
> > +       if (iopte_leaf(*ptep, lvl))
> > +               return -EEXIST;
> > [varun] Instead of returning an error, how about displaying a warning
> > and replacing the entry?
> 
> I'd be ok with displaying a warning, but I don't think we should just
> continue. It indicates a misuse of the IOMMU API and probably a missing
> TLBI.
> 
> [[varun]] May not apply now, but what if we are dealing with a case where
> memory is not pinned? It may be possible to hookup (without an unmap) an
> iova to a different physical address. Offcourse, tlb invalidation would be
> required. Could this scenario be relevant in case of stall mode?

If we wanted to support that, then we'd need some new functions for grabbing
hold of the entry and manipulating it in a similar way to the CPU side (e.g.
pte_mkdirty etc).

> > +               if (__arm_lpae_map(data, blk_start, blk_paddr, size, prot, lvl,
> > +                                  tablep) < 0) {
> >
> >
> > [[varun]] Again not clear how are we unmapping the range. Index at the
> > current level should point to a page table (with contiguous block
> > mappings). Unmap would applied to the mappings at the next level.
> > Unmap can happen anywhere in the contiguous range. It seems that you
> > are just creating a subset of the block mapping.
> 
> We will be unmapping a single entry at the next level, so we basically
> create a table, then map everything at the next level apart from the part
> we need to unmap.
> 
> 
> [varun] ok, but you could potentially end up splitting mapping to the
> least possible page size e.g. 4K. You, don't seem to take in to account
> the possibility of using the block size at the next level. For example,
> take a case where we have a huge page mapping using 1G page size and we
> have an unmap request for 4K. We could still split maximum part of the
> mapping using 2M pages at the next level. The entry where we need to unmap
> the 4K region would potentially go to the next level.

Aha, I see what you mean here, thanks. I'll take a look...

> > +static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> > +                           unsigned long iova, size_t size, int lvl,
> > +                           arm_lpae_iopte *ptep) {
> > +       arm_lpae_iopte pte;
> > +       struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> > +       void *cookie = data->iop.cookie;
> > +       size_t blk_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> > +
> > +       ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
> > +       pte = *ptep;
> > +
> > +       /* Something went horribly wrong and we ran out of page table */
> > +       if (WARN_ON(!pte || (lvl == ARM_LPAE_MAX_LEVELS)))
> > +               return 0;
> > +
> > +       /* If the size matches this level, we're in the right place */
> > +       if (size == blk_size) {
> > +               *ptep = 0;
> > +               tlb->flush_pgtable(ptep, sizeof(*ptep), cookie);
> > +
> > +               if (!iopte_leaf(pte, lvl)) {
> > +                       /* Also flush any partial walks */
> > +                       tlb->tlb_add_flush(iova, size, false, cookie);
> > +                       tlb->tlb_sync(data->iop.cookie);
> > +                       ptep = iopte_deref(pte, data);
> > +                       __arm_lpae_free_pgtable(data, lvl + 1, ptep);
> > +               } else {
> > +                       tlb->tlb_add_flush(iova, size, true, cookie);
> > +               }
> > +
> > +               return size;
> > +       } else if (iopte_leaf(pte, lvl)) {
> > +               /*
> > +                * Insert a table at the next level to map the old region,
> > +                * minus the part we want to unmap
> > +                */
> > [[varun]]  Minus could be somwhere in between the contiguous chunk? We
> > should first break the entire block mapping in to a next level page
> > mapping and then unmap a chunk.
> 
> The amount to unmap will match exactly one entry at the next level --
> that's enforced by the IOMMU API (and it will also be aligned as such).
> 
> > +static struct arm_lpae_io_pgtable *
> > +arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg) {
> > +       unsigned long va_bits;
> > +       struct arm_lpae_io_pgtable *data;
> > +
> > +       arm_lpae_restrict_pgsizes(cfg);
> > +
> > +       if (!(cfg->pgsize_bitmap & (SZ_4K | SZ_16K | SZ_64K)))
> > +               return NULL;
> > +
> > +       if (cfg->ias > ARM_LPAE_MAX_ADDR_BITS)
> > +               return NULL;
> > +
> > +       if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
> > +               return NULL;
> > +
> > +       data = kmalloc(sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return NULL;
> > +
> > +       data->pages_per_pgd = 1;
> > +       data->pg_shift = __ffs(cfg->pgsize_bitmap);
> > +       data->bits_per_level = data->pg_shift -
> > + ilog2(sizeof(arm_lpae_iopte));
> > +
> > +       va_bits = cfg->ias - data->pg_shift;
> > +       data->levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
> >
> > [[varun]]  Not related to the patch, but this would be applicable to
> > the CPU tables as well i.e, we can't support 48bit VA with 64 KB page
> > tables, right? The AR64 memory maps shows possibility of using 6 bits
> > for the first level page table.
> 
> Sure we can support 48-bit VAs with 64k pages. Why do you think we can't?
> 
> [varun]  My concern was with respect to the bits per level, which is
> uneven for the 64 K page sizes. Just wondering how would things work with
> 64K pages when we do a 3 level page lookup.

Well, it's uneven (9) for the 4k case too. Do you actually see an issue
here?

48-bit VA with 64k pages gives us:

  va_bits = (48 - 16) = 32
  bits_per_level = (16 - 3) = 13
  levels = ceil(32/13) = 3

so the starting level is 1, which resolves 32-(13*2) = 6 bits.

Does that make sense?

> > +static struct io_pgtable *arm_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg,
> > +                                                   void *cookie) {
> > +       u64 reg, sl;
> > +       size_t pgd_size;
> > +       struct arm_lpae_io_pgtable *data =
> > +arm_lpae_alloc_pgtable(cfg);
> > +
> > +       if (!data)
> > +               return NULL;
> > +
> > +       /*
> > +        * Concatenate PGDs at level 1 if possible in order to reduce
> > +        * the depth of the stage-2 walk.
> > +        */
> > +       if (data->levels == ARM_LPAE_MAX_LEVELS) {
> > +               unsigned long pgd_bits, pgd_pages;
> > +               unsigned long va_bits = cfg->ias - data->pg_shift;
> > +
> > +               pgd_bits = data->bits_per_level * (data->levels - 1);
> > +               pgd_pages = 1 << (va_bits - pgd_bits);
> > +               if (pgd_pages <= ARM_LPAE_S2_MAX_CONCAT_PAGES) {
> > +                       data->pages_per_pgd = pgd_pages;
> > +                       data->levels--;
> > +               }
> > +       }
> > +
> > [[varun]] Can you point me to some documentation regarding stage 2
> > page concatenation. Not sure why this is required?
> 
> It's all in the ARM ARM. The idea is to reduce the depth of the stage-2
> walk, since that can have an impact on performance when it gets too deep
> (remember that stage-1 table walks are themselves subjected to stage-2
> translation).
> 
> [varun] Just curious, why not consider concatenation at stage 1?

Well, the architecture doesn't support it. It's not as big a deal at
stage 1 anyway, because there is no nesting in that case (unlike stage 2,
which is applied to stage 1 table walks).

Will
