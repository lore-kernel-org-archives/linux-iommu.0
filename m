Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D2C4727E
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 21:20:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D282520888
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 21:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D282520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B61F84ABB;
	Tue, 22 Sep 2020 21:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LpvuGYctvGEG; Tue, 22 Sep 2020 21:20:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4CE17854DB;
	Tue, 22 Sep 2020 21:20:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 350EDC0895;
	Tue, 22 Sep 2020 21:20:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27166C0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 21:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 20FB386731
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 21:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kygOwx1tiMOK for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 21:20:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 39BB286757
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 21:20:52 +0000 (UTC)
IronPort-SDR: GbT96nDu7O0woW3kE2sBO2PGPqXYXYqIe96NmwdGN8XV4wAHuKREqPt/3/C3WH5NsqWga0Jczk
 t2I0zPjWjgdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="224870843"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="224870843"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 14:20:50 -0700
IronPort-SDR: 0Cu/j1StOEPoKMwPqcSuQOMm/HZoRFLVK9YMuRaqDoyDg+qjK4kNFjsgrtY6e8eIkh+W0WBBdw
 PEklKTlMXvBQ==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="511368026"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 14:20:50 -0700
From: Kyung Min Park <kyung.min.park@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 4/4] iommu/vt-d: Scale capability to the lowest supported
 between the IOMMUs
Date: Tue, 22 Sep 2020 14:02:40 -0700
Message-Id: <20200922210240.27178-5-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922210240.27178-1-kyung.min.park@intel.com>
References: <20200922210240.27178-1-kyung.min.park@intel.com>
Cc: ravi.v.shankar@intel.com, kevin.tian@intel.com, ashok.raj@intel.com,
 ricardo.neri@intel.com, Kyung Min Park <kyung.min.park@intel.com>,
 dwmw2@infradead.org
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

Audit IOMMU Capability/Extended Capabilities and check if the IOMMUs
have the consistent value for features as below. Find common denominator
for the features and set to the lowest supported value for each IOMMU.

Abort hot plug when the hot plugged IOMMU does not meet the aforementioned
common denominator.

Set capability to the lowest supported when below features are mismatched:
  - Maximum Address Mask Value (MAMV)
  - Second Level Large Page Support (SLLPS)
  - Maximum Guest Address Width (MGAW)
  - Supported Adjusted Guest Address Width (SAGAW)
  - Number of Domains supported (ND)
  - Pasid Size Supported (PSS)

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/audit.c | 23 +++++++++++++++++++++++
 drivers/iommu/intel/audit.h | 27 +++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  1 +
 3 files changed, 51 insertions(+)

diff --git a/drivers/iommu/intel/audit.c b/drivers/iommu/intel/audit.c
index e005bc61770a..7e12c963c2b7 100644
--- a/drivers/iommu/intel/audit.c
+++ b/drivers/iommu/intel/audit.c
@@ -40,6 +40,13 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 	if (MINIMAL_SVM_ECAP & (a->ecap ^ b->ecap))
 		set_cap_audit_svm_sanity(false);
 
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_MAMV_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_SLLPS_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_MGAW_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_SAGAW_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_NDOMS_MASK);
+	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_PSS_MASK);
+
 	CHECK_FEATURE_MISMATCH(a, b, cap, 5lp_support, CAP_FL5LP_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, fl1gp_support, CAP_FL1GP_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, read_drain, CAP_RD_MASK);
@@ -98,6 +105,14 @@ static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu,
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, qis, ECAP_QI_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, coherent, ECAP_C_MASK);
 
+	/* Abort hot plug if the hot plug iommu feature is smaller than global */
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, mamv, CAP_MAMV_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, super_page_val, CAP_SLLPS_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, mgaw, CAP_MGAW_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, sagaw, CAP_SAGAW_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, ndoms, CAP_NDOMS_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, ecap, pss, ECAP_PSS_MASK, mismatch);
+
 	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
 		goto out;
 
@@ -147,6 +162,14 @@ static int audit_iommu_capabilities(bool audit_irq)
 		intel_iommu_ecap_sanity = (intel_iommu_ecap_sanity & ~MINIMAL_SVM_ECAP) |
 					   (first_drhd->iommu->ecap & MINIMAL_SVM_ECAP);
 
