From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
Date: Wed, 8 Aug 2018 11:12:15 +0100
Message-ID: <20180808101215.GB28557@arm.com>
References: <1533558689-3000-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533558689-3000-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Hi Thunder,

On Mon, Aug 06, 2018 at 08:31:29PM +0800, Zhen Lei wrote:
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

Oh yuck, you're right! We probably want a CC stable on this. Did you see
this go wrong in practice?

One comment on your patch...

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d64710..4810f61 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -566,7 +566,7 @@ struct arm_smmu_device {
> 
>  	int				gerr_irq;
>  	int				combined_irq;
> -	atomic_t			sync_nr;
> +	u32				sync_nr;
> 
>  	unsigned long			ias; /* IPA */
>  	unsigned long			oas; /* PA */
> @@ -836,7 +836,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>  		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
>  		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);
>  		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
>  		break;
>  	default:
> @@ -947,7 +946,6 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>  	struct arm_smmu_cmdq_ent ent = {
>  		.opcode = CMDQ_OP_CMD_SYNC,
>  		.sync	= {
> -			.msidata = atomic_inc_return_relaxed(&smmu->sync_nr),
>  			.msiaddr = virt_to_phys(&smmu->sync_count),
>  		},
>  	};
> @@ -955,6 +953,8 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>  	arm_smmu_cmdq_build_cmd(cmd, &ent);
> 
>  	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> +	ent.sync.msidata = ++smmu->sync_nr;
> +	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent.sync.msidata);

I really don't like splitting this out from building the rest of the
command. Can you just move the call to arm_smmu_cmdq_build_cmd into the
critical section, please?

Thanks,

Will
