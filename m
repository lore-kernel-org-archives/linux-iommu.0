From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v6 06/20] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
	Mode
Date: Sun, 17 Feb 2019 18:01:31 +0800
Message-ID: <1550397691.17931.27.camel@mhfsdcap03>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
	<1546314952-15990-7-git-send-email-yong.wu@mediatek.com>
	<CAE=gft5bga+pM_7syKMnnma78xYN0HT4LaPPEftJ9DNqFf=zWw@mail.gmail.com>
	<1548917937.3292.15.camel@mhfsdcap03>
	<CAE=gft6ai_ff5e2=XL=pU5AxwOYeSb05PUkfEt9Bn7Ek+fZRyg@mail.gmail.com>
	<1549014148.12663.27.camel@mhfsdcap03>
	<CAE=gft4YBvbq5fSuu-RzY9jF8ea8eLKHgOrZ46wPcgdSAWKkVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAE=gft4YBvbq5fSuu-RzY9jF8ea8eLKHgOrZ46wPcgdSAWKkVQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "open
	list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2019-02-05 at 15:11 -0800, Evan Green wrote:
> On Fri, Feb 1, 2019 at 1:42 AM Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >
> > On Thu, 2019-01-31 at 11:23 -0800, Evan Green wrote:
> > > On Wed, Jan 30, 2019 at 10:59 PM Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > > >
> > > > On Wed, 2019-01-30 at 10:28 -0800, Evan Green wrote:
> > > > > On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > > > > >
> > > > > > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > > > > >
> > > > > > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > > > > > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > > > > > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > > > > > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > > > > > for all PTEs which means to enable bit32 of physical address.
> > > > >
> > > > > I got a little lost here. I get that you're trying to explain why you
> > > > > always used to set bit32 of the physical address. But I don't totally
> > > > > get the part about physical addresses being from 0x4000_0000 -
> > > > > 0x1_3fff_ffff, but also from 0x1_0000_0000-0x1_ffff_ffff. Are you
> > > > > saying that the physical addresses from the iommu's perspective were
> > > > > always >0x1_0000_0000?
> > > >
> > > > Yes. From the IOMMU's perspective, the Physical address is from
> > > > 0x1_0000_0000 to 0x1_ffff_ffff.
> > > >
> > > > > But then from whose perspective is it 0x4000_0000? ...
> > > >
> > > > I guess from SW point view. it is from 0x4000_0000 to 0x1_3fff_ffff.
> > > >
> > > > If 4GB mode is enabled, the memory property in dts like this:
> > > >
> > > >         memory@40000000 {
> > > >                 device_type = "memory";
> > > >                 reg = <0 0x40000000 0x00000001 0x00000000>;
> > > >         };
> > > >
> > > > > oh, or you're saying there was some sort of remapping
> > > > > facility that moved the physical addresses around?
> > > > >
> > > > > >
> > > > > > but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> > > > > > which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> > > > > > PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> > > > > > 32bits.
> > > > > >
> > > > > > In order to unify code, in the "4GB mode", we add the bit32 for the
> > > > > > physical address manually in our driver.
> > > > > >
> > > > > > Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
> > > > > > has to been moved into v7s.
> > > > > >
> > > > > > Regarding whether the pagetable address could be over 4GB, the mt8183
> > > > > > support it while the previous mt8173 don't. thus keep it as is.
> > > > > >
> > > > > > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > > > > > Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > > > > > ---
> > > > > >  drivers/iommu/io-pgtable-arm-v7s.c | 31 ++++++++++++++++++++++++-------
> > > > > >  drivers/iommu/io-pgtable.h         |  7 +++----
> > > > > >  drivers/iommu/mtk_iommu.c          | 14 ++++++++------
> > > > > >  drivers/iommu/mtk_iommu.h          |  1 +
> > > > > >  4 files changed, 36 insertions(+), 17 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > > > > > index 11d8505..8803a35 100644
> > > > > > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > > > > > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > > > > > @@ -124,7 +124,9 @@
> > > > > >  #define ARM_V7S_TEX_MASK               0x7
> > > > > >  #define ARM_V7S_ATTR_TEX(val)          (((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
> > > > > >
> > > > > > -#define ARM_V7S_ATTR_MTK_4GB           BIT(9) /* MTK extend it for 4GB mode */
> > > > > > +/* MediaTek extend the two bits below for over 4GB mode */
> > > > > > +#define ARM_V7S_ATTR_MTK_PA_BIT32      BIT(9)
> > > > > > +#define ARM_V7S_ATTR_MTK_PA_BIT33      BIT(4)
> > > > >
> > > > > If other vendors start doing stuff like this we'll need a more generic
> > > > > way to handle this... but I guess until we see a pattern this is okay.
> > > > >
> > > > > >
> > > > > >  /* *well, except for TEX on level 2 large pages, of course :( */
> > > > > >  #define ARM_V7S_CONT_PAGE_TEX_SHIFT    6
> > > > > > @@ -183,13 +185,22 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
> > > > > >  static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> > > > > >                                     struct io_pgtable_cfg *cfg)
> > > > > >  {
> > > > > > -       return paddr & ARM_V7S_LVL_MASK(lvl);
> > > > > > +       arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> > > > > > +
> > > > > > +       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > > > > > +               if (paddr & BIT_ULL(32))
> > > > > > +                       pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
> > > > > > +               if (paddr & BIT_ULL(33))
> > > > > > +                       pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> > > > > > +       }
> > > > > > +       return pte;
> > > > > >  }
> > > > > >
> > > > > >  static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> > > > > >                                   struct io_pgtable_cfg *cfg)
> > > > > >  {
> > > > > >         arm_v7s_iopte mask;
> > > > > > +       phys_addr_t paddr;
> > > > > >
> > > > > >         if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
> > > > > >                 mask = ARM_V7S_TABLE_MASK;
> > > > > > @@ -198,7 +209,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> > > > > >         else
> > > > > >                 mask = ARM_V7S_LVL_MASK(lvl);
> > > > > >
> > > > > > -       return pte & mask;
> > > > > > +       paddr = pte & mask;
> > > > > > +       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > > > > > +               if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> > > > > > +                       paddr |= BIT_ULL(32);
> > > > > > +               if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> > > > > > +                       paddr |= BIT_ULL(33);
> > > > > > +       }
> > > > > > +       return paddr;
> > > > > >  }
> > > > > >
> > > > > >  static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
> > > > > > @@ -315,9 +333,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
> > > > > >         if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
> > > > > >                 pte |= ARM_V7S_ATTR_NS_SECTION;
> > > > > >
> > > > > > -       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
> > > > > > -               pte |= ARM_V7S_ATTR_MTK_4GB;
> > > > > > -
> > > > >
> > > > > So despite getting lost in the details, I guess the reason it's okay
> > > > > that this goes from unconditional to conditional on bit32 is that
> > > > > before, with the older chips, all physical addresses were above 4GB,
> > > > > so we'll always see PA's above 4GB?
> > > > >
> > > > > >         return pte;
> > > > > >  }
> > > > > >
> > > > > > @@ -504,7 +519,9 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
> > > > > >         if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> > > > > >                 return 0;
> > > > > >
> > > > > > -       if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
> > > > > > +       if (WARN_ON(upper_32_bits(iova)) ||
> > > > > > +           WARN_ON(upper_32_bits(paddr) &&
> > > > > > +                   !(iop->cfg.quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
> > > > > >                 return -ERANGE;
> > > > > >
> > > > > >         ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
> > > > > > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > > > > > index 47d5ae5..69db115 100644
> > > > > > --- a/drivers/iommu/io-pgtable.h
> > > > > > +++ b/drivers/iommu/io-pgtable.h
> > > > > > @@ -62,10 +62,9 @@ struct io_pgtable_cfg {
> > > > > >          *      (unmapped) entries but the hardware might do so anyway, perform
> > > > > >          *      TLB maintenance when mapping as well as when unmapping.
> > > > > >          *
> > > > > > -        * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
> > > > > > -        *      PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
> > > > > > -        *      when the SoC is in "4GB mode" and they can only access the high
> > > > > > -        *      remap of DRAM (0x1_00000000 to 0x1_ffffffff).
> > > > > > +        * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) MediaTek IOMMUs extend
> > > > > > +        *      to support up to 34 bits PA where the bit32 and bit33 are
> > > > > > +        *      encoded in the bit9 and bit4 of the PTE respectively.
> > > > > >          *
> > > > > >          * IO_PGTABLE_QUIRK_NO_DMA: Guarantees that the tables will only ever
> > > > > >          *      be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
> > > > > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > > > > index 189d1b5..ae1aa5a 100644
> > > > > > --- a/drivers/iommu/mtk_iommu.c
> > > > > > +++ b/drivers/iommu/mtk_iommu.c
> > > > > > @@ -367,12 +367,16 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
> > > > > >                          phys_addr_t paddr, size_t size, int prot)
> > > > > >  {
> > > > > >         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > > > > > +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> > > > > >         unsigned long flags;
> > > > > >         int ret;
> > > > > >
> > > > > > +       /* The "4GB mode" M4U physically can not use the lower remap of Dram. */
> > > > > > +       if (data->plat_data->has_4gb_mode && data->enable_4GB)
> > > > > > +               paddr |= BIT_ULL(32);
> > > > > > +
> > > > >
> > > > > Ok here's where I get lost. How is this okay? Is the same physical RAM
> > > > > accessible at multiple locations in the physical address space? Won't
> > > > > this map an iova to a different pa than the one requested?
> > > >
> > > > In 4GB mode, HW will remap 0x4000_0000-0x1_3fff_ffff to 0x1_0000_0000-
> > > > 0x1_ffff_ffff. M4U help multimedia HW access dram, thus from M4U point
> > > > of view, the dram always is 0x1_0000_0000 to 0x1_ffff_ffff.
> > > >
> > > > The detailed mapping relationship is like this:
> > > >
> > > > 0x4000_0000  -0xffff_ffff   map to 0x1_4000_0000 - 0x1_ffff_ffff.
> > > > 0x1_0000_0000-0x1_3fff_ffff map to 0x1_0000_0000 - 0x1_3fff_ffff.
> > > >
> > > > Thus, we can only add bit32 for the PA in the 4GB mode.
> > >
> > > Ok, I think I get it now. This thread really helped:
> > > https://patchwork.kernel.org/patch/8402211/
> > >
> > > So from what I understand basically the same DRAM exists in two places:
> > > 0000_0000 - ffff_ffff, and is also available in
> > > 1_0000_0000 - 1_ffff_ffff
> > >
> > > ...except that the peripherals are located in 0000_0000 - 3ffff_ffff,
> > > so that first GB of RAM is not visible at the lower address. I'm
> > > gathering this was in fact the motivation for 4GB mode. The important
> > > part is that address 4000_0000 == 1_4000_0000.
> > >
> > > Then there was also some quirk of the IOMMU where it refused to access
> > > addresses below 4GB. But those same addresses are accessible by ORing
> > > in bit 32, so you just always do that and you're good to go.
> > >
> > > Ok so now I can use that to understand this refactoring:
> > > * You used to always return an address above 4GB in
> > > mtk_iommu_iova_to_phys. I don't fully get how that worked, since it
> > > seems like you'd start returning PAs to the rest of the system that
> > > were outside of the range 4000_0000 - 1_3fff_ffff, but okay, you're no
> >
> > I'm not sure I follow this. From the SW point view, the dram is
> > 0x4000_0000 - 0x1_3fff_ffff. there is no memory outside it.
> >
> > But there is really a issue in the mtk_iommu_iova_to_phys in the
> > 4gb_mode.
> 
> I guess I'm still struggling to understand what the "remapping" means.
> From what you've described, it seems like it means that the physical
> addresses seen by the CPU and IOMMU are different. I can picture two
> possibilities:
> 
> First variant:
> CPU PA == IOMMU PA
> 0x4000_0000 == 0x1_4000_0000
> 0x8000_0000 == 0x1_8000_0000
> 0xC000_0000 == 0x1_C000_0000
> 0x1_0000_0000 == 0x1_0000_0000

This one is right. The 4GB mode remap is a little complex, In the new
version, I explain it in the code. then someone don't need get it from
the git log or search from the network. help see [v6 21/22].

> 
> Or, maybe second variant:
> CPU PA == IOMMU PA
> 0x4000_0000 == 0x1_0000_0000
> 0x8000_0000 == 0x1_4000_0000
> 0xC000_0000 == 0x1_8000_0000
> 0x1_0000_0000 == 0x1_C000_0000
> 
> My only point in trying to understand this about 4GB mode is that I'm
> trying to figure out if the equation CPU PA | 0x1_0000_0000 == IOMMU
> PA holds. In the first variant above, that equation works. But in the
> second equation, I'd expect to see a +/- 0x4000_0000, as simply ORing
> in 0x1_0000_0000 would get you the wrong PA as seen by the IOMMU.
> 
> >
> > Currently in the 4gb mode, I always add BIT32 for all the memory, then
> > the PA returned by the mtk_iommu_iova_to_phys(in v7s) always
> > is from 0x1_0000_0000 to 0x1_ffff_ffff. But the SW still expect the PA
> > is from 0x4000_0000 - 0x1_3fff_ffff. Thus, I guess I will add a new
> > patch like this:
> >
> > @@ -418,6 +418,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct
> > iommu_domain *domain,
> >                                           dma_addr_t iova)
> >  {
> >         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> >         unsigned long flags;
> >         phys_addr_t pa;
> >
> > @@ -425,6 +426,11 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct
> > iommu_domain *domain,
> >         pa = dom->iop->iova_to_phys(dom->iop, iova);
> >         spin_unlock_irqrestore(&dom->pgtlock, flags);
> >
> > +       /* Discard bit32 if pa is 0x1_4000_0000 -0x1_ffff_ffff in 4GB mode. */
> > +       if (data->plat_data->has_4gb_mode && data->enable_4GB &&
> > +           pa >= 0x140000000)
> > +               paddr &= ~BIT_ULL(32);
> > +
> 
> Right. I had noticed this in my previous reply about the old code, but
> forgot about the place where we just jam in that BIT32 in the new code
> for enable_4GB, which would lead to returning PAs to the rest of the
> system outside of the valid range of 0x4000_0000 - 0x1_3fff_ffff. Good
> catch.
> 
> The hardcoded PA is horribly ugly, I'm trying to think of a better way
> to do this. I've got nothing at the moment...

Yes, the hard code is not good. And I also don't get a better name for
this, thus use the address into the MACRO. see [v6 21/22].

> 
> I guess this also lends another point towards #1 of my two variants
> being the correct picture of things.
> 
> >         return pa;
> >  }
> >
> >
> > > longer doing that there, so I won't worry about it.
> > > * Now, if you're in the 4GB mode, you just slam the bit in the PTE in
> > > mtk_iommu_map, which seems like the right thing to do.
> > > * The general functions in io-pgtable-arm-v7s.c now carefully reflect
> > > bits 32 & 33 in the PTE, since the new IOMMUs don't have the weird
> > > restriction of staying above 4GB, and there's not this weird 4GB
> > > aliasing mode going on (which I think would be a clearer name for this
> > > feature: has_4gb_alias).
> >
> > A more beautiful name. But our internal and all the CODA call this "4GB
> > mode"..thus I'd like to keep it....
> 
> Sigh.
> 
> >
> > >
> > > >
> > > > >
> > > > > Also, you could have rolled the has_4gb_mode check into whether or not
> > > > > you set enable_4GB. Then you're doing the check for has_4gb_mode once,
> > > > > rather than on every map call.
> > > >
> > > > "has_4gb_mode" means this SoC support 4GB mode.
> > > > "enable_4GB" means whether the current dram size is 4GB.
> > >
> > > Right. But your use of the variable as well as it's name suggest that
> > > it really means "is 4GB aliasing mode on", not "does the system have
> > > >=4GB of RAM". You could reduce the map function to one conditional if
> > > you treated the variable that way. Then the only things that would
> > > need to change would be:
> > > * Add an extra conditional in probe that would only set enable_4GB if
> > > has_4gb_mode is set.
> >
> > I guess I still don't get this. the enable_4GB and has_4gb_mode are not
> > the same. Take mt8173 as a example when its dram size is 2G. it
> > has_4gb_mode, but we can not enable_4GB at that time.(if dram size is
> > 2G, the HW will not remap the PA address, we can not add BIT32 at that
> > time.)
> 
> Right. So enable_4GB would be false there, since your code in probe
> would look like:
> data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> if (!data->plat_data->has_4gb_mode)
>     data->enable_4GB = false;
> 
> Then mtk_iommu_map would only have:
> if (data->enable_4GB)
>         paddr |= BIT_ULL(32);
> 
> Said differently: right now every place enable_4GB is read, there is
> (or could be with no change in behavior) a check just before it for
> has_4gb_mode, so roll that check into enable_4GB.
> 
> Anyway, this isn't a huge deal, it just seemed nice to save the extra
> conditional in the map function, which I imagine might be a hot
> function.

Thanks for this explanation with the code. I guess I get it.

I have to apologized that I misread this when I prepare v6. I thought it
may be NG when mt8183 use 4GB. But I realize it is also ok when I reply
this mail. Embarrassed!

The logical is a little complex and the string "enable_4GB" confused me.
Thus, I use a new patch[v6 20/22] to change it to "dram_is_4gb" for
readable.

If you still prefer the solution above, I can send v7.

> 
> >
> > > * in mtk_iommu_domain_finalize, you could just always set the MTK
> > > quirk, since if you have <4GB of RAM, those bits will never get set in
> > > the PTEs anyway.
> >
> > oh. Yes. this looks right.
> >
> > > * I suspect mtk_iommu_hw_init would continue to work as-is, since
> > > everything that has vld_pa_rng also has has_4gb_mode.
> >
> > mt8173 has 4gb_mode but it doesn't has vld_pa_rng.
> 
> Right, so that conditional would continue to stay false, as it should.
> Put differently, that conditional in mtk_iommu_hw_init() could be
> replaced with no functional difference by:
> 
> if ((data->has_4gb_mode && data->enable_4GB) && data->plat_data->vld_pa_rng)
> 
> since everything that has vld_pa_rng also has has_4gb_mode.
> -Evan
