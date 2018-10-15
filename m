From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
Date: Mon, 15 Oct 2018 18:36:52 +0100
Message-ID: <5fa2a259-b070-f8de-77d3-73eb8ac14d59@arm.com>
References: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
 <20181015172146.GD31305@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015172146.GD31305@brain-police>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, LinuxArm <linuxarm@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 15/10/18 18:21, Will Deacon wrote:
> On Mon, Oct 15, 2018 at 04:36:16PM +0800, Zhen Lei wrote:
>> ITS translation register map:
>> 0x0000-0x003C	Reserved
>> 0x0040		GITS_TRANSLATER
>> 0x0044-0xFFFC	Reserved
>>
>> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
>> expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
>> data will be written to MSIAddress each time.
>>
>> MSIAddr: |----4bytes----|----4bytes----|
>> 	 |    MSIData   |    IMPDEF    |
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
>>
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
>>   
>>   	struct arm_smmu_strtab_cfg	strtab_cfg;
>>   
>> +	union {
>> +	u64				padding; /* workaround for Hisilicon */
>>   	u32				sync_count;
>> +	} __attribute__((aligned(8)));
> 
> Won't this already be aligned by the ABI?
> 
> Anyway, you'll need to swizzle things for big-endian, I suspect. Maybe you
> can do something clever like making sync_count an array of two elements
> and determining the offset based on the endianness. Or just keep it simple
> like we do for things like struct qrwlock and struct qspinlock and use
> #ifdefs.

I don't think so - the CPUs should only ever be making word accesses to 
the u32 member, while the SMMU expects to be writing little-endian data 
to an ITS, so AFAICS the data word will always be at the lower address 
either way.

Although now that it's come up, the pre-existing issue of whether the 
byte order *within* that u32 comes out correct after its round-trip 
through the SMMU is something I need to run away and hurriedly think 
about...

Robin.
