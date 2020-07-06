Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6A0C433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:40:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC0420715
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC0420715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6549E87EF6;
	Mon,  6 Jul 2020 12:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J28Q8oQgDSFY; Mon,  6 Jul 2020 12:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AAB378878F;
	Mon,  6 Jul 2020 12:40:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD07C0891;
	Mon,  6 Jul 2020 12:40:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0874EC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F295E87196
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SO-4ByuRfkb2 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 12:40:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5B30886CF1
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:40:46 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 08DDF5B01FA725992115;
 Mon,  6 Jul 2020 20:40:39 +0800 (CST)
Received: from [127.0.0.1] (10.174.187.83) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 6 Jul 2020
 20:40:28 +0800
Subject: Re: [PATCH v8 08/12] iommu/arm-smmu-v3: Seize private ASID
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 <iommu@lists.linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
 <20200618155125.1548969-9-jean-philippe@linaro.org>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <c3ee2919-bec1-33ba-59f6-c3438e128ed5@huawei.com>
Date: Mon, 6 Jul 2020 20:40:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200618155125.1548969-9-jean-philippe@linaro.org>
Content-Language: en-US
X-Originating-IP: [10.174.187.83]
X-CFilter-Loop: Reflected
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 hch@infradead.org, Wang Haibin <wanghaibin.wang@huawei.com>,
 zhangfei.gao@linaro.org, will@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

