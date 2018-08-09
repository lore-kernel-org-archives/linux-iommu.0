From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: avoid redundant CMD_SYNCs if
	possible
Date: Thu, 9 Aug 2018 13:02:46 +0100
Message-ID: <647c4478-d8b9-4af6-65ed-0023e81408e3@arm.com>
References: <1533815333-17320-1-git-send-email-thunder.leizhen@huawei.com>
	<1533815333-17320-3-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1533815333-17320-3-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: LinuxArm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Libin <huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/08/18 12:48, Zhen Lei wrote:
> More than two CMD_SYNCs maybe adjacent in the command queue, and the first
> one has done what others want to do. Drop the redundant CMD_SYNCs can
> improve IO performance especially under the pressure scene.
> 
> I did the statistics in my test environment, the number of CMD_SYNCs can
> be reduced about 1/3. See below:
> CMD_SYNCs reduced:	19542181
> CMD_SYNCs total:	58098548	(include reduced)
> CMDs total:		116197099	(TLBI:SYNC about 1:1)
> 
> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d17a9a7..b96d2d2 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -567,6 +567,7 @@ struct arm_smmu_device {
>   	int				gerr_irq;
>   	int				combined_irq;
>   	u32				sync_nr;
> +	u8				prev_cmd_opcode;
> 
>   	unsigned long			ias; /* IPA */
>   	unsigned long			oas; /* PA */
> @@ -775,6 +776,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>   	return 0;
>   }
> 
> +static inline u8 arm_smmu_cmd_opcode_get(u64 *cmd)
> +{
> +	return cmd[0] & CMDQ_0_OP;
> +}
> +
>   /* High-level queue accessors */
>   static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   {
> @@ -900,6 +906,8 @@ static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
>   	struct arm_smmu_queue *q = &smmu->cmdq.q;
>   	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
> 
> +	smmu->prev_cmd_opcode = arm_smmu_cmd_opcode_get(cmd);
> +
>   	while (queue_insert_raw(q, cmd) == -ENOSPC) {
>   		if (queue_poll_cons(q, false, wfe))
>   			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> @@ -952,9 +960,17 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>   	};
> 
>   	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> -	ent.sync.msidata = ++smmu->sync_nr;
> -	arm_smmu_cmdq_build_cmd(cmd, &ent);
> -	arm_smmu_cmdq_insert_cmd(smmu, cmd);
> +	if (smmu->prev_cmd_opcode == CMDQ_OP_CMD_SYNC) {
> +		/*
> +		 * Previous command is CMD_SYNC also, there is no need to add
> +		 * one more. Just poll it.
> +		 */
> +		ent.sync.msidata = smmu->sync_nr;

Aha! at the time I had pondered how to make multiple callers wait on a 
previous sync instead of issuing another back-to-back, but it seemed 
complicated precisely *because* of the counter being updated outside the 
lock. If only I'd realised... :)

Now I just need to figure out if we can do the same for the polling case.

Robin.

> +	} else {
> +		ent.sync.msidata = ++smmu->sync_nr;
> +		arm_smmu_cmdq_build_cmd(cmd, &ent);
> +		arm_smmu_cmdq_insert_cmd(smmu, cmd);
> +	}
>   	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
> 
>   	return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
> --
> 1.8.3
> 
> 
