Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA7C433E0
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 15:27:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74CB60C3D
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 15:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74CB60C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 533A386FA2;
	Fri, 29 Jan 2021 15:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iEZkGGDPUCdF; Fri, 29 Jan 2021 15:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 222B986ED8;
	Fri, 29 Jan 2021 15:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11EF2C08A1;
	Fri, 29 Jan 2021 15:27:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46B92C013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 15:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3BBC82E128
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 15:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ECY9c+pViKbI for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 818932E120
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 15:27:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04FC113D5;
 Fri, 29 Jan 2021 07:27:15 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7990F3F71B;
 Fri, 29 Jan 2021 07:27:13 -0800 (PST)
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Reserving the entire SMMU
 register space
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-4-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fa170300-57d9-3883-c70f-d455a9e461f0@arm.com>
Date: Fri, 29 Jan 2021 15:27:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210127113258.1421-4-thunder.leizhen@huawei.com>
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
> commit 52f3fab0067d ("iommu/arm-smmu-v3: Don't reserve implementation
> defined register space") only reserves the basic SMMU register space. So
> the ECMDQ register space is not covered, it should be mapped again. Due
> to the size of this ECMDQ resource is not fixed, depending on
> SMMU_IDR6.CMDQ_CONTROL_PAGE_LOG2NUMQ. Processing its resource reservation
> to avoid resource conflict with PMCG is a bit more complicated.
> 
> Therefore, the resources of the PMCG are not reserved, and the entire SMMU
> resources are reserved.

This is the opposite of what I suggested. My point was that it will make 
the most sense to map the ECMDQ pages as a separate request anyway, 
therefore there is no reason to stop mapping page 0 and page 1 
separately either.

If we need to expand the page 0 mapping to cover more of page 0 to reach 
the SMMU_CMDQ_CONTROL_PAGE_* registers, we can do that when we actually 
add ECMDQ support.

Robin.

> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++--------------------
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 --
>   2 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f04c55a7503c790..fde24403b06a9e3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3476,14 +3476,6 @@ static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
>   	return err;
>   }
>   
> -static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
> -				      resource_size_t size)
> -{
> -	struct resource res = DEFINE_RES_MEM(start, size);
> -
> -	return devm_ioremap_resource(dev, &res);
> -}
> -
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -3519,22 +3511,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	}
>   	ioaddr = res->start;
>   
> -	/*
> -	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
> -	 * the PMCG registers which are reserved by the PMU driver.
> -	 */
> -	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
> +	smmu->base = devm_ioremap_resource(dev, res);
>   	if (IS_ERR(smmu->base))
>   		return PTR_ERR(smmu->base);
>   
> -	if (arm_smmu_resource_size(smmu) > SZ_64K) {
> -		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
> -					       ARM_SMMU_REG_SZ);
> -		if (IS_ERR(smmu->page1))
> -			return PTR_ERR(smmu->page1);
> -	} else {
> +	if (arm_smmu_resource_size(smmu) > SZ_64K)
> +		smmu->page1 = smmu->base + SZ_64K;
> +	else
>   		smmu->page1 = smmu->base;
> -	}
>   
>   	/* Interrupt lines */
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index da525f46dab4fc1..63f2b476987d6ae 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -152,8 +152,6 @@
>   #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
>   #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
>   
> -#define ARM_SMMU_REG_SZ			0xe00
> -
>   /* Common MSI config fields */
>   #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
>   #define MSI_CFG2_SH			GENMASK(5, 4)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
