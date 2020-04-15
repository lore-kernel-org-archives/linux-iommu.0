Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F28C2BA2B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B382620774
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B382620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A04DF20362;
	Wed, 15 Apr 2020 05:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qtKojKL10NZo; Wed, 15 Apr 2020 05:29:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9C838204C9;
	Wed, 15 Apr 2020 05:29:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8362EC1D7D;
	Wed, 15 Apr 2020 05:29:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70398C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6CA7785507
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5izOPT3jWZq for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 05:29:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9486F844AF
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:13 +0000 (UTC)
IronPort-SDR: iBlubJDniROtEy3FERSzckRhy0NWM3Zlnagyi7Hcv62FpSn+uns2AnO/Wn4s2fPKCYGU0YkZXI
 imUzNJ65Jr+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 22:29:13 -0700
IronPort-SDR: m6ypnE3eLfNIxrt+hdRWz1J2MiXl3Gp+x6EsEOO/GH3Eh+wxVUw1GCQhdXGOnw+ghjUcyX3ikQ
 ur4dZ4eaOo1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; d="scan'208";a="277504227"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 22:29:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 6/7] iommu/vt-d: Add page request draining support
Date: Wed, 15 Apr 2020 13:25:41 +0800
Message-Id: <20200415052542.30421-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415052542.30421-1-baolu.lu@linux.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

When a PASID is stopped or terminated, there can be pending
PRQs (requests that haven't received responses) in remapping
hardware. This adds the interface to drain page requests and
call it when a PASID is terminated.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 90 ++++++++++++++++++++++++++++++++++---
 include/linux/intel-iommu.h |  1 +
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 05aeb8ea51c4..736dd39fb52b 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -23,6 +23,7 @@
 #include "intel-pasid.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
+static void intel_svm_drain_prq(struct device *dev, int pasid);
 
 #define PRQ_ORDER 0
 
@@ -210,6 +211,7 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
 		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
+		intel_svm_drain_prq(sdev->dev, svm->pasid);
 		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 	}
 	rcu_read_unlock();
@@ -403,12 +405,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 		if (!sdev->users) {
 			list_del_rcu(&sdev->list);
 			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_svm_drain_prq(dev, svm->pasid);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
-			/* TODO: Drain in flight PRQ for the PASID since it
-			 * may get reused soon, we don't want to
-			 * confuse with its previous life.
-			 * intel_svm_drain_prq(dev, pasid);
-			 */
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
@@ -646,6 +644,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			 * large and has to be physically contiguous. So it's
 			 * hard to be as defensive as we might like. */
 			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_svm_drain_prq(dev, svm->pasid);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
@@ -703,6 +702,7 @@ struct page_req_dsc {
 struct page_req {
 	struct list_head list;
 	struct page_req_dsc desc;
+	struct completion complete;
 	unsigned int processing:1;
 	unsigned int drained:1;
 	unsigned int completed:1;
@@ -732,9 +732,83 @@ static bool is_canonical_address(u64 addr)
 	return (((saddr << shift) >> shift) == saddr);
 }
 
+/**
+ * intel_svm_drain_prq:
+ *
+ * Drain all pending page requests related to a specific pasid in both
+ * software and hardware. The caller must guarantee that no more page
+ * requests related to this pasid coming.
+ */
+static void intel_svm_drain_prq(struct device *dev, int pasid)
+{
+	struct device_domain_info *info;
+	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
+	struct qi_desc desc[3];
+	struct pci_dev *pdev;
+	struct page_req *req;
+	unsigned long flags;
+	u16 sid, did;
+	int qdep;
+
+	info = get_domain_info(dev);
+	if (WARN_ON(!info || !dev_is_pci(dev)))
+		return;
+
+	iommu = info->iommu;
+	domain = info->domain;
+	pdev = to_pci_dev(dev);
+
+	/* Mark all related pending requests drained. */
+	spin_lock_irqsave(&iommu->prq_lock, flags);
+	list_for_each_entry(req, &iommu->prq_list, list)
+		if (req->desc.pasid_present && req->desc.pasid == pasid)
+			req->drained = true;
+	spin_unlock_irqrestore(&iommu->prq_lock, flags);
+
+	/* Wait until all related pending requests complete. */
+retry:
+	spin_lock_irqsave(&iommu->prq_lock, flags);
+	list_for_each_entry(req, &iommu->prq_list, list) {
+		if (req->desc.pasid_present &&
+		    req->desc.pasid == pasid &&
+		    !req->completed) {
+			spin_unlock_irqrestore(&iommu->prq_lock, flags);
+			wait_for_completion_timeout(&req->complete, 5 * HZ);
+			goto retry;
+		}
+	}
+	spin_unlock_irqrestore(&iommu->prq_lock, flags);
+
+	/*
+	 * Perform steps described in VT-d spec CH7.10 to drain page
+	 * request and responses in hardware.
+	 */
+	sid = PCI_DEVID(info->bus, info->devfn);
+	did = domain->iommu_did[iommu->seq_id];
+	qdep = pci_ats_queue_depth(pdev);
+
+	memset(desc, 0, sizeof(desc));
+	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
+			QI_IWD_FENCE |
+			QI_IWD_TYPE;
+	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
+			QI_EIOTLB_DID(did) |
+			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
+			QI_EIOTLB_TYPE;
+	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
+			QI_DEV_EIOTLB_SID(sid) |
+			QI_DEV_EIOTLB_QDEP(qdep) |
+			QI_DEIOTLB_TYPE |
+			QI_DEV_IOTLB_PFSID(info->pfsid);
+
+	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
+}
+
 static void process_single_prq(struct intel_iommu *iommu,
 			       struct page_req_dsc *req)
 {
+	struct page_req *p_req = container_of(req, struct page_req, desc);
 	int result = QI_RESP_FAILURE;
 	struct intel_svm_dev *sdev;
 	struct vm_area_struct *vma;
@@ -768,6 +842,10 @@ static void process_single_prq(struct intel_iommu *iommu,
 	}
 
 	result = QI_RESP_INVALID;
+
+	if (p_req->drained)
+		goto bad_req;
+
 	/* Since we're using init_mm.pgd directly, we should never take
 	 * any faults on kernel addresses. */
 	if (!svm->mm)
@@ -868,6 +946,7 @@ static void intel_svm_process_prq(struct intel_iommu *iommu)
 			req->completed = true;
 		} else if (req->completed) {
 			list_del(&req->list);
+			complete(&req->complete);
 			kfree(req);
 		} else {
 			break;
@@ -899,6 +978,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (!req)
 			break;
 		req->desc = *dsc;
+		init_completion(&req->complete);
 		list_add_tail(&req->list, &iommu->prq_list);
 		head = (head + sizeof(*dsc)) & PRQ_RING_MASK;
 	}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 80715a59491c..714a0df3d879 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -333,6 +333,7 @@ enum {
 
 #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
 #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
+#define QI_IWD_FENCE		(((u64)1) << 6)
 #define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
 
 #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
