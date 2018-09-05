From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: avoid redundant CMD_SYNCs if
 possible
Date: Wed, 5 Sep 2018 09:15:20 +0800
Message-ID: <5B8F2E28.6060201@huawei.com>
References: <1534665071-7976-1-git-send-email-thunder.leizhen@huawei.com>
 <1534665071-7976-3-git-send-email-thunder.leizhen@huawei.com>
 <992a5e9a-ba0c-e25f-b881-89aa914d3a36@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <992a5e9a-ba0c-e25f-b881-89aa914d3a36@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>
List-Id: iommu@lists.linux-foundation.org



On 2018/8/30 19:18, John Garry wrote:
> On 19/08/2018 08:51, Zhen Lei wrote:
>>      spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
> 
> I find something like this adds support for combining CMD_SYNC commands for regular polling mode:
> 
> @@ -569,6 +569,7 @@ struct arm_smmu_device {
>         int                             combined_irq;
>         u32                             sync_nr;
>         u8                              prev_cmd_opcode;
> +       int                             prev_cmd_sync_res;
> 
>         unsigned long                   ias; /* IPA */
>         unsigned long                   oas; /* PA */
> @@ -985,17 +986,33 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
> 
>  static int __arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>  {
> -       u64 cmd[CMDQ_ENT_DWORDS];
> +       static u64 cmd[CMDQ_ENT_DWORDS] = {
> +               _FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
> +               _FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV) |
> +               _FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
> +               _FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB)
> +       };
>         unsigned long flags;
>         bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
> -       struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
> -       int ret;
> +       int ret = 0;
> 
> -       arm_smmu_cmdq_build_cmd(cmd, &ent);
> 
>         spin_lock_irqsave(&smmu->cmdq.lock, flags);
> -       arm_smmu_cmdq_insert_cmd(smmu, cmd);
> -       ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
> +       if (smmu->prev_cmd_opcode != CMDQ_OP_CMD_SYNC ||
> +               smmu->prev_cmd_sync_res != 0) {
> +               arm_smmu_cmdq_insert_cmd(smmu, cmd);
> +               smmu->prev_cmd_sync_res = ret =
> +                       queue_poll_cons(&smmu->cmdq.q, true, wfe);
> +       }
> 
> I tested iperf on a 1G network link and was seeing 6-10% CMD_SYNC commands combined. I would really need to test this on a faster connection to see any throughout difference.
> 
> From the above figures, I think leizhen was seeing 25% combine rate, right?

Yes. In my test case, the size of unmap are almost one page, that means 1 TLBI follows 1 SYNC,
so the probability that two CMD_SYNCs next to each other will be greater.

> 
> As for this code, it could be neatened...
> 
> Cheers,
> John
> 
>>
>>      return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
>> -- 
>> 1.8.3
>>
>>
>>
>> .
>>
> 
> 
> 
> .
> 

-- 
Thanks!
BestRegards
