From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/arm-smmu-v3: put off the execution of TLBI* to
	reduce lock confliction
Date: Tue, 22 Aug 2017 17:41:42 +0200
Message-ID: <20170822154142.GA19533@8bytes.org>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
	<1498484330-10840-2-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498484330-10840-2-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 26, 2017 at 09:38:46PM +0800, Zhen Lei wrote:
> -static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
> +static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent, int optimize)
>  {
>  	if (queue_full(q))
>  		return -ENOSPC;
>  
>  	queue_write(Q_ENT(q, q->prod), ent, q->ent_dwords);
> -	queue_inc_prod(q);
> +
> +	/*
> +	 * We don't want too many commands to be delayed, this may lead the
> +	 * followed sync command to wait for a long time.
> +	 */
> +	if (optimize && (++q->nr_delay < CMDQ_MAX_DELAYED)) {
> +		queue_inc_swprod(q);
> +	} else {
> +		queue_inc_prod(q);
> +		q->nr_delay = 0;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -909,6 +928,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
>  static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  				    struct arm_smmu_cmdq_ent *ent)
>  {
> +	int optimize = 0;
>  	u64 cmd[CMDQ_ENT_DWORDS];
>  	unsigned long flags;
>  	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
> @@ -920,8 +940,17 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  		return;
>  	}
>  
> +	/*
> +	 * All TLBI commands should be followed by a sync command later.
> +	 * The CFGI commands is the same, but they are rarely executed.
> +	 * So just optimize TLBI commands now, to reduce the "if" judgement.
> +	 */
> +	if ((ent->opcode >= CMDQ_OP_TLBI_NH_ALL) &&
> +	    (ent->opcode <= CMDQ_OP_TLBI_NSNH_ALL))
> +		optimize = 1;
> +
>  	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> -	while (queue_insert_raw(q, cmd) == -ENOSPC) {
> +	while (queue_insert_raw(q, cmd, optimize) == -ENOSPC) {
>  		if (queue_poll_cons(q, false, wfe))
>  			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>  	}

This doesn't look correct. How do you make sure that a given IOVA range
is flushed before the addresses are reused?


Regards,

	Joerg
