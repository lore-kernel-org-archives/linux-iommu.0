Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76487C43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 07:41:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35B9207DE
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 07:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4CkLPkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35B9207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 66F2620456;
	Tue,  8 Sep 2020 07:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTYCGQmWf3+5; Tue,  8 Sep 2020 07:41:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D75C2203EE;
	Tue,  8 Sep 2020 07:41:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3CA2C0859;
	Tue,  8 Sep 2020 07:41:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78B42C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 07:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 514F520443
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 07:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AOHqZYun0wqa for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 07:41:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id F213A203EE
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 07:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VENDZnB6tL+VIABZupQjGArsbD0sg+Ywb25nphoNKw=;
 b=E4CkLPkFvD7PzAoinzhA5Aj5uakHaJ04Nnum9cBJKq9iBYjrkk/3Hi+lCMOm7niYX9VS+g
 0CPpGNe/Gx6UQ/2195Fpab6pnc1ENo8c++sSWy8Lv6gmedXoeYoiD70azT8kgt6cwXJaEj
 6Dfg9LetVZWkYDq48SOHflACupz3a/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-ItYhXl8LNUGl2K5U7WC7TQ-1; Tue, 08 Sep 2020 03:41:26 -0400
X-MC-Unique: ItYhXl8LNUGl2K5U7WC7TQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C67A802B66;
 Tue,  8 Sep 2020 07:41:24 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D3E982462;
 Tue,  8 Sep 2020 07:41:21 +0000 (UTC)
Subject: Re: [PATCH RESEND v9 08/13] iommu/arm-smmu-v3: Share process page
 tables
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-9-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <496fbadf-a075-eed2-2dda-eeaaac35656e@redhat.com>
Date: Tue, 8 Sep 2020 09:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200817171558.325917-9-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: fenghua.yu@intel.com, will@kernel.org, zhengxiang9@huawei.com,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com
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

