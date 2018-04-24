From: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 2/2] iommu/arm-smmu-v3: Support software retention for
	pm_resume
Date: Tue, 24 Apr 2018 19:56:49 +0800
Message-ID: <6110799e-ad3b-f963-0632-c161e8f68b9f@huawei.com>
References: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
	<1524483959-54940-3-git-send-email-xieyisheng1@huawei.com>
	<f947a71e-4348-c4f7-d900-9b75ca5bc073@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f947a71e-4348-c4f7-d900-9b75ca5bc073-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thanks for your comment.
On 2018/4/24 0:14, Robin Murphy wrote:
> On 23/04/18 12:45, Yisheng Xie wrote:
>> When system suspend, hisilicon's smmu will do power gating for smmu,
>> this time smmu's reg will be set to default value for not having
>> hardware retention, which means need software do the retention instead.
>>
>> The patch is to use arm_smmu_device_reset() to restore the register of
>> smmu. However, it need to save the msis setting at probe if smmu do not
>> support hardware retention.
>>
>> Signed-off-by: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 69 +++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 66 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 044df6e..6cb56d8 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -534,6 +534,11 @@ struct arm_smmu_strtab_cfg {
>>       u32                strtab_base_cfg;
>>   };
>>   +struct arm_smmu_msi_val {
>> +    u64                doorbell;
>> +    u32                data;
>> +};
> 
> What does this do that struct msi_msg doesn't already (apart from take up more space in an array)?

Right, struct msi_msg can be used instead, and memcpy can be used when save the msi_msg.

