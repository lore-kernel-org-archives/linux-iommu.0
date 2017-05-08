From: Geetha Akula <geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 6/7] iommu/arm-smmu-v3: Add workaround for Cavium
	ThunderX2 erratum #126
Date: Mon, 8 May 2017 17:32:34 +0530
Message-ID: <CANHdaiaw4sB+bMY8LcyQGXbnAfKNk5zX6_893M0gqKrVNmeFuQ@mail.gmail.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
	<1493986091-30521-7-git-send-email-gakula@caviumnetworks.com>
	<a2618ab6-6609-7885-3b62-c1c1f170c318@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a2618ab6-6609-7885-3b62-c1c1f170c318-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 8, 2017 at 4:51 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 05/05/17 13:08, Geetha sowjanya wrote:
>> From: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
>> lines for gerror, eventq and cmdq-sync.
>>
>> This patch addresses the issue by checking if any interrupt sources are
>> using same irq number, then they are registered as shared irqs.
>>
>> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 32 ++++++++++++++++++++++++++++----
>>  1 file changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 016b702..46428e7 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -2236,10 +2236,30 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>       devm_add_action(dev, arm_smmu_free_msis, dev);
>>  }
>>
>> +static int get_irq_flags(struct arm_smmu_device *smmu, int irq)
>> +{
>> +     int match_count = 0;
>> +
>> +     if (irq == smmu->evtq.q.irq)
>> +             match_count++;
>> +     if (irq == smmu->cmdq.q.irq)
>> +             match_count++;
>> +     if (irq == smmu->gerr_irq)
>> +             match_count++;
>> +     if (irq == smmu->priq.q.irq)
>> +             match_count++;
>> +
>> +     if (match_count > 1)
>> +             return IRQF_SHARED | IRQF_ONESHOT;
>> +
>> +     return 0;
>
> I'd say just have this return IRQF_ONESHOT in the non-shared case...
>
>> +}
>> +
>>  static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>  {
>>       int ret, irq;
>>       u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
>> +     u32 irqflags = 0;
>>
>>       /* Disable IRQs first */
>>       ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
>> @@ -2254,9 +2274,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>       /* Request interrupt lines */
>>       irq = smmu->evtq.q.irq;
>>       if (irq) {
>> +             irqflags = get_irq_flags(smmu, irq);
>>               ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
>>                                               arm_smmu_evtq_thread,
>> -                                             IRQF_ONESHOT,
>> +                                             IRQF_ONESHOT | irqflags,
>
> ...and pass get_irq_flags(smmu, irq) directly as the argument here.
>
> The local variable and intermediate logic only seem to add unnecessary
> complexity, given that the two cases we actually end up with are:
>
> IRQF_ONESHOT | 0
>
> vs.
>
> IRQF_ONESHOT | IRQF_SHARED | IRQF_ONESHOT
>
> neither of which looks particularly sensible.
>
> Robin.
>
I will resubmit the patch with suggested changes.

Thank you,
Geetha.



>>                                               "arm-smmu-v3-evtq", smmu);
>>               if (ret < 0)
>>                       dev_warn(smmu->dev, "failed to enable evtq irq\n");
>> @@ -2264,8 +2285,9 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>
>>       irq = smmu->cmdq.q.irq;
>>       if (irq) {
>> +             irqflags = get_irq_flags(smmu, irq);
>>               ret = devm_request_irq(smmu->dev, irq,
>> -                                    arm_smmu_cmdq_sync_handler, 0,
>> +                                    arm_smmu_cmdq_sync_handler, irqflags,
>>                                      "arm-smmu-v3-cmdq-sync", smmu);
>>               if (ret < 0)
>>                       dev_warn(smmu->dev, "failed to enable cmdq-sync irq\n");
>> @@ -2273,8 +2295,9 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>
>>       irq = smmu->gerr_irq;
>>       if (irq) {
>> +             irqflags = get_irq_flags(smmu, irq);
>>               ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
>> -                                    0, "arm-smmu-v3-gerror", smmu);
>> +                                    irqflags, "arm-smmu-v3-gerror", smmu);
>>               if (ret < 0)
>>                       dev_warn(smmu->dev, "failed to enable gerror irq\n");
>>       }
>> @@ -2282,9 +2305,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>       if (smmu->features & ARM_SMMU_FEAT_PRI) {
>>               irq = smmu->priq.q.irq;
>>               if (irq) {
>> +                     irqflags = get_irq_flags(smmu, irq);
>>                       ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
>>                                                       arm_smmu_priq_thread,
>> -                                                     IRQF_ONESHOT,
>> +                                                     IRQF_ONESHOT | irqflags,
>>                                                       "arm-smmu-v3-priq",
>>                                                       smmu);
>>                       if (ret < 0)
>>
>
