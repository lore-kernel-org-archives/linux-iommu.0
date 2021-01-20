Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6BBC433E6
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 15:02:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B40223356
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 15:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B40223356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E3CB386A04;
	Wed, 20 Jan 2021 15:02:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OEYA1+IcGluK; Wed, 20 Jan 2021 15:02:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E1E686A01;
	Wed, 20 Jan 2021 15:02:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0570CC08A1;
	Wed, 20 Jan 2021 15:02:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4351C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 15:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B2AF220504
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 15:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PHe-tkPx11MA for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 15:02:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id F1741203FF
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 15:02:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67B231B;
 Wed, 20 Jan 2021 07:02:33 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215003F68F;
 Wed, 20 Jan 2021 07:02:31 -0800 (PST)
Subject: Re: [PATCH 2/2] Revert "iommu/arm-smmu-v3: Don't reserve
 implementation defined register space"
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-3-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <888312dc-85b7-4d5e-f264-bbdd9e3638f6@arm.com>
Date: Wed, 20 Jan 2021 15:02:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119015951.1042-3-thunder.leizhen@huawei.com>
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
> This reverts commit 52f3fab0067d6fa9e99c1b7f63265dd48ca76046.
> 
> This problem has been fixed by another patch. The original method had side
> effects, it was not mapped to the user-specified resource size. The code
> will become more complex when ECMDQ is supported later.

FWIW I don't think that's a significant issue either way - there could 
be any number of imp-def pages between SMMU page 0 and the ECMDQ control 
pages, so it will still be logical to map them as another separate thing 
anyway.

Robin.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 ++++-------------------------
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ---
>   2 files changed, 4 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8ca7415d785d9bf..477f473842e5272 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -91,8 +91,9 @@ struct arm_smmu_option_prop {
>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>   						 struct arm_smmu_device *smmu)
>   {
> -	if (offset > SZ_64K)
> -		return smmu->page1 + offset - SZ_64K;
> +	if ((offset > SZ_64K) &&
> +	    (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY))
> +		offset -= SZ_64K;
>   
>   	return smmu->base + offset;
>   }
> @@ -3486,18 +3487,6 @@ static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
>   	return err;
>   }
>   
> -static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
> -				      resource_size_t size)
> -{
> -	struct resource res = {
> -		.flags = IORESOURCE_MEM,
> -		.start = start,
> -		.end = start + size - 1,
> -	};
> -
> -	return devm_ioremap_resource(dev, &res);
> -}
> -
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -3533,23 +3522,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
> -		smmu->page1 = smmu->base;
> -	}
> -
>   	/* Interrupt lines */
>   
>   	irq = platform_get_irq_byname_optional(pdev, "combined");
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 96c2e9565e00282..0c3090c60840c22 100644
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
> @@ -584,7 +582,6 @@ struct arm_smmu_strtab_cfg {
>   struct arm_smmu_device {
>   	struct device			*dev;
>   	void __iomem			*base;
> -	void __iomem			*page1;
>   
>   #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
>   #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
