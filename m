From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu: Defer TLB flush in case of unmap op
Date: Wed, 13 Sep 2017 16:34:15 +0530
Message-ID: <b70ef4ca-eec6-f17b-cc79-258b06c5091a@codeaurora.org>
References: <CAFp+6iF=6W_X7Aq=Z4T+HuQT2x4sO+L3wCHuCOu8tQqK2QeTkQ@mail.gmail.com>
	<1504676255-15980-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1504676255-15980-1-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,


On 09/06/2017 11:07 AM, Vivek Gautam wrote:
> We don't want to touch the TLB when smmu is suspended, so
> defer the TLB maintenance until smmu is resumed.
> On resume, we issue arm_smmu_device_reset() to restore the
> configuration and flush the TLBs.
>
> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---

gentle ping. any thoughts on this patch?

>
> Hi Robin,
>
> This patch comes after the discussion[1] we had about defering the
> physical TLB maintenance for an unmap request if the SMMU is
> suspended. Sorry for the delay in sending the updated version
> of the patch.
>
> As discussed, this patch now checks the PM state of smmu in
> .tlb_add_flush and .tlb_sync page-table ops and return if smmu
> is suspended. On resume without assuming that the TLBs state is
> preserved, we issue a arm_smmu_device_reset() which is the safest
> thing to do.
>
> Alternatively, without going into the TLB defer thing, we can simply
> avoid calling pm_runtime_get/put() in case of atomic context, as we
> discussed in the other thread[3]. This will look something like this:
>
>        static size_t arm_smmu_unmap(struct iommu_domain *domain, ....)
>        {
>        <snip>
>
>       -       return ops->unmap(ops, iova, size);
>       +       if (!in_atomic())
>       +              pm_runtime_get_sync(smmu_domain->smmu->dev);
>       +       ret = ops->unmap(ops, iova, size);
>       +       if (!in_atomic())
>       +              pm_runtime_put_sync(smmu_domain->smmu->dev);
>       +
>       +       return ret;
>        }
>
> Let me know which approach should work.
>
> One other concern that we were discussing was of distributed SMMU
> configuration.
> "Say the GPU and its local TBU are in the same clock domain - if the GPU has
> just gone idle and we've clock-gated it, but "the SMMU" (i.e. the TCU)
> is still active servicing other devices, we will assume we can happily
> unmap GPU buffers and issue TLBIs, but what happens with entries held in
> the unclocked TBU's micro-TLB?"
>
> In such scenerio, when master is clock gated and TCU is still running:
>   -> If TCU and TBU are in same clock/power domain, then we can still
>      issue TLBIs as long as the smmu is clocked.
>   -> If TCU and TBU are in separate clock/power domains, then we better
>      check the power state for TBUs and defer TLB maintenance if TBUs are
>      clock gated.
>      In such scenerio will it make sense to represent a distributed smmu
>      as TCU device with multiple TBU child devices?
>
> This patch is based on the pm runtime series for arm-smmu[2], the next
> version of which I will post after we conclude this discussion.
>
> [1] https://patchwork.kernel.org/patch/9876489/
> [2] https://lkml.org/lkml/2017/7/6/230
> [3] https://lkml.org/lkml/2017/8/7/386
>
>   drivers/iommu/arm-smmu.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 8384d5fad388..c6d904733166 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -439,6 +439,10 @@ static void arm_smmu_tlb_sync_context(void *cookie)
>   	void __iomem *base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
>   	unsigned long flags;
>   
> +	/* smmu suspended? we can't perform TLB operations */
> +	if (pm_runtime_suspended(smmu->dev))
> +		return;
> +
>   	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
>   	__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_CB_TLBSYNC,
>   			    base + ARM_SMMU_CB_TLBSTATUS);
> @@ -449,6 +453,9 @@ static void arm_smmu_tlb_sync_vmid(void *cookie)
>   {
>   	struct arm_smmu_domain *smmu_domain = cookie;
>   
> +	if (pm_runtime_suspended(smmu_domain->smmu->dev))
> +		return;
> +
>   	arm_smmu_tlb_sync_global(smmu_domain->smmu);
>   }
>   
> @@ -458,6 +465,9 @@ static void arm_smmu_tlb_inv_context_s1(void *cookie)
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	void __iomem *base = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
>   
> +	if (pm_runtime_suspended(smmu_domain->smmu->dev))
> +		return;
> +
>   	writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
>   	arm_smmu_tlb_sync_context(cookie);
>   }
> @@ -468,6 +478,9 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   	void __iomem *base = ARM_SMMU_GR0(smmu);
>   
> +	if (pm_runtime_suspended(smmu_domain->smmu->dev))
> +		return;
> +
>   	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
>   	arm_smmu_tlb_sync_global(smmu);
>   }
> @@ -480,6 +493,9 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>   	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
>   	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
>   
> +	if (pm_runtime_suspended(smmu_domain->smmu->dev))
> +		return;
> +
>   	if (stage1) {
>   		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
>   
> @@ -521,6 +537,9 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
>   	struct arm_smmu_domain *smmu_domain = cookie;
>   	void __iomem *base = ARM_SMMU_GR0(smmu_domain->smmu);
>   
> +	if (pm_runtime_suspended(smmu_domain->smmu->dev))
> +		return;
> +
>   	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
>   }
>   
> @@ -2299,8 +2318,13 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>   static int __maybe_unused arm_smmu_resume(struct device *dev)
>   {
>   	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(smmu->num_clks, smmu->clocks);
> +	if (ret)
> +		return ret;
>   
> -	return clk_bulk_prepare_enable(smmu->num_clks, smmu->clocks);
> +	return arm_smmu_device_reset(smmu);
>   }
>   
>   static int __maybe_unused arm_smmu_suspend(struct device *dev)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
