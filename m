From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 1/2] iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq
	lock
Date: Thu, 18 Oct 2018 12:19:51 +0100
Message-ID: <535fd13d-4cc5-e551-01d9-f7eb05c3ddb0@arm.com>
References: <61b4c3e5f1322dfe96ca2062a7fe058298340996.1539782799.git.robin.murphy@arm.com>
	<2c4e00a2-cd53-a6f5-8561-97379dcf9c02@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2c4e00a2-cd53-a6f5-8561-97379dcf9c02-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 18/10/18 11:55, John Garry wrote:
[...]
>> @@ -976,18 +1019,19 @@ static int __arm_smmu_cmdq_issue_sync(struct =

>> arm_smmu_device *smmu)
>> =A0{
>> =A0=A0=A0=A0 u64 cmd[CMDQ_ENT_DWORDS];
>> =A0=A0=A0=A0 unsigned long flags;
>> -=A0=A0=A0 bool wfe =3D !!(smmu->features & ARM_SMMU_FEAT_SEV);
>> =A0=A0=A0=A0 struct arm_smmu_cmdq_ent ent =3D { .opcode =3D CMDQ_OP_CMD_=
SYNC };
>> -=A0=A0=A0 int ret;
>> +=A0=A0=A0 int sync_idx, sync_gen;
>>
>> =A0=A0=A0=A0 arm_smmu_cmdq_build_cmd(cmd, &ent);
>>
>> =A0=A0=A0=A0 spin_lock_irqsave(&smmu->cmdq.lock, flags);
>> -=A0=A0=A0 arm_smmu_cmdq_insert_cmd(smmu, cmd);
>> -=A0=A0=A0 ret =3D queue_poll_cons(&smmu->cmdq.q, true, wfe);
>> +=A0=A0=A0 if (smmu->prev_cmd_opcode !=3D CMDQ_OP_CMD_SYNC)
>> +=A0=A0=A0=A0=A0=A0=A0 arm_smmu_cmdq_insert_cmd(smmu, cmd);
> =

> Hi Robin,
> =

> If we did stop rebuilding the non-MSI command as I suggested, then we =

> would not have the case of building the command and then discarding it, =

> right?

I suppose so. But that build/discard case can also be avoided by =

applying patch 2/2 of this series ;)

Robin.

> =

> Thanks,
> John
> =

>> +=A0=A0=A0 sync_idx =3D smmu->cmdq.q.prod;
>> +=A0=A0=A0 sync_gen =3D READ_ONCE(smmu->cmdq_generation);
>> =A0=A0=A0=A0 spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
>>
>> -=A0=A0=A0 return ret;
>> +=A0=A0=A0 return arm_smmu_sync_poll_cons(smmu, sync_idx, sync_gen);
>> =A0}
>>
>> =A0static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>>
> =

> =
