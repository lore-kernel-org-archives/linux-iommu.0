From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Thu, 5 Jan 2017 10:27:27 -0500
Message-ID: <CAF6AEGsUdZALAQTozmxPV8Os=3pG7ay=1Oqtctx99FV9_4SX7Q@mail.gmail.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
 <1483479056-15202-2-git-send-email-robdclark@gmail.com> <20170105115528.GG679@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170105115528.GG679-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 5, 2017 at 6:55 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Tue, Jan 03, 2017 at 04:30:54PM -0500, Rob Clark wrote:
>> TODO maybe we want two options, one to enable stalling, and 2nd to punt
>> handling to wq?  I haven't needed to use mm APIs from fault handler yet
>> (although it is something that I think we'll want some day).  Perhaps
>> stalling support is limited to just letting driver dump some extra
>> debugging information otherwise.  Threaded handling probably only useful
>> with stalling, but inverse may not always be true.
>
> I'd actually like to see this stuck on a worker thread, because I think
> that's more generally useful and I don't want to have a situation where
> sometimes the IOMMU fault notifier is run in IRQ context and sometimes it's
> not.

So I was talking a bit w/ Jordan on IRC yesterday..  and we also have
the GPU's hw hang-detect to contend with.  So I *suspect* that when we
get to the point of using this to do things like page in things from
swap and resume the faulting transaction, we probably want to get
called immediately from the IRQ handler so we can disable the hw
hang-detect.

I'm not sure if the better solution then would be to have two fault
callbacks, one immediately from the IRQ and a later one from wq.  Or
let the driver handle the wq business and give it a way to tell the
IOMMU when to resume.

I kinda think we should punt on the worker thread for now until we are
ready to resume faulting transactions, because I guess a strong chance
that whatever way we do it now will be wrong ;-)

>>
>> Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/iommu/arm,smmu.txt         |  3 ++
>>  drivers/iommu/arm-smmu.c                           | 42 ++++++++++++++++++----
>>  2 files changed, 39 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index ef465b0..5f405a6 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -68,6 +68,9 @@ conditions.
>>                    aliases of secure registers have to be used during
>>                    SMMU configuration.
>>
>> +- arm,smmu-enable-stall : Enable stall mode to stall memory transactions
>> +                  and resume after fault is handled
>> +
>>  ** Deprecated properties:
>>
>>  - mmu-masters (deprecated in favour of the generic "iommus" binding) :
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index d505432..a71cb8f 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -350,6 +350,7 @@ struct arm_smmu_device {
>>       u32                             features;
>>
>>  #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
>> +#define ARM_SMMU_OPT_ENABLE_STALL      (1 << 1)
>>       u32                             options;
>>       enum arm_smmu_arch_version      version;
>>       enum arm_smmu_implementation    model;
>> @@ -425,6 +426,7 @@ static bool using_legacy_binding, using_generic_binding;
>>
>>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>>       { ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
>> +     { ARM_SMMU_OPT_ENABLE_STALL,      "arm,smmu-enable-stall" },
>>       { 0, NULL},
>>  };
>>
>> @@ -676,7 +678,8 @@ static struct iommu_gather_ops arm_smmu_gather_ops = {
>>
>>  static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>>  {
>> -     u32 fsr, fsynr;
>> +     int flags, ret;
>> +     u32 fsr, fsynr, resume;
>>       unsigned long iova;
>>       struct iommu_domain *domain = dev;
>>       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> @@ -690,15 +693,40 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>>       if (!(fsr & FSR_FAULT))
>>               return IRQ_NONE;
>>
>> +     if (fsr & FSR_IGN)
>> +             dev_err_ratelimited(smmu->dev,
>> +                                 "Unexpected context fault (fsr 0x%x)\n",
>> +                                 fsr);
>> +
>>       fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
>> -     iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
>> +     flags = fsynr & FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
>>
>> -     dev_err_ratelimited(smmu->dev,
>> -     "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
>> -                         fsr, iova, fsynr, cfg->cbndx);
>> +     iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
>> +     if (!report_iommu_fault(domain, smmu->dev, iova, flags)) {
>> +             ret = IRQ_HANDLED;
>> +             resume = RESUME_RETRY;
>> +     } else {
>> +             dev_err_ratelimited(smmu->dev,
>> +                 "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
>> +                 iova, fsynr, cfg->cbndx);
>> +             ret = IRQ_NONE;
>> +             resume = RESUME_TERMINATE;
>> +     }
>>
>> +     /* Clear the faulting FSR */
>>       writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>> -     return IRQ_HANDLED;
>> +
>> +     /* Retry or terminate any stalled transactions */
>> +     if (fsr & FSR_SS) {
>> +             /* Should we care about ending up w/ a stalled transaction
>> +              * when we didn't ask for it?  I guess for now best to call
>> +              * attention to it and resume anyways.
>> +              */
>> +             WARN_ON(!(smmu->options & ARM_SMMU_OPT_ENABLE_STALL));
>
> I don't think we need to care about this. If we're getting stall faults
> with CFCFG clear, then something has gone drastically wrong in the hardware
> and we'll probably see "Unhandled context fault" anyway.

ok, I can drop the WARN_ON()

>> +             writel_relaxed(resume, cb_base + ARM_SMMU_CB_RESUME);
>> +     }
>> +
>> +     return ret;
>>  }
>>
>>  static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>> @@ -824,6 +852,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>
>>       /* SCTLR */
>>       reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
>> +     if (smmu->options & ARM_SMMU_OPT_ENABLE_STALL)
>> +             reg |= SCTLR_CFCFG;
>
> I wonder if this should also be predicated on the compatible string, so
> that the "arm,smmu-enable-stall" property is ignored (with a warning) if
> the compatible string isn't specific enough to identify an implementation
> with the required SS behaviour? On the other hand, it feels pretty
> redundant and a single "stalling works" property is all we need.

We could also drop the property and key the behavior on specific
compat strings I guess.  Having both seems a bit odd.  Anyways, I'll
defer to DT folks about what the cleaner approach is.

BR,
-R

> I added the devicetree folks to CC for an opinion..
>
> Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
