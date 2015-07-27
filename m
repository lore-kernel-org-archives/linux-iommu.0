From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 3/6] iommu: add ARM short descriptor page table
 allocator.
Date: Mon, 27 Jul 2015 12:21:08 +0800
Message-ID: <1437970868.25925.20.camel@mhfsdcap03>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	 <1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
	 <20150721171101.GN31095@arm.com> <1437715466.23932.68.camel@mhfsdcap03>
	 <20150724165325.GC21177@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150724165325.GC21177-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>"arnd-r2nGTMty4D4@public.gmane.org" <a>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-07-24 at 17:53 +0100, Will Deacon wrote:
> On Fri, Jul 24, 2015 at 06:24:26AM +0100, Yong Wu wrote:
> > On Tue, 2015-07-21 at 18:11 +0100, Will Deacon wrote:
> > > On Thu, Jul 16, 2015 at 10:04:32AM +0100, Yong Wu wrote:
> > > > +/* level 2 pagetable */
> > > > +#define ARM_SHORT_PTE_TYPE_LARGE               BIT(0)
> > > > +#define ARM_SHORT_PTE_SMALL_XN                 BIT(0)
> > > > +#define ARM_SHORT_PTE_TYPE_SMALL               BIT(1)
> > > > +#define ARM_SHORT_PTE_B                                BIT(2)
> > > > +#define ARM_SHORT_PTE_C                                BIT(3)
> > > > +#define ARM_SHORT_PTE_SMALL_TEX0               BIT(6)
> > > > +#define ARM_SHORT_PTE_IMPLE                    BIT(9)
> > >
> > > This is AP[2] for small pages.
> > 
> > Sorry, In our pagetable bit9 in PGD and PTE is PA[32] that is for  the
> > dram size over 4G. I didn't care it is different in PTE of the standard
> > spec.
> > And I don't use the AP[2] currently, so I only delete this line in next
> > time.
> 
> Is this related to the "special bit". What would be good is a comment
> next to the #define for the quirk describing *exactly* that differs in
> your implementation. Without that, it's very difficult to know what is
> intentional and what is actually broken.

I will add the comment alongside the #define.

> 
> > > > +static arm_short_iopte
> > > > +__arm_short_pte_prot(struct arm_short_io_pgtable *data, int prot, bool large)
> > > > +{
> > > > +       arm_short_iopte pteprot;
> > > > +
> > > > +       pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG;
> > > > +       pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
> > > > +                               ARM_SHORT_PTE_TYPE_SMALL;
> > > > +       if (prot & IOMMU_CACHE)
> > > > +               pteprot |=  ARM_SHORT_PTE_B | ARM_SHORT_PTE_C;
> > > > +       if (prot & IOMMU_WRITE)
> > > > +               pteprot |= large ? ARM_SHORT_PTE_LARGE_TEX0 :
> > > > +                               ARM_SHORT_PTE_SMALL_TEX0;
> > >
> > > This doesn't make any sense. TEX[2:0] is all about memory attributes, not
> > > permissions, so you're making the mapping write-back, write-allocate but
> > > that's not what the IOMMU_* values are about.
> > 
> >      I will delete it.
> 
> Well, can you not control mapping permissions with the AP bits? The idea
> of the IOMMU flags are:
> 
>   IOMMU_CACHE : Install a normal, cacheable mapping (you've got this right)
>   IOMMU_READ : Allow read access for the device
>   IOMMU_WRITE : Allow write access for the device
>   IOMMU_NOEXEC : Disallow execute access for the device
> 
> so the caller to iommu_map passes in a bitmap of these, which you need to
> encode in the page-table entry.

>From the spec, AP[2] differentiate the read/write and readonly.
How about this?: 
//===============
  #define ARM_SHORT_PGD_FULL_ACCESS  (3 << 10) 
  #define ARM_SHORT_PGD_RDONLY       BIT(15)

  pgdprot |= ARM_SHORT_PGD_FULL_ACCESS;/* or other names? */
  if(!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
     pgdprot |= ARM_SHORT_PGD_RDONLY;
//===============
pte is the same. 

Sorry, Our HW don't meet the standard spec fully. it don't implement the
AP bits.

> 
> > > > +static int
> > > > +_arm_short_map(struct arm_short_io_pgtable *data,
> > > > +              unsigned int iova, phys_addr_t paddr,
> > > > +              arm_short_iopte pgdprot, arm_short_iopte pteprot,
> > > > +              bool large)
> > > > +{
> > > > +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> > > > +       arm_short_iopte *pgd = data->pgd, *pte;
> > > > +       void *cookie = data->iop.cookie, *pte_va;
> > > > +       unsigned int ptenr = large ? 16 : 1;
> > > > +       int i, quirk = data->iop.cfg.quirks;
> > > > +       bool ptenew = false;
> > > > +
> > > > +       pgd += ARM_SHORT_PGD_IDX(iova);
> > > > +
> > > > +       if (!pteprot) { /* section or supersection */
> > > > +               if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK)
> > > > +                       pgdprot &= ~ARM_SHORT_PGD_SECTION_XN;
> > > > +               pte = pgd;
> > > > +               pteprot = pgdprot;
> > > > +       } else {        /* page or largepage */
> > > > +               if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK) {
> > > > +                       if (large) { /* special Bit */
> > >
> > > This definitely needs a better comment! What exactly are you doing here
> > > and what is that quirk all about?
> > 
> > I use this quirk is for MTK Special Bit as we don't have the XN bit in
> > pagetable.
> 
> I'm still not really clear about what this is.

There is some difference between the standard spec and MTK HW,
Our hw don't implement some bits, like XN and AP.
So I add a quirk for MTK special.

> 
> > > > +               if (!(*pgd)) {
> > > > +                       pte_va = kmem_cache_zalloc(data->ptekmem, GFP_ATOMIC);
> > > > +                       if (unlikely(!pte_va))
> > > > +                               return -ENOMEM;
> > > > +                       ptenew = true;
> > > > +                       *pgd = virt_to_phys(pte_va) | pgdprot;
> > > > +                       kmemleak_ignore(pte_va);
> > > > +                       tlb->flush_pgtable(pgd, sizeof(*pgd), cookie);
> > >
> > > I think you need to flush this before it becomes visible to the walker.
> > 
> > I have flushed pgtable here, Do you meaning flush tlb here?
> 
> No. afaict, you allocate the pte table using kmem_cache_zalloc but you never
> flush it. However, you update the pgd to point at this table, so the walker
> can potentially see garbage instead of the zeroed entries.

Thanks. I will add :
tlb->flush_pgtable(pte_va, ARM_SHORT_BYTES_PER_PTE, cookie);

> 
> Will


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
