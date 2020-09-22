Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F78EC2D0E2
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 21:21:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1477F20936
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 21:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1477F20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C8AE321515;
	Tue, 22 Sep 2020 21:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CY+-LKNmMbYb; Tue, 22 Sep 2020 21:20:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 112DA20764;
	Tue, 22 Sep 2020 21:20:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF1B3C0859;
	Tue, 22 Sep 2020 21:20:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A094CC0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 21:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8D19A86731
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 21:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t6q98JK6ISaR for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 21:20:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A568786741
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 21:20:51 +0000 (UTC)
IronPort-SDR: 5bnTHDN1rxvFYayZX4n1fpKSgpj3xJH/1sIaDpga/uEOy3xGKrsZ7iIr8VWt5A7ucGiVvu0c0k
 k/5qdcj9aH8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="224870839"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="224870839"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 14:20:50 -0700
IronPort-SDR: M5vKN5tBmRclfy8kpFgwqkEXRPw0hmHYkbbCQ5FqrJHT1JHQrnOVscmZCrpi9sPjeiMlolFxcp
 UI5hXoDH8ltA==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="511368015"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 14:20:49 -0700
From: Kyung Min Park <kyung.min.park@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/4] iommu/vt-d: Disable SVM in the platform when IOMMUs have
 inconsistencies
Date: Tue, 22 Sep 2020 14:02:37 -0700
Message-Id: <20200922210240.27178-2-kyung.min.park@intel.com>
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

Some IOMMU Capabilities must be consistent for Shared Virtual Memory (SVM).
Audit IOMMU Capability/Extended Capabilities and check if IOMMUs have
the consistent value for features as below. When the features are not
matched among IOMMUs, disable SVMs in the platform during DMAR
initialization. Audit IOMMUs again when a device is hot plugged.

Disable Shared Virtual Memory when below features are mistmatched:
  - First Level Translation Support (FLTS)
  - Process Address Space ID Support (PASID)
  - Extended Accessed Flag Support (EAFS)
  - Supervisor Support (SRS)
  - Execute Request Support (ERS)
  - Page Request Support (PRS)

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/Makefile |  2 +-
 drivers/iommu/intel/audit.c  | 95 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/audit.h  | 29 +++++++++++
 drivers/iommu/intel/iommu.c  | 12 ++++-
 4 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/intel/audit.c
 create mode 100644 drivers/iommu/intel/audit.h

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index fb8e1e8c8029..02c26acb479f 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o
+obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o audit.o
 obj-$(CONFIG_INTEL_IOMMU) += trace.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
