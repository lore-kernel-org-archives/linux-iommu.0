Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DF3C18E5B
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AF120719
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AF120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 59EC08865E;
	Tue, 17 Mar 2020 07:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzX-st8qkj9R; Tue, 17 Mar 2020 07:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 466C5882F5;
	Tue, 17 Mar 2020 07:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FCD8C18DA;
	Tue, 17 Mar 2020 07:05:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 833AFC013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6BECA88B38
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3RPNFml7gT31 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 07:05:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 940C988B10
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:24 +0000 (UTC)
IronPort-SDR: UjgSfiyCF04SYF3gWNxIuHyhDSwW/xahgZSvGW4HqMm5w8Lxwtg3gnI1ytcdSpzmW6DKY2B+hI
 IVgXJHe7aDbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 00:05:24 -0700
IronPort-SDR: jcJ8xJ3PfNghQAJTLia7lHuCGWAMIZOycTG4anTFiTV79kEdUlsePFwUxjyFhkQCP67Oi9fpkj
 gS8kf6CG1phQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; d="scan'208";a="267867342"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 00:05:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/5] iommu/vt-d: Multiple descriptors per qi_submit_sync()
Date: Tue, 17 Mar 2020 15:02:27 +0800
Message-Id: <20200317070229.21131-4-baolu.lu@linux.intel.com>
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

Extend qi_submit_sync() function to support multiple descriptors.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c        | 30 +++++++++++++++++++-----------
 include/linux/intel-iommu.h |  1 +
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index dc9f9449907c..37910283022b 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1156,12 +1156,11 @@ static inline void reclaim_free_desc(struct q_inval *qi)
 	}
 }
 
-static int qi_check_fault(struct intel_iommu *iommu, int index)
+static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
 	int head, tail;
 	struct q_inval *qi = iommu->qi;
-	int wait_index = (index + 1) % QI_LENGTH;
 	int shift = qi_shift(iommu);
 
 	if (qi->desc_status[wait_index] == QI_ABORT)
@@ -1233,12 +1232,12 @@ static int qi_check_fault(struct intel_iommu *iommu, int index)
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		   unsigned int count, unsigned long options)
 {
-	int rc;
 	struct q_inval *qi = iommu->qi;
 	int offset, shift, length;
 	struct qi_desc wait_desc;
 	int wait_index, index;
 	unsigned long flags;
+	int rc, i;
 
 	if (!qi)
 		return 0;
@@ -1247,32 +1246,41 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	rc = 0;
 
 	raw_spin_lock_irqsave(&qi->q_lock, flags);
-	while (qi->free_cnt < 3) {
+	/*
+	 * Check if we have enough empty slots in the queue to submit,
+	 * the calculation is based on:
+	 * # of desc + 1 wait desc + 1 space between head and tail
+	 */
+	while (qi->free_cnt < count + 2) {
 		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
 		cpu_relax();
 		raw_spin_lock_irqsave(&qi->q_lock, flags);
 	}
 
 	index = qi->free_head;
-	wait_index = (index + 1) % QI_LENGTH;
+	wait_index = (index + count) % QI_LENGTH;
 	shift = qi_shift(iommu);
-	length = 1 << shift;
+	length = count << shift;
 
-	qi->desc_status[index] = qi->desc_status[wait_index] = QI_IN_USE;
+	/* Mark all desc and wait desc status in use */
+	for (i = 0; i < count + 1; i++)
+		qi->desc_status[(index + i) % QI_LENGTH] = QI_IN_USE;
 
 	offset = index << shift;
 	memcpy(qi->desc + offset, desc, length);
 	wait_desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
 			QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
+	if (options & QI_OPT_WAIT_DRAIN)
+		wait_desc.qw0 |= QI_IWD_PRQ_DRAIN;
 	wait_desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
 	wait_desc.qw2 = 0;
 	wait_desc.qw3 = 0;
 
 	offset = wait_index << shift;
-	memcpy(qi->desc + offset, &wait_desc, length);
+	memcpy(qi->desc + offset, &wait_desc, 1 << shift);
 
-	qi->free_head = (qi->free_head + 2) % QI_LENGTH;
-	qi->free_cnt -= 2;
+	qi->free_head = (qi->free_head + count + 1) % QI_LENGTH;
+	qi->free_cnt -= count + 1;
 
 	/*
 	 * update the HW tail register indicating the presence of
@@ -1288,7 +1296,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		 * a deadlock where the interrupt context can wait indefinitely
 		 * for free slots in the queue.
 		 */
-		rc = qi_check_fault(iommu, index);
+		rc = qi_check_fault(iommu, index, wait_index);
 		if (rc)
 			break;
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index e9190ffbd013..255b23f59a78 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -324,6 +324,7 @@ enum {
 
 #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
 #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
+#define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
 
 #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
 #define QI_IOTLB_DR(dr) 	(((u64)dr) << 7)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
