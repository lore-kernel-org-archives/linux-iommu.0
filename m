From: Andrew Murray <andrew.murray-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 2/2] iommu/arm-smmu-v3: Reunify
	arm_smmu_cmdq_issue_sync()
Date: Thu, 18 Oct 2018 09:58:52 +0100
Message-ID: <20181018085852.GJ12972@e119886-lin.cambridge.arm.com>
References: <61b4c3e5f1322dfe96ca2062a7fe058298340996.1539782799.git.robin.murphy@arm.com>
	<fe1b23d1980dd110eb2e8ffc01c2dd68632566d1.1539782799.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 17, 2018 at 02:56:07PM +0100, Robin Murphy wrote:
> Now that both sync methods are more or less the same shape, we can save
> some code and levels of indirection by rolling them up together again,
> with just a couple of simple conditionals to discriminate the MSI and
> queue-polling specifics.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
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

You indicated that "Patches are based on Will's iommu/devel branch plus my
"Fix big-endian CMD_SYNC writes" patch." - However your v2 of that patch didn't
include this cpu_to_le32 hunk. 

Reviewed-by: Andrew Murray <andrew.murray-5wv7dgnIgG8@public.gmane.org>

Thanks,

Andrew Murray

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
> -- 
> 2.19.1.dirty
> 
