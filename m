Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA5C433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:16:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7239E61363
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7239E61363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A56B40187;
	Thu, 20 May 2021 03:16:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sDhY69lrsEy6; Thu, 20 May 2021 03:16:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC16140155;
	Thu, 20 May 2021 03:16:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6782C000E;
	Thu, 20 May 2021 03:16:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AAF8C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79B8F405D4
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ectN-zYn-yqT for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 03:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EBF3405D5
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:16:47 +0000 (UTC)
IronPort-SDR: 99bGQdQwA/muyqiOcKPL3Wkl4w9ol0ZPCrBLr1rHJ3JRxml5L6IwNPYIM3LLfvJeA0n8uZS53y
 9h6cbi4GiwpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659606"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="286659606"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2021 20:16:46 -0700
IronPort-SDR: 792j3t8QyTuwQu+O+Q4y4q94IAI/X+k1qh1stuChoR4R7LFmWQNBMhzBzovwzB/cEuMgDuvvGN
 Rrr+XY+3vuag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="395527168"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:16:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 01/11] iommu/vt-d: Add pasid private data helpers
Date: Thu, 20 May 2021 11:15:21 +0800
Message-Id: <20210520031531.712333-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 ashok.raj@intel.com, linux-kernel@vger.kernel.org,
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

We are about to use iommu_sva_alloc/free_pasid() helpers in iommu core.
That means the pasid life cycle will be managed by iommu core. Use a
local array to save the per pasid private data instead of attaching it
the real pasid.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 62 ++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5165cea90421..82b0627ad7e7 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -17,6 +17,7 @@
 #include <linux/dmar.h>
 #include <linux/interrupt.h>
 #include <linux/mm_types.h>
+#include <linux/xarray.h>
 #include <linux/ioasid.h>
 #include <asm/page.h>
 #include <asm/fpu/api.h>
@@ -28,6 +29,23 @@ static void intel_svm_drain_prq(struct device *dev, u32 pasid);
 
 #define PRQ_ORDER 0
 
+static DEFINE_XARRAY_ALLOC(pasid_private_array);
+static int pasid_private_add(ioasid_t pasid, void *priv)
+{
+	return xa_alloc(&pasid_private_array, &pasid, priv,
+			XA_LIMIT(pasid, pasid), GFP_ATOMIC);
+}
+
+static void pasid_private_remove(ioasid_t pasid)
+{
+	xa_erase(&pasid_private_array, pasid);
+}
+
+static void *pasid_private_find(ioasid_t pasid)
+{
+	return xa_load(&pasid_private_array, pasid);
+}
+
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct page *pages;
@@ -224,7 +242,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
 		return -EINVAL;
 
-	svm = ioasid_find(NULL, pasid, NULL);
+	svm = pasid_private_find(pasid);
 	if (IS_ERR(svm))
 		return PTR_ERR(svm);
 
@@ -334,7 +352,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
 		}
-		ioasid_set_data(data->hpasid, svm);
+		pasid_private_add(data->hpasid, svm);
 		INIT_LIST_HEAD_RCU(&svm->devs);
 		mmput(svm->mm);
 	}
@@ -388,7 +406,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	list_add_rcu(&sdev->list, &svm->devs);
  out:
 	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
-		ioasid_set_data(data->hpasid, NULL);
+		pasid_private_remove(data->hpasid);
 		kfree(svm);
 	}
 
@@ -431,7 +449,7 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_set_data(pasid, NULL);
+				pasid_private_remove(pasid);
 				kfree(svm);
 			}
 		}
@@ -547,8 +565,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm) {
 			ret = -ENOMEM;
-			kfree(sdev);
-			goto out;
+			goto sdev_err;
 		}
 
 		if (pasid_max > intel_pasid_max_id)
@@ -556,13 +573,16 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 
 		/* Do not use PASID 0, reserved for RID to PASID */
 		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
-					  pasid_max - 1, svm);
+					  pasid_max - 1, NULL);
 		if (svm->pasid == INVALID_IOASID) {
-			kfree(svm);
-			kfree(sdev);
 			ret = -ENOSPC;
-			goto out;
+			goto svm_err;
 		}
+
+		ret = pasid_private_add(svm->pasid, svm);
+		if (ret)
+			goto pasid_err;
+
 		svm->notifier.ops = &intel_mmuops;
 		svm->mm = mm;
 		svm->flags = flags;
@@ -571,12 +591,8 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		ret = -ENOMEM;
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
-			if (ret) {
-				ioasid_put(svm->pasid);
-				kfree(svm);
-				kfree(sdev);
-				goto out;
-			}
+			if (ret)
+				goto priv_err;
 		}
 
 		spin_lock_irqsave(&iommu->lock, iflags);
@@ -590,8 +606,13 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
+priv_err:
+			pasid_private_remove(svm->pasid);
+pasid_err:
 			ioasid_put(svm->pasid);
+svm_err:
 			kfree(svm);
+sdev_err:
 			kfree(sdev);
 			goto out;
 		}
@@ -614,10 +635,8 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 						(cpu_feature_enabled(X86_FEATURE_LA57) ?
 						PASID_FLAG_FL5LP : 0));
 		spin_unlock_irqrestore(&iommu->lock, iflags);
-		if (ret) {
-			kfree(sdev);
-			goto out;
-		}
+		if (ret)
+			goto sdev_err;
 	}
 	list_add_rcu(&sdev->list, &svm->devs);
 success:
@@ -670,6 +689,7 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 					load_pasid(svm->mm, PASID_DISABLED);
 				}
 				list_del(&svm->list);
+				pasid_private_remove(svm->pasid);
 				/* We mandate that no page faults may be outstanding
 				 * for the PASID when intel_svm_unbind_mm() is called.
 				 * If that is not obeyed, subtle errors will happen.
@@ -924,7 +944,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		}
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
-			svm = ioasid_find(NULL, req->pasid, NULL);
+			svm = pasid_private_find(req->pasid);
 			/* It *can't* go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
