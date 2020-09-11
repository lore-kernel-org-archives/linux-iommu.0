Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DEBC433E2
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 17:13:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D73221EB
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 17:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D73221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 954742E29C;
	Fri, 11 Sep 2020 17:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVK1BjJRSfl4; Fri, 11 Sep 2020 17:13:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D580C2E298;
	Fri, 11 Sep 2020 17:13:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEEABC0859;
	Fri, 11 Sep 2020 17:13:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70050C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 17:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5FA7F87AB2
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 17:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQXnzS1SqUsL for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 17:13:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5DD0987AA9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 17:13:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80D80106F;
 Fri, 11 Sep 2020 10:13:10 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C6733F68F;
 Fri, 11 Sep 2020 10:13:06 -0700 (PDT)
Subject: Re: [PATCH v3 6/8] iommu/arm-smmu: Add impl hook for inherit boot
 mappings
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-7-bjorn.andersson@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0bfcc8f7-d054-616b-834b-319461b1ecb9@arm.com>
Date: Fri, 11 Sep 2020 18:13:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904155513.282067-7-bjorn.andersson@linaro.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

On 2020-09-04 16:55, Bjorn Andersson wrote:
> Add a new operation to allow platform implementations to inherit any
> stream mappings from the boot loader.

Is there a reason we need an explicit step for this? The aim of the 
cfg_probe hook is that the SMMU software state should all be set up by 
then, and you can mess about with it however you like before 
arm_smmu_reset() actually commits anything to hardware. I would have 
thought you could permanently steal a context bank, configure it as your 
bypass hole, read out the previous SME configuration and tweak 
smmu->smrs and smmu->s2crs appropriately all together "invisibly" at 
that point. If that can't work, I'm very curious as to what I've overlooked.

Robin.

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - New patch/interface
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 11 ++++++-----
>   drivers/iommu/arm/arm-smmu/arm-smmu.h |  6 ++++++
>   2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index eb5c6ca5c138..4c4d302cd747 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -85,11 +85,6 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>   		pm_runtime_put_autosuspend(smmu->dev);
>   }
>   
> -static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> -{
> -	return container_of(dom, struct arm_smmu_domain, domain);
> -}
> -
>   static struct platform_driver arm_smmu_driver;
>   static struct iommu_ops arm_smmu_ops;
>   
> @@ -2188,6 +2183,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	if (err)
>   		return err;
>   
> +	if (smmu->impl->inherit_mappings) {
> +		err = smmu->impl->inherit_mappings(smmu);
> +		if (err)
> +			return err;
> +	}
> +
>   	if (smmu->version == ARM_SMMU_V2) {
>   		if (smmu->num_context_banks > smmu->num_context_irqs) {
>   			dev_err(dev,
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 235d9a3a6ab6..f58164976e74 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -378,6 +378,11 @@ struct arm_smmu_domain {
>   	struct iommu_domain		domain;
>   };
>   
> +static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> +{
> +	return container_of(dom, struct arm_smmu_domain, domain);
> +}
> +
>   struct arm_smmu_master_cfg {
>   	struct arm_smmu_device		*smmu;
>   	s16				smendx[];
> @@ -442,6 +447,7 @@ struct arm_smmu_impl {
>   	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
>   				  struct arm_smmu_device *smmu,
>   				  struct device *dev, int start);
> +	int (*inherit_mappings)(struct arm_smmu_device *smmu);
>   };
>   
>   #define INVALID_SMENDX			-1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