On 2020/6/18 23:51, Jean-Philippe Brucker wrote:
> The SMMU has a single ASID space, the union of shared and private ASID
> sets. This means that the SMMU driver competes with the arch allocator
> for ASIDs. Shared ASIDs are those of Linux processes, allocated by the
> arch, and contribute in broadcast TLB maintenance. Private ASIDs are
> allocated by the SMMU driver and used for "classic" map/unmap DMA. They
> require command-queue TLB invalidations.
> 
> When we pin down an mm_context and get an ASID that is already in use by
> the SMMU, it belongs to a private context. We used to simply abort the
> bind, but this is unfair to users that would be unable to bind a few
> seemingly random processes. Try to allocate a new private ASID for the
> context, and make the old ASID shared.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 101 +++++++++++++++++++++++++++++-------
>  1 file changed, 82 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index cabd942e4cbf3..5506add42c9c8 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -733,6 +733,7 @@ struct arm_smmu_option_prop {
>  };
>  
>  static DEFINE_XARRAY_ALLOC1(asid_xa);
> +static DEFINE_MUTEX(asid_lock);
>  static DEFINE_MUTEX(sva_lock);
>  
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
> @@ -1537,6 +1538,17 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
>  }
>  
>  /* Context descriptor manipulation functions */
> +static void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
> +{
> +	struct arm_smmu_cmdq_ent cmd = {
> +		.opcode = CMDQ_OP_TLBI_NH_ASID,
> +		.tlbi.asid = asid,
> +	};
> +
> +	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> +	arm_smmu_cmdq_issue_sync(smmu);
> +}
> +
>  static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
>  			     int ssid, bool leaf)
>  {
> @@ -1795,9 +1807,18 @@ static bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
>  	return free;
>  }
>  
> +/*
> + * Try to reserve this ASID in the SMMU. If it is in use, try to steal it from
> + * the private entry. Careful here, we may be modifying the context tables of
> + * another SMMU!
> + */
>  static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
>  {
> +	int ret;
> +	u32 new_asid;
>  	struct arm_smmu_ctx_desc *cd;
> +	struct arm_smmu_device *smmu;
> +	struct arm_smmu_domain *smmu_domain;
>  
>  	cd = xa_load(&asid_xa, asid);
>  	if (!cd)
> @@ -1809,8 +1830,31 @@ static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
>  		return cd;
>  	}
>  
> -	/* Ouch, ASID is already in use for a private cd. */
> -	return ERR_PTR(-EBUSY);
> +	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
> +	smmu = smmu_domain->smmu;
> +
> +	ret = xa_alloc(&asid_xa, &new_asid, cd,
> +		       XA_LIMIT(1, 1 << smmu->asid_bits), GFP_KERNEL);
> +	if (ret)
> +		return ERR_PTR(-ENOSPC);
> +	/*
> +	 * Race with unmap: TLB invalidations will start targeting the new ASID,
> +	 * which isn't assigned yet. We'll do an invalidate-all on the old ASID
> +	 * later, so it doesn't matter.
> +	 */
> +	cd->asid = new_asid;
> +
> +	/*
> +	 * Update ASID and invalidate CD in all associated masters. There will
> +	 * be some overlap between use of both ASIDs, until we invalidate the
> +	 * TLB.
> +	 */
> +	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
> +
> +	/* Invalidate TLB entries previously associated with that context */
> +	arm_smmu_tlb_inv_asid(smmu, asid);
> +
> +	return NULL;
>  }
>  
>  __maybe_unused
> @@ -1836,7 +1880,20 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
>  
>  	arm_smmu_init_cd(cd);
>  
> +	/*
> +	 * Serialize against arm_smmu_domain_finalise_s1() and
> +	 * arm_smmu_domain_free() as we might need to replace the private ASID
> +	 * from an existing CD.
> +	 */
> +	mutex_lock(&asid_lock);
>  	old_cd = arm_smmu_share_asid(asid);
> +	if (!old_cd) {
> +		ret = xa_insert(&asid_xa, asid, cd, GFP_KERNEL);

Should we use "xa_store" here? If "asid" has already been used for private, old_cd would be NULL and
the entry indexed by "asid" in the asid_xa remains.

> +		if (ret)
> +			old_cd = ERR_PTR(ret);
> +	}
> +	mutex_unlock(&asid_lock);
> +
>  	if (IS_ERR(old_cd)) {
>  		ret = PTR_ERR(old_cd);
>  		goto err_free_cd;
> @@ -1850,11 +1907,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
>  		return old_cd;
>  	}
>  
> -	/* Fails if a private ASID has been allocated since we last checked */
> -	ret = xa_insert(&asid_xa, asid, cd, GFP_KERNEL);
> -	if (ret)
> -		goto err_free_cd;
> -
>  	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
>  	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
>  	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
> @@ -2398,15 +2450,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_cmdq_ent cmd;
>  
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> -		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
> -		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
> -		cmd.tlbi.vmid	= 0;
> -	} else {
> -		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
> -		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> -	}
> -
>  	/*
>  	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
>  	 * PTEs previously cleared by unmaps on the current CPU not yet visible
> @@ -2414,8 +2457,14 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	 * insertion to guarantee those are observed before the TLBI. Do be
>  	 * careful, 007.
>  	 */
> -	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> -	arm_smmu_cmdq_issue_sync(smmu);
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
> +	} else {
> +		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
> +		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> +		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> +		arm_smmu_cmdq_issue_sync(smmu);
> +	}
>  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
>  }
>  
> @@ -2599,9 +2648,15 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>  
> +		/*
> +		 * Prevent arm_smmu_share_asid() from rewriting CD#0 while we're
> +		 * freeing it.
> +		 */
> +		mutex_lock(&asid_lock);
>  		if (cfg->cdcfg.cdtab)
>  			arm_smmu_free_cd_tables(smmu_domain);
>  		arm_smmu_free_asid(&cfg->cd);
> +		mutex_unlock(&asid_lock);
>  	} else {
>  		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
>  		if (cfg->vmid)
> @@ -2623,10 +2678,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  
>  	arm_smmu_init_cd(&cfg->cd);
>  
> +	/*
> +	 * Prevent arm_smmu_share_asid() from seizing the private ASID we're
> +	 * allocating here until it is written to the CD.
> +	 */
> +	mutex_lock(&asid_lock);
>  	ret = xa_alloc(&asid_xa, &asid, &cfg->cd,
>  		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
>  	if (ret)
> -		return ret;
> +		goto out_unlock;
>  
>  	cfg->s1cdmax = master->ssid_bits;
>  
> @@ -2654,12 +2714,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	if (ret)
>  		goto out_free_cd_tables;
>  
> +	mutex_unlock(&asid_lock);
>  	return 0;
>  
>  out_free_cd_tables:
>  	arm_smmu_free_cd_tables(smmu_domain);
>  out_free_asid:
>  	arm_smmu_free_asid(&cfg->cd);
> +out_unlock:
> +	mutex_unlock(&asid_lock);
>  	return ret;
>  }
>  
> 

-- 
Thanks,
Xiang

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
