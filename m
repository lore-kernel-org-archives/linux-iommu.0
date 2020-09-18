Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C1C43466
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226B822208
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBxa45ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226B822208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E556D2E1FA;
	Fri, 18 Sep 2020 10:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cahdhtF5FU4Q; Fri, 18 Sep 2020 10:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 299722E208;
	Fri, 18 Sep 2020 10:20:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23B63C0891;
	Fri, 18 Sep 2020 10:20:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D4C7C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9764D87692
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M52dOYCoJqXs for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:20:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E4BC1876BB
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:05 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id j11so7446088ejk.0
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N4DgoZbv9M84LHIoPp24tcG/3zGmTW+r6nCgwOX6Bv8=;
 b=CBxa45llh5OZfBmW/bSVVbfSxVaVc2lCs9+BXqUfvaNeCPBpTQN4FhBxFWhVV2C1n/
 J4kvdQeFs3Z86rbPUxm1V6q8lXoAo6Uqh2BNp5+wuF9Q15rw9P+Ae6k+OVIuqMu4sqPa
 PLKYY08Q/39/P8DcUwzChBhrvzLS38UczwWn+xUJTgtlHelDtPWY2AUnzc3KqOAZq5p+
 RbJHJBPid/ZWb6nyP92zX/tGj4lNoCvD4Tbf/lnFQzd0yY3cSJztUfiCf2bjPu+w8nyp
 apnX8RTNax6UO1j6oZ0L8FzSHoPCMxyn0b+1RcQeik7kdZkqMOd4O+CxlOd42clRII18
 StMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N4DgoZbv9M84LHIoPp24tcG/3zGmTW+r6nCgwOX6Bv8=;
 b=EcYezcvoTan1S5nAENH8fSzRB4V2rZAG8+VyVU1eiNWmbrgx63pHdfwk8s/yq0eoa8
 Pz6+fcie9sADB4JyMBudhZO+xCCTHsURrhSCiQnFHI1TNfakfAkNAh6KtcVRPWyCsuki
 s2rCdVyTMkI3l0rmwH/N+CCD86g+pi+zMVzEdjYKnME/KVmf0GZUOE/zfnWRwDHc3fKy
 o44VqsS8VQ/4OeWmZcykJc3/DknedVXgWuM57lIbbXppd8dFrOhHEuJhGFX5/ivL/hEQ
 ErGXDKbaCVpxSk8e4mUy0QaSi1A1f0kt0J8B4qQ0++7loSJd4NzbCBfHwVj/oy/+BeEQ
 cV3w==
X-Gm-Message-State: AOAM531D1e1nYWdFw8QnXFz9aFwKIKyWMbD2RatEo9yHT+l0eO2T2+G6
 5DJWZ3+4S5QqhJr0RXh2mQlS7CwiOOyXnV3z
X-Google-Smtp-Source: ABdhPJw0y11rLC3V4HUBzuqKM0ykw3IE9QWgwHhJWilDvaIzUwRNg5fTpd0io672bC3r56rduJPllw==
X-Received: by 2002:a17:906:9718:: with SMTP id
 k24mr32946631ejx.365.1600424403919; 
 Fri, 18 Sep 2020 03:20:03 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r16sm1940674edc.57.2020.09.18.03.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:20:03 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v10 08/13] iommu/arm-smmu-v3: Share process page tables
Date: Fri, 18 Sep 2020 12:18:48 +0200
Message-Id: <20200918101852.582559-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918101852.582559-1-jean-philippe@linaro.org>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, zhangfei.gao@linaro.org,
 will@kernel.org
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

With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
into two sets, shared and private. Shared ASIDs correspond to those
obtained from the arch ASID allocator, and private ASIDs are used for
"classic" map/unmap DMA.

A possible conflict happens when trying to use a shared ASID that has
already been allocated for private use by the SMMU driver. This will be
addressed in a later patch by replacing the private ASID. At the
moment we return -EBUSY.

Each mm_struct shared with the SMMU will have a single context
descriptor. Add a refcount to keep track of this. It will be protected
by the global SVA lock.

Introduce a new arm-smmu-v3-sva.c file and the CONFIG_ARM_SMMU_V3_SVA
option to let users opt in SVA support.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v10: use vabits_actual instead of VA_BITS
---
 drivers/iommu/Kconfig                         |  10 ++
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   8 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 123 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  34 ++++-
 5 files changed, 172 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index fb1787377eb6..b1d592cd9984 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -313,6 +313,16 @@ config ARM_SMMU_V3
 	  Say Y here if your system includes an IOMMU device implementing
 	  the ARM SMMUv3 architecture.
 
