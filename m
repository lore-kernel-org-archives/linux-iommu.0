Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E65C3815B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123932076A
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123932076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E9FEC844B4;
	Wed, 15 Apr 2020 05:29:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DEhQrSjaRXRJ; Wed, 15 Apr 2020 05:29:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5569084508;
	Wed, 15 Apr 2020 05:29:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 397FAC1D7D;
	Wed, 15 Apr 2020 05:29:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2114BC0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 10C5484508
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id erXIPOwV0LdX for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 05:29:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 63A34844B4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:11 +0000 (UTC)
IronPort-SDR: RHVHZ1FC2CAkMN+xFugC0zyUi5r7ahhZds+o/3iEGa2mosHhy5CaNJTnS8NY4dvG5Uz7FilzKQ
 Mvm8koTgWD0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 22:29:11 -0700
IronPort-SDR: OvGXTUQb+261zgqu8bzjekwJmZRxO24/QbIUFrvkzaQne/dE1loragWUFJmhevrzmCZiLCO0zI
 h2g10tL18iCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; d="scan'208";a="277504218"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 22:29:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 5/7] iommu/vt-d: Save prq descriptors in an internal list
Date: Wed, 15 Apr 2020 13:25:40 +0800
Message-Id: <20200415052542.30421-6-baolu.lu@linux.intel.com>
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

Currently, the page request interrupt thread handles the page
requests in the queue in this way:

- Clear PPR bit to ensure new interrupt could come in;
- Read and record the head and tail registers;
- Handle all descriptors between head and tail;
- Write tail to head register.

This might cause some descriptors to be handles multiple times.
An example sequence:

- Thread A got scheduled with PRQ_1 and PRQ_2 in the queue;
- Thread A clear the PPR bit and record the head and tail;
- A new PRQ_3 comes and Thread B gets scheduled;
- Thread B record the head and tail which includes PRQ_1
  and PRQ_2.

As the result, PRQ_1 and PRQ_2 are handled twice in Thread_A and
Thread_B.

       Thread_A            Thread_B
      .--------.          .--------.
      |        |          |        |
      .--------.          .--------.
  head| PRQ_1  |      head| PRQ_1  |
      .--------.          .--------.
      | PRQ_2  |          | PRQ_2  |
      .--------.          .--------.
  tail|        |          | PRQ_3  |
      .--------.          .--------.
      |        |      tail|        |
      '--------'          '--------'

To avoid this, probably, we need to apply a spinlock to ensure
that PRQs are handled in a serialized way. But that means the
intel_svm_process_prq() will be called with a spinlock held.
This causes extra complexities in intel_svm_process_prq().

This aims to make PRQ descriptors to be handled in a serialized
way while remove the requirement of holding the spin lock in
intel_svm_process_prq() by saving the descriptors in a list.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 58 ++++++++++++++++++++++++++++++-------
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a1921b462783..05aeb8ea51c4 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -50,6 +50,8 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 		return ret;
 	}
 	iommu->pr_irq = irq;
+	INIT_LIST_HEAD(&iommu->prq_list);
+	spin_lock_init(&iommu->prq_lock);
 
 	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-prq", iommu->seq_id);
 
@@ -698,6 +700,14 @@ struct page_req_dsc {
 
 #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 
+struct page_req {
+	struct list_head list;
+	struct page_req_dsc desc;
+	unsigned int processing:1;
+	unsigned int drained:1;
+	unsigned int completed:1;
+};
+
 static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
 {
 	unsigned long requested = 0;
@@ -842,34 +852,60 @@ static void process_single_prq(struct intel_iommu *iommu,
 	}
 }
 
-static void intel_svm_process_prq(struct intel_iommu *iommu,
-				  struct page_req_dsc *prq,
-				  int head, int tail)
+static void intel_svm_process_prq(struct intel_iommu *iommu)
 {
-	struct page_req_dsc *req;
-
-	while (head != tail) {
-		req = &iommu->prq[head / sizeof(*req)];
-		process_single_prq(iommu, req);
-		head = (head + sizeof(*req)) & PRQ_RING_MASK;
+	struct page_req *req;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->prq_lock, flags);
+	while (!list_empty(&iommu->prq_list)) {
+		req = list_first_entry(&iommu->prq_list, struct page_req, list);
+		if (!req->processing) {
+			req->processing = true;
+			spin_unlock_irqrestore(&iommu->prq_lock, flags);
+			process_single_prq(iommu, &req->desc);
+			spin_lock_irqsave(&iommu->prq_lock, flags);
+			req->completed = true;
+		} else if (req->completed) {
+			list_del(&req->list);
+			kfree(req);
+		} else {
+			break;
+		}
 	}
+	spin_unlock_irqrestore(&iommu->prq_lock, flags);
 }
 
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
+	unsigned long flags;
 	int head, tail;
 
+	spin_lock_irqsave(&iommu->prq_lock, flags);
 	/*
 	 * Clear PPR bit before reading head/tail registers, to
 	 * ensure that we get a new interrupt if needed.
 	 */
 	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
-
 	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
 	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
-	intel_svm_process_prq(iommu, iommu->prq, head, tail);
+	while (head != tail) {
+		struct page_req_dsc *dsc;
+		struct page_req *req;
+
+		dsc = &iommu->prq[head / sizeof(*dsc)];
+		req = kzalloc(sizeof (*req), GFP_ATOMIC);
+		if (!req)
+			break;
+		req->desc = *dsc;
+		list_add_tail(&req->list, &iommu->prq_list);
+		head = (head + sizeof(*dsc)) & PRQ_RING_MASK;
+	}
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
+	spin_unlock_irqrestore(&iommu->prq_lock, flags);
+
+	intel_svm_process_prq(iommu);
 
 	return IRQ_RETVAL(1);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index cca1e5f9aeaa..80715a59491c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -590,6 +590,8 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct list_head prq_list;	/* pending page request list */
+	spinlock_t prq_lock;		/* protect above pending list */
 	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
