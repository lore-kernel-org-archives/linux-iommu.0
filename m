From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 2/2] iommu/arm-smmu-v3: Reunify
	arm_smmu_cmdq_issue_sync()
Date: Thu, 18 Oct 2018 12:18:18 +0100
Message-ID: <06a949af-2660-3efa-a315-5f45620c139b@arm.com>
References: <61b4c3e5f1322dfe96ca2062a7fe058298340996.1539782799.git.robin.murphy@arm.com>
	<fe1b23d1980dd110eb2e8ffc01c2dd68632566d1.1539782799.git.robin.murphy@arm.com>
	<b35bb171-013b-3cb7-9a99-78505b9fdd18@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b35bb171-013b-3cb7-9a99-78505b9fdd18-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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

Hi John,

On 17/10/18 15:38, John Garry wrote:
> On 17/10/2018 14:56, Robin Murphy wrote:
>> Now that both sync methods are more or less the same shape, we can save
>> some code and levels of indirection by rolling them up together again,
>> with just a couple of simple conditionals to discriminate the MSI and
>> queue-polling specifics.
> =

> Hi Robin, Will,
> =

> I had been thinking of this other patch previously:
> =

> iommu/arm-smmu-v3: Stop rebuilding non-MSI CMD_SYNC commands
> =

> The contents of the non-MSI CMD_SYNC command are fixed. This patch =

> offers a small optimisation by keeping a sample of this command on the =

> heap for re-use, thereby avoiding unnecessary re-building.

As far as I can tell, not counting the general call overhead which can =

be solved in less-specific ways, this essentially saves two MOVs, a =

MOVK, and an STP which in practice might not even reach L1 before it =

gets forwarded back out of the store buffer. Do you have any numbers for =

what difference this makes in terms of I/O performance or cache traffic?

Robin.

> Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> =

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 6947ccf..9d86c29 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -963,14 +963,16 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct =

> arm_smmu_device *smmu)
> =

>  =A0static int __arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>  =A0{
> -=A0=A0=A0=A0=A0=A0 u64 cmd[CMDQ_ENT_DWORDS];
> +=A0=A0=A0=A0=A0=A0 static u64 cmd[CMDQ_ENT_DWORDS] =3D {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CM=
D_SYNC) |
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_=
SYNC_0_CS_SEV) |
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_=
SMMU_SH_ISH) |
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, =
ARM_SMMU_MEMATTR_OIWB),
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0};
>  =A0=A0=A0=A0=A0=A0=A0 unsigned long flags;
>  =A0=A0=A0=A0=A0=A0=A0 bool wfe =3D !!(smmu->features & ARM_SMMU_FEAT_SEV=
);
> -=A0=A0=A0=A0=A0=A0 struct arm_smmu_cmdq_ent ent =3D { .opcode =3D CMDQ_O=
P_CMD_SYNC };
>  =A0=A0=A0=A0=A0=A0=A0 int ret;
> =

> -=A0=A0=A0=A0=A0=A0 arm_smmu_cmdq_build_cmd(cmd, &ent);
> -
>  =A0=A0=A0=A0=A0=A0=A0 spin_lock_irqsave(&smmu->cmdq.lock, flags);
>  =A0=A0=A0=A0=A0=A0=A0 arm_smmu_cmdq_insert_cmd(smmu, cmd);
>  =A0=A0=A0=A0=A0=A0=A0 ret =3D queue_poll_cons(&smmu->cmdq.q, true, wfe);
> =

> But it seems that combining the the MSI and non-MSI methods would block =

> this.
> =

> How do you feel about this?
> =

> Thanks,
> John
> =

>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>> =A0drivers/iommu/arm-smmu-v3.c | 49 +++++++++----------------------------
>> =A01 file changed, 12 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index da8a91d116bf..36db63e3afcf 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -933,7 +933,7 @@ static void arm_smmu_cmdq_issue_cmd(struct =

>> arm_smmu_device *smmu,
>> =A0 * The difference between val and sync_idx is bounded by the maximum =

>> size of
>> =A0 * a queue at 2^20 entries, so 32 bits is plenty for wrap-safe =

>> arithmetic.
>> =A0 */
>> -static int __arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 =

>> sync_idx)
>> +static int arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 =