+config ARM_SMMU_V3_SVA
+	bool "Shared Virtual Addressing support for the ARM SMMUv3"
+	depends on ARM_SMMU_V3
+	help
+	  Support for sharing process address spaces with devices using the
+	  SMMUv3.
+
+	  Say Y here if your system supports SVA extensions such as PCIe PASID
+	  and PRI.
+
 config S390_IOMMU
 	def_bool y if S390 && PCI
 	depends on S390 && PCI
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 569e24e9f162..54feb1ecccad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,2 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
+obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
+arm_smmu_v3-objs-y += arm-smmu-v3.o
+arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 51a9ce07b2d6..6b06a6f19604 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -540,6 +540,9 @@ struct arm_smmu_ctx_desc {
 	u64				ttbr;
 	u64				tcr;
 	u64				mair;
+
+	refcount_t			refs;
+	struct mm_struct		*mm;
 };
 
 struct arm_smmu_l1_ctx_desc {
@@ -672,4 +675,9 @@ struct arm_smmu_domain {
 	spinlock_t			devices_lock;
 };
 
+extern struct xarray arm_smmu_asid_xa;
+extern struct mutex arm_smmu_asid_lock;
+
+bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
+
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
new file mode 100644
index 000000000000..6c1113059632
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Implementation of the IOMMU SVA API for the ARM SMMUv3
+ */
+
+#include <linux/mm.h>
+#include <linux/mmu_context.h>
+#include <linux/slab.h>
+
+#include "arm-smmu-v3.h"
+#include "../../io-pgtable-arm.h"
+
+static struct arm_smmu_ctx_desc *
+arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
+{
+	struct arm_smmu_ctx_desc *cd;
+
+	cd = xa_load(&arm_smmu_asid_xa, asid);
+	if (!cd)
+		return NULL;
+
+	if (cd->mm) {
+		if (WARN_ON(cd->mm != mm))
+			return ERR_PTR(-EINVAL);
+		/* All devices bound to this mm use the same cd struct. */
+		refcount_inc(&cd->refs);
+		return cd;
+	}
+
+	/* Ouch, ASID is already in use for a private cd. */
+	return ERR_PTR(-EBUSY);
+}
+
+__maybe_unused
+static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
+{
+	u16 asid;
+	int err = 0;
+	u64 tcr, par, reg;
+	struct arm_smmu_ctx_desc *cd;
+	struct arm_smmu_ctx_desc *ret = NULL;
+
+	asid = arm64_mm_context_get(mm);
+	if (!asid)
+		return ERR_PTR(-ESRCH);
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd) {
+		err = -ENOMEM;
+		goto out_put_context;
+	}
+
+	refcount_set(&cd->refs, 1);
+
+	mutex_lock(&arm_smmu_asid_lock);
+	ret = arm_smmu_share_asid(mm, asid);
+	if (ret) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		goto out_free_cd;
+	}
+
+	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
+	mutex_unlock(&arm_smmu_asid_lock);
+
+	if (err)
+		goto out_free_asid;
+
+	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - vabits_actual) |
+	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
+	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
+	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
+	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
+
+	switch (PAGE_SIZE) {
+	case SZ_4K:
+		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
+		break;
+	case SZ_16K:
+		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
+		break;
+	case SZ_64K:
+		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
+		break;
+	default:
+		WARN_ON(1);
+		err = -EINVAL;
+		goto out_free_asid;
+	}
+
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
+
+	cd->ttbr = virt_to_phys(mm->pgd);
+	cd->tcr = tcr;
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	cd->mair = read_sysreg(mair_el1);
+	cd->asid = asid;
+	cd->mm = mm;
+
+	return cd;
+
+out_free_asid:
+	arm_smmu_free_asid(cd);
+out_free_cd:
+	kfree(cd);
+out_put_context:
+	arm64_mm_context_put(mm);
+	return err < 0 ? ERR_PTR(err) : ret;
+}
+
+__maybe_unused
+static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
+{
+	if (arm_smmu_free_asid(cd)) {
+		/* Unpin ASID */
+		arm64_mm_context_put(cd->mm);
+		kfree(cd);
+	}
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ce604abad384..19af27fd183b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -68,7 +68,8 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
-static DEFINE_XARRAY_ALLOC1(asid_xa);
+DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
+DEFINE_MUTEX(arm_smmu_asid_lock);
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
@@ -1003,7 +1004,8 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 #ifdef __BIG_ENDIAN
 			CTXDESC_CD_0_ENDI |
 #endif
-			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
+			CTXDESC_CD_0_R | CTXDESC_CD_0_A |
+			(cd->mm ? 0 : CTXDESC_CD_0_ASET) |
 			CTXDESC_CD_0_AA64 |
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
@@ -1107,12 +1109,20 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 	cdcfg->cdtab = NULL;
 }
 
-static void arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
+bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
 {
+	bool free;
+	struct arm_smmu_ctx_desc *old_cd;
+
 	if (!cd->asid)
-		return;
+		return false;
 
-	xa_erase(&asid_xa, cd->asid);
+	free = refcount_dec_and_test(&cd->refs);
+	if (free) {
+		old_cd = xa_erase(&arm_smmu_asid_xa, cd->asid);
+		WARN_ON(old_cd != cd);
+	}
+	return free;
 }
 
 /* Stream table manipulation functions */
@@ -1800,9 +1810,12 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
+		/* Prevent SVA from touching the CD while we're freeing it */
+		mutex_lock(&arm_smmu_asid_lock);
 		if (cfg->cdcfg.cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
 		arm_smmu_free_asid(&cfg->cd);
+		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
@@ -1822,10 +1835,14 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
-	ret = xa_alloc(&asid_xa, &asid, &cfg->cd,
+	refcount_set(&cfg->cd.refs, 1);
+
+	/* Prevent SVA from modifying the ASID until it is written to the CD */
+	mutex_lock(&arm_smmu_asid_lock);
+	ret = xa_alloc(&arm_smmu_asid_xa, &asid, &cfg->cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	cfg->s1cdmax = master->ssid_bits;
 
@@ -1853,12 +1870,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_free_cd_tables;
 
+	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 
 out_free_cd_tables:
 	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
 	arm_smmu_free_asid(&cfg->cd);
+out_unlock:
+	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
 }
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
