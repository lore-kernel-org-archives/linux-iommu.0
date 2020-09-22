Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4B9C4727E
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 21:21:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAFB23600
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 21:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAFB23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5E5402047D;
	Tue, 22 Sep 2020 21:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RAt6YExxbqyl; Tue, 22 Sep 2020 21:20:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D341F20431;
	Tue, 22 Sep 2020 21:20:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0C88C0859;
	Tue, 22 Sep 2020 21:20:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50EABC0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 21:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 344C92047D
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 21:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SFUD8vrOWqwp for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 21:20:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 1540520431
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 21:20:52 +0000 (UTC)
IronPort-SDR: LDQl5p0fZiptgpIuzxae5VDRa5XOMjEVNiXus/3JlwsSZt55KzKspXLuI4Ja2XEd4XwGwiHtpp
 v9xWb9tOyPzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="224870842"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="224870842"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 14:20:50 -0700
IronPort-SDR: uSAp0embKIDp59RnahYP6XLiEROI+cxPWFiFKPNU0s4GuIH8fOHOflF7zZuxHUELNVR9/Jhh/T
 b8vZg/3DwvzA==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="511368023"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 14:20:50 -0700
From: Kyung Min Park <kyung.min.park@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 3/4] iommu/vt-d: Audit IOMMUs for Interrupt Remapping features
Date: Tue, 22 Sep 2020 14:02:39 -0700
Message-Id: <20200922210240.27178-4-kyung.min.park@intel.com>
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

Audit IOMMU Capability/Extended Capabilities for Interrupt Remapping.
Check if the IOMMUs have the consistent value for the features as below.
When the features are not matched among IOMMUs, report out the IOMMU
features during irq remapping initialization. Audit IOMMUs again
when a device is hot plugged.

Report out features when below features are mismatched:
  - Posted Interrupts (PI)
  - Extended Interrupt Mode (EIM)

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/Makefile        |  2 +-
 drivers/iommu/intel/audit.c         | 39 ++++++++++++++++++++++++-----
 drivers/iommu/intel/audit.h         |  4 +++
 drivers/iommu/intel/irq_remapping.c |  8 ++++++
 4 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 02c26acb479f..b5760c4abc54 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o audit.o
 obj-$(CONFIG_INTEL_IOMMU) += trace.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
-obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
+obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o audit.o
diff --git a/drivers/iommu/intel/audit.c b/drivers/iommu/intel/audit.c
index f783acabb402..e005bc61770a 100644
--- a/drivers/iommu/intel/audit.c
+++ b/drivers/iommu/intel/audit.c
@@ -27,6 +27,13 @@ bool get_cap_audit_svm_sanity(void)
 	return svm_sanity_check;
 }
 
+static inline void check_irq_capabilities(struct intel_iommu *a,
+					  struct intel_iommu *b)
+{
+	CHECK_FEATURE_MISMATCH(a, b, cap, pi_support, CAP_PI_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, eim_support, ECAP_EIM_MASK);
+}
+
 static inline void check_dmar_capabilities(struct intel_iommu *a,
 					   struct intel_iommu *b)
 {
@@ -57,10 +64,17 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 	CHECK_FEATURE_MISMATCH(a, b, ecap, coherent, ECAP_C_MASK);
 }
 
-static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu)
+static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu,
+					    bool audit_irq)
 {
 	bool mismatch = false;
 
+	if (audit_irq) {
+		CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, pi_support, CAP_PI_MASK);
+		CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, eim_support, ECAP_EIM_MASK);
+		goto out;
+	}
+
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, 5lp_support, CAP_FL5LP_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, fl1gp_support, CAP_FL1GP_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, read_drain, CAP_RD_MASK);
@@ -103,7 +117,7 @@ static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu)
 	return 0;
 }
 
-static int audit_iommu_capabilities(void)
+static int audit_iommu_capabilities(bool audit_irq)
 {
 	struct dmar_drhd_unit *first_drhd, *drhd;
 	struct intel_iommu *iommu;
@@ -117,8 +131,17 @@ static int audit_iommu_capabilities(void)
 		goto out;
 	}
 
