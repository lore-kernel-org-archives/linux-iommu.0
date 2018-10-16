From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
Date: Tue, 16 Oct 2018 17:27:14 +0800
Message-ID: <5BC5AEF2.9030505@huawei.com>
References: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
 <db0943c2-7a20-d0f9-0a2c-e37b57618761@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <db0943c2-7a20-d0f9-0a2c-e37b57618761@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: LinuxArm <linuxarm@huawei.com>, nd@arm.com
List-Id: iommu@lists.linux-foundation.org



On 2018/10/15 21:52, Robin Murphy wrote:
> On 15/10/18 09:36, Zhen Lei wrote:
>> ITS translation register map:
>> 0x0000-0x003C    Reserved
>> 0x0040        GITS_TRANSLATER
>> 0x0044-0xFFFC    Reserved
>>
>> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
>> expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
>> data will be written to MSIAddress each time.
>>
>> MSIAddr: |----4bytes----|----4bytes----|
>>      |    MSIData   |    IMPDEF    |
>>
>> There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
>> But it will overwrite the 4 bytes memory following "sync_count". It's very
>> luckly that the previous and the next neighbour of "sync_count" are both aligned
>> by 8 bytes, so no problem is met now.
>>
>> It's good to explicitly add a workaround:
>> 1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is always
>>     aligned by 8 bytes.
>> 2. Add a "u64" union member to make sure the 4 bytes padding is always exist.
> 
> Surely the u64 member inherently makes the union, and thus the u32 member as well, 64-bit-aligned anyway?

Yes, we really only need one step, "1." or "2.". As John Garry suggested, I will change it to "struct" mode.

> 
> Robin.
> 
>> There is no functional change.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 5059d09..a07bc0d 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -586,7 +586,10 @@ struct arm_smmu_device {
>>         struct arm_smmu_strtab_cfg    strtab_cfg;
>>   +    union {
>> +    u64                padding; /* workaround for Hisilicon */
>>       u32                sync_count;
>> +    } __attribute__((aligned(8)));
>>         /* IOMMU core code handle */
>>       struct iommu_device        iommu;
>>
> 
> 

-- 
Thanks!
BestRegards
