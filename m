Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA45C433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 03:00:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5428B2075F
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 03:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5428B2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0FFD187852;
	Wed, 27 May 2020 03:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5j2JBW0kRr5W; Wed, 27 May 2020 03:00:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 948D68784E;
	Wed, 27 May 2020 03:00:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8820BC0888;
	Wed, 27 May 2020 03:00:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14A76C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 03:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0314688634
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 03:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fvRPDOz7PtHf for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 03:00:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B1F4A88583
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 03:00:45 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3C20BF272BC3D1B5F2DA;
 Wed, 27 May 2020 11:00:42 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.213) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 27 May 2020 11:00:31 +0800
Subject: Re: [PATCH v7 18/24] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
 <linux-mm@kvack.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-19-jean-philippe@linaro.org>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <4eea10e0-1343-8d7d-ba8d-214d05558c76@huawei.com>
Date: Wed, 27 May 2020 11:00:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200519175502.2504091-19-jean-philippe@linaro.org>
Content-Language: en-US
X-Originating-IP: [10.173.221.213]
X-CFilter-Loop: Reflected
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, will@kernel.org,
 catalin.marinas@arm.com, christian.koenig@amd.com, hch@infradead.org,
 jgg@ziepe.ca, Wang Haibin <wanghaibin.wang@huawei.com>,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, felix.kuehling@amd.com
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

This patch only enables HTTU bits in CDs. Is it also neccessary to enable
HTTU bits in STEs in this patch?

On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
> If the SMMU supports it and the kernel was built with HTTU support,
> enable hardware update of access and dirty flags. This is essential for
> shared page tables, to reduce the number of access faults on the fault
> queue. Normal DMA with io-pgtables doesn't currently use the access or
> dirty flags.
> 
> We can enable HTTU even if CPUs don't support it, because the kernel
> always checks for HW dirty bit and updates the PTE flags atomically.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1386d4d2bc60..6a368218f54c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -58,6 +58,8 @@
>  #define IDR0_ASID16			(1 << 12)
>  #define IDR0_ATS			(1 << 10)
>  #define IDR0_HYP			(1 << 9)
> +#define IDR0_HD				(1 << 7)
> +#define IDR0_HA				(1 << 6)
>  #define IDR0_BTM			(1 << 5)
>  #define IDR0_COHACC			(1 << 4)
>  #define IDR0_TTF			GENMASK(3, 2)
> @@ -311,6 +313,9 @@
>  #define CTXDESC_CD_0_TCR_IPS		GENMASK_ULL(34, 32)
>  #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
>  
> +#define CTXDESC_CD_0_TCR_HA		(1UL << 43)
> +#define CTXDESC_CD_0_TCR_HD		(1UL << 42)
> +

>  #define CTXDESC_CD_0_AA64		(1UL << 41)
>  #define CTXDESC_CD_0_S			(1UL << 44)
>  #define CTXDESC_CD_0_R			(1UL << 45)
> @@ -663,6 +668,8 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_E2H		(1 << 16)
>  #define ARM_SMMU_FEAT_BTM		(1 << 17)
>  #define ARM_SMMU_FEAT_SVA		(1 << 18)
> +#define ARM_SMMU_FEAT_HA		(1 << 19)
> +#define ARM_SMMU_FEAT_HD		(1 << 20)
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> @@ -1718,10 +1725,17 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  		 * this substream's traffic
>  		 */
>  	} else { /* (1) and (2) */
> +		u64 tcr = cd->tcr;
> +
>  		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
>  		cdptr[2] = 0;
>  		cdptr[3] = cpu_to_le64(cd->mair);
>  
> +		if (!(smmu->features & ARM_SMMU_FEAT_HD))
> +			tcr &= ~CTXDESC_CD_0_TCR_HD;
> +		if (!(smmu->features & ARM_SMMU_FEAT_HA))
> +			tcr &= ~CTXDESC_CD_0_TCR_HA;
> +
>  		/*
>  		 * STE is live, and the SMMU might read dwords of this CD in any
>  		 * order. Ensure that it observes valid values before reading
> @@ -1729,7 +1743,7 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  		 */
>  		arm_smmu_sync_cd(smmu_domain, ssid, true);
>  
> -		val = cd->tcr |
> +		val = tcr |
>  #ifdef __BIG_ENDIAN
>  			CTXDESC_CD_0_ENDI |
>  #endif
> @@ -1958,10 +1972,12 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
>  		return old_cd;
>  	}
>  
> +	/* HA and HD will be filtered out later if not supported by the SMMU */
>  	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
>  	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
>  	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
>  	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
> +	      CTXDESC_CD_0_TCR_HA | CTXDESC_CD_0_TCR_HD |
>  	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
>  
>  	switch (PAGE_SIZE) {
> @@ -4454,6 +4470,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  			smmu->features |= ARM_SMMU_FEAT_E2H;
>  	}
>  
> +	if (reg & (IDR0_HA | IDR0_HD)) {

> +		smmu->features |= ARM_SMMU_FEAT_HA;
> +		if (reg & IDR0_HD)
> +			smmu->features |= ARM_SMMU_FEAT_HD;
> +	}
> +

>  	/*
>  	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
>  	 * will create TLB entries for NH-EL1 world and will miss the
> 

-- 
Thanks,
Xiang

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
