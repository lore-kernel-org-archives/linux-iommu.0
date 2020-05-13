Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA78CA90AF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 12:17:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA23206D6
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 12:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA23206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A60B821539;
	Wed, 13 May 2020 12:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZrcv7NYeTMh; Wed, 13 May 2020 12:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A70DE2041A;
	Wed, 13 May 2020 12:17:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99519C088B;
	Wed, 13 May 2020 12:17:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69C59C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 12:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4684920488
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 12:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PuwyvSHzh88f for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 12:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id AD9A82041A
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 12:17:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0746D30E;
 Wed, 13 May 2020 05:17:05 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF3BF3F71E;
 Wed, 13 May 2020 05:17:03 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Don't reserve implementation
 defined register space
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <20200513110255.597203-1-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <cb1d150c-c83a-39ed-29df-599cec7b9201@arm.com>
Date: Wed, 13 May 2020 13:17:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513110255.597203-1-jean-philippe@linaro.org>
Content-Language: en-GB
Cc: will@kernel.org, tuanphan@amperemail.onmicrosoft.com
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

On 2020-05-13 12:02 pm, Jean-Philippe Brucker wrote:
> Some SMMUv3 implementation embed the Perf Monitor Group Registers (PMCG)
> inside the first 64kB region of the SMMU. Since PMCG are managed by a
> separate driver, this layout causes resource reservation conflicts
> during boot.
> 
> To avoid this conflict, don't reserve the MMIO regions that are
> implementation defined. Although devm_ioremap_resource() still works on
> full pages under the hood, this way we benefit from resource conflict
> checks.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Although in case there's any other cause to resend, a couple of nits below.

> Fixes: 7d839b4b9e00 ("perf/smmuv3: Add arm64 smmuv3 pmu driver")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1->v2: simplify following Robin's comments
> https://lore.kernel.org/linux-iommu/20200506174629.1504153-1-jean-philippe@linaro.org/
> ---
>   drivers/iommu/arm-smmu-v3.c | 35 +++++++++++++++++++++++++++++++----
>   1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 82508730feb7a1..af21d24a09e888 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -171,6 +171,8 @@
>   #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
>   #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
>   
> +#define ARM_SMMU_REG_SZ			0xe00

Since it's not necessarily self-explanatory at a glance, might this 
deserve a comment to clarify that it's the start of the first IMP-DEF 
region in the register map, and all the architectural registers that we 
care about lie below it?

> +
>   /* Common MSI config fields */
>   #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
>   #define MSI_CFG2_SH			GENMASK(5, 4)
> @@ -628,6 +630,7 @@ struct arm_smmu_strtab_cfg {
>   struct arm_smmu_device {
>   	struct device			*dev;
>   	void __iomem			*base;
> +	void __iomem			*page1;
>   
>   #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
>   #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
> @@ -733,9 +736,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>   						 struct arm_smmu_device *smmu)
>   {
> -	if ((offset > SZ_64K) &&
> -	    (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY))
> -		offset -= SZ_64K;
> +	if (offset > SZ_64K)
> +		return smmu->page1 + offset - SZ_64K;
>   
>   	return smmu->base + offset;
>   }
> @@ -4021,6 +4023,18 @@ err_reset_pci_ops: __maybe_unused;
>   	return err;
>   }
>   
> +static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
> +				      resource_size_t size)
> +{
> +	struct resource res = {
> +		.flags = IORESOURCE_MEM,
> +		.start = start,
> +		.end = start + size - 1,

There doesn't seem to be much point in pretending size is a variable 
argument; I'd have just encoded ARM_SMMU_REG_SZ directly here.

Thanks,
Robin.

> +	};
> +
> +	return devm_ioremap_resource(dev, &res);
> +}
> +
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -4056,10 +4070,23 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	}
>   	ioaddr = res->start;
>   
> -	smmu->base = devm_ioremap_resource(dev, res);
> +	/*
> +	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
> +	 * the PMCG registers which are reserved by the PMU driver.
> +	 */
> +	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
>   	if (IS_ERR(smmu->base))
>   		return PTR_ERR(smmu->base);
>   
> +	if (arm_smmu_resource_size(smmu) > SZ_64K) {
> +		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
> +					       ARM_SMMU_REG_SZ);
> +		if (IS_ERR(smmu->page1))
> +			return PTR_ERR(smmu->page1);
> +	} else {
> +		smmu->page1 = smmu->base;
> +	}
> +
>   	/* Interrupt lines */
>   
>   	irq = platform_get_irq_byname_optional(pdev, "combined");
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
