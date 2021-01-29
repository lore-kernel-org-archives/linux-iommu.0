Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57169C433E0
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 15:07:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BDE64E05
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 15:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BDE64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5F9A8624A;
	Fri, 29 Jan 2021 15:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RtSmdHVlEOl5; Fri, 29 Jan 2021 15:07:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2763A86199;
	Fri, 29 Jan 2021 15:07:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 073F6C08A1;
	Fri, 29 Jan 2021 15:07:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F392FC013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 15:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D8F2D2E113
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 15:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s-ryXGC8K3Zv for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:07:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 671D62E10B
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 15:07:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B4813D5;
 Fri, 29 Jan 2021 07:06:59 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03E6A3F71B;
 Fri, 29 Jan 2021 07:06:57 -0800 (PST)
Subject: Re: [PATCH v3 1/3] perf/smmuv3: Don't reserve the PMCG register spaces
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-2-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a794cb2f-599e-c346-042e-d361d5321cce@arm.com>
Date: Fri, 29 Jan 2021 15:06:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210127113258.1421-2-thunder.leizhen@huawei.com>
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

On 2021-01-27 11:32, Zhen Lei wrote:
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

I'm still not a fan of this get_and_ioremap notion in general, 
especially when the "helper" function ends up over twice the size of all 
the code it replaces[1], but for the actual functional change here,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 74474bb322c3f26..e5e505a0804fe53 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -761,6 +761,29 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
>   	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
>   }
>   
> +static void __iomem *
> +smmu_pmu_get_and_ioremap_resource(struct platform_device *pdev,
> +				  unsigned int index,
> +				  struct resource **res)
> +{
> +	void __iomem *base;
> +	struct resource *r;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	if (!r) {
> +		dev_err(&pdev->dev, "invalid resource\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +	if (res)
> +		*res = r;
> +
> +	base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
> +	if (!base)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return base;
> +}
> +
>   static int smmu_pmu_probe(struct platform_device *pdev)
>   {
>   	struct smmu_pmu *smmu_pmu;
> @@ -793,7 +816,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>   	};
>   
> -	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
> +	smmu_pmu->reg_base = smmu_pmu_get_and_ioremap_resource(pdev, 0, &res_0);
>   	if (IS_ERR(smmu_pmu->reg_base))
>   		return PTR_ERR(smmu_pmu->reg_base);
>   
> @@ -801,7 +824,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   
>   	/* Determine if page 1 is present */
>   	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> -		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
> +		smmu_pmu->reloc_base = smmu_pmu_get_and_ioremap_resource(pdev, 1, NULL);
>   		if (IS_ERR(smmu_pmu->reloc_base))
>   			return PTR_ERR(smmu_pmu->reloc_base);
>   	} else {
> 

[1]
----->8-----
  drivers/perf/arm_smmuv3_pmu.c | 35 +++++++++--------------------------
  1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index e5e505a0804f..c9adbc7b55a1 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -761,33 +761,10 @@ static void smmu_pmu_get_acpi_options(struct 
smmu_pmu *smmu_pmu)
  	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
  }

-static void __iomem *
-smmu_pmu_get_and_ioremap_resource(struct platform_device *pdev,
-				  unsigned int index,
-				  struct resource **res)
-{
-	void __iomem *base;
-	struct resource *r;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	if (!r) {
-		dev_err(&pdev->dev, "invalid resource\n");
-		return ERR_PTR(-EINVAL);
-	}
-	if (res)
-		*res = r;
-
-	base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!base)
-		return ERR_PTR(-ENOMEM);
-
-	return base;
-}
-
  static int smmu_pmu_probe(struct platform_device *pdev)
  {
  	struct smmu_pmu *smmu_pmu;
-	struct resource *res_0;
+	struct resource *res_0, *res_1;
  	u32 cfgr, reg_size;
  	u64 ceid_64[2];
  	int irq, err;
@@ -816,7 +793,10 @@ static int smmu_pmu_probe(struct platform_device *pdev)
  		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
  	};

-	smmu_pmu->reg_base = smmu_pmu_get_and_ioremap_resource(pdev, 0, &res_0);
+	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_0)
+		return ERR_PTR(-EINVAL);
+	smmu_pmu->reg_base = devm_ioremap(dev, res_0->start, 
resource_size(res_0));
  	if (IS_ERR(smmu_pmu->reg_base))
  		return PTR_ERR(smmu_pmu->reg_base);

@@ -824,7 +804,10 @@ static int smmu_pmu_probe(struct platform_device *pdev)

  	/* Determine if page 1 is present */
  	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
-		smmu_pmu->reloc_base = smmu_pmu_get_and_ioremap_resource(pdev, 1, NULL);
+		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res_1)
+			return -EINVAL;
+		smmu_pmu->reloc_base = devm_ioremap(dev, res_1->start, 
resource_size(res_1));
  		if (IS_ERR(smmu_pmu->reloc_base))
  			return PTR_ERR(smmu_pmu->reloc_base);
  	} else {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
