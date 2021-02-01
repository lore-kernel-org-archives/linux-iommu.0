Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5612EC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:08:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA92464E8F
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA92464E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9364485FC4;
	Mon,  1 Feb 2021 12:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGc22zPakq9X; Mon,  1 Feb 2021 12:08:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B09E18409C;
	Mon,  1 Feb 2021 12:08:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98749C0174;
	Mon,  1 Feb 2021 12:08:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFFBAC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B36E42035C
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:08:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWWhDCEyoEQE for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 12:08:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id EB1FD20020
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:08:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FF1DED1;
 Mon,  1 Feb 2021 04:08:38 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54B853F718;
 Mon,  1 Feb 2021 04:08:36 -0800 (PST)
Subject: Re: [PATCH v4 1/2] perf/smmuv3: Don't reserve the PMCG register spaces
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210130071414.1575-1-thunder.leizhen@huawei.com>
 <20210130071414.1575-2-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9904b39d-f328-14d6-b5d8-8b9e8a1437b6@arm.com>
Date: Mon, 1 Feb 2021 12:08:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210130071414.1575-2-thunder.leizhen@huawei.com>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

On 2021-01-30 07:14, Zhen Lei wrote:
> According to the SMMUv3 specification:
> Each PMCG counter group is represented by one 4KB page (Page 0) with one
> optional additional 4KB page (Page 1), both of which are at IMPLEMENTATION
> DEFINED base addresses.
> 
> This means that the PMCG register spaces may be within the 64KB pages of
> the SMMUv3 register space. When both the SMMU and PMCG drivers reserve
> their own resources, a resource conflict occurs.
> 
> To avoid this conflict, don't reserve the PMCG regions.

I said my review on v3 stood either way, but for the avoidance of doubt,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I hadn't considered that a comment is a very good idea, in case the 
cleanup-script crew find this in future and try to "simplify" it :)

Thanks,
Robin.

> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 74474bb322c3f26..5e894f957c7b935 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -793,17 +793,30 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>   	};
>   
> -	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
> -	if (IS_ERR(smmu_pmu->reg_base))
> -		return PTR_ERR(smmu_pmu->reg_base);
> +	/*
> +	 * The register spaces of the PMCG may be in the register space of
> +	 * other devices. For example, SMMU. Therefore, the PMCG resources are
> +	 * not reserved to avoid resource conflicts with other drivers.
> +	 */
> +	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res_0)
> +		return ERR_PTR(-EINVAL);
> +	smmu_pmu->reg_base = devm_ioremap(dev, res_0->start, resource_size(res_0));
> +	if (!smmu_pmu->reg_base)
> +		return ERR_PTR(-ENOMEM);
>   
>   	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
>   
>   	/* Determine if page 1 is present */
>   	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> -		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
> -		if (IS_ERR(smmu_pmu->reloc_base))
> -			return PTR_ERR(smmu_pmu->reloc_base);
> +		struct resource *res_1;
> +
> +		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res_1)
> +			return ERR_PTR(-EINVAL);
> +		smmu_pmu->reloc_base = devm_ioremap(dev, res_1->start, resource_size(res_1));
> +		if (!smmu_pmu->reloc_base)
> +			return ERR_PTR(-ENOMEM);
>   	} else {
>   		smmu_pmu->reloc_base = smmu_pmu->reg_base;
>   	}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
