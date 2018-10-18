From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v5 1/2] iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq
 lock
Date: Thu, 18 Oct 2018 12:48:07 +0100
Message-ID: <3e52b993-a850-301e-85e1-71597df45dc5@huawei.com>
References: <61b4c3e5f1322dfe96ca2062a7fe058298340996.1539782799.git.robin.murphy@arm.com>
 <2c4e00a2-cd53-a6f5-8561-97379dcf9c02@huawei.com>
 <535fd13d-4cc5-e551-01d9-f7eb05c3ddb0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <535fd13d-4cc5-e551-01d9-f7eb05c3ddb0@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, will.deacon@arm.com
Cc: iommu@lists.linux-foundation.org, Linuxarm <linuxarm@huawei.com>, linux-arm-kernel@lists.infradead.org, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 18/10/2018 12:19, Robin Murphy wrote:
> On 18/10/18 11:55, John Garry wrote:
> [...]
>>> @@ -976,18 +1019,19 @@ static int __arm_smmu_cmdq_issue_sync(struct
>>> arm_smmu_device *smmu)
>>>  {
>>>      u64 cmd[CMDQ_ENT_DWORDS];
>>>      unsigned long flags;
>>> -    bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
>>>      struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
>>> -    int ret;
>>> +    int sync_idx, sync_gen;
>>>
>>>      arm_smmu_cmdq_build_cmd(cmd, &ent);
>>>
>>>      spin_lock_irqsave(&smmu->cmdq.lock, flags);
>>> -    arm_smmu_cmdq_insert_cmd(smmu, cmd);
>>> -    ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
>>> +    if (smmu->prev_cmd_opcode != CMDQ_OP_CMD_SYNC)
>>> +        arm_smmu_cmdq_insert_cmd(smmu, cmd);
>>
>> Hi Robin,
>>
>> If we did stop rebuilding the non-MSI command as I suggested, then we
>> would not have the case of building the command and then discarding
>> it, right?
>
> I suppose so. But that build/discard case can also be avoided by
> applying patch 2/2 of this series ;)

OK, I'll check it more detail. TBH, I found 2/2 hard to follow from just 
the diff.

Thanks,
John

>
> Robin.
>
>>
>> Thanks,
>> John
>>
>>> +    sync_idx = smmu->cmdq.q.prod;
>>> +    sync_gen = READ_ONCE(smmu->cmdq_generation);
>>>      spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
>>>
>>> -    return ret;
>>> +    return arm_smmu_sync_poll_cons(smmu, sync_idx, sync_gen);
>>>  }
>>>
>>>  static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>>>
>>
>>
>
> .
>
