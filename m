Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7614C433E3
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 10:32:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1302067D
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 10:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1302067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 407AD220E5;
	Wed, 15 Jul 2020 10:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3h8h0EFzi42; Wed, 15 Jul 2020 10:32:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6904E20430;
	Wed, 15 Jul 2020 10:32:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED38C0891;
	Wed, 15 Jul 2020 10:32:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31921C0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2083D8AC0C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhO2h7QuhHFY for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 10:32:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2B53E8AC0B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:32:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B851230E;
 Wed, 15 Jul 2020 03:32:33 -0700 (PDT)
Received: from [10.57.32.45] (unknown [10.57.32.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8E623F718;
 Wed, 15 Jul 2020 03:32:31 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] iommu/arm-smmu: Workaround for Marvell
 Armada-AP806 SoC erratum #582743
To: Tomasz Nowicki <tn@semihalf.com>, will@kernel.org, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
References: <20200715070649.18733-1-tn@semihalf.com>
 <20200715070649.18733-3-tn@semihalf.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <793ede4d-79e9-3615-9da1-57cfe1a44c4d@arm.com>
Date: Wed, 15 Jul 2020 11:32:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715070649.18733-3-tn@semihalf.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
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

On 2020-07-15 08:06, Tomasz Nowicki wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit to
> ARM SMMUv2 registers.
> 
> Provide implementation relevant hooks:
> - split the writeq/readq to two accesses of writel/readl.
> - mask the MMU_IDR2.PTFSv8 fields to not use AArch64 format (but
> only AARCH32_L) since with AArch64 format 32 bits access is not supported.
> 
> Note that most 64-bit registers like TTBRn can be accessed as two 32-bit
> halves without issue, and AArch32 format ensures that the register writes
> which must be atomic (for TLBI etc.) need only be 32-bit.

Thanks Tomasz, this has ended up as clean as I'd hoped it could, and 
there's still room to come back and play more complicated games later if 
a real need for AARCH64_64K at stage 2 crops up.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>   Documentation/arm64/silicon-errata.rst |  3 ++
>   drivers/iommu/arm-smmu-impl.c          | 45 ++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index 936cf2a59ca4..157214d3abe1 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -125,6 +125,9 @@ stable kernels.
>   | Cavium         | ThunderX2 Core  | #219            | CAVIUM_TX2_ERRATUM_219      |
>   +----------------+-----------------+-----------------+-----------------------------+
>   +----------------+-----------------+-----------------+-----------------------------+
> +| Marvell        | ARM-MMU-500     | #582743         | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
> ++----------------+-----------------+-----------------+-----------------------------+

And in case anyone feels like nit-picking the order here, I think the 
current respective corporate structures perfectly justify "Marvell" 
sorting alphabetically before "NXP", to be next to "Cavium" :D

Robin.

>   | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>   +----------------+-----------------+-----------------+-----------------------------+
>   +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index c75b9d957b70..59422cb92488 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -147,6 +147,48 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
>   	.reset = arm_mmu500_reset,
>   };
>   
> +static u64 mrvl_mmu500_readq(struct arm_smmu_device *smmu, int page, int off)
> +{
> +	/*
> +	 * Marvell Armada-AP806 erratum #582743.
> +	 * Split all the readq to double readl
> +	 */
> +	return hi_lo_readq_relaxed(arm_smmu_page(smmu, page) + off);
> +}
> +
> +static void mrvl_mmu500_writeq(struct arm_smmu_device *smmu, int page, int off,
> +			       u64 val)
> +{
> +	/*
> +	 * Marvell Armada-AP806 erratum #582743.
> +	 * Split all the writeq to double writel
> +	 */
> +	hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + off);
> +}
> +
> +static int mrvl_mmu500_cfg_probe(struct arm_smmu_device *smmu)
> +{
> +
> +	/*
> +	 * Armada-AP806 erratum #582743.
> +	 * Hide the SMMU_IDR2.PTFSv8 fields to sidestep the AArch64
> +	 * formats altogether and allow using 32 bits access on the
> +	 * interconnect.
> +	 */
> +	smmu->features &= ~(ARM_SMMU_FEAT_FMT_AARCH64_4K |
> +			    ARM_SMMU_FEAT_FMT_AARCH64_16K |
> +			    ARM_SMMU_FEAT_FMT_AARCH64_64K);
> +
> +	return 0;
> +}
> +
> +static const struct arm_smmu_impl mrvl_mmu500_impl = {
> +	.read_reg64 = mrvl_mmu500_readq,
> +	.write_reg64 = mrvl_mmu500_writeq,
> +	.cfg_probe = mrvl_mmu500_cfg_probe,
> +	.reset = arm_mmu500_reset,
> +};
> +
>   
>   struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   {
> @@ -175,5 +217,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
>   		return qcom_smmu_impl_init(smmu);
>   
> +	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
> +		smmu->impl = &mrvl_mmu500_impl;
> +
>   	return smmu;
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
