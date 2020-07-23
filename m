Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC42C433ED
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9115208E4
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCsk0FDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9115208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C0239892AA;
	Thu, 23 Jul 2020 15:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CJuUNTzuJTT; Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCA72892AF;
	Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9D10C016F;
	Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 210C8C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 10AB3883BF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HxitJDVEof8S for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 15:05:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 80A62883AD
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:05:57 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id a1so6723500ejg.12
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yWZ8FjwXK+dksOqK3nLYWBRxXcByntJO5CNNaeLNHxY=;
 b=zCsk0FDm4L+791n8G8Whn/IMan8qkhGJpd3itkoU2fE4osc7hietit0/wFo1MMYCKu
 YLh4ONxoCZqgiKb+XNT+lMP18iTusa796HBhYJrr5tU2ULz1O4FRtnBHbffYUzkXfTay
 U2N2iJLFAWrq4ssTfz+EYfwXdEtRdmw4xUqyNvL8TOvB/Xl5frW7qhDd7PmG53A+849b
 2F3zMOhjDVPKjHCSorennkhS7NA9x26f8xfQYpuud3Sz6YXKCb4f3r/GUwMW17iFcJhH
 FBm3FAb2l2kcUOpcoW9wxg5I2AOLZKNQw1ZaRwxmYriNdw8jTws/j/LEr0o48ZwuyLdw
 1qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yWZ8FjwXK+dksOqK3nLYWBRxXcByntJO5CNNaeLNHxY=;
 b=fGicwc3hEcYtT6DpWNU3UINM7l6l+R+NYfYADrLF3V16Ijz86ddtBlOZV+kmw9gyRq
 Jyx5sxYN96koCAFw93AN3480RvIkvnaaqqa+aTgYgy2z6ZRwQb0rANKlc/lKl/fZpgrV
 gKj7Vn1zC/j9CNIHo8WEv4cwemZLqcROw/l8AEgaQkTuD8t9HEHpDekzaESZs0iMA/iV
 hfLpj7rdGFGUYIO5lRmcz+IOoROxg6Ka/K3wRVXbuPs+IxLAYmqu7GjVP4yEObRd0fLr
 7HQJlMeuud8Ib38Ryi5ve3RgOPOrtfnr4la/khKuLPMpH9elJI0Ps9yezBuHhQ8jcpnA
 2hIA==
X-Gm-Message-State: AOAM532p9DnPxASriIzN42Yq3q8vvOcsF8rTt/fAzy7xgU/oLGfc/60k
 HMRtC2oapu8e3FHyjucrmdxrGK8svHQ=
X-Google-Smtp-Source: ABdhPJylrtOaxrTLvFdaGtqIle2qLiXnjnEywz0sCPFX1x5omIQ/yFKbHKVthU0n2KaXfMbOZkXhOQ==
X-Received: by 2002:a17:907:20b4:: with SMTP id
 pw20mr4955394ejb.225.1595516755496; 
 Thu, 23 Jul 2020 08:05:55 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k15sm2145952eji.49.2020.07.23.08.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 08:05:54 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v9 08/13] iommu/arm-smmu-v3: Share process page tables
Date: Thu, 23 Jul 2020 16:57:20 +0200
Message-Id: <20200723145724.3014766-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723145724.3014766-1-jean-philippe@linaro.org>
References: <20200723145724.3014766-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhengxiang9@huawei.com, zhangfei.gao@linaro.org, will@kernel.org
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
v9: Move to arm-smmu-v3-sva.c
---
 drivers/iommu/Kconfig           |  10 +++
 drivers/iommu/Makefile          |   5 +-
 drivers/iommu/arm-smmu-v3.h     |   8 +++
 drivers/iommu/arm-smmu-v3-sva.c | 123 ++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu-v3.c     |  34 +++++++--
 5 files changed, 172 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-v3-sva.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 490c86e3615a..afe355c02a50 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -446,6 +446,16 @@ config ARM_SMMU_V3
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
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 0fe5a7f9bc69..929a752e4723 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -16,7 +16,10 @@ obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
 arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
-obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
+arm_smmu_v3-objs-y += arm-smmu-v3.o
+arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
+obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
 obj-$(CONFIG_INTEL_IOMMU) += intel/trace.o
diff --git a/drivers/iommu/arm-smmu-v3.h b/drivers/iommu/arm-smmu-v3.h
index 51a9ce07b2d6..6b06a6f19604 100644
--- a/drivers/iommu/arm-smmu-v3.h
+++ b/drivers/iommu/arm-smmu-v3.h
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
diff --git a/drivers/iommu/arm-smmu-v3-sva.c b/drivers/iommu/arm-smmu-v3-sva.c
new file mode 100644
index 000000000000..7c1541864688
--- /dev/null
+++ b/drivers/iommu/arm-smmu-v3-sva.c
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
+#include "io-pgtable-arm.h"
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
+	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
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
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 827334ed312b..06f148a9ed82 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -68,7 +68,8 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
-static DEFINE_XARRAY_ALLOC1(asid_xa);
+DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
+DEFINE_MUTEX(arm_smmu_asid_lock);
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
@@ -1004,7 +1005,8 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 #ifdef __BIG_ENDIAN
 			CTXDESC_CD_0_ENDI |
 #endif
-			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
+			CTXDESC_CD_0_R | CTXDESC_CD_0_A |
+			(cd->mm ? 0 : CTXDESC_CD_0_ASET) |
 			CTXDESC_CD_0_AA64 |
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
@@ -1108,12 +1110,20 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
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
@@ -1801,9 +1811,12 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
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
@@ -1823,10 +1836,14 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
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
 
@@ -1854,12 +1871,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
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
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
