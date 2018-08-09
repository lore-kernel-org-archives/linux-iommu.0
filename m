From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
Date: Thu, 9 Aug 2018 18:05:20 +0800
Message-ID: <5B6C11E0.9030908@huawei.com>
References: <1533558689-3000-1-git-send-email-thunder.leizhen@huawei.com>
 <20180808101215.GB28557@arm.com> <5B6B994B.10208@huawei.com>
 <20180809084901.GA28801@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809084901.GA28801@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>
List-Id: iommu@lists.linux-foundation.org



On 2018/8/9 16:49, Will Deacon wrote:
> On Thu, Aug 09, 2018 at 09:30:51AM +0800, Leizhen (ThunderTown) wrote:
>> On 2018/8/8 18:12, Will Deacon wrote:
>>> On Mon, Aug 06, 2018 at 08:31:29PM +0800, Zhen Lei wrote:
>>>> The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
>>>> __arm_smmu_sync_poll_msi requires that sync_idx must be increased
>>>> monotonously according to the sequence of the CMDs in the cmdq.
>>>>
>>>> But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
>>>> by spinlock, so the following scenarios may appear:
>>>> cpu0			cpu1
>>>> msidata=0
>>>> 			msidata=1
>>>> 			insert cmd1
>>>> insert cmd0
>>>> 			smmu execute cmd1
>>>> smmu execute cmd0
>>>> 			poll timeout, because msidata=1 is overridden by
>>>> 			cmd0, that means VAL=0, sync_idx=1.
>>>
>>> Oh yuck, you're right! We probably want a CC stable on this. Did you see
>>> this go wrong in practice?
>> Just misreported and make the caller wait for a long time until TIMEOUT. It's
>> rare to happen, because any other CMD_SYNC during the waiting period will break
>> it.
> 
> Thanks. Please mention that in the commit message, because I think it's
> useful to know.

OK.

> 
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  drivers/iommu/arm-smmu-v3.c | 7 +++----
>>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>>> index 1d64710..4810f61 100644
>>>> --- a/drivers/iommu/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>>> @@ -566,7 +566,7 @@ struct arm_smmu_device {
>>>>
>>>>  	int				gerr_irq;
>>>>  	int				combined_irq;
>>>> -	atomic_t			sync_nr;
>>>> +	u32				sync_nr;
>>>>
>>>>  	unsigned long			ias; /* IPA */
>>>>  	unsigned long			oas; /* PA */
>>>> @@ -836,7 +836,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>>>  			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>>>>  		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
>>>>  		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
>>>> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);
>>>>  		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
>>>>  		break;
>>>>  	default:
>>>> @@ -947,7 +946,6 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>>>>  	struct arm_smmu_cmdq_ent ent = {
>>>>  		.opcode = CMDQ_OP_CMD_SYNC,
>>>>  		.sync	= {
>>>> -			.msidata = atomic_inc_return_relaxed(&smmu->sync_nr),
>>>>  			.msiaddr = virt_to_phys(&smmu->sync_count),
>>>>  		},
>>>>  	};
>>>> @@ -955,6 +953,8 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>>>>  	arm_smmu_cmdq_build_cmd(cmd, &ent);
>>>>
>>>>  	spin_lock_irqsave(&smmu->cmdq.lock, flags);
>>>> +	ent.sync.msidata = ++smmu->sync_nr;
>>>> +	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent.sync.msidata);
>>>
>>> I really don't like splitting this out from building the rest of the
>>> command. Can you just move the call to arm_smmu_cmdq_build_cmd into the
>>> critical section, please?
>> OK. I have considered that before, just worry it will increase the
>> compition of spinlock.
> 
> If you can provide numbers showing that it's a problem, then we could add
> a helper function e.g. arm_smmu_cmdq_sync_set_msidata(arm_smmu_cmdq_ent *cmd)

The performance data from my current test envirnoment is not stable now, I'm
trying to find anothor one. So I want to leave this problem for the time being.
If it'a problem, I will send a new patch.

> 
>> In addition, I will append a optimization patch: the adjacent CMD_SYNCs,
>> we only need one.
> 
> Ok, but please keep them separate, since I don't want to fix up fixes and
> optimisations.

OK

> 
> Thanks,
> 
> Will
> 
> .
> 

-- 
Thanks!
BestRegards
