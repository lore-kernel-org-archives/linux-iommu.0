Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCF8C433E7
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 14:02:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B39208B8
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 14:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B39208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3540986F38;
	Mon, 19 Oct 2020 14:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PdXgTAJZYv3p; Mon, 19 Oct 2020 14:02:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EDD9586F33;
	Mon, 19 Oct 2020 14:02:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB056C0052;
	Mon, 19 Oct 2020 14:02:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FBB9C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 14:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 21A1F2C35C
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 14:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3nVA9IbSi7d7 for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 14:02:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id CD20B274AA
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 14:02:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D943FD6E;
 Mon, 19 Oct 2020 07:02:09 -0700 (PDT)
Received: from [10.57.19.34] (unknown [10.57.19.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C043F66E;
 Mon, 19 Oct 2020 07:02:07 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu: Allow implementation specific
 write_s2cr
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Thierry Reding <treding@nvidia.com>,
 Rob Clark <robdclark@chromium.org>
References: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
 <20201017043907.2656013-2-bjorn.andersson@linaro.org>
Message-ID: <e5ee0dad-3b52-3bf2-a473-f624415cdf67@arm.com>
Date: Mon, 19 Oct 2020 15:02:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201017043907.2656013-2-bjorn.andersson@linaro.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2020-10-17 05:39, Bjorn Andersson wrote:
> The firmware found in some Qualcomm platforms intercepts writes to the
> S2CR register in order to replace the BYPASS type with FAULT. Further
> more it treats faults at this level as catastrophic and restarts the
> device.
> 
> Add support for providing implementation specific versions of the S2CR
> write function, to allow the Qualcomm driver to work around this
> behavior.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v3:
> - New patch
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 22 ++++++++++++++--------
>   drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
>   2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index dad7fa86fbd4..ed3f0428c110 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -929,14 +929,20 @@ static void arm_smmu_write_smr(struct arm_smmu_device *smmu, int idx)
>   static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
>   {
>   	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
> -	u32 reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, s2cr->type) |
> -		  FIELD_PREP(ARM_SMMU_S2CR_CBNDX, s2cr->cbndx) |
> -		  FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
> -
> -	if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs &&
> -	    smmu->smrs[idx].valid)
> -		reg |= ARM_SMMU_S2CR_EXIDVALID;
> -	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
> +	u32 reg;
> +
> +	if (smmu->impl && smmu->impl->write_s2cr) {
> +		smmu->impl->write_s2cr(smmu, idx);

Nit: just add an early return here to avoid reindenting the whole 
function. Otherwise this looks like a reasonable level of abstraction to 
me - we'll still have plenty of flexibility to adjust things in future 
if necessary.

With that change,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +	} else {
> +		reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, s2cr->type) |
> +		      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, s2cr->cbndx) |
> +		      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
> +
> +		if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs &&
> +		    smmu->smrs[idx].valid)
> +			reg |= ARM_SMMU_S2CR_EXIDVALID;
> +		arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
> +	}
>   }
>   
>   static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 1a746476927c..b71647eaa319 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -436,6 +436,7 @@ struct arm_smmu_impl {
>   	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
>   				  struct arm_smmu_device *smmu,
>   				  struct device *dev, int start);
> +	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
>   };
>   
>   #define INVALID_SMENDX			-1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