On 8/17/20 7:15 PM, Jean-Philippe Brucker wrote:
> With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
> MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
> into two sets, shared and private. Shared ASIDs correspond to those
> obtained from the arch ASID allocator, and private ASIDs are used for
> "classic" map/unmap DMA.
> 
> A possible conflict happens when trying to use a shared ASID that has
> already been allocated for private use by the SMMU driver. This will be
> addressed in a later patch by replacing the private ASID. At the
> moment we return -EBUSY.
> 
> Each mm_struct shared with the SMMU will have a single context
> descriptor. Add a refcount to keep track of this. It will be protected
> by the global SVA lock.
> 
> Introduce a new arm-smmu-v3-sva.c file and the CONFIG_ARM_SMMU_V3_SVA
> option to let users opt in SVA support.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v9: Move to arm-smmu-v3-sva.c
> ---
>  drivers/iommu/Kconfig                         |  10 ++
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |   5 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   8 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 123 ++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  34 ++++-
>  5 files changed, 172 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index fb1787377eb6..b1d592cd9984 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -313,6 +313,16 @@ config ARM_SMMU_V3
>  	  Say Y here if your system includes an IOMMU device implementing
>  	  the ARM SMMUv3 architecture.
>  
> +config ARM_SMMU_V3_SVA
> +	bool "Shared Virtual Addressing support for the ARM SMMUv3"
> +	depends on ARM_SMMU_V3
> +	help
> +	  Support for sharing process address spaces with devices using the
> +	  SMMUv3.
> +
> +	  Say Y here if your system supports SVA extensions such as PCIe PASID
> +	  and PRI.
> +
>  config S390_IOMMU
>  	def_bool y if S390 && PCI
>  	depends on S390 && PCI
> diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
> index 569e24e9f162..54feb1ecccad 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/Makefile
> +++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
> @@ -1,2 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> +obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
> +arm_smmu_v3-objs-y += arm-smmu-v3.o
> +arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
> +arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 51a9ce07b2d6..6b06a6f19604 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -540,6 +540,9 @@ struct arm_smmu_ctx_desc {
>  	u64				ttbr;
>  	u64				tcr;
>  	u64				mair;
> +
> +	refcount_t			refs;
> +	struct mm_struct		*mm;
>  };
>  
>  struct arm_smmu_l1_ctx_desc {
> @@ -672,4 +675,9 @@ struct arm_smmu_domain {
>  	spinlock_t			devices_lock;
>  };
>  
> +extern struct xarray arm_smmu_asid_xa;
> +extern struct mutex arm_smmu_asid_lock;
> +
> +bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
> +
>  #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> new file mode 100644
> index 000000000000..7a4f40565e06
> --- /dev/null
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Implementation of the IOMMU SVA API for the ARM SMMUv3
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/mmu_context.h>
> +#include <linux/slab.h>
> +
> +#include "arm-smmu-v3.h"
> +#include "../../io-pgtable-arm.h"
> +
> +static struct arm_smmu_ctx_desc *
> +arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> +{
> +	struct arm_smmu_ctx_desc *cd;
> +
> +	cd = xa_load(&arm_smmu_asid_xa, asid);
> +	if (!cd)
> +		return NULL;
> +
> +	if (cd->mm) {
> +		if (WARN_ON(cd->mm != mm))
> +			return ERR_PTR(-EINVAL);
> +		/* All devices bound to this mm use the same cd struct. */
> +		refcount_inc(&cd->refs);
> +		return cd;
> +	}
> +
> +	/* Ouch, ASID is already in use for a private cd. */
> +	return ERR_PTR(-EBUSY);
> +}
> +
> +__maybe_unused
> +static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
> +{
> +	u16 asid;
> +	int err = 0;
> +	u64 tcr, par, reg;
> +	struct arm_smmu_ctx_desc *cd;
> +	struct arm_smmu_ctx_desc *ret = NULL;
> +
> +	asid = arm64_mm_context_get(mm);
> +	if (!asid)
> +		return ERR_PTR(-ESRCH);
> +
> +	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
> +	if (!cd) {
> +		err = -ENOMEM;
> +		goto out_put_context;
> +	}
> +
> +	refcount_set(&cd->refs, 1);
> +
> +	mutex_lock(&arm_smmu_asid_lock);
> +	ret = arm_smmu_share_asid(mm, asid);
> +	if (ret) {
> +		mutex_unlock(&arm_smmu_asid_lock);
> +		goto out_free_cd;
> +	}
> +
> +	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
> +	mutex_unlock(&arm_smmu_asid_lock);
I am not clear about the locking scope. Can't we release the lock before
as if I understand correctly xa_insert/xa_erase takes the xa_lock.
> +
> +	if (err)
> +		goto out_free_asid;
> +
> +	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
Wondering if no additional check is needed to check if the T0SZ is valid
as documented in 5.4 Context Descriptor T0SZ description.
> +	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
> +	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
> +	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
> +	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
> +
> +	switch (PAGE_SIZE) {
> +	case SZ_4K:
> +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
> +		break;
> +	case SZ_16K:
> +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
> +		break;
> +	case SZ_64K:
> +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
> +		break;
> +	default:
> +		WARN_ON(1);
> +		err = -EINVAL;
> +		goto out_free_asid;
> +	}
> +
> +	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> +	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
> +	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
> +
> +	cd->ttbr = virt_to_phys(mm->pgd);
> +	cd->tcr = tcr;
> +	/*
> +	 * MAIR value is pretty much constant and global, so we can just get it
> +	 * from the current CPU register
> +	 */
> +	cd->mair = read_sysreg(mair_el1);
> +	cd->asid = asid;
> +	cd->mm = mm;
> +
> +	return cd;
> +
> +out_free_asid:
> +	arm_smmu_free_asid(cd);
> +out_free_cd:
> +	kfree(cd);
> +out_put_context:
> +	arm64_mm_context_put(mm);
> +	return err < 0 ? ERR_PTR(err) : ret;
> +}
> +
> +__maybe_unused
> +static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
> +{
> +	if (arm_smmu_free_asid(cd)) {
> +		/* Unpin ASID */
> +		arm64_mm_context_put(cd->mm);
> +		kfree(cd);
> +	}
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b2ad5dc73e6a..9e81615744de 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -68,7 +68,8 @@ struct arm_smmu_option_prop {
>  	const char *prop;
>  };
>  
> -static DEFINE_XARRAY_ALLOC1(asid_xa);
> +DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
> +DEFINE_MUTEX(arm_smmu_asid_lock);
>  
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
> @@ -1004,7 +1005,8 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  #ifdef __BIG_ENDIAN
>  			CTXDESC_CD_0_ENDI |
>  #endif
> -			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
> +			CTXDESC_CD_0_R | CTXDESC_CD_0_A |
> +			(cd->mm ? 0 : CTXDESC_CD_0_ASET) |
>  			CTXDESC_CD_0_AA64 |
>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
>  			CTXDESC_CD_0_V;
> @@ -1108,12 +1110,20 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
>  	cdcfg->cdtab = NULL;
>  }
>  
> -static void arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
> +bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
>  {
> +	bool free;
> +	struct arm_smmu_ctx_desc *old_cd;
> +
>  	if (!cd->asid)
> -		return;
> +		return false;
>  
> -	xa_erase(&asid_xa, cd->asid);
> +	free = refcount_dec_and_test(&cd->refs);
> +	if (free) {
> +		old_cd = xa_erase(&arm_smmu_asid_xa, cd->asid);
> +		WARN_ON(old_cd != cd);
> +	}
> +	return free;
>  }
>  
>  /* Stream table manipulation functions */
> @@ -1801,9 +1811,12 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>  
> +		/* Prevent SVA from touching the CD while we're freeing it */
> +		mutex_lock(&arm_smmu_asid_lock);
>  		if (cfg->cdcfg.cdtab)
>  			arm_smmu_free_cd_tables(smmu_domain);
>  		arm_smmu_free_asid(&cfg->cd);
> +		mutex_unlock(&arm_smmu_asid_lock);
>  	} else {
>  		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
>  		if (cfg->vmid)
> @@ -1823,10 +1836,14 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>  	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  
> -	ret = xa_alloc(&asid_xa, &asid, &cfg->cd,
> +	refcount_set(&cfg->cd.refs, 1);
> +
> +	/* Prevent SVA from modifying the ASID until it is written to the CD */
> +	mutex_lock(&arm_smmu_asid_lock);
> +	ret = xa_alloc(&arm_smmu_asid_xa, &asid, &cfg->cd,
>  		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
>  	if (ret)
> -		return ret;
> +		goto out_unlock;
>  
>  	cfg->s1cdmax = master->ssid_bits;
>  
> @@ -1854,12 +1871,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	if (ret)
>  		goto out_free_cd_tables;
>  
> +	mutex_unlock(&arm_smmu_asid_lock);
>  	return 0;
>  
>  out_free_cd_tables:
>  	arm_smmu_free_cd_tables(smmu_domain);
>  out_free_asid:
>  	arm_smmu_free_asid(&cfg->cd);
> +out_unlock:
> +	mutex_unlock(&arm_smmu_asid_lock);
>  	return ret;
>  }
>  
> 
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
