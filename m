Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96347C433E2
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 18:42:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C7D2080A
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 18:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="it2ScUej";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="jOEobJor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C7D2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BCCAF8707C;
	Tue,  8 Sep 2020 18:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mKbmTs6kkUXQ; Tue,  8 Sep 2020 18:42:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EC39486FDB;
	Tue,  8 Sep 2020 18:42:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C61BBC0052;
	Tue,  8 Sep 2020 18:42:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EC43C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 18:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E04E86546
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 18:42:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RbWS6ALgQ-JH for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 18:42:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-21.smtp-out.us-west-2.amazonses.com
 (a27-21.smtp-out.us-west-2.amazonses.com [54.240.27.21])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4AD0C864A6
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599590526;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 bh=EiaJlKj7Ne8nGiRMenHLunM8+6hemqqH4NYaF6fj2gk=;
 b=it2ScUejdwwV6rZqq2a0/gIfw/Jwythl9qWLIfKwINQ0xMe48aS9aC+IkMIWUUP/
 qximFRBWgxncEyGlDu5gu3fZ3oJKKd2qxVWqygMG9SW7BqqP3MBwOBBY1snSR9OXJrt
 GHBiadUj53i/MlOQfrwRPJD0uOHJdwV/hhe8noYk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599590526;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
 bh=EiaJlKj7Ne8nGiRMenHLunM8+6hemqqH4NYaF6fj2gk=;
 b=jOEobJordYoa1Qbp5yZjgjvQz2Fi1qigrfXdzLWDGAsMCZLjeykCT6xlIYE6TY03
 uFa5hclMwfQwWh442gZYuW3Me8cyq3K96kp0lw1Bv8Q0Rved2BguJYm1UtIltlkoA0i
 qpVhqS9ZsUiSiaN+RfrZCcOPAzuOF587QuiWVZHU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B5B5C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date: Tue, 8 Sep 2020 18:42:06 +0000
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 1/8] iommu/arm-smmu: Refactor context bank allocation
Message-ID: <010101746f066ece-dac1eef9-768d-4c90-95fd-56900d13b4c9-000000@us-west-2.amazonses.com>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rob Clark <robdclark@chromium.org>,
 Sibi Sankar <sibis@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200904155513.282067-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SES-Outgoing: 2020.09.08-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Fri, Sep 04, 2020 at 03:55:06PM +0000, Bjorn Andersson wrote:
> Extract the conditional invocation of the platform defined
> alloc_context_bank() to a separate function to keep
> arm_smmu_init_domain_context() cleaner.
> 
> Instead pass a reference to the arm_smmu_device as parameter to the
> call. Also remove the count parameter, as this can be read from the
> newly passed object.
> 
> This allows us to not assign smmu_domain->smmu before attempting to
> allocate the context bank and as such we don't need to roll back this
> assignment on failure.

Much nicer.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Note that this series applies ontop of:
> https://lore.kernel.org/linux-arm-msm/20200901164707.2645413-1-robdclark@gmail.com/
> 
> This could either go on its own, or be squashed with "[PATCH v16 14/20]
> iommu/arm-smmu: Prepare for the adreno-smmu implementation" from Rob's series.
> 
> Changes since v2:
> - New patch
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  6 ++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 23 ++++++++++++----------
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  3 ++-
>  3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 2aa6249050ff..0663d7d26908 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -91,9 +91,10 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
>  }
>  
>  static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
> -		struct device *dev, int start, int count)
> +					       struct arm_smmu_device *smmu,
> +					       struct device *dev, int start)
>  {
> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	int count;
>  
>  	/*
>  	 * Assign context bank 0 to the GPU device so the GPU hardware can
> @@ -104,6 +105,7 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
>  		count = 1;
>  	} else {
>  		start = 1;
> +		count = smmu->num_context_banks;
>  	}
>  
>  	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index bbec5793faf8..e19d7bdc7674 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -623,6 +623,16 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>  }
>  
> +static int arm_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
> +				       struct arm_smmu_device *smmu,
> +				       struct device *dev, unsigned int start)
> +{
> +	if (smmu->impl && smmu->impl->alloc_context_bank)
> +		return smmu->impl->alloc_context_bank(smmu_domain, smmu, dev, start);
> +
> +	return __arm_smmu_alloc_bitmap(smmu->context_map, start, smmu->num_context_banks);
> +}
> +
>  static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  					struct arm_smmu_device *smmu,
>  					struct device *dev)
> @@ -741,20 +751,13 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		goto out_unlock;
>  	}
>  
> -	smmu_domain->smmu = smmu;
> -
> -	if (smmu->impl && smmu->impl->alloc_context_bank)
> -		ret = smmu->impl->alloc_context_bank(smmu_domain, dev,
> -				start, smmu->num_context_banks);
> -	else
> -		ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
> -				      smmu->num_context_banks);
> -
> +	ret = arm_smmu_alloc_context_bank(smmu_domain, smmu, dev, start);
>  	if (ret < 0) {
> -		smmu_domain->smmu = NULL;
>  		goto out_unlock;
>  	}
>  
> +	smmu_domain->smmu = smmu;
> +
>  	cfg->cbndx = ret;
>  	if (smmu->version < ARM_SMMU_V2) {
>  		cfg->irptndx = atomic_inc_return(&smmu->irptndx);
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 2df3a70a8a41..ddf2ca4c923d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -437,7 +437,8 @@ struct arm_smmu_impl {
>  	irqreturn_t (*global_fault)(int irq, void *dev);
>  	irqreturn_t (*context_fault)(int irq, void *dev);
>  	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
> -			struct device *dev, int start, int max);
> +				  struct arm_smmu_device *smmu,
> +				  struct device *dev, int start);
>  };
>  
>  #define INVALID_SMENDX			-1
> -- 
> 2.28.0
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
