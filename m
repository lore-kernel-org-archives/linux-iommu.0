From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
Date: Thu, 16 Aug 2018 10:27:38 +0100
Message-ID: <ad5bd6c0-20bd-9581-a12a-4464e5ec69f6@arm.com>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
 <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
 <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com> <5B7533FD.20903@huawei.com>
 <20180816091805.GB31093@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180816091805.GB31093@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 2018-08-16 10:18 AM, Will Deacon wrote:
> On Thu, Aug 16, 2018 at 04:21:17PM +0800, Leizhen (ThunderTown) wrote:
>> On 2018/8/15 20:26, Robin Murphy wrote:
>>> On 15/08/18 11:23, Zhen Lei wrote:
>>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>>> index 1d64710..3f5c236 100644
>>>> --- a/drivers/iommu/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>>> @@ -566,7 +566,7 @@ struct arm_smmu_device {
>>>>
>>>>        int                gerr_irq;
>>>>        int                combined_irq;
>>>> -    atomic_t            sync_nr;
>>>> +    u32                sync_nr;
>>>>
>>>>        unsigned long            ias; /* IPA */
>>>>        unsigned long            oas; /* PA */
>>>> @@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>>>>        return 0;
>>>>    }
>>>>
>>>> +static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)
>>>
>>> If we *are* going to go down this route then I think it would make sense
>>> to move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e.
>>> arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync
>>> command, then calling this guy would convert it to an MSI-based one.
>>> As-is, having bits of mutually-dependent data handled across two
>>> separate places just seems too messy and error-prone.
>>
>> Yes, How about create a new function "arm_smmu_cmdq_build_sync_msi_cmd"?
>>
>> static inline
>> void arm_smmu_cmdq_build_sync_msi_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>> {
>> 	cmd[0]  = FIELD_PREP(CMDQ_0_OP, ent->opcode);
>> 	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
>> 	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
>> 	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
>> 	cmd[1]  = ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
>> }
> 
> None of this seems justified given the numbers from John, so please just do
> the simple thing and build the command with the lock held.

Agreed - sorry if my wording was unclear, but that suggestion was only 
for the possibility of it proving genuinely worthwhile to build the 
command outside the lock. Since that isn't the case, I definitely prefer 
the simpler approach too.

Robin.
