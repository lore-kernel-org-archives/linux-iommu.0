Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A5C4338F
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 13:52:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5F061058
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 13:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF5F061058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87C7F4041A;
	Wed, 18 Aug 2021 13:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQ35h61rYjDg; Wed, 18 Aug 2021 13:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5AE8C402C6;
	Wed, 18 Aug 2021 13:52:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46407C000E;
	Wed, 18 Aug 2021 13:52:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A8A1C000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EED4402C6
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LLsxnQLUPxNn for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 13:51:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6EF49403FB
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="214478890"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="214478890"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 06:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="449729245"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2021 06:51:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 6/9] iommu/vt-d: Allow devices to have more than 32
 outstanding PRs
Date: Wed, 18 Aug 2021 21:48:49 +0800
Message-Id: <20210818134852.1847070-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818134852.1847070-1-baolu.lu@linux.intel.com>
References: <20210818134852.1847070-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>, iommu@lists.linux-foundation.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

The minimum per-IOMMU PRQ queue size is one 4K page, this is more entries
than the hardcoded limit of 32 in the current VT-d code. Some devices can
support up to 512 outstanding PRQs but underutilized by this limit of 32.
Although, 32 gives some rough fairness when multiple devices share the same
IOMMU PRQ queue, but far from optimal for customized use case. This extends
the per-IOMMU PRQ queue size to four 4K pages and let the devices have as
many outstanding page requests as they can.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210720013856.4143880-1-baolu.lu@linux.intel.com
---
 include/linux/intel-svm.h   | 5 +++++
 drivers/iommu/intel/iommu.c | 3 ++-
 drivers/iommu/intel/svm.c   | 4 ----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 10fa80eef13a..57cceecbe37f 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -14,6 +14,11 @@
 #define SVM_REQ_EXEC	(1<<1)
 #define SVM_REQ_PRIV	(1<<0)
 
+/* Page Request Queue depth */
+#define PRQ_ORDER	2
+#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
+#define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
+
 /*
  * The SVM_FLAG_SUPERVISOR_MODE flag requests a PASID which can be used only
  * for access to kernel addresses. No IOTLB flushes are automatically done
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8d4d49e12c51..d75f59ae28e6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -33,6 +33,7 @@
 #include <linux/iommu.h>
 #include <linux/dma-iommu.h>
 #include <linux/intel-iommu.h>
+#include <linux/intel-svm.h>
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
 #include <linux/dmi.h>
@@ -1541,7 +1542,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 
 	if (info->pri_supported &&
 	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
-	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
+	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
 		info->pri_enabled = 1;
 #endif
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 4b9b3f35ba0e..2014fe8695ac 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -31,8 +31,6 @@ static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
 #define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
 
-#define PRQ_ORDER 0
-
 static DEFINE_XARRAY_ALLOC(pasid_private_array);
 static int pasid_private_add(ioasid_t pasid, void *priv)
 {
@@ -725,8 +723,6 @@ struct page_req_dsc {
 	u64 priv_data[2];
 };
 
-#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
-
 static bool is_canonical_address(u64 addr)
 {
 	int shift = 64 - (__VIRTUAL_MASK_SHIFT + 1);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
