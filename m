Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786ACC43463
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 13:09:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5E0235FD
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 13:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5E0235FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 891812E191;
	Fri, 18 Sep 2020 13:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jgHrviLNP0rl; Fri, 18 Sep 2020 13:09:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 61A512045B;
	Fri, 18 Sep 2020 13:09:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 520BAC0859;
	Fri, 18 Sep 2020 13:09:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0322C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 13:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9846C8531D
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 13:09:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pX_1Ej5SycDo for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 13:09:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2BED285319
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 13:09:25 +0000 (UTC)
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 4C4B6DF79AB68529DC49;
 Fri, 18 Sep 2020 14:09:22 +0100 (IST)
Received: from localhost (10.52.125.116) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Sep
 2020 14:09:21 +0100
Date: Fri, 18 Sep 2020 14:07:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 09/13] iommu/arm-smmu-v3: Seize private ASID
Message-ID: <20200918140743.00007482@Huawei.com>
In-Reply-To: <20200918101852.582559-10-jean-philippe@linaro.org>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-10-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.52.125.116]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, 18 Sep 2020 12:18:49 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

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
Hi,

One totally trivial comment inline that might have ever so slightly
improved reviewability of the patch.

However it is only minor so don't bother respinning for that.

Thanks,

Jonathan

> ---
> v10: fix ASID limit, small comment update
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 35 +++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 34 +++++++++++-------
>  3 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 6b06a6f19604..90c08f156b43 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -678,6 +678,9 @@ struct arm_smmu_domain {
>  extern struct xarray arm_smmu_asid_xa;
>  extern struct mutex arm_smmu_asid_lock;
>  
> +int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
> +			    struct arm_smmu_ctx_desc *cd);
> +void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
>  bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
>  
>  #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 6c1113059632..ef3fcfa72187 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -10,10 +10,18 @@
>  #include "arm-smmu-v3.h"
>  #include "../../io-pgtable-arm.h"
>  
> +/*
> + * Check if the CPU ASID is available on the SMMU side. If a private context
> + * descriptor is using it, try to replace it.
> + */
>  static struct arm_smmu_ctx_desc *
>  arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  {
> +	int ret;
> +	u32 new_asid;
>  	struct arm_smmu_ctx_desc *cd;
> +	struct arm_smmu_device *smmu;
> +	struct arm_smmu_domain *smmu_domain;
>  
>  	cd = xa_load(&arm_smmu_asid_xa, asid);
>  	if (!cd)
> @@ -27,8 +35,31 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  		return cd;
>  	}
>  
> -	/* Ouch, ASID is already in use for a private cd. */
> -	return ERR_PTR(-EBUSY);
> +	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
> +	smmu = smmu_domain->smmu;
> +
> +	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
> +		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
> +	if (ret)
> +		return ERR_PTR(-ENOSPC);
> +	/*
> +	 * Race with unmap: TLB invalidations will start targeting the new ASID,
> +	 * which isn't assigned yet. We'll do an invalidate-all on the old ASID
> +	 * later, so it doesn't matter.
> +	 */
> +	cd->asid = new_asid;
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
> +	xa_erase(&arm_smmu_asid_xa, asid);
> +	return NULL;
>  }
>  
>  __maybe_unused
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 19af27fd183b..e99ebdd4c841 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -872,6 +872,17 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
>  }
>  
>  /* Context descriptor manipulation functions */
> +void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
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
> @@ -952,8 +963,8 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
>  	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
>  }
>  
> -static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> -				   int ssid, struct arm_smmu_ctx_desc *cd)
> +int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
> +			    struct arm_smmu_ctx_desc *cd)
>  {
>  	/*
>  	 * This function handles the following cases:
> @@ -1609,15 +1620,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
> @@ -1625,8 +1627,14 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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

Nothing wrong with the code, but you could perhaps have split out the noop
refactoring change from more interesting parts.

>  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
>  }
>  


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