>> sync_idx)
>> =A0{
>> =A0=A0=A0=A0 ktime_t timeout;
>> =A0=A0=A0=A0 u32 val;
>> @@ -988,16 +988,17 @@ static int arm_smmu_sync_poll_cons(struct =

>> arm_smmu_device *smmu, u32 sync_idx,
>> =A0=A0=A0=A0 return -ETIMEDOUT;
>> =A0}
>>
>> -static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>> +static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>> =A0{
>> =A0=A0=A0=A0 u64 cmd[CMDQ_ENT_DWORDS];
>> =A0=A0=A0=A0 unsigned long flags;
>> -=A0=A0=A0 struct arm_smmu_cmdq_ent ent =3D {
>> -=A0=A0=A0=A0=A0=A0=A0 .opcode =3D CMDQ_OP_CMD_SYNC,
>> -=A0=A0=A0=A0=A0=A0=A0 .sync=A0=A0=A0 =3D {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .msiaddr =3D cpu_to_le32(virt_to_phys=
(&smmu->sync_count)),
>> -=A0=A0=A0=A0=A0=A0=A0 },
>> -=A0=A0=A0 };
>> +=A0=A0=A0 bool msi =3D (smmu->features & ARM_SMMU_FEAT_MSI) &&
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (smmu->features & ARM_SMMU_FEAT_COHERENC=
Y);
>> +=A0=A0=A0 struct arm_smmu_cmdq_ent ent =3D { .opcode =3D CMDQ_OP_CMD_SY=
NC };
>> +=A0=A0=A0 int ret, sync_idx, sync_gen;
>> +
>> +=A0=A0=A0 if (msi)
>> +=A0=A0=A0=A0=A0=A0=A0 ent.sync.msiaddr =3D cpu_to_le32(virt_to_phys(&sm=
mu->sync_count));
>>
>> =A0=A0=A0=A0 spin_lock_irqsave(&smmu->cmdq.lock, flags);
>>
>> @@ -1009,39 +1010,13 @@ static int =

>> __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>> =A0=A0=A0=A0=A0=A0=A0=A0 arm_smmu_cmdq_build_cmd(cmd, &ent);
>> =A0=A0=A0=A0=A0=A0=A0=A0 arm_smmu_cmdq_insert_cmd(smmu, cmd);
>> =A0=A0=A0=A0 }
>> -
>> -=A0=A0=A0 spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
>> -
>> -=A0=A0=A0 return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
>> -}
>> -
>> -static int __arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>> -{
>> -=A0=A0=A0 u64 cmd[CMDQ_ENT_DWORDS];
>> -=A0=A0=A0 unsigned long flags;
>> -=A0=A0=A0 struct arm_smmu_cmdq_ent ent =3D { .opcode =3D CMDQ_OP_CMD_SY=
NC };
>> -=A0=A0=A0 int sync_idx, sync_gen;
>> -
>> -=A0=A0=A0 arm_smmu_cmdq_build_cmd(cmd, &ent);
>> -
>> -=A0=A0=A0 spin_lock_irqsave(&smmu->cmdq.lock, flags);
>> -=A0=A0=A0 if (smmu->prev_cmd_opcode !=3D CMDQ_OP_CMD_SYNC)
>> -=A0=A0=A0=A0=A0=A0=A0 arm_smmu_cmdq_insert_cmd(smmu, cmd);
>> =A0=A0=A0=A0 sync_idx =3D smmu->cmdq.q.prod;
>> =A0=A0=A0=A0 sync_gen =3D READ_ONCE(smmu->cmdq_generation);
>> +
>> =A0=A0=A0=A0 spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
>>
>> -=A0=A0=A0 return arm_smmu_sync_poll_cons(smmu, sync_idx, sync_gen);
>> -}
>> -
>> -static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>> -{
>> -=A0=A0=A0 int ret;
>> -=A0=A0=A0 bool msi =3D (smmu->features & ARM_SMMU_FEAT_MSI) &&
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (smmu->features & ARM_SMMU_FEAT_COHERENC=
Y);
>> -
>> -=A0=A0=A0 ret =3D msi ? __arm_smmu_cmdq_issue_sync_msi(smmu)
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0 : __arm_smmu_cmdq_issue_sync(smmu);
>> +=A0=A0=A0 ret =3D msi ? arm_smmu_sync_poll_msi(smmu, ent.sync.msidata)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 : arm_smmu_sync_poll_cons(smmu, sync_idx, s=
ync_gen);
>> =A0=A0=A0=A0 if (ret)
>> =A0=A0=A0=A0=A0=A0=A0=A0 dev_err_ratelimited(smmu->dev, "CMD_SYNC timeou=
t\n");
>> =A0}
>>
> =

> =
