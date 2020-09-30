Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A96C4727F
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 00:11:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435472074A
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 00:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435472074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EA1AE84EE4;
	Thu,  1 Oct 2020 00:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J7eMIXNNV3ae; Thu,  1 Oct 2020 00:11:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4F2A86204;
	Thu,  1 Oct 2020 00:11:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1972C1AD6;
	Thu,  1 Oct 2020 00:11:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3717FC016F
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 00:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 25D9286408
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 00:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lrMhzs3gR1qH for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 00:11:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 607B4862B2
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 00:11:54 +0000 (UTC)
IronPort-SDR: m2g1qNCIBgQBqpJGxodyrnxwGSzzOkzGeVWCYpQKzwzaB/vFa+6oOOO00lNLAGeKJMDoFeBYE2
 mC3ORTnYYwRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="180732763"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="180732763"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 17:11:53 -0700
IronPort-SDR: ecRCQUVC8v++2cPeL1lorRs9faCWDyGZOxQsFpGl2GZKv6va+M4jDxLzS3WO9ptp68I2+wrgmD
 lE6fRIpAzsww==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="500276757"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 17:11:52 -0700
From: Kyung Min Park <kyung.min.park@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [RESEND PATCH 2/4] iommu/vt-d: Report out when IOMMU features have
 inconsistencies
Date: Wed, 30 Sep 2020 16:53:07 -0700
Message-Id: <20200930235309.22841-3-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930235309.22841-1-kyung.min.park@intel.com>
References: <20200930235309.22841-1-kyung.min.park@intel.com>
Cc: ravi.v.shankar@intel.com, kevin.tian@intel.com, ashok.raj@intel.com,
 ricardo.neri@intel.com, kyung.min.park@intel.com, dwmw2@infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOMMU features as below can have incompatibilities among IOMMUs.
Audit IOMMU Capability/Extended Capability and check if the IOMMUs have
the consistent value for features as below. Report out when features as
below have incompatibility among IOMMUs.

Report out features when below features are mismatched:
  - First Level 5 Level Paging Support (FL5LP)
  - First Level 1 GByte Page Support (FL1GP)
  - Read Draining (DRD)
  - Write Draining (DWD)
  - Page Selective Invalidation (PSI)
  - Caching Mode (CM)
  - Protected High/Low-Memory Region (PHMR/PLMR)
  - Scalable Mode Page Walk Coherency (SMPWC)
  - First Level Translation Support (FLTS)
  - Second Level Translation Support (SLTS)
  - Second Level Accessed/Dirty Support (SLADS)
  - Virtual Command Support (VCS)
  - Scalable Mode Translation Support (SMTS)
  - Device TLB Invalidation Throttle (DIT)
  - Page Drain Support (PDS)
  - Nested Translation Support (NEST)
  - Snoop Control (SC)
  - Pass Through (PT)
  - Device TLB Support (DT)
  - Queued Invalidation (QI)
  - Page walk Coherency (C)

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/audit.c | 48 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/audit.h | 43 +++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  2 ++
 3 files changed, 93 insertions(+)

diff --git a/drivers/iommu/intel/audit.c b/drivers/iommu/intel/audit.c
index 2893170f5b6c..f783acabb402 100644
--- a/drivers/iommu/intel/audit.c
+++ b/drivers/iommu/intel/audit.c
@@ -13,6 +13,8 @@
 #include "audit.h"
 
 static bool svm_sanity_check = true;
+/* global variables that hold feature consistency and minimum features */
+static u64 intel_iommu_cap_sanity = ~0ULL;
 static u64 intel_iommu_ecap_sanity = ~0ULL;
 
 static void set_cap_audit_svm_sanity(bool svm_sanity)
