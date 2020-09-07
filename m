Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFE3C2D0E0
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A704F2080A
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQ+e73oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A704F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E1C5860F0;
	Mon,  7 Sep 2020 16:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id avsf3HD_2q5m; Mon,  7 Sep 2020 16:41:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 931F3860F2;
	Mon,  7 Sep 2020 16:41:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DAAFC0052;
	Mon,  7 Sep 2020 16:41:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37774C0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 16:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 20913860F2
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 16:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VTSWQnuSo2uZ for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 16:41:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 18315860F0
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599496881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMgOaS05otbt+/P7CbPiz1Nb5iZ2rR1Ue9Q+igyYByo=;
 b=NQ+e73ojn02jGEmJ4extK2/J65OsSab+oJcwMXMcmoJ4RwR5bZRGuS/iv7zfDSQr+t0Hh2
 c/t9ZwqEtje3C+WyuAHF2j3QCz0PhQ02jP/C9K0VcT+EYQGt94tRCXHDg90SSLTA6Fa51N
 msiKcWuVoklvQkPc2fGg71tM60/pqqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-2CwP4QcKM8uAqM4tNOrqZg-1; Mon, 07 Sep 2020 12:41:17 -0400
X-MC-Unique: 2CwP4QcKM8uAqM4tNOrqZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1EB7802B69;
 Mon,  7 Sep 2020 16:41:15 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6719F100238C;
 Mon,  7 Sep 2020 16:41:13 +0000 (UTC)
Subject: Re: [PATCH RESEND v9 09/13] iommu/arm-smmu-v3: Seize private ASID
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-10-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7a67022c-a33a-5ea1-1bfb-4154d83ca009@redhat.com>
Date: Mon, 7 Sep 2020 18:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200817171558.325917-10-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: fenghua.yu@intel.com, will@kernel.org, zhengxiang9@huawei.com,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com
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

On 8/17/20 7:15 PM, Jean-Philippe Brucker wrote:
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
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 36 +++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 34 +++++++++++-------
>  3 files changed, 58 insertions(+), 15 deletions(-)
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
> index 7a4f40565e06..e919ce894dd1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -10,10 +10,19 @@
>  #include "arm-smmu-v3.h"
>  #include "../../io-pgtable-arm.h"
>  
> +/*
> + * Try to reserve this ASID in the SMMU. If it is in use, try to steal it from
> + * the private entry. Careful here, we may be modifying the context tables of
> + * another SMMU!
Not sure I got what you meant by this comment.
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
> @@ -27,8 +36,31 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  		return cd;
>  	}
>  
> -	/* Ouch, ASID is already in use for a private cd. */
> -	return ERR_PTR(-EBUSY);
> +	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
> +	smmu = smmu_domain->smmu;
> +
> +	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
> +		       XA_LIMIT(1, 1 << smmu->asid_bits), GFP_KERNEL);
XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL)
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
> index 9e81615744de..9e755caea525 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -873,6 +873,17 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
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
> @@ -953,8 +964,8 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
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
> @@ -1610,15 +1621,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
> @@ -1626,8 +1628,14 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
> 

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
