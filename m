From: Geetha Akula <geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu-v3: Add workaround for Cavium
	ThunderX2 erratum #126
Date: Wed, 21 Jun 2017 12:09:45 +0530
Message-ID: <CANHdaiYb8gG5+OjiSBkSGfyNnt4=WDze08qW1JXA9-F66HE9ZA@mail.gmail.com>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
	<1497968259-16390-4-git-send-email-gakula@caviumnetworks.com>
	<20170620180038.GC28035@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170620180038.GC28035-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Tue, Jun 20, 2017 at 11:30 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Tue, Jun 20, 2017 at 07:47:39PM +0530, Geetha sowjanya wrote:
>> From: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
>> lines for gerror, eventq and cmdq-sync.
>>
>> SHARED_IRQ option is set as a errata workaround, which allows to share the irq
>> line by register single irq handler for all the interrupts.
>>
>> Signed-off-by: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> ---
>>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    5 ++
>>  drivers/iommu/arm-smmu-v3.c                        |   73 ++++++++++++++++----
>>  2 files changed, 64 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>> index 6ecc48c..44b40e0 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>> @@ -55,6 +55,11 @@ the PCIe specification.
>>                     Set for Caviun ThunderX2 silicon that doesn't support
>>                     SMMU page1 register space.
>>
>> +- cavium,cn9900-broken-unique-irqline
>> +                    : Use single irq line for all the SMMUv3 interrupts.
>> +                   Set for Caviun ThunderX2 silicon that doesn't support
>> +                   MSI and also doesn't have unique irq lines for gerror,
>> +                   eventq and cmdq-sync.
>
> I think we're better off just supporting a new (optional) named interrupt
> as "combined", and then allowing that to be used instead of the others.

Are you suggesting to have new name irq "combined" like gerror ?
If yes, then this won't be possible with apci. We need to update iort spec to
add new name irq.
>
>>  ** Example
>>
>>          smmu@2b400000 {
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 2dea4a9..6c0c632 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -598,6 +598,7 @@ struct arm_smmu_device {
>>
>>  #define ARM_SMMU_OPT_SKIP_PREFETCH   (1 << 0)
>>  #define ARM_SMMU_OPT_PAGE0_REGS_ONLY (1 << 1)
>> +#define ARM_SMMU_OPT_SHARED_IRQ      (1 << 2)
>
> Please call this COMBINED instead of SHARED (similarly elsewhere). That
> said, not sure we need this.
>
>>       u32                             options;
>>
>>       struct arm_smmu_cmdq            cmdq;
>> @@ -665,6 +666,7 @@ struct arm_smmu_option_prop {
>>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>>       { ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
>>       { ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
>> +     { ARM_SMMU_OPT_SHARED_IRQ, "cavium,cn9900-broken-unique-irqline"},
>>       { 0, NULL},
>>  };
>>
>> @@ -1313,6 +1315,21 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>>       writel(gerror, smmu->base + ARM_SMMU_GERRORN);
>>       return IRQ_HANDLED;
>>  }
>> +/* Shared irq handler*/
>> +static irqreturn_t arm_smmu_shared_irq_thread(int irq, void *dev)
>> +{
>> +     struct arm_smmu_device *smmu = dev;
>> +     irqreturn_t ret;
>> +
>> +     ret = arm_smmu_gerror_handler(irq, dev);
>> +     if (ret == IRQ_NONE) {
>> +             arm_smmu_evtq_thread(irq, dev);
>> +             arm_smmu_cmdq_sync_handler(irq, dev);
>> +             if (smmu->features & ARM_SMMU_FEAT_PRI)
>> +                     arm_smmu_priq_thread(irq, dev);
>> +     }
>> +     return IRQ_HANDLED;
>> +}
>
> This isn't quite right, because you're now running low-level handlers (like
> the gerror handler) in threaded context. You're better off registering a
> low-level handler too (see below) which can kick gerror and cmdq_sync
> before unconditionally returning IRQ_WAKE_THREAD.

+static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
+{
+       struct arm_smmu_device *smmu = dev;
+
+       arm_smmu_evtq_thread(irq, dev);
+       if (smmu->features & ARM_SMMU_FEAT_PRI)
+               arm_smmu_priq_thread(irq, dev);
+
+       return IRQ_HANDLED;
+}
+
+static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
+{
+       irqreturn_t ret;
+
+       ret = arm_smmu_gerror_handler(irq, dev);
+       if (ret == IRQ_NONE) {
+               arm_smmu_cmdq_sync_handler(irq, dev);
+               return IRQ_WAKE_THREAD;
+       }
+       else
+               return ret;
+}

>
>>
>>  /* IO_PGTABLE API */
>>  static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>> @@ -2230,18 +2247,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>       devm_add_action(dev, arm_smmu_free_msis, dev);
>>  }
>>
>> -static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>> +static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>>  {
>> -     int ret, irq;
>> -     u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
>> -
>> -     /* Disable IRQs first */
>> -     ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
>> -                                   ARM_SMMU_IRQ_CTRLACK);
>> -     if (ret) {
>> -             dev_err(smmu->dev, "failed to disable irqs\n");
>> -             return ret;
>> -     }
>> +     int irq, ret;
>>
>>       arm_smmu_setup_msis(smmu);
>>
>> @@ -2284,10 +2292,46 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>                       if (ret < 0)
>>                               dev_warn(smmu->dev,
>>                                        "failed to enable priq irq\n");
>> -                     else
>> -                             irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
>>               }
>>       }
>> +}
>> +
>> +static void arm_smmu_setup_shared_irqs(struct arm_smmu_device *smmu)
>> +{
>> +     int ret, irq;
>> +
>> +     /* Single irq is used for all queues, request single interrupt lines */
>> +     irq = smmu->evtq.q.irq;
>> +     if (irq) {
>> +             ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
>
> As above, stick your low-level handler in instead of NULL here.
>
>> +                                     arm_smmu_shared_irq_thread,
>> +                                     IRQF_ONESHOT | IRQF_SHARED,
>
> Why do you need IRQF_SHARED here?


+devm_request_threaded_irq(smmu->dev, irq,
+                                       arm_smmu_combined_irq_handler,
+                                       arm_smmu_combined_irq_thread,
+                                       IRQF_SHARED,
+                                       "arm-smmu-v3-combined-irq", smmu);

On multi-node system, node1 SMMU's share irq lines with node0 SMMU's.

>
>> +                                     "arm-smmu-v3-shared_irq", smmu);
>
> Call this "combined" instead of shared, to avoid confusion with the IRQ
> flags.
>
>> +             if (ret < 0)
>> +                     dev_warn(smmu->dev, "failed to enable shared irq\n");
>> +     }
>> +}
>> +
>> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>> +{
>> +     int ret;
>> +     u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
>> +
>> +     /* Disable IRQs first */
>> +     ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
>> +                                   ARM_SMMU_IRQ_CTRLACK);
>> +     if (ret) {
>> +             dev_err(smmu->dev, "failed to disable irqs\n");
>> +             return ret;
>> +     }
>> +
>> +     if (smmu->options & ARM_SMMU_OPT_SHARED_IRQ)
>> +             arm_smmu_setup_shared_irqs(smmu);
>> +     else
>> +             arm_smmu_setup_unique_irqs(smmu);
>
> I'd rather just have something like:
>
>   irq = platform_get_irq_byname(pdev, "combined");
>
> in the arm_smmu_device_probe function. If we find it's there, we use that
> in preference to the other interrupts.
>
> Will

Thanks,
Geetha.
