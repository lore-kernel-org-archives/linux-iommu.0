Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A012C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:51:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B66764F51
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B66764F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 566328725C;
	Thu,  4 Feb 2021 19:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0eCGIvXP1cn; Thu,  4 Feb 2021 19:51:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E8AF8723B;
	Thu,  4 Feb 2021 19:51:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67D3FC07FD;
	Thu,  4 Feb 2021 19:51:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E544EC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CCB8385085
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WORBofr2-i5u for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 19:50:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C105484785
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:50:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25137D6E;
 Thu,  4 Feb 2021 11:50:58 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 838793F73B;
 Thu,  4 Feb 2021 11:50:55 -0800 (PST)
Subject: Re: [RFC PATCH 01/11] iommu/arm-smmu-v3: Add feature detection for
 HTTU
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
 Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
 <20210128151742.18840-2-zhukeqian1@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8be5718-d4d9-0565-eaf0-b5a128897d15@arm.com>
Date: Thu, 4 Feb 2021 19:50:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128151742.18840-2-zhukeqian1@huawei.com>
Content-Language: en-GB
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 lushenming@huawei.com, Kirti Wankhede <kwankhede@nvidia.com>,
 James Morse <james.morse@arm.com>, wanghaibin.wang@huawei.com
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

On 2021-01-28 15:17, Keqian Zhu wrote:
> From: jiangkunkun <jiangkunkun@huawei.com>
> 
> The SMMU which supports HTTU (Hardware Translation Table Update) can
> update the access flag and the dirty state of TTD by hardware. It is
> essential to track dirty pages of DMA.
> 
> This adds feature detection, none functional change.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++++++
>   include/linux/io-pgtable.h                  |  1 +
>   3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8ca7415d785d..0f0fe71cc10d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1987,6 +1987,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>   		.pgsize_bitmap	= smmu->pgsize_bitmap,
>   		.ias		= ias,
>   		.oas		= oas,
> +		.httu_hd	= smmu->features & ARM_SMMU_FEAT_HTTU_HD,
>   		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
>   		.tlb		= &arm_smmu_flush_ops,
>   		.iommu_dev	= smmu->dev,
> @@ -3224,6 +3225,21 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	if (reg & IDR0_HYP)
>   		smmu->features |= ARM_SMMU_FEAT_HYP;
>   
> +	switch (FIELD_GET(IDR0_HTTU, reg)) {

We need to accommodate the firmware override as well if we need this to 
be meaningful. Jean-Philippe is already carrying a suitable patch in the 
SVA stack[1].

> +	case IDR0_HTTU_NONE:
> +		break;
> +	case IDR0_HTTU_HA:
> +		smmu->features |= ARM_SMMU_FEAT_HTTU_HA;
> +		break;
> +	case IDR0_HTTU_HAD:
> +		smmu->features |= ARM_SMMU_FEAT_HTTU_HA;
> +		smmu->features |= ARM_SMMU_FEAT_HTTU_HD;
> +		break;
> +	default:
> +		dev_err(smmu->dev, "unknown/unsupported HTTU!\n");
> +		return -ENXIO;
> +	}
> +
>   	/*
>   	 * The coherency feature as set by FW is used in preference to the ID
>   	 * register, but warn on mismatch.
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 96c2e9565e00..e91bea44519e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -33,6 +33,10 @@
>   #define IDR0_ASID16			(1 << 12)
>   #define IDR0_ATS			(1 << 10)
>   #define IDR0_HYP			(1 << 9)
> +#define IDR0_HTTU			GENMASK(7, 6)
> +#define IDR0_HTTU_NONE			0
> +#define IDR0_HTTU_HA			1
> +#define IDR0_HTTU_HAD			2
>   #define IDR0_COHACC			(1 << 4)
>   #define IDR0_TTF			GENMASK(3, 2)
>   #define IDR0_TTF_AARCH64		2
> @@ -286,6 +290,8 @@
>   #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
>   
>   #define CTXDESC_CD_0_AA64		(1UL << 41)
> +#define CTXDESC_CD_0_HD			(1UL << 42)
> +#define CTXDESC_CD_0_HA			(1UL << 43)
>   #define CTXDESC_CD_0_S			(1UL << 44)
>   #define CTXDESC_CD_0_R			(1UL << 45)
>   #define CTXDESC_CD_0_A			(1UL << 46)
> @@ -604,6 +610,8 @@ struct arm_smmu_device {
>   #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
>   #define ARM_SMMU_FEAT_BTM		(1 << 16)
>   #define ARM_SMMU_FEAT_SVA		(1 << 17)
> +#define ARM_SMMU_FEAT_HTTU_HA		(1 << 18)
> +#define ARM_SMMU_FEAT_HTTU_HD		(1 << 19)
>   	u32				features;
>   
>   #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index ea727eb1a1a9..1a00ea8562c7 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -97,6 +97,7 @@ struct io_pgtable_cfg {
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
>   	unsigned int			oas;
> +	bool				httu_hd;

This is very specific to the AArch64 stage 1 format, not a generic 
capability - I think it should be a quirk flag rather than a common field.

Robin.

[1] 
https://jpbrucker.net/git/linux/commit/?h=sva/current&id=1ef7d512fb9082450dfe0d22ca4f7e35625a097b

>   	bool				coherent_walk;
>   	const struct iommu_flush_ops	*tlb;
>   	struct device			*iommu_dev;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
