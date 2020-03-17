Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E54BC5ACC0
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE3320719
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE3320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4C7F188300;
	Tue, 17 Mar 2020 07:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1BZvdwvWaui; Tue, 17 Mar 2020 07:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9DC09882F5;
	Tue, 17 Mar 2020 07:05:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82595C18DA;
	Tue, 17 Mar 2020 07:05:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94359C013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7C31388B38
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dW7X7DBrVhXw for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 07:05:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9291288B10
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:28 +0000 (UTC)
IronPort-SDR: mzUSUMIRuHKEnbmMFM+yoyYUr9HnUEO9XHEwMKYXsh++tem9rVktkJUgtszzrwpQbkn6GMmY41
 5ZS2BDfHDRMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 00:05:28 -0700
IronPort-SDR: Du6KI+jVJxW8i0JEH2B5QN2MxBjOTS3IucnyWHyVlhTQqGr5Sy9dLktw8bDHvwip2cs0QoN44g
 Jrwj3+FAq+VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; d="scan'208";a="267867354"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 00:05:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 4/5] iommu/vt-d: Refactor prq_event_thread()
Date: Tue, 17 Mar 2020 15:02:28 +0800
Message-Id: <20200317070229.21131-5-baolu.lu@linux.intel.com>
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

Move the software processing page request descriptors part from
prq_event_thread() into a separated function. No any functional
changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 43 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 6183016f4269..6ce96dd541a6 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -517,27 +517,21 @@ static bool is_canonical_address(u64 addr)
 	return (((saddr << shift) >> shift) == saddr);
 }
 
-static irqreturn_t prq_event_thread(int irq, void *d)
+static int intel_svm_process_prq(struct intel_iommu *iommu,
+				 struct page_req_dsc *prq,
+				 int head, int tail)
 {
-	struct intel_iommu *iommu = d;
 	struct intel_svm *svm = NULL;
-	int head, tail, handled = 0;
-
-	/* Clear PPR bit before reading head/tail registers, to
-	 * ensure that we get a new interrupt if needed. */
-	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
+	struct intel_svm_dev *sdev;
+	struct vm_area_struct *vma;
+	struct page_req_dsc *req;
+	struct qi_desc resp;
+	int handled = 0;
+	vm_fault_t ret;
+	u64 address;
+	int result;
 
-	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
 	while (head != tail) {
-		struct intel_svm_dev *sdev;
-		struct vm_area_struct *vma;
-		struct page_req_dsc *req;
-		struct qi_desc resp;
-		int result;
-		vm_fault_t ret;
-		u64 address;
-
 		handled = 1;
 
 		req = &iommu->prq[head / sizeof(*req)];
@@ -649,6 +643,21 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
+	return handled;
+}
+
+static irqreturn_t prq_event_thread(int irq, void *d)
+{
+	struct intel_iommu *iommu = d;
+	int head, tail, handled;
+
+	/* Clear PPR bit before reading head/tail registers, to
+	 * ensure that we get a new interrupt if needed. */
+	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
+
+	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	handled = intel_svm_process_prq(iommu, iommu->prq, head, tail);
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
 
 	return IRQ_RETVAL(handled);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
