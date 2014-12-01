From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu: add ARM LPAE page table allocator
Date: Mon, 1 Dec 2014 17:23:15 +0000
Message-ID: <20141201172315.GI18466@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<1417089078-22900-3-git-send-email-will.deacon@arm.com>
	<3665319.WRLLeiHAYk@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3665319.WRLLeiHAYk@avalon>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Nov 30, 2014 at 11:29:46PM +0000, Laurent Pinchart wrote:
> Hi Will,

Hello again,

> On Thursday 27 November 2014 11:51:16 Will Deacon wrote:
> > +static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable
> > *data, +                                         int prot)
> > +{
> > +     arm_lpae_iopte pte;
> > +
> > +     if (data->iop.fmt == ARM_LPAE_S1) {
> > +             pte = ARM_LPAE_PTE_AP_UNPRIV | ARM_LPAE_PTE_nG;
> > +
> > +             if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> > +                     pte |= ARM_LPAE_PTE_AP_RDONLY;
> > +
> > +             if (prot & IOMMU_CACHE)
> > +                     pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
> > +                             << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> 
> In my case I'll need to manage the NS bit (here and when allocating tables in
> __arm_lpae_map). The exact requirements are not exactly clear at the moment
> I'm afraid, the datasheet doesn't clearly document secure behaviour, but tests
> showed that setting the NS was necessary.

Hurrah! You can add a quick to the currently unused quirks field that I have
in io_pgtable_cfg :)

> Given that arm_lpae_init_pte() will unconditionally set the AF and SH_IS bits
> you could set them here too, but that shouldn't make a big difference.

I prefer to keep only the protection bits handled here (i.e. those bits that
map directly to the IOMMU_* prot flags).

> > +     } else {
> > +             pte = ARM_LPAE_PTE_HAP_FAULT;
> > +             if (prot & IOMMU_READ)
> > +                     pte |= ARM_LPAE_PTE_HAP_READ;
> > +             if (prot & IOMMU_WRITE)
> > +                     pte |= ARM_LPAE_PTE_HAP_WRITE;
> > +             if (prot & IOMMU_CACHE)
> > +                     pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
> > +             else
> > +                     pte |= ARM_LPAE_PTE_MEMATTR_NC;
> > +     }
> > +
> > +     if (prot & IOMMU_NOEXEC)
> > +             pte |= ARM_LPAE_PTE_XN;
> > +
> > +     return pte;
> > +}
> > +
> > +static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
> > +                     phys_addr_t paddr, size_t size, int iommu_prot)
> > +{
> > +     struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +     arm_lpae_iopte *ptep = data->pgd;
> > +     int lvl = ARM_LPAE_START_LVL(data);
> > +     arm_lpae_iopte prot;
> > +
> > +     /* If no access, then nothing to do */
> > +     if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> > +             return 0;
> 
> Shouldn't this create a faulting entry instead ?

That's effectively what it does. Calling iommu_map on something that's
already mapped is a programming error, so therefore we know that the entry
is already faulting by virtue of it being unmapped.

> > +static struct io_pgtable *arm_lpae_alloc_pgtable_s1(struct io_pgtable_cfg
> > *cfg, +                                                   void *cookie)
> > +{
> > +     u64 reg;
> > +     struct arm_lpae_io_pgtable *data = arm_lpae_alloc_pgtable(cfg);
> > +
> > +     if (!data)
> > +             return NULL;
> > +
> > +     /* TCR */
> > +     reg = ARM_LPAE_TCR_EAE |
> > +          (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > +          (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > +          (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> > +
> > +     switch (1 << data->pg_shift) {
> > +     case SZ_4K:
> > +             reg |= ARM_LPAE_TCR_TG0_4K;
> > +             break;
> > +     case SZ_16K:
> > +             reg |= ARM_LPAE_TCR_TG0_16K;
> > +             break;
> > +     case SZ_64K:
> > +             reg |= ARM_LPAE_TCR_TG0_64K;
> > +             break;
> > +     }
> > +
> > +     switch (cfg->oas) {
> > +     case 32:
> > +             reg |= (ARM_LPAE_TCR_PS_32_BIT << ARM_LPAE_TCR_IPS_SHIFT);
> > +             break;
> > +     case 36:
> > +             reg |= (ARM_LPAE_TCR_PS_36_BIT << ARM_LPAE_TCR_IPS_SHIFT);
> > +             break;
> > +     case 40:
> > +             reg |= (ARM_LPAE_TCR_PS_40_BIT << ARM_LPAE_TCR_IPS_SHIFT);
> > +             break;
> > +     case 42:
> > +             reg |= (ARM_LPAE_TCR_PS_42_BIT << ARM_LPAE_TCR_IPS_SHIFT);
> > +             break;
> > +     case 44:
> > +             reg |= (ARM_LPAE_TCR_PS_44_BIT << ARM_LPAE_TCR_IPS_SHIFT);
> > +             break;
> > +     case 48:
> > +             reg |= (ARM_LPAE_TCR_PS_48_BIT << ARM_LPAE_TCR_IPS_SHIFT);
> > +             break;
> > +     default:
> > +             goto out_free_data;
> > +     }
> > +
> > +     reg |= (64ULL - cfg->ias) << ARM_LPAE_TCR_T0SZ_SHIFT;
> > +     cfg->arm_lpae_s1_cfg.tcr = reg;
> > +
> > +     /* MAIRs */
> > +     reg = (ARM_LPAE_MAIR_ATTR_NC
> > +            << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_NC)) |
> > +           (ARM_LPAE_MAIR_ATTR_WBRWA
> > +            << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
> > +           (ARM_LPAE_MAIR_ATTR_DEVICE
> > +            << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV));
> > +
> > +     cfg->arm_lpae_s1_cfg.mair[0] = reg;
> > +     cfg->arm_lpae_s1_cfg.mair[1] = 0;
> > +
> > +     /* Looking good; allocate a pgd */
> > +     data->pgd = alloc_pages_exact(1UL << data->pg_shift,
> > +                                   GFP_KERNEL | __GFP_ZERO);
> 
> data->pg_shift is computed as __ffs(cfg->pgsize_bitmap). 1UL << data->pg_shift
> will thus be equal to the smallest page size supported by the IOMMU. This will
> thus allocate 4kB, 16kB or 64kB depending on the IOMMU configuration. However,
> if I'm not mistaken the top-level directory needs to store one entry per
> largest supported page size. That's 4, 128 or 8 entries depending on the
> configuration. You're thus over-allocating.

Yeah, I'll take a closer look at this. The size of the pgd really depends
on the TxSZ configuration, which in turn depends on the ias and the page
size. There are also alignment constraints to bear in mind, but I'll see
what I can do (as it stands, over-allocating will always work).

Thanks,

Will
