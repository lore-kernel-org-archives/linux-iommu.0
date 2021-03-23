Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF7BC433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:15:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368C86196E
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368C86196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EE1B83D8E;
	Tue, 23 Mar 2021 01:15:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7XDXls6-gCC; Tue, 23 Mar 2021 01:15:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E757083D89;
	Tue, 23 Mar 2021 01:15:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9EE4C000B;
	Tue, 23 Mar 2021 01:15:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AE01C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CE2D60809
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xZO26Nmr2B2t for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 01:15:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91BA760806
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:43 +0000 (UTC)
IronPort-SDR: zB7F5xJPJQJBxgH9mixNg8YnnDNjq5gVfbAwY0YDTpUqEzgE8vk/UD/IYjDhqBEenO4l3NUNr3
 lPF9Kaw3feAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275480163"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="275480163"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 18:15:43 -0700
IronPort-SDR: wBoLq5XsrZtSB4vGSmXLEyZehOlKMVSpPxjr4ryACUxOrZIFCT3gzPZLHo4deHbLRBm5sx67mr
 Gm28BRlFMyhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="435362463"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 3/5] iommu/vt-d: Remove SVM_FLAG_PRIVATE_PASID
Date: Tue, 23 Mar 2021 09:05:58 +0800
Message-Id: <20210323010600.678627-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

The SVM_FLAG_PRIVATE_PASID has never been referenced in the tree, and
there's no plan to have anything to use it. So cleanup it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 40 ++++++++++++++++++---------------------
 include/linux/intel-svm.h | 16 +++-------------
 2 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 875ee74d8c41..5165cea90421 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -465,9 +465,9 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct intel_svm *svm = NULL, *t;
 	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
-	struct intel_svm *svm = NULL;
 	unsigned long iflags;
 	int pasid_max;
 	int ret;
@@ -493,30 +493,26 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		}
 	}
 
-	if (!(flags & SVM_FLAG_PRIVATE_PASID)) {
-		struct intel_svm *t;
-
-		list_for_each_entry(t, &global_svm_list, list) {
-			if (t->mm != mm || (t->flags & SVM_FLAG_PRIVATE_PASID))
-				continue;
-
-			svm = t;
-			if (svm->pasid >= pasid_max) {
-				dev_warn(dev,
-					 "Limited PASID width. Cannot use existing PASID %d\n",
-					 svm->pasid);
-				ret = -ENOSPC;
-				goto out;
-			}
+	list_for_each_entry(t, &global_svm_list, list) {
+		if (t->mm != mm)
+			continue;
 
-			/* Find the matching device in svm list */
-			for_each_svm_dev(sdev, svm, dev) {
-				sdev->users++;
-				goto success;
-			}
+		svm = t;
+		if (svm->pasid >= pasid_max) {
+			dev_warn(dev,
+				 "Limited PASID width. Cannot use existing PASID %d\n",
+				 svm->pasid);
+			ret = -ENOSPC;
+			goto out;
+		}
 
-			break;
+		/* Find the matching device in svm list */
+		for_each_svm_dev(sdev, svm, dev) {
+			sdev->users++;
+			goto success;
 		}
+
+		break;
 	}
 
 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 6c9d10c0fb1e..10fa80eef13a 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -14,16 +14,6 @@
 #define SVM_REQ_EXEC	(1<<1)
 #define SVM_REQ_PRIV	(1<<0)
 
-/*
- * The SVM_FLAG_PRIVATE_PASID flag requests a PASID which is *not* the "main"
- * PASID for the current process. Even if a PASID already exists, a new one
- * will be allocated. And the PASID allocated with SVM_FLAG_PRIVATE_PASID
- * will not be given to subsequent callers. This facility allows a driver to
- * disambiguate between multiple device contexts which access the same MM,
- * if there is no other way to do so. It should be used sparingly, if at all.
- */
-#define SVM_FLAG_PRIVATE_PASID		(1<<0)
-
 /*
  * The SVM_FLAG_SUPERVISOR_MODE flag requests a PASID which can be used only
  * for access to kernel addresses. No IOTLB flushes are automatically done
@@ -35,18 +25,18 @@
  * It is unlikely that we will ever hook into flush_tlb_kernel_range() to
  * do such IOTLB flushes automatically.
  */
-#define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
+#define SVM_FLAG_SUPERVISOR_MODE	BIT(0)
 /*
  * The SVM_FLAG_GUEST_MODE flag is used when a PASID bind is for guest
  * processes. Compared to the host bind, the primary differences are:
  * 1. mm life cycle management
  * 2. fault reporting
  */
-#define SVM_FLAG_GUEST_MODE		(1<<2)
+#define SVM_FLAG_GUEST_MODE		BIT(1)
 /*
  * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own PASID space,
  * which requires guest and host PASID translation at both directions.
  */
-#define SVM_FLAG_GUEST_PASID		(1<<3)
+#define SVM_FLAG_GUEST_PASID		BIT(2)
 
 #endif /* __INTEL_SVM_H__ */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
