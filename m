From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
Date: Wed, 15 Aug 2018 13:26:31 +0100
Message-ID: <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
	<1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1534328582-17664-2-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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

On 15/08/18 11:23, Zhen Lei wrote:
> The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
> __arm_smmu_sync_poll_msi requires that sync_idx must be increased
> monotonously according to the sequence of the CMDs in the cmdq.
> 
> But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
> by spinlock, so the following scenarios may appear:
> cpu0			cpu1
> msidata=0
> 			msidata=1
> 			insert cmd1
> insert cmd0
> 			smmu execute cmd1
> smmu execute cmd0
> 			poll timeout, because msidata=1 is overridden by
> 			cmd0, that means VAL=0, sync_idx=1.
> 
> This is not a functional problem, just make the caller wait for a long
> time until TIMEOUT. It's rare to happen, because any other CMD_SYNCs
> during the waiting period will break it.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d64710..3f5c236 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -566,7 +566,7 @@ struct arm_smmu_device {
> 
>   	int				gerr_irq;
>   	int				combined_irq;
> -	atomic_t			sync_nr;
> +	u32				sync_nr;
> 
>   	unsigned long			ias; /* IPA */
>   	unsigned long			oas; /* PA */
> @@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>   	return 0;
>   }
> 
> +static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)

If we *are* going to go down this route then I think it would make sense 
to move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e. 
arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync 
command, then calling this guy would convert it to an MSI-based one. 
As-is, having bits of mutually-dependent data handled across two 
separate places just seems too messy and error-prone.

That said, I still don't think that just building the whole command 
under the lock is really all that bad - even when it doesn't get 
optimised into one of the assignments that memset you call out is only a 
single "stp xzr, xzr, ...", and a couple of extra branches doesn't seem 
a huge deal compared to the DSB and MMIO accesses (and potentially 
polling) that we're about to do anyway. I've tried hacking things up 
enough to convince GCC to inline a specialisation of the relevant switch 
case when ent->opcode is known, and that reduces the "overhead" down to 
just a handful of ALU instructions. I still need to try cleaning said 
hack up and double-check that it doesn't have any adverse impact on all 
the other SMMUv3 stuff in development, but watch this space...

Robin.

> +{
> +	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, msidata);
> +}
> +
>   /* High-level queue accessors */
>   static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   {
> @@ -836,7 +841,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>   		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
>   		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);
>   		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
>   		break;
>   	default:
> @@ -947,7 +951,6 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>   	struct arm_smmu_cmdq_ent ent = {
>   		.opcode = CMDQ_OP_CMD_SYNC,
>   		.sync	= {
> -			.msidata = atomic_inc_return_relaxed(&smmu->sync_nr),
>   			.msiaddr = virt_to_phys(&smmu->sync_count),
>   		},
>   	};
> @@ -955,6 +958,8 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>   	arm_smmu_cmdq_build_cmd(cmd, &ent);
> 
>   	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> +	ent.sync.msidata = ++smmu->sync_nr;
> +	arm_smmu_cmdq_sync_set_msidata(cmd, ent.sync.msidata);
>   	arm_smmu_cmdq_insert_cmd(smmu, cmd);
>   	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
> 
> @@ -2179,7 +2184,6 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>   {
>   	int ret;
> 
> -	atomic_set(&smmu->sync_nr, 0);
>   	ret = arm_smmu_init_queues(smmu);
>   	if (ret)
>   		return ret;
> --
> 1.8.3
> 
> 
