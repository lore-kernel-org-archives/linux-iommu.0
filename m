Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBADFC433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 11:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7305D405A6;
	Fri, 29 Apr 2022 11:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q_pVWWBl10Qq; Fri, 29 Apr 2022 11:11:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D367640001;
	Fri, 29 Apr 2022 11:11:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F85AC0032;
	Fri, 29 Apr 2022 11:11:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5B37C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 11:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9445360615
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 11:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IuWxU8r75aRc for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 11:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9473B605C9
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 11:11:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAE241063;
 Fri, 29 Apr 2022 04:11:50 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3866B3F73B;
 Fri, 29 Apr 2022 04:11:47 -0700 (PDT)
Message-ID: <8e897628-61fa-b3fb-b609-44eeda11b45e@arm.com>
Date: Fri, 29 Apr 2022 12:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC 13/19] iommu/arm-smmu-v3: Add feature detection for
 BBML
Content-Language: en-GB
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-14-joao.m.martins@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220428210933.3583-14-joao.m.martins@oracle.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2022-04-28 22:09, Joao Martins wrote:
> From: Kunkun Jiang <jiangkunkun@huawei.com>
> 
> This detects BBML feature and if SMMU supports it, transfer BBMLx
> quirk to io-pgtable.
> 
> BBML1 requires still marking PTE nT prior to performing a
> translation table update, while BBML2 requires neither break-before-make
> nor PTE nT bit being set. For dirty tracking it needs to clear
> the dirty bit so checking BBML2 tells us the prerequisite. See SMMUv3.2
> manual, section "3.21.1.3 When SMMU_IDR3.BBML == 2 (Level 2)" and
> "3.21.1.2 When SMMU_IDR3.BBML == 1 (Level 1)"

You can drop this, and the dependencies on BBML elsewhere, until you get 
round to the future large-page-splitting work, since that's the only 
thing this represents. Not much point having the feature flags without 
an actual implementation, or any users.

Robin.

> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> [joaomart: massage commit message with the need to have BBML quirk
>   and add the Quirk io-pgtable flags]
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 ++++++
>   include/linux/io-pgtable.h                  |  3 +++
>   3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 14609ece4e33..4dba53bde2e3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2203,6 +2203,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>   		.iommu_dev	= smmu->dev,
>   	};
>   
> +	if (smmu->features & ARM_SMMU_FEAT_BBML1)
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_BBML1;
> +	else if (smmu->features & ARM_SMMU_FEAT_BBML2)
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_BBML2;
> +
>   	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>   	if (!pgtbl_ops)
>   		return -ENOMEM;
> @@ -3591,6 +3596,20 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   
>   	/* IDR3 */
>   	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
> +	switch (FIELD_GET(IDR3_BBML, reg)) {
> +	case IDR3_BBML0:
> +		break;
> +	case IDR3_BBML1:
> +		smmu->features |= ARM_SMMU_FEAT_BBML1;
> +		break;
> +	case IDR3_BBML2:
> +		smmu->features |= ARM_SMMU_FEAT_BBML2;
> +		break;
> +	default:
> +		dev_err(smmu->dev, "unknown/unsupported BBM behavior level\n");
> +		return -ENXIO;
> +	}
> +
>   	if (FIELD_GET(IDR3_RIL, reg))
>   		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 1487a80fdf1b..e15750be1d95 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -54,6 +54,10 @@
>   #define IDR1_SIDSIZE			GENMASK(5, 0)
>   
>   #define ARM_SMMU_IDR3			0xc
> +#define IDR3_BBML			GENMASK(12, 11)
> +#define IDR3_BBML0			0
> +#define IDR3_BBML1			1
> +#define IDR3_BBML2			2
>   #define IDR3_RIL			(1 << 10)
>   
>   #define ARM_SMMU_IDR5			0x14
> @@ -644,6 +648,8 @@ struct arm_smmu_device {
>   #define ARM_SMMU_FEAT_E2H		(1 << 18)
>   #define ARM_SMMU_FEAT_HA		(1 << 19)
>   #define ARM_SMMU_FEAT_HD		(1 << 20)
> +#define ARM_SMMU_FEAT_BBML1		(1 << 21)
> +#define ARM_SMMU_FEAT_BBML2		(1 << 22)
>   	u32				features;
>   
>   #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index c2ebfe037f5d..d7626ca67dbf 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -85,6 +85,9 @@ struct io_pgtable_cfg {
>   	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
>   	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
>   	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA	BIT(6)
> +	#define IO_PGTABLE_QUIRK_ARM_BBML1      BIT(7)
> +	#define IO_PGTABLE_QUIRK_ARM_BBML2      BIT(8)
> +
>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
