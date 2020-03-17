Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C734C10F29
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FA320719
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FA320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 12ED0203AA;
	Tue, 17 Mar 2020 07:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I6hBPstF+Pr7; Tue, 17 Mar 2020 07:05:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C91EB2272C;
	Tue, 17 Mar 2020 07:05:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B11BAC18DA;
	Tue, 17 Mar 2020 07:05:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF9CAC013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AEA1F2272C
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i61QZVG5Po+e for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 07:05:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 310D4203AA
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:38 +0000 (UTC)
IronPort-SDR: k+gAAaNdRjDw9DpK6Q3xOTjLS8GlbMAgL8yntRKSF/tOxHzLGwNIVU83u5q3uAx72uH37IkK4H
 FkmwHF2/vvlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 00:05:37 -0700
IronPort-SDR: NeCZHbGg09fk4kwj2JMY5fY2mF4KoaDIw4W25G0ulQx8YSZHchYi455WpuSIIUua8r4R77Ipsi
 syLg6ZAhrFMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; d="scan'208";a="267867364"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 00:05:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 5/5] iommu/vt-d: Add page request draining support
Date: Tue, 17 Mar 2020 15:02:29 +0800
Message-Id: <20200317070229.21131-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317070229.21131-1-baolu.lu@linux.intel.com>
References: <20200317070229.21131-1-baolu.lu@linux.intel.com>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

When a PASID is stopped or terminated, there can be pending
PRQs (requests that haven't received responses) in remapping
hardware. This adds the interface to drain page requests and
call it when a PASID is terminated.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 156 +++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |   1 +
 2 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 6ce96dd541a6..ab13e33bc6ff 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -22,9 +22,14 @@
 
 #include "intel-pasid.h"
 
+static int intel_svm_process_prq(struct intel_iommu *iommu,
+				 struct page_req_dsc *prq,
+				 int head, int tail);
+static void intel_svm_drain_prq(struct device *dev, int pasid);
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-#define PRQ_ORDER 0
+#define PRQ_ORDER	0
+#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
@@ -208,6 +213,7 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
 		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
+		intel_svm_drain_prq(sdev->dev, svm->pasid);
 		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 	}
 	rcu_read_unlock();
@@ -226,6 +232,152 @@ static LIST_HEAD(global_svm_list);
 	list_for_each_entry((sdev), &(svm)->devs, list)	\
 		if ((d) != (sdev)->dev) {} else
 
+/*
+ * When a PASID is stopped or terminated, there can be pending PRQs
+ * (requests have not received responses) in remapping hardware.
+ *
+ * There are at least below scenarios that PRQ drains are required:
+ * - unbind a PASID;
+ * - resume phase of the PASID suspend/resume cycle.
+ *
+ * Steps to be performed:
+ * - Disable PR interrupt;
+ * - Take a snapshot of the page request queue, record current head
+ *   and tail, and mark PRQ entries with PASID to be dropped;
+ * - Mark queue empty, a.k.a. Head = Tail;
+ * - PRQ draining as described in 7.11 of the spec. Unnecessary to
+ *   check queue full since queue was empty at the point of drain;
+ * - Tail could have been moved due to new PRQ written by HW;
+ * - Process snapshot copy of PR queue;
+ * - Process hardware PR queue, enable interrupt again.
+ *
+ * For an example, consider the following timeline going downward.
+ *    VT-d HW            VT-d Driver          User(KMD, guest)
+ * --------------------------------------------------------
+ *   [PR1.2.3]
+ *   [PR1.1.3] <tail>
+ *   [PR1.2.2]
+ *   [PR1.2.1]
+ *   [PR1.1.2]
+ *   [PR1.1.1] <head>
+ *   [IRQ] ->
+ *
+ *
+ *                                          <-  [unbind PASID 1]
+ *                       [delete pending PR]
+ *                       [drain PRQs]
+ *
+ * Decoder:
+ * - PR.PASID.GroupID.Index, e.g. PR.1.2.3 indicates the Page request
+ *   with PASID = 1, GroupID = 2, 3rd request in the group.
+ * - LPIG: last page in group
+ * - PDP: private data present
+ * - KMD: kernel mode driver for native SVA
+ *
+ * Note:
+ * - Caller of unbind/suspend/resume PASID APIs must ensure no pending
+ *   DMA activities prior to call.
+ */
+static void intel_svm_drain_prq(struct device *dev, int pasid)
+{
+	struct device_domain_info *info;
+	struct qi_desc desc[3] = { 0 };
+	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
+	struct intel_svm *svm;
+	struct pci_dev *pdev;
+	unsigned long flags;
+	int head, tail;
+	u16 sid, did;
+	void *prqq;
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
+	rcu_read_lock();
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (WARN_ON(!svm)) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+
+	/*
+	 * Make a copy of the PR queue then process it offline without
+	 * blocking PRQ interrupts.
+	 */
+	prqq = kmemdup(iommu->prq, PAGE_SIZE ^ PRQ_ORDER, GFP_ATOMIC);
+	if (!prqq) {
+		spin_unlock_irqrestore(&iommu->lock, flags);
+		return;
+	}
+	/*
+	 * Make queue empty to allow further events and avoid the queue
+	 * full condition while we drain the queue.
+	 */
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	/*
+	 * Process the copy of PRQ, drained PASID already marked to be
+	 * dropped.
+	 */
+	if (intel_svm_process_prq(iommu, prqq, head, tail)) {
+		kfree(prqq);
+		return;
+	}
+
+	/*
+	 * Perform steps prescribed in VT-d spec CH7.11 to drain page
+	 * request and responses.
+	 */
+	sid = PCI_DEVID(info->bus, info->devfn);
+	did = domain->iommu_did[iommu->seq_id];
+	qdep = pci_ats_queue_depth(pdev);
+
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
+
+	/*
+	 * If new requests come in while we processing the copy, we should
+	 * process it now, otherwise the new request may be stuck until the
+	 * next IRQ.
+	 */
+	if (dmar_readq(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PPR) {
+		tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+		head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+		intel_svm_process_prq(iommu, iommu->prq, head, tail);
+	}
+
+	/* Allow new pending PRQ to generate interrupts. */
+	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
+
+	kfree(prqq);
+	return;
+}
+
 /* Caller must hold pasid_mutex, mm reference */
 static int intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 		      struct mm_struct *mm, struct intel_svm_dev **sd)
@@ -439,6 +591,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			 * large and has to be physically contiguous. So it's
 			 * hard to be as defensive as we might like. */
 			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_svm_drain_prq(dev, svm->pasid);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
@@ -491,7 +644,6 @@ struct page_req_dsc {
 	u64 priv_data[2];
 };
 
-#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 
 static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
 {
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 255b23f59a78..fcbc40d3ce18 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -324,6 +324,7 @@ enum {
 
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
