Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60407C4742C
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 18:19:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E041E2222B
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 18:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E041E2222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B15885D50;
	Mon,  2 Nov 2020 18:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RkmXj9dk4gip; Mon,  2 Nov 2020 18:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5E968697C;
	Mon,  2 Nov 2020 18:19:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89D2EC088B;
	Mon,  2 Nov 2020 18:19:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EDA1C0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 18:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 341C185D21
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 18:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KTH7YCzJAQYY for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 18:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 10CEE85CA1
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 18:19:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E14B139F;
 Mon,  2 Nov 2020 10:19:02 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF6BA3F719;
 Mon,  2 Nov 2020 10:18:46 -0800 (PST)
Subject: Re: [PATCH v18 2/4] iommu/arm-smmu: Add a way for implementations to
 influence SCTLR
To: Jordan Crouse <jcrouse@codeaurora.org>, linux-arm-msm@vger.kernel.org
References: <20201102171416.654337-1-jcrouse@codeaurora.org>
 <20201102171416.654337-3-jcrouse@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0a00c162-ad77-46b7-85ad-e11229b57a3d@arm.com>
Date: Mon, 2 Nov 2020 18:18:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102171416.654337-3-jcrouse@codeaurora.org>
Content-Language: en-GB
Cc: Rob Clark <robdclark@chromium.org>, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On 2020-11-02 17:14, Jordan Crouse wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> For the Adreno GPU's SMMU, we want SCTLR.HUPCF set to ensure that
> pending translations are not terminated on iova fault.  Otherwise
> a terminated CP read could hang the GPU by returning invalid
> command-stream data.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu.c      | 3 +++
>   drivers/iommu/arm/arm-smmu/arm-smmu.h      | 3 +++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 1e942eed2dfc..0663d7d26908 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -129,6 +129,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>   	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
>   		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
>   
> +	/*
> +	 * On the GPU device we want to process subsequent transactions after a
> +	 * fault to keep the GPU from hanging
> +	 */
> +	smmu_domain->cfg.sctlr_set |= ARM_SMMU_SCTLR_HUPCF;
> +
>   	/*
>   	 * Initialize private interface with GPU:
>   	 */
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index dad7fa86fbd4..1f06ab219819 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -617,6 +617,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
>   	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>   		reg |= ARM_SMMU_SCTLR_E;
>   
> +	reg |= cfg->sctlr_set;
> +	reg &= ~cfg->sctlr_clr;

Since we now have a write_s2cr hook, I'm inclined to think that the 
consistency of a write_sctlr hook that could similarly apply its own 
arbitrary tweaks would make sense for this. Does anyone have any strong 
opinions?

Robin.

> +
>   	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>   }
>   
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 6c5ff9999eae..ddf2ca4c923d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -144,6 +144,7 @@ enum arm_smmu_cbar_type {
>   #define ARM_SMMU_CB_SCTLR		0x0
>   #define ARM_SMMU_SCTLR_S1_ASIDPNE	BIT(12)
>   #define ARM_SMMU_SCTLR_CFCFG		BIT(7)
> +#define ARM_SMMU_SCTLR_HUPCF		BIT(8)
>   #define ARM_SMMU_SCTLR_CFIE		BIT(6)
>   #define ARM_SMMU_SCTLR_CFRE		BIT(5)
>   #define ARM_SMMU_SCTLR_E		BIT(4)
> @@ -341,6 +342,8 @@ struct arm_smmu_cfg {
>   		u16			asid;
>   		u16			vmid;
>   	};
> +	u32				sctlr_set;    /* extra bits to set in SCTLR */
> +	u32				sctlr_clr;    /* bits to mask in SCTLR */
>   	enum arm_smmu_cbar_type		cbar;
>   	enum arm_smmu_context_fmt	fmt;
>   };
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
