Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E815B135
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216394; cv=none; b=s5LzFAZ2HafvTEAHTIITP/B6j6AIl9v7k/2vuS1N9rF+utN2OD5Bilj0AVmu2NJ5dni89RKf/8Ag0ia0mfIG0KuV0kzWmm32XjEHPpIEwhGqqaoOOL6gDdzMnC/rsFcOoSzogC+D4KX+KkuhFtxI54KvB05pSuZCbN1l4+qfA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216394; c=relaxed/simple;
	bh=cNryEoRuQTgOmeBYr+3vHo/QbeEgW22EEBDyFRPb3HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+EYg/1kJys4iIFX2giKUpz1nCGy6PNmQ+IROZ8TdvscqkztVsHoHE+bIvYrBoo0XiXCVo3Ftx7lZpIw6jtpcvi25h2ATAb9WKhDQPkMK6itXxjF0VAr9dFJCBJiUcjU0W4cDxVQ0t4QTt+aA3OwCfmHRuPRTAIDk/Nja9DU0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0HEO6cv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0HEO6cv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736216392; x=1767752392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cNryEoRuQTgOmeBYr+3vHo/QbeEgW22EEBDyFRPb3HQ=;
  b=Y0HEO6cv+txnUAfrQsTSqtNMSTN54/eRpgMCa/fYDAo/J3h3893Bdm/h
   RgWGKPEusts2kGYlo62LBQxRvYIe/lwxjCeehze4zTrijJX82+V9i1ooL
   X2aWf/F8S8yKtjFXsB75V+onGYutjofn0xVrv8gIXZNA+rxP1RYy51Qav
   8xKBdCyEuCn9UJFe9T2UUJcinySH0bf0FPk7K4EeZ+Og8OAbXoevzcH8F
   5XluTWHTfIDN2CTOF4weWVF2dHxKQfmpSoXKXK13gq72tSR5rd5iSG8IO
   NmJ20gSNv01pcquc4bgRPVnfJ3MxLJ4HTkHwYzjEC6W3fTN/Rl7Br/qDc
   Q==;
X-CSE-ConnectionGUID: 3kKzZKNISAeTb1BPEScvbA==
X-CSE-MsgGUID: 1qQbIKegQqiu1I2b9Dz6aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="47800780"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="47800780"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 18:19:51 -0800
X-CSE-ConnectionGUID: aP9TB/xWRCOTairFEqzk5w==
X-CSE-MsgGUID: SmMYL26DRiexgYnl46U8LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="102442958"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa009.jf.intel.com with ESMTP; 06 Jan 2025 18:19:50 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kees Bakker <kees@ijzerbout.nl>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iommu/vt-d: Remove iommu cap audit
Date: Tue,  7 Jan 2025 10:17:44 +0800
Message-ID: <20250107021746.6908-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107021746.6908-1-baolu.lu@linux.intel.com>
References: <20250107021746.6908-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The capability audit code was introduced by commit <ad3d19029979>
"iommu/vt-d: Audit IOMMU Capabilities and add helper functions", aiming
to verify the consistency of capabilities across all IOMMUs for supported
features.

Nowadays, all the kAPIs of the iommu subsystem have evolved to be device
oriented, in preparation for supporting heterogeneous IOMMU architectures.
There is no longer a need to require capability consistence among IOMMUs
for any feature.

Remove the iommu cap audit code to make the driver align with the design
in the iommu core.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20241216071828.22962-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/Makefile        |   2 +-
 drivers/iommu/intel/cap_audit.c     | 217 ----------------------------
 drivers/iommu/intel/cap_audit.h     | 131 -----------------
 drivers/iommu/intel/iommu.c         |   9 --
 drivers/iommu/intel/irq_remapping.c |   8 -
 5 files changed, 1 insertion(+), 366 deletions(-)
 delete mode 100644 drivers/iommu/intel/cap_audit.c
 delete mode 100644 drivers/iommu/intel/cap_audit.h

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index d3bb0798092d..6c7528130cf9 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o prq.o
-obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
+obj-$(CONFIG_DMAR_TABLE) += trace.o
 obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
