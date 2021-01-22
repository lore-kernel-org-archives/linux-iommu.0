Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FB9C433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 14:05:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2298239EF
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 14:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2298239EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E05B786ADD;
	Fri, 22 Jan 2021 14:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HDwnNGBLJpan; Fri, 22 Jan 2021 14:05:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7EF5986A73;
	Fri, 22 Jan 2021 14:05:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C508C08A1;
	Fri, 22 Jan 2021 14:05:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB90FC013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 14:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C885E86AD1
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 14:04:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sFnjrQiBWICA for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 14:04:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8FEA386A73
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 14:04:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA39A11B3;
 Fri, 22 Jan 2021 06:04:57 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 497863F66E;
 Fri, 22 Jan 2021 06:04:56 -0800 (PST)
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Make BTM optional for SVA
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 joro@8bytes.org
References: <20210122115257.2502526-1-jean-philippe@linaro.org>
 <20210122115257.2502526-3-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <14f78aee-c7fd-22ff-64d4-6aff2e9ec015@arm.com>
Date: Fri, 22 Jan 2021 14:04:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122115257.2502526-3-jean-philippe@linaro.org>
Content-Language: en-GB
Cc: vivek.gautam@arm.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, zhangfei.gao@linaro.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-01-22 11:52, Jean-Philippe Brucker wrote:
> When BTM isn't supported by the SMMU, send invalidations on the
> command queue.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  3 +++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 14 +++++++++++---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 14 ++++++++++++++
>   3 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index a6536c2b32d0..652d03ad8ae6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -743,6 +743,9 @@ extern struct arm_smmu_ctx_desc quiet_cd;
>   int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>   			    struct arm_smmu_ctx_desc *cd);
>   void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
> +void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
> +				 size_t granule, bool leaf,
> +				 struct arm_smmu_domain *smmu_domain);
>   bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
>   int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
>   			    unsigned long iova, size_t size);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 642ce2c225b5..ad8cf62a8f83 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -16,6 +16,7 @@ struct arm_smmu_mmu_notifier {
>   	struct mmu_notifier		mn;
>   	struct arm_smmu_ctx_desc	*cd;
>   	bool				cleared;
> +	bool				tlb_inv_command;
>   	refcount_t			refs;
>   	struct list_head		list;
>   	struct arm_smmu_domain		*domain;
> @@ -182,9 +183,13 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>   					 unsigned long start, unsigned long end)
>   {
>   	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
> +	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> +	size_t size = end - start + 1;
>   
> -	arm_smmu_atc_inv_domain(smmu_mn->domain, mm->pasid, start,
> -				end - start + 1);
> +	if (smmu_mn->tlb_inv_command)

Since we're going to be drilling down to smmu_domain->smmu->features in 
the invalidate call anyway, perhaps we could just test for BTM directly 
here?

Obviously that also proves my previous comment involved a reading 
comprehension failure and too much haste, so should be discounted. Sorry 
about that :)

Robin.

> +		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> +					    PAGE_SIZE, false, smmu_domain);
> +	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
>   }
>   
>   static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> @@ -253,6 +258,9 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
>   	smmu_mn->domain = smmu_domain;
>   	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
>   
> +	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
> +		smmu_mn->tlb_inv_command = true;
> +
>   	ret = mmu_notifier_register(&smmu_mn->mn, mm);
>   	if (ret) {
>   		kfree(smmu_mn);
> @@ -404,7 +412,7 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>   	unsigned long reg, fld;
>   	unsigned long oas;
>   	unsigned long asid_bits;
> -	u32 feat_mask = ARM_SMMU_FEAT_BTM | ARM_SMMU_FEAT_COHERENCY;
> +	u32 feat_mask = ARM_SMMU_FEAT_COHERENCY;
>   
>   	if (vabits_actual == 52)
>   		feat_mask |= ARM_SMMU_FEAT_VAX;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a27b074d5c0c..db545834493b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2018,6 +2018,20 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>   	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
>   }
>   
> +void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
> +				 size_t granule, bool leaf,
> +				 struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_cmdq_ent cmd = {
> +		.opcode	= CMDQ_OP_TLBI_NH_VA,
> +		.tlbi = {
> +			.asid	= asid,
> +			.leaf	= leaf,
> +		},
> +	};
> +	arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
> +}
> +
>   static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
>   					 unsigned long iova, size_t granule,
>   					 void *cookie)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
