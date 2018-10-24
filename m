From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Date: Wed, 24 Oct 2018 23:18:27 +0530
Message-ID: <CAFp+6iFWZ9DGGHedqVLrGZqXPsS9RMbe4QgpJr5skJdd4m+RSA@mail.gmail.com>
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org> <CAAFQd5AMirap5vjVC+73cv_KzE=-+EUD6TWd_NHRDw_m-sXDrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAFQd5AMirap5vjVC+73cv_KzE=-+EUD6TWd_NHRDw_m-sXDrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: pdaly@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

On Tue, Oct 23, 2018 at 9:45 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Vivek,
>
> On Fri, Jun 15, 2018 at 7:53 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
> > Qualcomm SoCs have an additional level of cache called as
> > System cache or Last level cache[1]. This cache sits right
> > before the DDR, and is tightly coupled with the memory
> > controller.
> > The cache is available to all the clients present in the
> > SoC system. The clients request their slices from this system
> > cache, make it active, and can then start using it. For these
> > clients with smmu, to start using the system cache for
> > dma buffers and related page tables [2], few of the memory
> > attributes need to be set accordingly.
> > This change makes the related memory Outer-Shareable, and
> > updates the MAIR with necessary protection.
> >
> > The MAIR attribute requirements are:
> >     Inner Cacheablity = 0
> >     Outer Cacheablity = 1, Write-Back Write Allocate
> >     Outer Shareablity = 1
> >
> > This change is a realisation of following changes
> > from downstream msm-4.9:
> > iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT
> > iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT
>
> Would you be able to provide links to those 2 downstream changes?

Thanks for the review.
Here are the links for the changes:
[1] -- iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT
[2] -- iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
[2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602

>
> >
> > [1] https://patchwork.kernel.org/patch/10422531/
> > [2] https://patchwork.kernel.org/patch/10302791/
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > ---
> >  drivers/iommu/arm-smmu.c       | 14 ++++++++++++++
> >  drivers/iommu/io-pgtable-arm.c | 24 +++++++++++++++++++-----
> >  drivers/iommu/io-pgtable.h     |  4 ++++
> >  include/linux/iommu.h          |  4 ++++
> >  4 files changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index f7a96bcf94a6..8058e7205034 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -249,6 +249,7 @@ struct arm_smmu_domain {
> >         struct mutex                    init_mutex; /* Protects smmu pointer */
> >         spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
> >         struct iommu_domain             domain;
> > +       bool                            has_sys_cache;
> >  };
> >
> >  struct arm_smmu_option_prop {
> > @@ -862,6 +863,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >
> >         if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
> >                 pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> > +       if (smmu_domain->has_sys_cache)
> > +               pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
> >
> >         smmu_domain->smmu = smmu;
> >         pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
> > @@ -1477,6 +1480,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >         case DOMAIN_ATTR_NESTING:
> >                 *(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
> >                 return 0;
> > +       case DOMAIN_ATTR_USE_SYS_CACHE:
> > +               *((int *)data) = smmu_domain->has_sys_cache;
> > +               return 0;
> >         default:
> >                 return -ENODEV;
> >         }
> > @@ -1506,6 +1512,14 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
> >                         smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
> >
> >                 break;
> > +       case DOMAIN_ATTR_USE_SYS_CACHE:
> > +               if (smmu_domain->smmu) {
> > +                       ret = -EPERM;
> > +                       goto out_unlock;
> > +               }
> > +               if (*((int *)data))
> > +                       smmu_domain->has_sys_cache = true;
> > +               break;
> >         default:
> >                 ret = -ENODEV;
> >         }
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 010a254305dd..b2aee1828524 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -169,9 +169,11 @@
> >  #define ARM_LPAE_MAIR_ATTR_DEVICE      0x04
> >  #define ARM_LPAE_MAIR_ATTR_NC          0x44
> >  #define ARM_LPAE_MAIR_ATTR_WBRWA       0xff
> > +#define ARM_LPAE_MAIR_ATTR_SYS_CACHE   0xf4
> >  #define ARM_LPAE_MAIR_ATTR_IDX_NC      0
> >  #define ARM_LPAE_MAIR_ATTR_IDX_CACHE   1
> >  #define ARM_LPAE_MAIR_ATTR_IDX_DEV     2
> > +#define ARM_LPAE_MAIR_ATTR_IDX_SYS_CACHE       3
> >
> >  /* IOPTE accessors */
> >  #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
> > @@ -442,6 +444,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> >                 else if (prot & IOMMU_CACHE)
> >                         pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
> >                                 << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> > +               else if (prot & IOMMU_SYS_CACHE)
> > +                       pte |= (ARM_LPAE_MAIR_ATTR_IDX_SYS_CACHE
> > +                               << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> > +
>
> Okay, so we favor the full caching (IC WBRWA, OC WBRWA, OS) first if
> requested or otherwise try to use system cache (IC NC, OC WBWA?, OS)?
> Sounds fine.

That's right. When devices can use full caching, the system cache will
also be used. Otherwise when devices can't allocate/use inner caches,
system cache (Outer WBRWA, and IC NC) is the option.

>
> nit: Unnecessary blank line.

will remove it.

>
> >         } else {
> >                 pte = ARM_LPAE_PTE_HAP_FAULT;
> >                 if (prot & IOMMU_READ)
> > @@ -771,7 +777,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
> >         u64 reg;
> >         struct arm_lpae_io_pgtable *data;
> >
> > -       if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
> > +       if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
> > +                           IO_PGTABLE_QUIRK_SYS_CACHE))
> >                 return NULL;
> >
> >         data = arm_lpae_alloc_pgtable(cfg);
> > @@ -779,9 +786,14 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
> >                 return NULL;
> >
> >         /* TCR */
> > -       reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > -             (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > -             (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> > +       if (cfg->quirks & IO_PGTABLE_QUIRK_SYS_CACHE) {
> > +               reg = (ARM_LPAE_TCR_SH_OS << ARM_LPAE_TCR_SH0_SHIFT) |
> > +                     (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT);
>
> Contrary to the earlier code which favored IC/IS if possible, here we
> seem to disable IC/IS if the SYS_CACHE quirk is requested, regardless
> of whether it could still be desirable to use IC/IS. Perhaps rather
> than
> IO_PGTABLE_QUIRK_SYS_CACHE, we need something like
> IO_PGTABLE_QUIRK_NO_INNER_CACHE?

IIUC, with QUIRK_NO_INNER_CACHE, we would explicitly handle the case
of non I/O-coherent devices that can't use inner caches.
Other devices will have coherent view of inner as well as outer caches
(including system cache).
Do I understand you correctly?

Best regards
Vivek
>
> > +       } else {
> > +               reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > +                     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT);
> > +       }
> > +       reg |= (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> >
>
> [keeping the context]
>
> Best regards,
> Tomasz
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
