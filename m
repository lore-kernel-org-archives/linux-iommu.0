From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V4] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
Date: Fri, 4 Mar 2016 10:09:02 -0800
Message-ID: <56D9CF3E.7080607@caviumnetworks.com>
References: <1457063043-10623-1-git-send-email-tchalamarla@caviumnetworks.com>
	<20160304160221.GC7886@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160304160221.GC7886-5wv7dgnIgG8@public.gmane.org>
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
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 03/04/2016 08:02 AM, Will Deacon wrote:
> On Thu, Mar 03, 2016 at 07:44:03PM -0800, Tirumalesh Chalamarla wrote:
>> Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
>> namespaces; specifically within a given node SMMU0 and SMMU1 share,
>> as does SMMU2 and SMMU3.
>>
>> This patch make sures ASID and VMID space is unique across cavium SMMUv2.
>>
>> changes from V3:
>> 	- Removed redundent variable.
>
> [...]
>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 247a469..bfe38f3 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -326,6 +326,11 @@ struct arm_smmu_device {
>>
>>   	struct list_head		list;
>>   	struct rb_root			masters;
>> +	/*
>> +	 *The following fields are specific to Cavium, Thunder
>> +	 */
>> +	u32				cavium_id_base;
>> +
>>   };
>>
>>   struct arm_smmu_cfg {
>> @@ -335,8 +340,8 @@ struct arm_smmu_cfg {
>>   };
>>   #define INVALID_IRPTNDX			0xff
>>
>> -#define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
>> -#define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
>> +#define ARM_SMMU_CB_ASID(smmu, cfg) ((u16)(smmu)->cavium_id_base + (cfg)->cbndx)
>> +#define ARM_SMMU_CB_VMID(smmu, cfg) ((u16)(smmu)->cavium_id_base + (cfg)->cbndx + 1)
>>
>>   enum arm_smmu_domain_stage {
>>   	ARM_SMMU_DOMAIN_S1 = 0,
>> @@ -364,6 +369,8 @@ struct arm_smmu_option_prop {
>>   	const char *prop;
>>   };
>>
>> +static u32 cavium_smmu_context_count;
>
> I thought you were going to make this an atomic_t?
well i moved variable handling inside atomic context.
with atomic_t i still needed 2 operations like read and add
it seems atomic_add_return is not sufficient.

in any case i thought why not use the atomic context that is already 
there. if you feel the use of atomic_t is more natural, i will resend 
again.

Thanks,
Tirumalesh.
>
> Will
>
