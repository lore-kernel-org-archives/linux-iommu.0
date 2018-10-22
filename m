From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 2/2] iommu/arm-smmu-v3: Reunify
	arm_smmu_cmdq_issue_sync()
Date: Mon, 22 Oct 2018 13:29:15 +0100
Message-ID: <dbe0e7bc-a5f4-1fb7-3c46-feb535f4222d@huawei.com>
References: <61b4c3e5f1322dfe96ca2062a7fe058298340996.1539782799.git.robin.murphy@arm.com>
	<fe1b23d1980dd110eb2e8ffc01c2dd68632566d1.1539782799.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fe1b23d1980dd110eb2e8ffc01c2dd68632566d1.1539782799.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/10/2018 14:56, Robin Murphy wrote:
> Now that both sync methods are more or less the same shape, we can save
> some code and levels of indirection by rolling them up together again,
> with just a couple of simple conditionals to discriminate the MSI and
> queue-polling specifics.
>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Tested-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

I seem to be getting some boost in the scenarios I tested:
Storage controller: 746K IOPS (with) vs 730K (without)
NVMe disk:  471K IOPS (with) vs 420K IOPS (without)

Note that this is with strict mode set and without the CMD_SYNC 
optimisation I punted. And this is on D05, so no MSI-based CMD_SYNC support.

Thanks,
John

Ps. for anyone testing, use the v1 smmu "Fix Endian" patch to get this 
series to apply.

> ---
>  drivers/iommu/arm-smmu-v3.c | 49 +++++++++----------------------------
>  1 file changed, 12 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index da8a91d116bf..36db63e3afcf 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -933,7 +933,7 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>   * The difference between val and sync_idx is bounded by the maximum size of
>   * a queue at 2^20 entries, so 32 bits is plenty for wrap-safe arithmetic.
>   */
> -static int __arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
> +static int arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
>  {
>  	ktime_t timeout;
>  	u32 val;
> @@ -988,16 +988,17 @@ static int arm_smmu_sync_poll_cons(struct arm_smmu_device *smmu, u32 sync_idx,
>  	return -ETIMEDOUT;
>  }
>
> -static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
> +static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>  {
>  	u64 cmd[CMDQ_ENT_DWORDS];
>  	unsigned long flags;
> -	struct arm_smmu_cmdq_ent ent = {
> -		.opcode = CMDQ_OP_CMD_SYNC,
> -		.sync	= {
> -			.msiaddr = cpu_to_le32(virt_to_phys(&smmu->sync_count)),
> -		},
> -	};
> +	bool msi = (smmu->features & ARM_SMMU_FEAT_MSI) &&
> +		   (smmu->features & ARM_SMMU_FEAT_COHERENCY);
> +	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
> +	int ret, sync_idx, sync_gen;
> +
> +	if (msi)
> +		ent.sync.msiaddr = cpu_to_le32(virt_to_phys(&smmu->sync_count));
>
>  	spin_lock_irqsave(&smmu->cmdq.lock, flags);
>
> @@ -1009,39 +1010,13 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>  		arm_smmu_cmdq_build_cmd(cmd, &ent);
>  		arm_smmu_cmdq_insert_cmd(smmu, cmd);
>  	}
> -
> -	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
> -
> -	return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
> -}
> -
> -static int __arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
> -{
> -	u64 cmd[CMDQ_ENT_DWORDS];
> -	unsigned long flags;
> -	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
> -	int sync_idx, sync_gen;
> -
> -	arm_smmu_cmdq_build_cmd(cmd, &ent);
> -
> -	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> -	if (smmu->prev_cmd_opcode != CMDQ_OP_CMD_SYNC)
> -		arm_smmu_cmdq_insert_cmd(smmu, cmd);
>  	sync_idx = smmu->cmdq.q.prod;
>  	sync_gen = READ_ONCE(smmu->cmdq_generation);
> +
>  	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
>
> -	return arm_smmu_sync_poll_cons(smmu, sync_idx, sync_gen);
> -}
> -
> -static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
> -{
> -	int ret;
> -	bool msi = (smmu->features & ARM_SMMU_FEAT_MSI) &&
> -		   (smmu->features & ARM_SMMU_FEAT_COHERENCY);
> -
> -	ret = msi ? __arm_smmu_cmdq_issue_sync_msi(smmu)
> -		  : __arm_smmu_cmdq_issue_sync(smmu);
> +	ret = msi ? arm_smmu_sync_poll_msi(smmu, ent.sync.msidata)
> +		  : arm_smmu_sync_poll_cons(smmu, sync_idx, sync_gen);
>  	if (ret)
>  		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
>  }
>