diff --git a/drivers/iommu/intel/audit.c b/drivers/iommu/intel/audit.c
new file mode 100644
index 000000000000..2893170f5b6c
--- /dev/null
+++ b/drivers/iommu/intel/audit.c
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * audit.c - audit iommu capabilities for boot time and hot plug
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * Author: Kyung Min Park <kyung.min.park@intel.com>
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/intel-iommu.h>
+#include "audit.h"
+
+static bool svm_sanity_check = true;
+static u64 intel_iommu_ecap_sanity = ~0ULL;
+
+static void set_cap_audit_svm_sanity(bool svm_sanity)
+{
+	svm_sanity_check = svm_sanity;
+}
+
+bool get_cap_audit_svm_sanity(void)
+{
+	return svm_sanity_check;
+}
+
+static inline void check_dmar_capabilities(struct intel_iommu *a,
+					   struct intel_iommu *b)
+{
+	if (MINIMAL_SVM_ECAP & (a->ecap ^ b->ecap))
+		set_cap_audit_svm_sanity(false);
+}
+
+static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu)
+{
+	bool mismatch = false;
+
+	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
+		goto out;
+
+	if (!get_cap_audit_svm_sanity() && (hot_iommu->flags & VTD_FLAG_SVM_CAPABLE)) {
+		pr_warn("Disable SVM in the IOMMU: SVM disabled at boot time.\n");
+		hot_iommu->flags = hot_iommu->flags & ~VTD_FLAG_SVM_CAPABLE;
+	} else if (get_cap_audit_svm_sanity() && (MINIMAL_SVM_ECAP &
+		   (hot_iommu->ecap ^ intel_iommu_ecap_sanity))) {
+		pr_warn("Abort Hot Plug IOMMU: SVM inconsistent.\n");
+		mismatch = true;
+	}
+
+out:
+	if (mismatch)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int audit_iommu_capabilities(void)
+{
+	struct dmar_drhd_unit *first_drhd, *drhd;
+	struct intel_iommu *iommu;
+	int ret = -EFAULT;
+
+	rcu_read_lock();
+	first_drhd = list_first_or_null_rcu(&dmar_drhd_units, typeof(*drhd),
+					    list);
+	if (!first_drhd) {
+		ret = 0;
+		goto out;
+	}
+
+	for_each_active_iommu(iommu, drhd)
+		check_dmar_capabilities(first_drhd->iommu, iommu);
+
+	if (get_cap_audit_svm_sanity())
+		intel_iommu_ecap_sanity = (intel_iommu_ecap_sanity & ~MINIMAL_SVM_ECAP) |
+					   (first_drhd->iommu->ecap & MINIMAL_SVM_ECAP);
+
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+int intel_iommu_audit_capabilities(enum cap_audit_type type, struct intel_iommu *iommu)
+{
+	switch (type) {
+	case CAP_AUDIT_STATIC_DMAR:
+		return audit_iommu_capabilities();
+	case CAP_AUDIT_HOTPLUG_DMAR:
+		return audit_iommu_capabilities_hotplug(iommu);
+	default:
+		return -EFAULT;
+	}
+}
diff --git a/drivers/iommu/intel/audit.h b/drivers/iommu/intel/audit.h
new file mode 100644
index 000000000000..887900d9517d
--- /dev/null
+++ b/drivers/iommu/intel/audit.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * audit.h - audit iommu capabilities header
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * Author: Kyung Min Park <kyung.min.park@intel.com>
+ */
+
+/*
+ * Extended Capability Register Mask
+ */
+#define ECAP_FLTS_MASK		BIT(47)
+#define ECAP_PASID_MASK		BIT(40)
+#define ECAP_EAFS_MASK		BIT(34)
+#define ECAP_SRS_MASK		BIT(31)
+#define ECAP_ERS_MASK		BIT(30)
+#define ECAP_PRS_MASK		BIT(29)
+
+#define MINIMAL_SVM_ECAP (ECAP_FLTS_MASK | ECAP_PASID_MASK | ECAP_EAFS_MASK | \
+			  ECAP_SRS_MASK | ECAP_ERS_MASK | ECAP_PRS_MASK)
+
+enum cap_audit_type {
+	CAP_AUDIT_STATIC_DMAR,
+	CAP_AUDIT_HOTPLUG_DMAR,
+};
+
+int intel_iommu_audit_capabilities(enum cap_audit_type type, struct intel_iommu *iommu);
+bool get_cap_audit_svm_sanity(void);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 87b17bac04c2..ab8300ee9791 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -49,6 +49,7 @@
 
 #include "../irq_remapping.h"
 #include "pasid.h"
+#include "audit.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -3230,6 +3231,10 @@ static int __init init_dmars(void)
 		goto error;
 	}
 
+	ret = intel_iommu_audit_capabilities(CAP_AUDIT_STATIC_DMAR, NULL);
+	if (ret)
+		goto free_iommu;
+
 	for_each_iommu(iommu, drhd) {
 		if (drhd->ignored) {
 			iommu_disable_translation(iommu);
@@ -3300,7 +3305,8 @@ static int __init init_dmars(void)
 
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
-		intel_svm_check(iommu);
+		if (get_cap_audit_svm_sanity())
+			intel_svm_check(iommu);
 	}
 
 	/*
@@ -4366,6 +4372,10 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (g_iommus[iommu->seq_id])
 		return 0;
 
+	ret = intel_iommu_audit_capabilities(CAP_AUDIT_HOTPLUG_DMAR, iommu);
+	if (ret)
+		goto out;
+
 	if (hw_pass_through && !ecap_pass_through(iommu->ecap)) {
 		pr_warn("%s: Doesn't support hardware pass through.\n",
 			iommu->name);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