deleted file mode 100644
index 9862dc20b35e..000000000000
--- a/drivers/iommu/intel/cap_audit.c
+++ /dev/null
@@ -1,217 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * cap_audit.c - audit iommu capabilities for boot time and hot plug
- *
- * Copyright (C) 2021 Intel Corporation
- *
- * Author: Kyung Min Park <kyung.min.park@intel.com>
- *         Lu Baolu <baolu.lu@linux.intel.com>
- */
-
-#define pr_fmt(fmt)	"DMAR: " fmt
-
-#include "iommu.h"
-#include "cap_audit.h"
-
-static u64 intel_iommu_cap_sanity;
-static u64 intel_iommu_ecap_sanity;
-
-static inline void check_irq_capabilities(struct intel_iommu *a,
-					  struct intel_iommu *b)
-{
-	CHECK_FEATURE_MISMATCH(a, b, cap, pi_support, CAP_PI_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, eim_support, ECAP_EIM_MASK);
-}
-
-static inline void check_dmar_capabilities(struct intel_iommu *a,
-					   struct intel_iommu *b)
-{
-	MINIMAL_FEATURE_IOMMU(b, cap, CAP_MAMV_MASK);
-	MINIMAL_FEATURE_IOMMU(b, cap, CAP_NFR_MASK);
-	MINIMAL_FEATURE_IOMMU(b, cap, CAP_SLLPS_MASK);
-	MINIMAL_FEATURE_IOMMU(b, cap, CAP_FRO_MASK);
-	MINIMAL_FEATURE_IOMMU(b, cap, CAP_MGAW_MASK);
-	MINIMAL_FEATURE_IOMMU(b, cap, CAP_SAGAW_MASK);
-	MINIMAL_FEATURE_IOMMU(b, cap, CAP_NDOMS_MASK);
-	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_PSS_MASK);
-	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_MHMV_MASK);
-	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_IRO_MASK);
-
-	CHECK_FEATURE_MISMATCH(a, b, cap, fl5lp_support, CAP_FL5LP_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, fl1gp_support, CAP_FL1GP_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, read_drain, CAP_RD_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, write_drain, CAP_WD_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, pgsel_inv, CAP_PSI_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, zlr, CAP_ZLR_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, caching_mode, CAP_CM_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, phmr, CAP_PHMR_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, plmr, CAP_PLMR_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, rwbf, CAP_RWBF_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, cap, afl, CAP_AFL_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, rps, ECAP_RPS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, smpwc, ECAP_SMPWC_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, flts, ECAP_FLTS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, slts, ECAP_SLTS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, nwfs, ECAP_NWFS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, slads, ECAP_SLADS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, smts, ECAP_SMTS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, pds, ECAP_PDS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, dit, ECAP_DIT_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, pasid, ECAP_PASID_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, eafs, ECAP_EAFS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, srs, ECAP_SRS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, ers, ECAP_ERS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, prs, ECAP_PRS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, nest, ECAP_NEST_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, mts, ECAP_MTS_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, sc_support, ECAP_SC_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, pass_through, ECAP_PT_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, dev_iotlb_support, ECAP_DT_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, qis, ECAP_QI_MASK);
-	CHECK_FEATURE_MISMATCH(a, b, ecap, coherent, ECAP_C_MASK);
-}
-
-static int cap_audit_hotplug(struct intel_iommu *iommu, enum cap_audit_type type)
-{
-	bool mismatch = false;
-	u64 old_cap = intel_iommu_cap_sanity;
-	u64 old_ecap = intel_iommu_ecap_sanity;
-
-	if (type == CAP_AUDIT_HOTPLUG_IRQR) {
-		CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, pi_support, CAP_PI_MASK);
-		CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, eim_support, ECAP_EIM_MASK);
-		goto out;
-	}
-
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, fl5lp_support, CAP_FL5LP_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, fl1gp_support, CAP_FL1GP_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, read_drain, CAP_RD_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, write_drain, CAP_WD_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, pgsel_inv, CAP_PSI_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, zlr, CAP_ZLR_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, caching_mode, CAP_CM_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, phmr, CAP_PHMR_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, plmr, CAP_PLMR_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, rwbf, CAP_RWBF_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, afl, CAP_AFL_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, rps, ECAP_RPS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, smpwc, ECAP_SMPWC_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, flts, ECAP_FLTS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, slts, ECAP_SLTS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, nwfs, ECAP_NWFS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, slads, ECAP_SLADS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, smts, ECAP_SMTS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, pds, ECAP_PDS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, dit, ECAP_DIT_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, pasid, ECAP_PASID_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, eafs, ECAP_EAFS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, srs, ECAP_SRS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, ers, ECAP_ERS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, prs, ECAP_PRS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, nest, ECAP_NEST_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, mts, ECAP_MTS_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, sc_support, ECAP_SC_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, pass_through, ECAP_PT_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, dev_iotlb_support, ECAP_DT_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, qis, ECAP_QI_MASK);
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, ecap, coherent, ECAP_C_MASK);
-
-	/* Abort hot plug if the hot plug iommu feature is smaller than global */
-	MINIMAL_FEATURE_HOTPLUG(iommu, cap, max_amask_val, CAP_MAMV_MASK, mismatch);
-	MINIMAL_FEATURE_HOTPLUG(iommu, cap, num_fault_regs, CAP_NFR_MASK, mismatch);
-	MINIMAL_FEATURE_HOTPLUG(iommu, cap, super_page_val, CAP_SLLPS_MASK, mismatch);
-	MINIMAL_FEATURE_HOTPLUG(iommu, cap, fault_reg_offset, CAP_FRO_MASK, mismatch);
-	MINIMAL_FEATURE_HOTPLUG(iommu, cap, mgaw, CAP_MGAW_MASK, mismatch);
-	MINIMAL_FEATURE_HOTPLUG(iommu, cap, sagaw, CAP_SAGAW_MASK, mismatch);
-	MINIMAL_FEATURE_HOTPLUG(iommu, cap, ndoms, CAP_NDOMS_MASK, mismatch);
-	MINIMAL_FEATURE_HOTPLUG(iommu, ecap, pss, ECAP_PSS_MASK, mismatch);
-	MINIMAL_FEATURE_HOTPLUG(iommu, ecap, max_handle_mask, ECAP_MHMV_MASK, mismatch);
-	MINIMAL_FEATURE_HOTPLUG(iommu, ecap, iotlb_offset, ECAP_IRO_MASK, mismatch);
-
-out:
-	if (mismatch) {
-		intel_iommu_cap_sanity = old_cap;
-		intel_iommu_ecap_sanity = old_ecap;
-		return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int cap_audit_static(struct intel_iommu *iommu, enum cap_audit_type type)
-{
-	struct dmar_drhd_unit *d;
-	struct intel_iommu *i;
-	int rc = 0;
-
-	rcu_read_lock();
-	if (list_empty(&dmar_drhd_units))
-		goto out;
-
-	for_each_active_iommu(i, d) {
-		if (!iommu) {
-			intel_iommu_ecap_sanity = i->ecap;
-			intel_iommu_cap_sanity = i->cap;
-			iommu = i;
-			continue;
-		}
-
-		if (type == CAP_AUDIT_STATIC_DMAR)
-			check_dmar_capabilities(iommu, i);
-		else
-			check_irq_capabilities(iommu, i);
-	}
-
-	/*
-	 * If the system is sane to support scalable mode, either SL or FL
-	 * should be sane.
-	 */
-	if (intel_cap_smts_sanity() &&
-	    !intel_cap_flts_sanity() && !intel_cap_slts_sanity())
-		rc = -EOPNOTSUPP;
-
-out:
-	rcu_read_unlock();
-	return rc;
-}
-
-int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu)
-{
-	switch (type) {
-	case CAP_AUDIT_STATIC_DMAR:
-	case CAP_AUDIT_STATIC_IRQR:
-		return cap_audit_static(iommu, type);
-	case CAP_AUDIT_HOTPLUG_DMAR:
-	case CAP_AUDIT_HOTPLUG_IRQR:
-		return cap_audit_hotplug(iommu, type);
-	default:
-		break;
-	}
-
-	return -EFAULT;
-}
-
-bool intel_cap_smts_sanity(void)
-{
-	return ecap_smts(intel_iommu_ecap_sanity);
-}
-
-bool intel_cap_pasid_sanity(void)
-{
-	return ecap_pasid(intel_iommu_ecap_sanity);
-}
-
-bool intel_cap_nest_sanity(void)
-{
-	return ecap_nest(intel_iommu_ecap_sanity);
-}
-
-bool intel_cap_flts_sanity(void)
-{
-	return ecap_flts(intel_iommu_ecap_sanity);
-}
-
-bool intel_cap_slts_sanity(void)
-{
-	return ecap_slts(intel_iommu_ecap_sanity);
-}
diff --git a/drivers/iommu/intel/cap_audit.h b/drivers/iommu/intel/cap_audit.h
deleted file mode 100644
index d07b75938961..000000000000
--- a/drivers/iommu/intel/cap_audit.h
+++ /dev/null
@@ -1,131 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * cap_audit.h - audit iommu capabilities header
- *
- * Copyright (C) 2021 Intel Corporation
- *
- * Author: Kyung Min Park <kyung.min.park@intel.com>
- */
-
-/*
- * Capability Register Mask
- */
-#define CAP_FL5LP_MASK		BIT_ULL(60)
-#define CAP_PI_MASK		BIT_ULL(59)
-#define CAP_FL1GP_MASK		BIT_ULL(56)
-#define CAP_RD_MASK		BIT_ULL(55)
-#define CAP_WD_MASK		BIT_ULL(54)
-#define CAP_MAMV_MASK		GENMASK_ULL(53, 48)
-#define CAP_NFR_MASK		GENMASK_ULL(47, 40)
-#define CAP_PSI_MASK		BIT_ULL(39)
-#define CAP_SLLPS_MASK		GENMASK_ULL(37, 34)
-#define CAP_FRO_MASK		GENMASK_ULL(33, 24)
-#define CAP_ZLR_MASK		BIT_ULL(22)
-#define CAP_MGAW_MASK		GENMASK_ULL(21, 16)
-#define CAP_SAGAW_MASK		GENMASK_ULL(12, 8)
-#define CAP_CM_MASK		BIT_ULL(7)
-#define CAP_PHMR_MASK		BIT_ULL(6)
-#define CAP_PLMR_MASK		BIT_ULL(5)
-#define CAP_RWBF_MASK		BIT_ULL(4)
-#define CAP_AFL_MASK		BIT_ULL(3)
-#define CAP_NDOMS_MASK		GENMASK_ULL(2, 0)
-
-/*
- * Extended Capability Register Mask
- */
-#define ECAP_RPS_MASK		BIT_ULL(49)
-#define ECAP_SMPWC_MASK		BIT_ULL(48)
-#define ECAP_FLTS_MASK		BIT_ULL(47)
-#define ECAP_SLTS_MASK		BIT_ULL(46)
-#define ECAP_SLADS_MASK		BIT_ULL(45)
-#define ECAP_VCS_MASK		BIT_ULL(44)
-#define ECAP_SMTS_MASK		BIT_ULL(43)
-#define ECAP_PDS_MASK		BIT_ULL(42)
-#define ECAP_DIT_MASK		BIT_ULL(41)
-#define ECAP_PASID_MASK		BIT_ULL(40)
-#define ECAP_PSS_MASK		GENMASK_ULL(39, 35)
-#define ECAP_EAFS_MASK		BIT_ULL(34)
-#define ECAP_NWFS_MASK		BIT_ULL(33)
-#define ECAP_SRS_MASK		BIT_ULL(31)
-#define ECAP_ERS_MASK		BIT_ULL(30)
-#define ECAP_PRS_MASK		BIT_ULL(29)
-#define ECAP_NEST_MASK		BIT_ULL(26)
-#define ECAP_MTS_MASK		BIT_ULL(25)
-#define ECAP_MHMV_MASK		GENMASK_ULL(23, 20)
-#define ECAP_IRO_MASK		GENMASK_ULL(17, 8)
-#define ECAP_SC_MASK		BIT_ULL(7)
-#define ECAP_PT_MASK		BIT_ULL(6)
-#define ECAP_EIM_MASK		BIT_ULL(4)
-#define ECAP_DT_MASK		BIT_ULL(2)
-#define ECAP_QI_MASK		BIT_ULL(1)
-#define ECAP_C_MASK		BIT_ULL(0)
-
-/*
- * u64 intel_iommu_cap_sanity, intel_iommu_ecap_sanity will be adjusted as each
- * IOMMU gets audited.
- */
-#define DO_CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
-do { \
-	if (cap##_##feature(a) != cap##_##feature(b)) { \
-		intel_iommu_##cap##_sanity &= ~(MASK); \
-		pr_info("IOMMU feature %s inconsistent", #feature); \
-	} \
-} while (0)
-
-#define CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
-	DO_CHECK_FEATURE_MISMATCH((a)->cap, (b)->cap, cap, feature, MASK)
-
-#define CHECK_FEATURE_MISMATCH_HOTPLUG(b, cap, feature, MASK) \
-do { \
-	if (cap##_##feature(intel_iommu_##cap##_sanity)) \
-		DO_CHECK_FEATURE_MISMATCH(intel_iommu_##cap##_sanity, \
-					  (b)->cap, cap, feature, MASK); \
-} while (0)
-
-#define MINIMAL_FEATURE_IOMMU(iommu, cap, MASK) \
-do { \
-	u64 min_feature = intel_iommu_##cap##_sanity & (MASK); \
-	min_feature = min_t(u64, min_feature, (iommu)->cap & (MASK)); \
-	intel_iommu_##cap##_sanity = (intel_iommu_##cap##_sanity & ~(MASK)) | \
-				     min_feature; \
-} while (0)
-
-#define MINIMAL_FEATURE_HOTPLUG(iommu, cap, feature, MASK, mismatch) \
-do { \
-	if ((intel_iommu_##cap##_sanity & (MASK)) > \
-	    (cap##_##feature((iommu)->cap))) \
-		mismatch = true; \
-	else \
-		(iommu)->cap = ((iommu)->cap & ~(MASK)) | \
-		(intel_iommu_##cap##_sanity & (MASK)); \
-} while (0)
-
-enum cap_audit_type {
-	CAP_AUDIT_STATIC_DMAR,
-	CAP_AUDIT_STATIC_IRQR,
-	CAP_AUDIT_HOTPLUG_DMAR,
-	CAP_AUDIT_HOTPLUG_IRQR,
-};
-
-bool intel_cap_smts_sanity(void);
-bool intel_cap_pasid_sanity(void);
-bool intel_cap_nest_sanity(void);
-bool intel_cap_flts_sanity(void);
-bool intel_cap_slts_sanity(void);
-
-static inline bool scalable_mode_support(void)
-{
-	return (intel_iommu_sm && intel_cap_smts_sanity());
-}
-
-static inline bool pasid_mode_support(void)
-{
-	return scalable_mode_support() && intel_cap_pasid_sanity();
-}
-
-static inline bool nested_mode_support(void)
-{
-	return scalable_mode_support() && intel_cap_nest_sanity();
-}
-
-int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 113c66dcc32e..a1e254417307 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -29,7 +29,6 @@
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 #include "pasid.h"
-#include "cap_audit.h"
 #include "perfmon.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
@@ -2118,10 +2117,6 @@ static int __init init_dmars(void)
 	struct intel_iommu *iommu;
 	int ret;
 
-	ret = intel_cap_audit(CAP_AUDIT_STATIC_DMAR, NULL);
-	if (ret)
-		goto free_iommu;
-
 	for_each_iommu(iommu, drhd) {
 		if (drhd->ignored) {
 			iommu_disable_translation(iommu);
@@ -2617,10 +2612,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	struct intel_iommu *iommu = dmaru->iommu;
 	int ret;
 
-	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
-	if (ret)
-		goto out;
-
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 466c1412dd45..4431543bcfe3 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -24,7 +24,6 @@
 #include "iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
-#include "cap_audit.h"
 
 enum irq_mode {
 	IRQ_REMAPPING,
@@ -727,9 +726,6 @@ static int __init intel_prepare_irq_remapping(void)
 	if (dmar_table_init() < 0)
 		return -ENODEV;
 
-	if (intel_cap_audit(CAP_AUDIT_STATIC_IRQR, NULL))
-		return -ENODEV;
-
 	if (!dmar_ir_support())
 		return -ENODEV;
 
@@ -1534,10 +1530,6 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 	int ret;
 	int eim = x2apic_enabled();
 
-	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_IRQR, iommu);
-	if (ret)
-		return ret;
-
 	if (eim && !ecap_eim_support(iommu->ecap)) {
 		pr_info("DRHD %Lx: EIM not supported by DRHD, ecap %Lx\n",
 			iommu->reg_phys, iommu->ecap);
-- 
2.43.0

