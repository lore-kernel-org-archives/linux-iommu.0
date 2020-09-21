Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAEAC43463
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 08:59:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A6D2151B
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 08:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A6D2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E6CA2867F5;
	Mon, 21 Sep 2020 08:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gATbmC+z3bIf; Mon, 21 Sep 2020 08:59:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A1D6867F3;
	Mon, 21 Sep 2020 08:59:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 857E1C0859;
	Mon, 21 Sep 2020 08:59:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59997C0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 08:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3883020492
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 08:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPyVKNATYvYd for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 08:59:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id DBA0F2040D
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 08:59:42 +0000 (UTC)
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 44C52F0E845806F6D929;
 Mon, 21 Sep 2020 09:59:40 +0100 (IST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 21 Sep 2020 09:59:40 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Mon, 21 Sep 2020 09:59:40 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>
Subject: RE: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Topic: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Index: AQHWjaVYIOfN4SdH50ySUPU7pQ9X7Klyx0+A
Date: Mon, 21 Sep 2020 08:59:39 +0000
Message-ID: <753bcd76c21c4ea98ef1d4e492db01f4@huawei.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-11-jean-philippe@linaro.org>
In-Reply-To: <20200918101852.582559-11-jean-philippe@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.108]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, "will@kernel.org" <will@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

> -----Original Message-----
> From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of
> Jean-Philippe Brucker
> Sent: 18 September 2020 11:19
> To: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> linux-mm@kvack.org
> Cc: fenghua.yu@intel.com; Jean-Philippe Brucker <jean-philippe@linaro.org>;
> catalin.marinas@arm.com; Suzuki K Poulose <suzuki.poulose@arm.com>;
> robin.murphy@arm.com; zhangfei.gao@linaro.org; will@kernel.org
> Subject: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
> 
> Aggregate all sanity-checks for sharing CPU page tables with the SMMU
> under a single ARM_SMMU_FEAT_SVA bit. For PCIe SVA, users also need to
> check FEAT_ATS and FEAT_PRI. For platform SVA, they will have to check
> FEAT_STALLS.
> 
> Introduce ARM_SMMU_FEAT_BTM (Broadcast TLB Maintenance), but don't
> enable it at the moment. Since the entire VMID space is shared with the
> CPU, enabling DVM (by clearing SMMU_CR2.PTM) could result in
> over-invalidation and affect performance of stage-2 mappings.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v10:
> * Check that 52-bit VA is supported on the SMMU side if vabits_actual
>   requires it.
> * Check arm64_kernel_unmapped_at_el0() instead of
>   CONFIG_UNMAP_KERNEL_AT_EL0
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 10 +++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 45
> +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 ++
>  3 files changed, 58 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 90c08f156b43..7b14b48a26c7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -602,6 +602,8 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
>  #define ARM_SMMU_FEAT_VAX		(1 << 14)
>  #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
> +#define ARM_SMMU_FEAT_BTM		(1 << 16)
> +#define ARM_SMMU_FEAT_SVA		(1 << 17)
>  	u32				features;
> 
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> @@ -683,4 +685,12 @@ int arm_smmu_write_ctx_desc(struct
> arm_smmu_domain *smmu_domain, int ssid,
>  void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
>  bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
> 
> +#ifdef CONFIG_ARM_SMMU_V3_SVA
> +bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
> +#else /* CONFIG_ARM_SMMU_V3_SVA */
> +static inline bool arm_smmu_sva_supported(struct arm_smmu_device
> *smmu)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_ARM_SMMU_V3_SVA */
>  #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index ef3fcfa72187..cb94c0924196 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -152,3 +152,48 @@ static void arm_smmu_free_shared_cd(struct
> arm_smmu_ctx_desc *cd)
>  		kfree(cd);
>  	}
>  }
> +
> +bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
> +{
> +	unsigned long reg, fld;
> +	unsigned long oas;
> +	unsigned long asid_bits;
> +	u32 feat_mask = ARM_SMMU_FEAT_BTM |
> ARM_SMMU_FEAT_COHERENCY;

Why is BTM mandated for SVA? I couldn't find this requirement in SMMU spec
(Sorry if I missed it or this got discussed earlier). But if performance is the only concern here,
is it better just to allow it with a warning rather than limiting SMMUs without BTM?

Thanks,
Shameer

> +
> +	if (vabits_actual == 52)
> +		feat_mask |= ARM_SMMU_FEAT_VAX;
> +
> +	if ((smmu->features & feat_mask) != feat_mask)
> +		return false;
> +
> +	if (!(smmu->pgsize_bitmap & PAGE_SIZE))
> +		return false;
> +
> +	/*
> +	 * Get the smallest PA size of all CPUs (sanitized by cpufeature). We're
> +	 * not even pretending to support AArch32 here. Abort if the MMU
> outputs
> +	 * addresses larger than what we support.
> +	 */
> +	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> +	fld = cpuid_feature_extract_unsigned_field(reg,
> ID_AA64MMFR0_PARANGE_SHIFT);
> +	oas = id_aa64mmfr0_parange_to_phys_shift(fld);
> +	if (smmu->oas < oas)
> +		return false;
> +
> +	/* We can support bigger ASIDs than the CPU, but not smaller */
> +	fld = cpuid_feature_extract_unsigned_field(reg,
> ID_AA64MMFR0_ASID_SHIFT);
> +	asid_bits = fld ? 16 : 8;
> +	if (smmu->asid_bits < asid_bits)
> +		return false;
> +
> +	/*
> +	 * See max_pinned_asids in arch/arm64/mm/context.c. The following is
> +	 * generally the maximum number of bindable processes.
> +	 */
> +	if (arm64_kernel_unmapped_at_el0())
> +		asid_bits--;
> +	dev_dbg(smmu->dev, "%d shared contexts\n", (1 << asid_bits) -
> +		num_possible_cpus() - 2);
> +
> +	return true;
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e99ebdd4c841..44c57bcfe112 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3257,6 +3257,9 @@ static int arm_smmu_device_hw_probe(struct
> arm_smmu_device *smmu)
> 
>  	smmu->ias = max(smmu->ias, smmu->oas);
> 
> +	if (arm_smmu_sva_supported(smmu))
> +		smmu->features |= ARM_SMMU_FEAT_SVA;
> +
>  	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
>  		 smmu->ias, smmu->oas, smmu->features);
>  	return 0;
> --
> 2.28.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
