Return-Path: <SRS0=sVNY=6G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43674C55186
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 08:09:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED322071E
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 08:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED322071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F028E8804A;
	Wed, 22 Apr 2020 08:09:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Ndmc-Nut1X3; Wed, 22 Apr 2020 08:09:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 66B4587FDE;
	Wed, 22 Apr 2020 08:09:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55147C1DC9;
	Wed, 22 Apr 2020 08:09:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C045C1D92
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 08:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 873F221561
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 08:09:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVuTMxEDfhz4 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Apr 2020 08:09:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 29E4B2033D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 08:09:29 +0000 (UTC)
IronPort-SDR: /tBYmPv0dz/vhgUwD72LRFdTUXTfgtBGgci4PAR29mMrOjV1VZXIWX63aihpHwePIW5zXf+1ss
 o1utq8zUNTvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 01:09:29 -0700
IronPort-SDR: 5HyutUOt6J5G7c4Z1aUynNtYw7Zh8aj2pgm5PNJlFpcC/GX1W1Z7cGscazMbv8NMFMF+bwoW44
 YS3No3sij2aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; d="scan'208";a="365609637"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2020 01:09:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 3/4] iommu/vt-d: Add page request draining support
Date: Wed, 22 Apr 2020 16:06:10 +0800
Message-Id: <20200422080611.15689-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422080611.15689-1-baolu.lu@linux.intel.com>
References: <20200422080611.15689-1-baolu.lu@linux.intel.com>
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

When a PASID is stopped or terminated, there can be pending PRQs
(requests that haven't received responses) in remapping hardware.
This adds the interface to drain page requests and call it when a
PASID is terminated.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 103 ++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h |   4 ++
 2 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 83dc4319f661..2534641ef707 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -23,6 +23,7 @@
 #include "intel-pasid.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
+static void intel_svm_drain_prq(struct device *dev, int pasid);
 
 #define PRQ_ORDER 0
 
@@ -66,6 +67,8 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
 	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu->prq) | PRQ_ORDER);
 
+	init_completion(&iommu->prq_complete);
+
 	return 0;
 }
 
@@ -208,6 +211,7 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
 		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
+		intel_svm_drain_prq(sdev->dev, svm->pasid);
 		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 	}
 	rcu_read_unlock();
@@ -401,12 +405,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
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
@@ -644,6 +644,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			 * large and has to be physically contiguous. So it's
 			 * hard to be as defensive as we might like. */
 			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_svm_drain_prq(dev, svm->pasid);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
@@ -722,6 +723,92 @@ static bool is_canonical_address(u64 addr)
 	return (((saddr << shift) >> shift) == saddr);
 }
 
+/**
+ * intel_svm_drain_prq:
+ *
+ * Drain all pending page requests and responses related to a specific
+ * pasid in both software and hardware.
+ */
+static void intel_svm_drain_prq(struct device *dev, int pasid)
+{
+	struct device_domain_info *info;
+	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
+	struct qi_desc desc[3];
+	struct pci_dev *pdev;
+	int head, tail;
+	u16 sid, did;
+	int qdep;
+
+	info = get_domain_info(dev);
+	if (WARN_ON(!info || !dev_is_pci(dev)))
+		return;
+
+	if (!info->ats_enabled)
+		return;
+
+	iommu = info->iommu;
+	domain = info->domain;
+	pdev = to_pci_dev(dev);
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
+	/*
+	 * Submit an invalidation wait descriptor with fence and page request
+	 * drain flags set to invalidation queue. This ensures that all requests
+	 * submitted to the invalidation queue ahead of this wait descriptor are
+	 * processed and completed, and all already issued page requests from
+	 * the device are put in the page request queue.
+	 */
+	qi_submit_sync(iommu, desc, 1, QI_OPT_WAIT_DRAIN);
+
+	/*
+	 * Check and wait until all pending page requests in the queue are
+	 * handled by the intr thread.
+	 */
+prq_retry:
+	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	while (head != tail) {
+		struct page_req_dsc *req;
+
+		req = &iommu->prq[head / sizeof(*req)];
+		if (!req->pasid_present || req->pasid != pasid) {
+			head = (head + sizeof(*req)) & PRQ_RING_MASK;
+			continue;
+		}
+
+		wait_for_completion_timeout(&iommu->prq_complete, HZ);
+		goto prq_retry;
+	}
+
+	/*
+	 * Perform steps described in VT-d spec CH7.10 to drain page
+	 * requests and responses in hardware.
+	 */
+qi_retry:
+	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
+	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
+		wait_for_completion_timeout(&iommu->prq_complete, HZ);
+		goto qi_retry;
+	}
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
@@ -856,6 +943,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	}
 
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
+	/*
+	 * Clear the page request overflow bit and wake up all threads that
+	 * are waiting for the completion of this handling.
+	 */
+	writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
+	complete(&iommu->prq_complete);
 
 	return IRQ_RETVAL(handled);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index cca1e5f9aeaa..a0512b401a59 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -292,6 +292,8 @@
 
 /* PRS_REG */
 #define DMA_PRS_PPR	((u32)1)
+#define DMA_PRS_PRO	((u32)2)
+
 #define DMA_VCS_PAS	((u64)1)
 
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
@@ -333,6 +335,7 @@ enum {
 
 #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
 #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
+#define QI_IWD_FENCE		(((u64)1) << 6)
 #define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
 
 #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
@@ -590,6 +593,7 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct completion prq_complete;
 	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
