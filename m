Return-Path: <SRS0=U628=6F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CEDC54FC9
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 17:26:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEF8206D5
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 17:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEF8206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DFA4220421;
	Tue, 21 Apr 2020 17:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BsDqqyEH9ml9; Tue, 21 Apr 2020 17:26:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9E7E9203F0;
	Tue, 21 Apr 2020 17:26:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8500BC1D91;
	Tue, 21 Apr 2020 17:26:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08BEBC0175
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 17:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F3B8120419
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 17:26:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ge22gkXdyQM0 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Apr 2020 17:26:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 36998203F0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 17:26:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 910F21FB;
 Tue, 21 Apr 2020 10:25:58 -0700 (PDT)
Received: from [10.57.33.63] (unknown [10.57.33.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC6073F73D;
 Tue, 21 Apr 2020 10:25:56 -0700 (PDT)
Subject: Re: [PATCH] perf/smmuv3: Allow sharing MMIO registers with the SMMU
 driver
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 mark.rutland@arm.com
References: <20200421155745.19815-1-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <beec9760-f6f4-90fb-74fc-3e074b553b59@arm.com>
Date: Tue, 21 Apr 2020 18:25:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421155745.19815-1-jean-philippe@linaro.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 2020-04-21 4:57 pm, Jean-Philippe Brucker wrote:
> Some Arm SMMUv3 implementations, for example Arm CoreLink MMU-600, embed
> the PMCG registers into the SMMU MMIO regions. It currently causes probe
> failure because the PMU and SMMU drivers request overlapping resources.
> 
> Avoid the conflict by calling devm_ioremap() directly from the PMU
> driver. We loose some sanity-checking of the memory map provided by
> firmware, which doesn't seem catastrophic.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> 
> So this is the simplest solution, and I don't think we're missing much
> by skipping the resource reservation. I've also been exploring a more
> complex approach [1] which has the SMMU driver perform resource
> reservation on behalf of the PMU driver, but I'm not sure it's
> necessary.

Now try it for potential future PMCGs on DTI masters in any old device 
or root complex ;)

If we did want to go down the resource-claiming route, rather than new 
inter-driver APIs it would probably be more sensible to just resolve the 
associated device and rifle through its resource list directly within 
the PMCG driver. Of course that probably leads to a whole bunch of probe 
ordering and dependency issues, and if the end result is just to make 
/proc/iomem look slightly nicer then I'd agree it's not worth the bother.

> Please test, I've only tried the RevC FastModel using devicetree so far.

For ACPI there's the additional fun that all the resources may already 
have been claimed at least once more, by companion devices, but I guess 
SMMU and PMCG at least escape that by virtue of not being namespace objects.

Robin.

> [1] https://jpbrucker.net/git/linux/log/?h=smmu/pmu
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index ca183a53a7f10..ad63d1e73333f 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -730,8 +730,8 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
>   
>   static int smmu_pmu_probe(struct platform_device *pdev)
>   {
> +	struct resource *res_0, *res_1;
>   	struct smmu_pmu *smmu_pmu;
> -	struct resource *res_0;
>   	u32 cfgr, reg_size;
>   	u64 ceid_64[2];
>   	int irq, err;
> @@ -759,18 +759,32 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>   	};
>   
> +	/*
> +	 * If the PMCG registers are embedded into the SMMU regions, the
> +	 * resources have to be shared with the SMMU driver. Use ioremap()
> +	 * rather than ioremap_resource() to avoid conflicts.
> +	 */
>   	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	smmu_pmu->reg_base = devm_ioremap_resource(dev, res_0);
> -	if (IS_ERR(smmu_pmu->reg_base))
> -		return PTR_ERR(smmu_pmu->reg_base);
> +	if (!res_0)
> +		return -ENXIO;
> +
> +	smmu_pmu->reg_base = devm_ioremap(dev, res_0->start,
> +					  resource_size(res_0));
> +	if (!smmu_pmu->reg_base)
> +		return -ENOMEM;
>   
>   	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
>   
>   	/* Determine if page 1 is present */
>   	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> -		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
> -		if (IS_ERR(smmu_pmu->reloc_base))
> -			return PTR_ERR(smmu_pmu->reloc_base);
> +		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res_1)
> +			return -ENXIO;
> +
> +		smmu_pmu->reloc_base = devm_ioremap(dev, res_1->start,
> +						    resource_size(res_1));
> +		if (!smmu_pmu->reloc_base)
> +			return -ENOMEM;
>   	} else {
>   		smmu_pmu->reloc_base = smmu_pmu->reg_base;
>   	}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
