Return-Path: <SRS0=eP4Y=2X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB0AC2D0DF
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 00:19:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93CA20672
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 00:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93CA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9CEE185540;
	Thu,  2 Jan 2020 00:19:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZA0czZrBakXL; Thu,  2 Jan 2020 00:19:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 74B23854C0;
	Thu,  2 Jan 2020 00:19:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F1AEC1D85;
	Thu,  2 Jan 2020 00:19:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D832EC077D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D538F8553C
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nAsZWPB8eZFq for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jan 2020 00:19:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DB084854C0
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:34 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jan 2020 16:19:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,384,1571727600"; d="scan'208";a="244475897"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jan 2020 16:19:33 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 02/22] iommu/vt-d: Fix CPU and IOMMU SVM feature matching
 checks
Date: Thu,  2 Jan 2020 08:18:03 +0800
Message-Id: <20200102001823.21976-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102001823.21976-1-baolu.lu@linux.intel.com>
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Shared Virtual Memory(SVM) is based on a collective set of hardware
features detected at runtime. There are requirements for matching CPU
and IOMMU capabilities.

The current code checks CPU and IOMMU feature set for SVM support but
the result is never stored nor used. Therefore, SVM can still be used
even when these checks failed. The consequences can be:
1. CPU uses 5-level paging mode for virtual address of 57 bits, but
IOMMU can only support 4-level paging mode with 48 bits address for DMA.
2. 1GB page size is used by CPU but IOMMU does not support it. VT-d
unrecoverable faults may be generated.

The best solution to fix these problems is to prevent them in the first
place.

This patch consolidates code for checking PASID, CPU vs. IOMMU paging
mode compatibility, as well as provides specific error messages for
each failed checks. On sane hardware configurations, these error message
shall never appear in kernel log.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 10 ++--------
 drivers/iommu/intel-svm.c   | 40 +++++++++++++++++++++++++------------
 include/linux/intel-iommu.h |  5 ++++-
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 26c40134817e..5328e2ed2dd3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3299,10 +3299,7 @@ static int __init init_dmars(void)
 
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
-#ifdef CONFIG_INTEL_IOMMU_SVM
-		if (pasid_supported(iommu))
-			intel_svm_init(iommu);
-#endif
+		intel_svm_check(iommu);
 	}
 
 	/*
@@ -4495,10 +4492,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ret)
 		goto out;
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_supported(iommu))
-		intel_svm_init(iommu);
-#endif
+	intel_svm_check(iommu);
 
 	if (dmaru->ignored) {
 		/*
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index dca88f9fdf29..e4a5d542b84f 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -23,19 +23,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-int intel_svm_init(struct intel_iommu *iommu)
-{
-	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
-			!cap_fl1gp_support(iommu->cap))
-		return -EINVAL;
-
-	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-			!cap_5lp_support(iommu->cap))
-		return -EINVAL;
-
-	return 0;
-}
-
 #define PRQ_ORDER 0
 
 int intel_svm_enable_prq(struct intel_iommu *iommu)
@@ -99,6 +86,33 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
 	return 0;
 }
 
+static inline bool intel_svm_capable(struct intel_iommu *iommu)
+{
+	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
+}
+
+void intel_svm_check(struct intel_iommu *iommu)
+{
+	if (!pasid_supported(iommu))
+		return;
+
+	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
+	    !cap_fl1gp_support(iommu->cap)) {
+		pr_err("%s SVM disabled, incompatible 1GB page capability\n",
+		       iommu->name);
+		return;
+	}
+
+	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+	    !cap_5lp_support(iommu->cap)) {
+		pr_err("%s SVM disabled, incompatible paging mode\n",
+		       iommu->name);
+		return;
+	}
+
+	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
+}
+
 static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
 				unsigned long address, unsigned long pages, int ih)
 {
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6d8bf4bdf240..aaece25c055f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -435,6 +435,7 @@ enum {
 
 #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
+#define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
 extern int intel_iommu_sm;
 
@@ -658,7 +659,7 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-int intel_svm_init(struct intel_iommu *iommu);
+extern void intel_svm_check(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 
@@ -686,6 +687,8 @@ struct intel_svm {
 };
 
 extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
+#else
+static inline void intel_svm_check(struct intel_iommu *iommu) {}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
