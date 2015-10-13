From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3] iommu/arm-smmu: Add support for MSI on SMMUv3
Date: Tue, 13 Oct 2015 18:04:30 +0100
Message-ID: <561D399E.4040706@arm.com>
References: <1444315920-11906-1-git-send-email-marc.zyngier@arm.com>
	<20151013154145.GR21550@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151013154145.GR21550-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 13/10/15 16:41, Will Deacon wrote:
> Hi Marc,
> 
> On Thu, Oct 08, 2015 at 03:52:00PM +0100, Marc Zyngier wrote:
>> Despite being a platform device, the SMMUv3 is capable of signaling
>> interrupts using MSIs. Hook it into the platform MSI framework and
>> enjoy faults being reported in a new and exciting way.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
>> ---
>> * From v2:
>>   - MSI indexes as an enum
>>   - Fixed stupid 16bit writes instead of 32bit
>>   - Added devm callback to release MSIs on teardown
>>   - Moved all the MSI setup to its own function
>>
>>  drivers/iommu/arm-smmu-v3.c | 108 ++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 99 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 5b11b77..3f7f096 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/iommu.h>
>>  #include <linux/iopoll.h>
>>  #include <linux/module.h>
>> +#include <linux/msi.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_platform.h>
>> @@ -403,6 +404,12 @@ enum pri_resp {
>>  	PRI_RESP_SUCC,
>>  };
>>  
>> +enum msi_index {
>> +	EVTQ_MSI_INDEX,
>> +	GERROR_MSI_INDEX,
>> +	PRIQ_MSI_INDEX,
>> +};
>> +
>>  struct arm_smmu_cmdq_ent {
>>  	/* Common fields */
>>  	u8				opcode;
>> @@ -2176,6 +2183,92 @@ static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
>>  					  1, ARM_SMMU_POLL_TIMEOUT_US);
>>  }
>>  
>> +static void arm_smmu_free_msis(void *data)
>> +{
>> +	struct arm_smmu_device *smmu = data;
>> +	platform_msi_domain_free_irqs(smmu->dev);
> 
> So the smmu structure here is also managed by devm. What guarantees that
> it doesn't get freed before your callback is invoked?

Because the whole devm thing is managed as a stack (each allocation or
action is pushed on the stack), and actions are popped off the stack on
teardown. See add_dr/release_nodes. This guarantee that the smmu
structure cannot be free before the MSIs are released.

Now, a good way to settle the matter would be to pass the device
structure instead of the smmu, removing the dependency altogether.

> Also, none of this compiles if PCI_MSI=n.

Gahh. Obviously, we need to select GENERIC_MSI_IRQ_DOMAIN. I'll update
this as well.

>> +}
>> +
>> +static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>> +{
>> +	struct device *dev = msi_desc_to_dev(desc);
>> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +	phys_addr_t cfg0_offset, cfg1_offset, cfg2_offset;
>> +	phys_addr_t doorbell;
>> +
>> +	switch (desc->platform.msi_index) {
>> +	case EVTQ_MSI_INDEX:
>> +		cfg0_offset = ARM_SMMU_EVTQ_IRQ_CFG0;
>> +		cfg1_offset = ARM_SMMU_EVTQ_IRQ_CFG1;
>> +		cfg2_offset = ARM_SMMU_EVTQ_IRQ_CFG2;
>> +		break;
>> +	case GERROR_MSI_INDEX:
>> +		cfg0_offset = ARM_SMMU_GERROR_IRQ_CFG0;
>> +		cfg1_offset = ARM_SMMU_GERROR_IRQ_CFG1;
>> +		cfg2_offset = ARM_SMMU_GERROR_IRQ_CFG2;
>> +		break;
>> +	case PRIQ_MSI_INDEX:
>> +		cfg0_offset = ARM_SMMU_PRIQ_IRQ_CFG0;
>> +		cfg1_offset = ARM_SMMU_PRIQ_IRQ_CFG1;
>> +		cfg2_offset = ARM_SMMU_PRIQ_IRQ_CFG2;
>> +		break;
>> +	default:		/* Unknown */
>> +		return;
>> +	}
>> +
>> +	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>> +	doorbell &= MSI_CFG0_ADDR_MASK << MSI_CFG0_ADDR_SHIFT;
>> +
>> +	writeq_relaxed(doorbell, smmu->base + cfg0_offset);
>> +	writel_relaxed(msg->data, smmu->base + cfg1_offset);
>> +	writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
>> +		       smmu->base + cfg2_offset);
> 
> This looks like the wrong way around to me. Once we've set a non-zero
> doorbell, the hardware will switch to using MSI, so there's a potential
> race where it generates an interrupt before we've initialised the payload.

We should be fine: we start by disabling interrupts (which is the only
sane way to update the MSI registers). It is only the end of
arm_smmu_setup_irq that we enable interrupts, which makes sure that the
hardware will not generate any MSI in the interval.

I'll update the above and repost.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
