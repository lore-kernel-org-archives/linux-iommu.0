Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873F38CFE8
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395620; cv=none; b=pm4nsO91nWc3ymylz/pr65CTePSKgnront4AEI0C+RcoEUsBOKyQa8/nxhRp4jdrdRW68WRRbqKnlXKNAc1Mdd7V1h6PZLLjATXZHopGk2IZEyt2Nt7MKbAzTVHs3PfkciMIFmp7I4XjpPkkWyNF91/wUGdtqRrSHKJ2cwTtDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395620; c=relaxed/simple;
	bh=hbHaS7J7b5xUwceuLJQmLgoCfeU7RtqG8kTP0AyV7+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZ8piAHk7M6BWOYEI8bmpxuFAjXU7136gwglYh/CAuRh21H9XVQxwJ6Pasa+GnjrzbmCkj2QtKxgqzAFjB2Xt9O/L18TpuLipkRJ7MLJhHmMz46ziPUbYOcwS7c51tWLXbrD5rAkUHgH3JiKP2XM9BTEcOlr2lKZ/FSGeBy86aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yhrkjmI1; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yhrkjmI1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789395610; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=GWFdRchYZqBBGeQE8j64Vzh1eOeHRn4zPfZx1af+Rs8=;
	b=yhrkjmI1PX8/p8AYgmdtK4w27jf+zGZWRCz4TreW+/emfiGK+5NhIBmftq7Ii/ONHM3BRbgtycIKhlb7rSmGkyUD0NuGJPocblgJ8YQeQKixco2KJa1oQdwZs51WZcuPefawieOW5dyDD2SlDFF1ggPitil/qoJ7p20GrdqATbs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XAyJddP_1789395600;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XAyJddP_1789395600 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 22:20:09 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: baolu.lu@linux.intel.com
Cc: bikuan.zbk@alibaba-inc.com,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>
Subject: [PATCH v3] iommu/vt-d: Fix IQE handling to cover all descriptors in submission range
Date: Mon, 14 Sep 2026 22:19:58 +0800
Message-ID: <20260914141958.584919-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2c0d1b6d-6844-4413-b399-1000cc6712e4@linux.intel.com>
References: <2c0d1b6d-6844-4413-b399-1000cc6712e4@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When an Invalidation Queue Error (IQE) occurs, hardware halts fetching
and IQH points at the faulting descriptor. The previous code only
checked whether IQH matched the first descriptor index of the current
submission, missing faults on any other descriptor within the batch.

Expand the check to cover the entire submission range [index, wait_index],
accounting for circular wrap-around.

Furthermore, after detecting IQE, the old recovery only replaced the
single faulting slot with a copy of the wait descriptor and immediately
returned -EINVAL. This left two problems:

  a) Hardware resumed fetching and could hit another invalid descriptor
     in the same abandoned batch, raising a second IQE that no submitter
     would claim — permanently deadlocking the queue.

  b) The caller reclaimed all batch slots (QI_FREE) while hardware might
     still be asynchronously processing descriptors from that batch,
     allowing concurrent overwrite and descriptor corruption.

Fix both by introducing qi_drain_remaining_descs(): upon IQE detection,
overwrite the stranded slots in [IQH, wait_index) with no-op wait
descriptors, resubmit the wait descriptor at wait_index, then clear IQE.
The caller's existing poll loop naturally waits for QI_DONE — which per
VT-d spec §6.5.2.12 is only written after ALL preceding descriptors
complete — guaranteeing hardware has fully drained the batch before
slots are reclaimed.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Signed-off-by: bikuan.zbk <bikuan.zbk@alibaba-inc.com>
---
 drivers/iommu/intel/dmar.c | 78 ++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b08cd20..db92fb247131 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1344,6 +1344,43 @@ static void qi_dump_fault(struct intel_iommu *iommu, u32 fault)
 	       (unsigned long long)desc->qw1);
 }
 
+/**
+ * qi_drain_remaining_descs - drain descriptors stranded by an IQE
+ * @iommu: the affected IOMMU
+ * @wait_index: slot index of the wait descriptor of the current submission
+ * @shift: qi_shift(iommu), converts a slot index into a byte offset
+ * @options: QI_OPT_* flags of the current submission
+ *
+ * Overwrite the slots in [IQH, @wait_index) with no-op descriptors, resubmit
+ * the wait descriptor at @wait_index, and clear IQE so hardware resumes and
+ * eventually signals QI_DONE. Must be called with qi->q_lock held.
+ */
+static void qi_drain_remaining_descs(struct intel_iommu *iommu,
+				     int wait_index, int shift,
+				     unsigned long options)
+{
+	struct q_inval *qi = iommu->qi;
+	struct qi_desc desc;
+	int head_idx;
+	int cur;
+
+	head_idx = (readl(iommu->reg + DMAR_IQH_REG)) >> shift;
+
+	memset(&desc, 0, sizeof(desc));
+	desc.qw0 = QI_IWD_TYPE;
+	for (cur = head_idx; cur != wait_index; cur = (cur + 1) % QI_LENGTH)
+		memcpy(qi->desc + (cur << shift), &desc, 1 << shift);
+
+	desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
+			QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
+	if (options & QI_OPT_WAIT_DRAIN)
+		desc.qw0 |= QI_IWD_PRQ_DRAIN;
+	desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
+	memcpy(qi->desc + (wait_index << shift), &desc, 1 << shift);
+
+	writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
+}
+
 static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
@@ -1366,21 +1403,22 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 	 * is cleared.
 	 */
 	if (fault & DMA_FSTS_IQE) {
+		int head_idx;
+
 		head = readl(iommu->reg + DMAR_IQH_REG);
-		if ((head >> shift) == index) {
-			struct qi_desc *desc = qi->desc + head;
+		head_idx = head >> shift;
 
-			/*
-			 * desc->qw2 and desc->qw3 are either reserved or
-			 * used by software as private data. We won't print
-			 * out these two qw's for security consideration.
-			 */
-			memcpy(desc, qi->desc + (wait_index << shift),
-			       1 << shift);
-			writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
-			pr_info("Invalidation Queue Error (IQE) cleared\n");
+		/*
+		 * The faulting descriptor can be anywhere within the current
+		 * submission's range [index, wait_index]. Since the queue is
+		 * circular, this submission may wrap around QI_LENGTH
+		 * (index > wait_index in that case), so check both the
+		 * non-wrapped and wrapped cases of the range.
+		 */
+		if (index <= wait_index ?
+		    (head_idx >= index && head_idx <= wait_index) :
+		    (head_idx >= index || head_idx <= wait_index))
 			return -EINVAL;
-		}
 	}
 
 	/*
@@ -1452,7 +1490,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	int wait_index, index;
 	unsigned long flags;
 	int offset, shift;
-	int rc, i;
+	int rc = 0, fault, i;
 	u64 type;
 
 	if (!qi)
@@ -1528,9 +1566,19 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		 * a deadlock where the interrupt context can wait indefinitely
 		 * for free slots in the queue.
 		 */
-		rc = qi_check_fault(iommu, index, wait_index);
-		if (rc)
+		fault = qi_check_fault(iommu, index, wait_index);
+		if (fault == -EINVAL) {
+			/*
+			 * IQE in our batch: drain the remaining descriptors
+			 * and keep polling until hardware completes.
+			 */
+			qi_drain_remaining_descs(iommu, wait_index, shift,
+						  options);
+			rc = -EINVAL;
+		} else if (fault) {
+			rc = fault;
 			break;
+		}
 
 		raw_spin_unlock(&qi->q_lock);
 		cpu_relax();
-- 
2.43.7