-	for_each_active_iommu(iommu, drhd)
-		check_dmar_capabilities(first_drhd->iommu, iommu);
+	for_each_active_iommu(iommu, drhd) {
+		if (audit_irq)
+			check_irq_capabilities(first_drhd->iommu, iommu);
+		else
+			check_dmar_capabilities(first_drhd->iommu, iommu);
+	}
+
+	if (audit_irq) {
+		ret = 0;
+		goto out;
+	}
 
 	if (get_cap_audit_svm_sanity())
 		intel_iommu_ecap_sanity = (intel_iommu_ecap_sanity & ~MINIMAL_SVM_ECAP) |
@@ -134,9 +157,13 @@ int intel_iommu_audit_capabilities(enum cap_audit_type type, struct intel_iommu
 {
 	switch (type) {
 	case CAP_AUDIT_STATIC_DMAR:
-		return audit_iommu_capabilities();
+		return audit_iommu_capabilities(false);
+	case CAP_AUDIT_STATIC_IRQR:
+		return audit_iommu_capabilities(true);
 	case CAP_AUDIT_HOTPLUG_DMAR:
-		return audit_iommu_capabilities_hotplug(iommu);
+		return audit_iommu_capabilities_hotplug(iommu, false);
+	case CAP_AUDIT_HOTPLUG_IRQR:
+		return audit_iommu_capabilities_hotplug(iommu, true);
 	default:
 		return -EFAULT;
 	}
diff --git a/drivers/iommu/intel/audit.h b/drivers/iommu/intel/audit.h
index e3a370405f82..6dfebe8e8fbe 100644
--- a/drivers/iommu/intel/audit.h
+++ b/drivers/iommu/intel/audit.h
@@ -11,6 +11,7 @@
  * Capability Register Mask
  */
 #define CAP_FL5LP_MASK		BIT(60)
+#define CAP_PI_MASK		BIT(59)
 #define CAP_FL1GP_MASK		BIT(56)
 #define CAP_RD_MASK		BIT(55)
 #define CAP_WD_MASK		BIT(54)
@@ -38,6 +39,7 @@
 #define ECAP_NEST_MASK		BIT(26)
 #define ECAP_SC_MASK		BIT(7)
 #define ECAP_PT_MASK		BIT(6)
+#define ECAP_EIM_MASK		BIT(4)
 #define ECAP_DT_MASK		BIT(2)
 #define ECAP_QI_MASK		BIT(1)
 #define ECAP_C_MASK		BIT(0)
@@ -65,7 +67,9 @@ do { \
 
 enum cap_audit_type {
 	CAP_AUDIT_STATIC_DMAR,
+	CAP_AUDIT_STATIC_IRQR,
 	CAP_AUDIT_HOTPLUG_DMAR,
+	CAP_AUDIT_HOTPLUG_IRQR,
 };
 
 int intel_iommu_audit_capabilities(enum cap_audit_type type, struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 8f4ce72570ce..7c77e0754896 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -23,6 +23,7 @@
 #include <asm/msidef.h>
 
 #include "../irq_remapping.h"
+#include "audit.h"
 
 enum irq_mode {
 	IRQ_REMAPPING,
@@ -737,6 +738,9 @@ static int __init intel_prepare_irq_remapping(void)
 	if (dmar_table_init() < 0)
 		return -ENODEV;
 
+	if (intel_iommu_audit_capabilities(CAP_AUDIT_STATIC_IRQR, NULL))
+		goto error;
+
 	if (!dmar_ir_support())
 		return -ENODEV;
 
@@ -1470,6 +1474,10 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 	int ret;
 	int eim = x2apic_enabled();
 
+	ret = intel_iommu_audit_capabilities(CAP_AUDIT_HOTPLUG_IRQR, iommu);
+	if (ret)
+		return ret;
+
 	if (eim && !ecap_eim_support(iommu->ecap)) {
 		pr_info("DRHD %Lx: EIM not supported by DRHD, ecap %Lx\n",
 			iommu->reg_phys, iommu->ecap);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
