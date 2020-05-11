Return-Path: <SRS0=Mzfx=6Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55200C54E8D
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 19:03:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC61B20736
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 19:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC61B20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A339886302;
	Mon, 11 May 2020 19:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WfZ4_uw82Ry8; Mon, 11 May 2020 19:03:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B52C586EFD;
	Mon, 11 May 2020 19:03:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E011C0176;
	Mon, 11 May 2020 19:03:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97B62C016F
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 19:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5EDF22502F
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 19:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hSKa3+ICZWmv for <iommu@lists.linux-foundation.org>;
 Mon, 11 May 2020 19:03:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 488E320356
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 19:03:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 611D81FB;
 Mon, 11 May 2020 12:03:07 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F6683F71E;
 Mon, 11 May 2020 12:03:06 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Don't reserve implementation defined
 register space
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <20200506174629.1504153-1-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2c5b52c0-8be0-9c22-ed27-3a2acd2b570c@arm.com>
Date: Mon, 11 May 2020 20:03:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200506174629.1504153-1-jean-philippe@linaro.org>
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

On 2020-05-06 6:46 pm, Jean-Philippe Brucker wrote:
> Some SMMUv3 implementation embed the Perf Monitor Group Registers (PMCG)
> inside the first 64kB region of the SMMU. Since PMCG are managed by a
> separate driver, this layout causes resource reservation conflicts
> during boot.
> 
> To avoid this conflict, only reserve the MMIO region we actually use:
> the first 0xe0 bytes of page 0 and the first 0xd0 bytes of page 1.
> Although devm_ioremap() still works on full pages under the hood, this
> way we benefit from resource conflict checks.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> A nicer (and hopefully working) solution to the problem dicussed here:
> https://lore.kernel.org/linux-iommu/20200421155745.19815-1-jean-philippe@linaro.org/
> ---
>   drivers/iommu/arm-smmu-v3.c | 50 +++++++++++++++++++++++++++++++++----
>   1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 82508730feb7a1..fc85cdd5b62cca 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -171,6 +171,9 @@
>   #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
>   #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
>   
> +#define ARM_SMMU_PAGE0_REG_SZ		0xe0
> +#define ARM_SMMU_PAGE1_REG_SZ		0xd0

I wonder if we shouldn't still claim all the way up to 0xdff for good 
measure, since the IMP-DEF areas only start appearing beyond that.

> +
>   /* Common MSI config fields */
>   #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
>   #define MSI_CFG2_SH			GENMASK(5, 4)
> @@ -628,6 +631,7 @@ struct arm_smmu_strtab_cfg {
>   struct arm_smmu_device {
>   	struct device			*dev;
>   	void __iomem			*base;
> +	void __iomem			*page1;
>   
>   #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
>   #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
> @@ -733,11 +737,14 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>   						 struct arm_smmu_device *smmu)
>   {
> -	if ((offset > SZ_64K) &&
> -	    (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY))
> -		offset -= SZ_64K;
> +	void __iomem *base = smmu->base;
>   
> -	return smmu->base + offset;
> +	if (offset > SZ_64K) {
> +		offset -= SZ_64K;
> +		if (smmu->page1)
> +			base = smmu->page1;
> +	}
> +	return base + offset;
>   }

Why not just assign page1 = base in the Cavium case and let this simply be:

	if (offset > SZ_64K)
		return smmu->page1 + offset - SZ_64K;
	return smmu->base + offset;

Then it's only one step further to get rid of the fixup and use page1 
directly where relevant, but that could be a cleanup on top, since we 
probably want a minimal change here for the sake of backporting (I 
believe this deserves to go to stable, now that MMU-600 hardware is 
reaching the field and will go wonky otherwise).

>   
>   static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> @@ -4021,6 +4028,28 @@ err_reset_pci_ops: __maybe_unused;
>   	return err;
>   }
>   
> +static void __iomem *arm_smmu_ioremap(struct device *dev,
> +				      resource_size_t start,
> +				      resource_size_t size)
> +{
> +	void __iomem *dest_ptr;
> +	struct resource *res;
> +
> +	res = devm_request_mem_region(dev, start, size, dev_name(dev));
> +	if (!res) {
> +		dev_err(dev, "can't request SMMU region %pa\n", &start);
> +		return IOMEM_ERR_PTR(-EINVAL);
> +	}
> +
> +	dest_ptr = devm_ioremap(dev, start, size);
> +	if (!dest_ptr) {
> +		dev_err(dev, "ioremap failed for SMMU region %pR\n", res);
> +		devm_release_mem_region(dev, start, size);
> +		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
> +	}
> +	return dest_ptr;
> +}

Would it be any less complicated to stick with devm_ioremap_resource() 
and fix up the resource itself for each call, rather than open-coding it?

> +
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -4056,10 +4085,21 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	}
>   	ioaddr = res->start;
>   
> -	smmu->base = devm_ioremap_resource(dev, res);
> +	/*
> +	 * Only map what we need, because the IMPLEMENTATION DEFINED registers
> +	 * may be used for the PMCGs, which are reserved by the PMU driver.
> +	 */
> +	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_PAGE0_REG_SZ);
>   	if (IS_ERR(smmu->base))
>   		return PTR_ERR(smmu->base);
>   
> +	if (arm_smmu_resource_size(smmu) > SZ_64K) {
> +		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
> +					       ARM_SMMU_PAGE1_REG_SZ);
> +		if (IS_ERR(smmu->page1))
> +			return PTR_ERR(smmu->page1);
> +	}

As above,

	} else {
		smmu->page1 = smmu->base;
	}

Either way, those are just cleanliness nitpicks; I've no real objection 
to the patch in its current state. Getting MMU-600 systems un-broken at 
all is more important, there will always be time for cleanup :)

Robin.

> +
>   	/* Interrupt lines */
>   
>   	irq = platform_get_irq_byname_optional(pdev, "combined");
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