@@ -30,12 +32,58 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 {
 	if (MINIMAL_SVM_ECAP & (a->ecap ^ b->ecap))
 		set_cap_audit_svm_sanity(false);
+
+	CHECK_FEATURE_MISMATCH(a, b, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, fl1gp_support, CAP_FL1GP_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, read_drain, CAP_RD_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, write_drain, CAP_WD_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, pgsel_inv, CAP_PSI_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, caching_mode, CAP_CM_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, phmr, CAP_PHMR_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, plmr, CAP_PLMR_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, smpwc, ECAP_SMPWC_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, flts, ECAP_FLTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, slts, ECAP_SLTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, slads, ECAP_SLADS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, vcs, ECAP_VCS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, smts, ECAP_SMTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, pds, ECAP_PDS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, dit, ECAP_DIT_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, nest, ECAP_NEST_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, sc_support, ECAP_SC_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, pass_through, ECAP_PT_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, dev_iotlb_support, ECAP_DT_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, qis, ECAP_QI_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, coherent, ECAP_C_MASK);
 }
 
 static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu)
 {
 	bool mismatch = false;
 
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, fl1gp_support, CAP_FL1GP_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, read_drain, CAP_RD_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, write_drain, CAP_WD_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, pgsel_inv, CAP_PSI_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, caching_mode, CAP_CM_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, phmr, CAP_PHMR_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, plmr, CAP_PLMR_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, smpwc, ECAP_SMPWC_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, flts, ECAP_FLTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, slts, ECAP_SLTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, slads, ECAP_SLADS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, vcs, ECAP_VCS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, smts, ECAP_SMTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, pds, ECAP_PDS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, dit, ECAP_DIT_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, nest, ECAP_NEST_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, sc_support, ECAP_SC_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, pass_through, ECAP_PT_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, dev_iotlb_support, ECAP_DT_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, qis, ECAP_QI_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, coherent, ECAP_C_MASK);
+
 	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
 		goto out;
 
diff --git a/drivers/iommu/intel/audit.h b/drivers/iommu/intel/audit.h
index 887900d9517d..e3a370405f82 100644
--- a/drivers/iommu/intel/audit.h
+++ b/drivers/iommu/intel/audit.h
@@ -7,19 +7,62 @@
  * Author: Kyung Min Park <kyung.min.park@intel.com>
  */
 
+/*
+ * Capability Register Mask
+ */
+#define CAP_FL5LP_MASK		BIT(60)
+#define CAP_FL1GP_MASK		BIT(56)
+#define CAP_RD_MASK		BIT(55)
+#define CAP_WD_MASK		BIT(54)
+#define CAP_PSI_MASK		BIT(39)
+#define CAP_CM_MASK		BIT(7)
+#define CAP_PHMR_MASK		BIT(6)
+#define CAP_PLMR_MASK		BIT(5)
+
 /*
  * Extended Capability Register Mask
  */
+#define ECAP_SMPWC_MASK		BIT(48)
 #define ECAP_FLTS_MASK		BIT(47)
+#define ECAP_SLTS_MASK		BIT(46)
+#define ECAP_SLADS_MASK		BIT(45)
+#define ECAP_VCS_MASK		BIT(44)
+#define ECAP_SMTS_MASK		BIT(43)
+#define ECAP_PDS_MASK		BIT(42)
+#define ECAP_DIT_MASK		BIT(41)
 #define ECAP_PASID_MASK		BIT(40)
 #define ECAP_EAFS_MASK		BIT(34)
 #define ECAP_SRS_MASK		BIT(31)
 #define ECAP_ERS_MASK		BIT(30)
 #define ECAP_PRS_MASK		BIT(29)
+#define ECAP_NEST_MASK		BIT(26)
+#define ECAP_SC_MASK		BIT(7)
+#define ECAP_PT_MASK		BIT(6)
+#define ECAP_DT_MASK		BIT(2)
+#define ECAP_QI_MASK		BIT(1)
+#define ECAP_C_MASK		BIT(0)
 
 #define MINIMAL_SVM_ECAP (ECAP_FLTS_MASK | ECAP_PASID_MASK | ECAP_EAFS_MASK | \
 			  ECAP_SRS_MASK | ECAP_ERS_MASK | ECAP_PRS_MASK)
 
+#define DO_CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
+do { \
+	if (cap##_##feature(a) != cap##_##feature(b)) { \
+		intel_iommu_##cap##_sanity &= ~(MASK); \
+		pr_info("IOMMU feature %s inconsistent.", #feature); \
+	} \
+} while (0)
+
+#define CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
+	DO_CHECK_FEATURE_MISMATCH((a)->cap, (b)->cap, cap, feature, MASK)
+
+#define CHECK_FEATURE_MISMATCH_HOTPLUG(b, cap, feature, MASK) \
+do { \
+	if (cap##_##feature(intel_iommu_##cap##_sanity)) \
+		DO_CHECK_FEATURE_MISMATCH(intel_iommu_##cap##_sanity, \
+					  (b)->cap, cap, feature, MASK); \
+} while (0)
+
 enum cap_audit_type {
 	CAP_AUDIT_STATIC_DMAR,
 	CAP_AUDIT_HOTPLUG_DMAR,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b1ed2f25f7c0..6744f00a144a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -171,8 +171,10 @@
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
+#define ecap_slads(e)		(((e) >> 45) & 0x1)
 #define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
+#define ecap_pds(e)		(((e) >> 42) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
 #define ecap_pss(e)		((e >> 35) & 0x1f)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
