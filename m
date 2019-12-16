Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A4C2D0C3
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 19:19:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1FE21582
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 19:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1FE21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B2F8B86966;
	Mon, 16 Dec 2019 19:19:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNoBaAs7pPTD; Mon, 16 Dec 2019 19:19:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1785D86992;
	Mon, 16 Dec 2019 19:19:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F00BC1AE8;
	Mon, 16 Dec 2019 19:19:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 460A5C077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3938C86896
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XTFWFS__eEQ0 for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 19:19:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 614DB861A1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:19:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 11:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; d="scan'208";a="209411667"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 16 Dec 2019 11:19:23 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v8 10/10] iommu/vt-d: Handle IOASID notifications
Date: Mon, 16 Dec 2019 11:24:12 -0800
Message-Id: <1576524252-79116-11-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

IOASID/PASID are shared system resources that can be freed by software
components outside IOMMU subsystem. When status of an IOASID changes,
e.g. freed or suspended, notifications will be available to its users to
take proper action.

This patch adds a notification block such that when IOASID is freed by
other components such as VFIO, associated software and hardware context
can be cleaned.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 52 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  2 +-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index f580b7be63c5..a660e741551c 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -230,6 +230,48 @@ static LIST_HEAD(global_svm_list);
 	list_for_each_entry((sdev), &(svm)->devs, list)	\
 		if ((d) != (sdev)->dev) {} else
 
+static int ioasid_status_change(struct notifier_block *nb,
+				unsigned long code, void *data)
+{
+	ioasid_t ioasid = *(ioasid_t *)data;
+	struct intel_svm_dev *sdev;
+	struct intel_svm *svm;
+
+	if (code == IOASID_FREE) {
+		/*
+		 * Unbind all devices associated with this PASID which is
+		 * being freed by other users such as VFIO.
+		 */
+		svm = ioasid_find(NULL, ioasid, NULL);
+		if (!svm || !svm->iommu)
+			return NOTIFY_DONE;
+
+		if (IS_ERR(svm))
+			return NOTIFY_BAD;
+
+		list_for_each_entry(sdev, &svm->devs, list) {
+			list_del_rcu(&sdev->list);
+			intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
+						    svm->pasid);
+				kfree_rcu(sdev, rcu);
+
+				if (list_empty(&svm->devs)) {
+					list_del(&svm->list);
+					ioasid_set_data(ioasid, NULL);
+					kfree(svm);
+				}
+		}
+
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block svm_ioasid_notifier = {
+		.notifier_call = ioasid_status_change,
+};
+
 int intel_svm_bind_gpasid(struct iommu_domain *domain,
 			struct device *dev,
 			struct iommu_gpasid_bind_data *data)
@@ -319,6 +361,13 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
 		}
+		/* Get notified when IOASID is freed by others, e.g. VFIO */
+		ret = ioasid_add_notifier(data->hpasid, &svm_ioasid_notifier);
+		if (ret) {
+			mmput(svm->mm);
+			kfree(svm);
+			goto out;
+		}
 		ioasid_set_data(data->hpasid, svm);
 		INIT_LIST_HEAD_RCU(&svm->devs);
 		INIT_LIST_HEAD(&svm->list);
@@ -432,6 +481,9 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * that PASID allocated by one guest cannot be
 				 * used by another.
 				 */
+				ioasid_remove_notifier(pasid,
+						       &svm_ioasid_notifier);
+
 				ioasid_set_data(pasid, NULL);
 				kfree(svm);
 			}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8c30b23bd838..e2a33c794e8d 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -711,7 +711,7 @@ struct intel_svm_dev {
 struct intel_svm {
 	struct mmu_notifier notifier;
 	struct mm_struct *mm;
-
+	struct notifier_block *nb;
 	struct intel_iommu *iommu;
 	int flags;
 	int pasid;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
