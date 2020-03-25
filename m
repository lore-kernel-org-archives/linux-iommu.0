Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AA6C2D0E9
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780632078E
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780632078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 436B5883C9;
	Wed, 25 Mar 2020 17:49:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ui260EpiT94V; Wed, 25 Mar 2020 17:49:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 841C588368;
	Wed, 25 Mar 2020 17:49:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64FBEC1D88;
	Wed, 25 Mar 2020 17:49:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4464EC1D8A
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 17:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2EF1786CEF
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 17:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E2qcHLV7fgZi for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 17:49:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A04DE863A1
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 17:49:49 +0000 (UTC)
IronPort-SDR: 0osURA7cMGYzG6PIPmaA4oa2PS2SOEGACS3zS6PzOoUhbWhGol8vAjlpdl/C9C3bSz2cj6Tz/N
 T/VX8MGcDNOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 10:49:49 -0700
IronPort-SDR: ARQgIwOFa7uTee97rp4tMpDfZY+JUyOLRBrt94THE7WOzu42tL43ONqjxD+4Pcv8CZNjHDOXtX
 YTGKWz//BP6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; d="scan'208";a="393702219"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 10:49:48 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH 10/10] iommu/vt-d: Register PASID notifier for status change
Date: Wed, 25 Mar 2020 10:55:31 -0700
Message-Id: <1585158931-1825-11-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
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

In bare metal SVA, IOMMU driver ensures that IOASID free call always comes
after IOASID unbind operation.

However, for guest SVA the unbind and free call come from user space
via VFIO, which could be out of order. This patch registers a notifier
block in case IOASID free() comes before unbind such that VT-d driver
can take action to clean up PASID context and data.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 68 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  1 +
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index f511855d187b..779dd2c6f9e1 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -23,6 +23,7 @@
 #include "intel-pasid.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
+static DEFINE_MUTEX(pasid_mutex);
 
 #define PRQ_ORDER 0
 
@@ -92,6 +93,65 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
 	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
 }
 
+#define pasid_lock_held() lock_is_held(&pasid_mutex.dep_map)
+
+static int pasid_status_change(struct notifier_block *nb,
+				unsigned long code, void *data)
+{
+	struct ioasid_nb_args *args = (struct ioasid_nb_args *)data;
+	struct intel_svm_dev *sdev;
+	struct intel_svm *svm;
+	int ret = NOTIFY_DONE;
+
+	if (code == IOASID_FREE) {
+		/*
+		 * Unbind all devices associated with this PASID which is
+		 * being freed by other users such as VFIO.
+		 */
+		mutex_lock(&pasid_mutex);
+		svm = ioasid_find(INVALID_IOASID_SET, args->id, NULL);
+		if (!svm || !svm->iommu)
+			goto done_unlock;
+
+		if (IS_ERR(svm)) {
+			ret = NOTIFY_BAD;
+			goto done_unlock;
+		}
+
+		list_for_each_entry_rcu(sdev, &svm->devs, list, pasid_lock_held()) {
+			/* Does not poison forward pointer */
+			list_del_rcu(&sdev->list);
+			intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
+						    svm->pasid);
+			kfree_rcu(sdev, rcu);
+
+			/*
+			 * Free before unbind only happens with guest usaged
+			 * host PASIDs. IOASID free will detach private data
+			 * and free the IOASID entry.
+			 */
+			if (list_empty(&svm->devs))
+				kfree(svm);
+		}
+		mutex_unlock(&pasid_mutex);
+
+		return NOTIFY_OK;
+	}
+
+done_unlock:
+	mutex_unlock(&pasid_mutex);
+	return ret;
+}
+
+static struct notifier_block pasid_nb = {
+		.notifier_call = pasid_status_change,
+};
+
+void intel_svm_add_pasid_notifier(void)
+{
+	ioasid_add_notifier(&pasid_nb);
+}
+
 void intel_svm_check(struct intel_iommu *iommu)
 {
 	if (!pasid_supported(iommu))
@@ -219,7 +279,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.invalidate_range = intel_invalidate_range,
 };
 
-static DEFINE_MUTEX(pasid_mutex);
 static LIST_HEAD(global_svm_list);
 
 #define for_each_svm_dev(sdev, svm, d)			\
@@ -319,6 +378,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
 		}
+		svm->iommu = iommu;
 
 		ioasid_attach_data(data->hpasid, svm);
 		INIT_LIST_HEAD_RCU(&svm->devs);
@@ -383,6 +443,11 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
 	}
 	svm->flags |= SVM_FLAG_GUEST_MODE;
 
+	/*
+	 * Notify KVM new host-guest PASID bind is ready. KVM will set up
+	 * PASID translation table to support guest ENQCMD.
+	 */
+	ioasid_notify(data->hpasid, IOASID_BIND);
 	init_rcu_head(&sdev->rcu);
 	list_add_rcu(&sdev->list, &svm->devs);
  out:
@@ -440,6 +505,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * used by another.
 				 */
 				ioasid_attach_data(pasid, NULL);
+				ioasid_notify(pasid, IOASID_UNBIND);
 				kfree(svm);
 			}
 		}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index f8504a980981..64799067ea58 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -708,6 +708,7 @@ extern struct iommu_sva *
 intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata);
 extern void intel_svm_unbind(struct iommu_sva *handle);
 extern int intel_svm_get_pasid(struct iommu_sva *handle);
+extern void intel_svm_add_pasid_notifier(void);
 
 struct svm_dev_ops;
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