> 
>> +
>>   /* An SMMUv3 instance */
>>   struct arm_smmu_device {
>>       struct device            *dev;
>> @@ -558,6 +563,7 @@ struct arm_smmu_device {
>>     #define ARM_SMMU_OPT_SKIP_PREFETCH    (1 << 0)
>>   #define ARM_SMMU_OPT_PAGE0_REGS_ONLY    (1 << 1)
>> +#define ARM_SMMU_OPT_SW_RETENTION    (1 << 2)
>>       u32                options;
>>         struct arm_smmu_cmdq        cmdq;
>> @@ -587,6 +593,8 @@ struct arm_smmu_device {
>>         u32                sync_count;
>>   +    struct arm_smmu_msi_val        *msi;
>> +    bool                probed;
> 
> This looks really hacky. I'm sure there's probably enough driver model information
> to be able to identify the probe state from just the struct device, but that's still
> not the right way to go. If you need to know this, then it can only mean we've got
> one-time software state initialisation mixed in with the actual hardware reset which
> programs the software state into the device. Thus there should be some refactoring to
> properly separate those concerns.

So you mean status enum should use instead? Maybe something like:
enum arm_smmu_status {
	ARM_SMMU_INACTIVE;
	ARM_SMMU_ACTIVE;
	ARM_SMMU_SUSPEND;
};
to indicate the status of device ?

> 
>>       bool                bypass;
>>         /* IOMMU core code handle */
>> @@ -630,6 +638,7 @@ struct arm_smmu_option_prop {
>>   static struct arm_smmu_option_prop arm_smmu_options[] = {
>>       { ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
>>       { ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
>> +    { ARM_SMMU_OPT_SW_RETENTION, "hisilicon,broken-hardware-retention" },
> 
> That seems a bit over-specific - there are going to be any number of SMMU implementations/integrations
> which may or may not implement hardware retention states. More crucially, it's also backwards. Making
> the driver assume that *every* SMMU implements hardware retention unless this new DT property is present
> is quite obviously completely wrong, especially for ACPI...
> 
I was thought about remove the word *hisilicon* for other implement may
also not have hardware retention. Anyway, this a wrong for ACPI cannot
works without hardware retention.

> The sensible thing to do is to implement suspend/resume support which works in general, *then* consider
> optimising it for cases where explicitly restoring the hardware state may be skipped (if indeed it makes
> a significant difference).

Yes, we should make it common, what I was doubt is that whether should enable it
by default or not, for someone who do not want do power gating at all when suspend,
it may suffer from device reset when resume ?

> Are there not already generic DT/ACPI properties for describing the retention
> levels of different power states, which could be made use of here?

AFAIK no, and I have just tried to find some clue from the document of DT/ACPI
but do not find any usefull information. Do you have any idea or clue about it?

>>       { 0, NULL},
>>   };
>>   @@ -2228,7 +2237,8 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>>       phys_addr_t doorbell;
>>       struct device *dev = msi_desc_to_dev(desc);
>>       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> -    phys_addr_t *cfg = arm_smmu_msi_cfg[desc->platform.msi_index];
>> +    int msi_index = desc->platform.msi_index;
>> +    phys_addr_t *cfg = arm_smmu_msi_cfg[msi_index];
>>         doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>>       doorbell &= MSI_CFG0_ADDR_MASK;
>> @@ -2236,6 +2246,28 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>>       writeq_relaxed(doorbell, smmu->base + cfg[0]);
>>       writel_relaxed(msg->data, smmu->base + cfg[1]);
>>       writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>> +
>> +    if (smmu->options & ARM_SMMU_OPT_SW_RETENTION) {
> 
> The overhead of writing an extra 12 bytes per MSI to memory is entirely negligible;
> saving the message data just doesn't warrant the complexity of being conditional. 
> In fact, given the need to untangle the IRQ requests from the hardware reset, I'd
> rather expect to end up *only* saving the message here, and writing the IRQ_CFG
> registers later along with everything else.

I will use msi_msg instead in next version.

> 
>> +        smmu->msi[msi_index].doorbell = doorbell;
>> +        smmu->msi[msi_index].data = msg->data;
>> +    }
>> +}
>> +
>> +static void arm_smmu_restore_msis(struct arm_smmu_device *smmu)
>> +{
>> +    int nevc = ARM_SMMU_MAX_MSIS - 1;
>> +
>> +    if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>> +        nevc--;
>> +
>> +    for (; nevc >= 0; nevc--) {
>> +        phys_addr_t *cfg = arm_smmu_msi_cfg[nevc];
>> +        struct arm_smmu_msi_val msi_val = smmu->msi[nevc];
>> +
>> +        writeq_relaxed(msi_val.doorbell, smmu->base + cfg[0]);
>> +        writel_relaxed(msi_val.data, smmu->base + cfg[1]);
>> +        writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>> +    }
>>   }
>>     static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>> @@ -2261,6 +2293,16 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>           return;
>>       }
>>   +    if (smmu->probed) {
>> +        BUG_ON(!(smmu->options & ARM_SMMU_OPT_SW_RETENTION));
>> +        arm_smmu_restore_msis(smmu);
>> +        return;
>> +    } else if (smmu->options & ARM_SMMU_OPT_SW_RETENTION) {
>> +        smmu->msi = devm_kmalloc_array(dev, nvec,
>> +                           sizeof(*(smmu->msi)),
>> +                           GFP_KERNEL);
>> +    }
> 
> A single code path which either allocates an empty array *or* writes the contents of that array to hardware is a clear "you're doing it wrong" indicator. Yes, this definitely wants refactoring.

Right!

> 
>> +
>>       /* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
>>       ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
>>       if (ret) {
>> @@ -2294,6 +2336,9 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>>         arm_smmu_setup_msis(smmu);
>>   +    if (smmu->probed)
>> +        return;
>> +
>>       /* Request interrupt lines */
>>       irq = smmu->evtq.q.irq;
>>       if (irq) {
>> @@ -2348,7 +2393,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>       }
>>         irq = smmu->combined_irq;
>> -    if (irq) {
>> +    if (irq && !smmu->probed) {
>>           /*
>>            * Cavium ThunderX2 implementation doesn't not support unique
>>            * irq lines. Use single irq line for all the SMMUv3 interrupts.
>> @@ -2360,7 +2405,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>                       "arm-smmu-v3-combined-irq", smmu);
>>           if (ret < 0)
>>               dev_warn(smmu->dev, "failed to enable combined irq\n");
>> -    } else
>> +    } else if (!irq)
>>           arm_smmu_setup_unique_irqs(smmu);
>>         if (smmu->features & ARM_SMMU_FEAT_PRI)
>> @@ -2882,6 +2927,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>           if (ret)
>>               return ret;
>>       }
>> +
>> +    smmu->probed = true;
>> +
>>       return 0;
>>   }
>>   @@ -2899,6 +2947,20 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>>       arm_smmu_device_remove(pdev);
>>   }
>>   +static int arm_smmu_pm_resume(struct device *dev)
>> +{
>> +    struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>> +    if (smmu->options & ARM_SMMU_OPT_SW_RETENTION)
>> +        return arm_smmu_device_reset(smmu);
> 
> Given the SYSTEM_SLEEP_PM_OPS below, does your hardware really preserve state across hibernate/restore as well?

Sorry, I not quite get this point, and maybe I was missing something.
What's state should also be preserved by software?

Thanks
Yisheng
> That would be particularly impressive ;)
> 
> Robin.
> 
