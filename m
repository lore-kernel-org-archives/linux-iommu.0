Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CC2C48BCD
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5216140F
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5216140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C7A26FB5C;
	Thu, 10 Jun 2021 02:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ha3lCP9sewKu; Thu, 10 Jun 2021 02:03:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 44A3C600C6;
	Thu, 10 Jun 2021 02:03:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1893AC000E;
	Thu, 10 Jun 2021 02:03:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B23DC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AF6A83224
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JbE3SCpV7WB3 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:03:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98BEC83211
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:14 +0000 (UTC)
IronPort-SDR: WLjH4jI+Bm8/AnRzjQcoQOxMExtJwSavouZ9ep3gupVgULublttrkkVM6mW8i+qexiT/9EWNkD
 UsgF2H9g50Zg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184198"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:03:14 -0700
IronPort-SDR: 9V7ELwvaGUAJHBedrI9xyaDnzz/T+8S2HhSotOxCMAzIH49+wXlk2tBWvVdPMKxyLYHbz4c3QS
 VDuRknSBPo3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500365"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:03:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 06/23] iommu/vt-d: Add pasid private data helpers
Date: Thu, 10 Jun 2021 10:00:58 +0800
Message-Id: <20210610020115.1637656-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
References: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Aditya Srivastava <yashsri421@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 YueHaibing <yuehaibing@huawei.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 iommu@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>,
 Will Deacon <will@kernel.org>
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
Link: https://lore.kernel.org/r/20210520031531.712333-1-baolu.lu@linux.intel.com
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
