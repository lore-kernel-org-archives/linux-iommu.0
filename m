Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BF6C433E0
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 12:32:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F81C22D2A
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 12:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F81C22D2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 87E38861A0;
	Tue, 19 Jan 2021 12:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYbwy9dJd+fC; Tue, 19 Jan 2021 12:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A9AA86193;
	Tue, 19 Jan 2021 12:32:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5054C08A1;
	Tue, 19 Jan 2021 12:32:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7ECA8C013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 12:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5DEF020454
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 12:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZeDWLH0pOQMU for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 12:32:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id C613C20428
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 12:32:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FD47113E;
 Tue, 19 Jan 2021 04:32:25 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F2013F719;
 Tue, 19 Jan 2021 04:32:23 -0800 (PST)
Subject: Re: [PATCH 1/2] perf/smmuv3: Don't reserve the register space that
 overlaps with the SMMUv3
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-2-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <30665cd6-b438-1d1d-7445-9e45e240f79a@arm.com>
Date: Tue, 19 Jan 2021 12:32:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119015951.1042-2-thunder.leizhen@huawei.com>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Neil Leeder <nleeder@codeaurora.org>
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

On 2021-01-19 01:59, Zhen Lei wrote:
> Some SMMUv3 implementation embed the Perf Monitor Group Registers (PMCG)
> inside the first 64kB region of the SMMU. Since SMMU and PMCG are managed
> by two separate drivers, and this driver depends on ARM_SMMU_V3, so the
> SMMU driver reserves the corresponding resource first, this driver should
> not reserve the corresponding resource again. Otherwise, a resource
> reservation conflict is reported during boot.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 74474bb322c3f26..dcce085431c6ce8 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -761,6 +761,44 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
>   	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
>   }
>   
> +static void __iomem *
> +smmu_pmu_get_and_ioremap_resource(struct platform_device *pdev,
> +				  unsigned int index,
> +				  struct resource **out_res)
> +{
> +	int ret;
> +	void __iomem *base;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	if (!res) {
> +		dev_err(&pdev->dev, "invalid resource\n");
> +		return IOMEM_ERR_PTR(-EINVAL);
> +	}
> +	if (out_res)
> +		*out_res = res;
> +
> +	ret = region_intersects(res->start, resource_size(res),
> +				IORESOURCE_MEM, IORES_DESC_NONE);
> +	if (ret == REGION_INTERSECTS) {
> +		/*
> +		 * The resource has already been reserved by the SMMUv3 driver.
> +		 * Don't reserve it again, just do devm_ioremap().
> +		 */
> +		base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	} else {
> +		/*
> +		 * The resource may have not been reserved by any driver, or
> +		 * has been reserved but not type IORESOURCE_MEM. In the latter
> +		 * case, devm_ioremap_resource() reports a conflict and returns
> +		 * IOMEM_ERR_PTR(-EBUSY).
> +		 */
> +		base = devm_ioremap_resource(&pdev->dev, res);
> +	}

What if the PMCG driver simply happens to probe first?

Robin.

> +
> +	return base;
> +}
> +
>   static int smmu_pmu_probe(struct platform_device *pdev)
>   {
>   	struct smmu_pmu *smmu_pmu;
> @@ -793,7 +831,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>   	};
>   
> -	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
> +	smmu_pmu->reg_base = smmu_pmu_get_and_ioremap_resource(pdev, 0, &res_0);
>   	if (IS_ERR(smmu_pmu->reg_base))
>   		return PTR_ERR(smmu_pmu->reg_base);
>   
> @@ -801,7 +839,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   
>   	/* Determine if page 1 is present */
>   	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> -		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
> +		smmu_pmu->reloc_base = smmu_pmu_get_and_ioremap_resource(pdev, 1, NULL);
>   		if (IS_ERR(smmu_pmu->reloc_base))
>   			return PTR_ERR(smmu_pmu->reloc_base);
>   	} else {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
