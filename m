From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu: Log CBFRSYNRA register on context fault
Date: Tue, 23 Apr 2019 13:16:18 +0200
Message-ID: <CAKv+Gu-W4x-8Aha6vV6xjfmkt1X+Yhb_hjxXTsqdUyCpb4XHHA@mail.gmail.com>
References: <20190422071036.32671-1-vivek.gautam@codeaurora.org> <149dee19-e2eb-0b27-3df0-c99a05e8bea1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <149dee19-e2eb-0b27-3df0-c99a05e8bea1@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 23 Apr 2019 at 13:13, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 22/04/2019 08:10, Vivek Gautam wrote:
> > Bits[15:0] in CBFRSYNRA register contain information about
> > StreamID of the incoming transaction that generated the
> > fault. Dump CBFRSYNRA register to get this info.
> > This is specially useful in a distributed SMMU architecture
> > where multiple masters are connected to the SMMU.
> > SID information helps to quickly identify the faulting
> > master device.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v1:
> >   - Addressed review comments, given by Bjorn, for nits.
> >
> >   drivers/iommu/arm-smmu-regs.h | 2 ++
> >   drivers/iommu/arm-smmu.c      | 7 +++++--
> >   2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> > index a1226e4ab5f8..e9132a926761 100644
> > --- a/drivers/iommu/arm-smmu-regs.h
> > +++ b/drivers/iommu/arm-smmu-regs.h
> > @@ -147,6 +147,8 @@ enum arm_smmu_s2cr_privcfg {
> >   #define CBAR_IRPTNDX_SHIFT          24
> >   #define CBAR_IRPTNDX_MASK           0xff
> >
> > +#define ARM_SMMU_GR1_CBFRSYNRA(n)    (0x400 + ((n) << 2))
> > +
> >   #define ARM_SMMU_GR1_CBA2R(n)               (0x800 + ((n) << 2))
> >   #define CBA2R_RW64_32BIT            (0 << 0)
> >   #define CBA2R_RW64_64BIT            (1 << 0)
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 045d93884164..e000473f8205 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -575,7 +575,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> >       struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +     void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
> >       void __iomem *cb_base;
> > +     u32 cbfrsynra;
>
> Nit: I would simply add to the existing "u32 fsr, fsynr;" declaration,
> but that's the sort of thing that could hopefully be fixed up when
> applying (or otherwise I might bulldoze it anyway in my eventual rework
> of register accesses throughout the driver). Regardless,
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> >       cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
> >       fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> > @@ -585,10 +587,11 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >
> >       fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
> >       iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> > +     cbfrsynra = readl_relaxed(gr1_base + ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
> >
> >       dev_err_ratelimited(smmu->dev,
> > -     "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> > -                         fsr, iova, fsynr, cfg->cbndx);
> > +     "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> > +                         fsr, iova, fsynr, cbfrsynra, cfg->cbndx);
> >
> >       writel(fsr, cb_base + ARM_SMMU_CB_FSR);
> >       return IRQ_HANDLED;
> >
>

This is something I've had to hack up locally in the past, so

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