+	/* scale capability to the lowest supported value */
+	for_each_active_iommu(iommu, drhd) {
+		iommu->cap = (intel_iommu_cap_sanity & MINIMAL_FEATURE_CAP) |
+			     (~MINIMAL_FEATURE_CAP & iommu->cap);
+		iommu->ecap = (intel_iommu_ecap_sanity & ECAP_PSS_MASK) |
+			      (~ECAP_PSS_MASK & iommu->ecap);
+	}
+
 	ret = 0;
 out:
 	rcu_read_unlock();
diff --git a/drivers/iommu/intel/audit.h b/drivers/iommu/intel/audit.h
index 6dfebe8e8fbe..a293e71ce9ab 100644
--- a/drivers/iommu/intel/audit.h
+++ b/drivers/iommu/intel/audit.h
@@ -13,9 +13,14 @@
 #define CAP_FL5LP_MASK		BIT(60)
 #define CAP_PI_MASK		BIT(59)
 #define CAP_FL1GP_MASK		BIT(56)
+#define CAP_MAMV_MASK		GENMASK_ULL(53, 48)
 #define CAP_RD_MASK		BIT(55)
 #define CAP_WD_MASK		BIT(54)
 #define CAP_PSI_MASK		BIT(39)
+#define CAP_SLLPS_MASK		GENMASK_ULL(37, 34)
+#define CAP_MGAW_MASK		GENMASK_ULL(21, 16)
+#define CAP_SAGAW_MASK		GENMASK_ULL(12, 8)
+#define CAP_NDOMS_MASK		GENMASK_ULL(2, 0)
 #define CAP_CM_MASK		BIT(7)
 #define CAP_PHMR_MASK		BIT(6)
 #define CAP_PLMR_MASK		BIT(5)
@@ -32,6 +37,7 @@
 #define ECAP_PDS_MASK		BIT(42)
 #define ECAP_DIT_MASK		BIT(41)
 #define ECAP_PASID_MASK		BIT(40)
+#define ECAP_PSS_MASK		GENMASK_ULL(39, 35)
 #define ECAP_EAFS_MASK		BIT(34)
 #define ECAP_SRS_MASK		BIT(31)
 #define ECAP_ERS_MASK		BIT(30)
@@ -47,6 +53,9 @@
 #define MINIMAL_SVM_ECAP (ECAP_FLTS_MASK | ECAP_PASID_MASK | ECAP_EAFS_MASK | \
 			  ECAP_SRS_MASK | ECAP_ERS_MASK | ECAP_PRS_MASK)
 
+#define MINIMAL_FEATURE_CAP (CAP_MAMV_MASK | CAP_SLLPS_MASK | CAP_MGAW_MASK | \
+			     CAP_SAGAW_MASK | CAP_NDOMS_MASK)
+
 #define DO_CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
 do { \
 	if (cap##_##feature(a) != cap##_##feature(b)) { \
@@ -65,6 +74,24 @@ do { \
 					  (b)->cap, cap, feature, MASK); \
 } while (0)
 
+#define MINIMAL_FEATURE_IOMMU(iommu, cap, MASK) \
+do { \
+	u64 min_feature = intel_iommu_##cap##_sanity & MASK; \
+	min_feature = min_t(u64, min_feature, (iommu)->cap & (MASK)); \
+	intel_iommu_##cap##_sanity = (intel_iommu_##cap##_sanity & ~(MASK)) | \
+				     min_feature; \
+} while (0)
+
+#define MINIMAL_FEATURE_HOTPLUG(iommu, cap, feature, MASK, mismatch) \
+do { \
+	if ((intel_iommu_##cap##_sanity & (MASK)) > \
+	    (cap##_##feature((iommu)->cap))) \
+		mismatch = true; \
+	else \
+		(iommu)->cap = ((iommu)->cap & ~(MASK)) | \
+		(intel_iommu_##cap##_sanity & (MASK)); \
+} while (0)
+
 enum cap_audit_type {
 	CAP_AUDIT_STATIC_DMAR,
 	CAP_AUDIT_STATIC_IRQR,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6744f00a144a..297a10091bb5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -154,6 +154,7 @@
 #define cap_max_fault_reg_offset(c) \
 	(cap_fault_reg_offset(c) + cap_num_fault_regs(c) * 16)
 
+#define cap_mamv(c)		(((c) >> 48) & 0x3f)
 #define cap_zlr(c)		(((c) >> 22) & 1)
 #define cap_isoch(c)		(((c) >> 23) & 1)
 #define cap_mgaw(c)		((((c) >> 16) & 0x3f) + 1)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
