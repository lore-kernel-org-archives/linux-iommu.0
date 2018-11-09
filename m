From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu: arm-smmu: Set SCTLR.HUPCF bit
Date: Fri, 9 Nov 2018 13:01:55 -0500
Message-ID: <CAF6AEGtgC0V6ii2=p2HGmqvHFKNJhaOLi8873SGPDsrg70xGRg@mail.gmail.com>
References: <20180927224609.19515-1-robdclark@gmail.com> <20181029191000.GD16739@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029191000.GD16739@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, freedreno <freedreno@lists.freedesktop.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 29, 2018 at 3:09 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Sep 27, 2018 at 06:46:07PM -0400, Rob Clark wrote:
> > We seem to need to set either this or CFCFG (stall), otherwise gpu
> > faults trigger problems with other in-flight transactions from the
> > GPU causing CP errors, etc.
> >
> > In the ARM SMMU spec, the 'Hit under previous context fault' bit is
> > described as:
> >
> >  '0' - Stall or terminate subsequent transactions in the presence
> >        of an outstanding context fault
> >  '1' - Process all subsequent transactions independently of any
> >        outstanding context fault.
> >
> > Since we don't enable CFCFG (stall) the behavior of terminating
> > other transactions makes sense.  And is probably not what we want
> > (and definately not what we want for GPU).
> >
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > ---
> > So I hit this issue a long time back on 820 (msm8996) and at the
> > time I solved it with a patch that enabled CFCFG.  And it resurfaced
> > more recently on sdm845.  But at the time CFCFG was rejected, iirc
> > because of concern that it would cause problems on other non-qcom
> > arm smmu implementations.  And I think I forgot to send this version
> > of the solution.
> >
> > If enabling HUPCF is anticipated to cause problems on other ARM
> > SMMU implementations, I think I can come up with a variant of this
> > patch which conditionally enables it for snapdragon.
> >
> > Either way, I'd really like to get some variant of this fix merged
> > (and probably it would be a good idea for stable kernel branches
> > too), since current behaviour with the GPU means faults turn into
> > a fantastic cascade of fail.
>
> Can you describe how this fantastic cascade of fail improves with this
> patch, please? If you're getting context faults then something has already
> gone horribly wrong, so I'm trying to work out how this improves things.
>

There are plenty of cases where getting iommu faults with a GPU is
"normal", or at least not something the kernel or even GL driver can
control.

With this patch, you still get the iommu fault, but it doesn't cause
the gpu to crash.  But without it, other memory accesses in flight
while the fault occurs, like the GPU command-processor reading further
ahead in the cmdstream to setup next draw, would return zero's,
causing the GPU to crash or get into a bad state.

BR,
-R

> > diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> > index a1226e4ab5f8..2291925eb800 100644
> > --- a/drivers/iommu/arm-smmu-regs.h
> > +++ b/drivers/iommu/arm-smmu-regs.h
> > @@ -178,6 +178,7 @@ enum arm_smmu_s2cr_privcfg {
> >  #define ARM_SMMU_CB_ATSR             0x8f0
> >
> >  #define SCTLR_S1_ASIDPNE             (1 << 12)
> > +#define SCTLR_HUPCF                  (1 << 8)
> >  #define SCTLR_CFCFG                  (1 << 7)
> >  #define SCTLR_CFIE                   (1 << 6)
> >  #define SCTLR_CFRE                   (1 << 5)
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index f7a96bcf94a6..47ffc9aade72 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -713,9 +713,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> >       reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
> >       if (stage1)
> >               reg |= SCTLR_S1_ASIDPNE;
> > +     reg |= SCTLR_HUPCF;
>
> Maybe just throw this into the assignment a couple of lines above?
>
> >       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> >               reg |= SCTLR_E;
> > -
>
> Random whitespace change.
>
> Will
