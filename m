Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDAFC3A59E
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 21:17:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A2C2332A
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 21:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A2C2332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 070A2D2E;
	Tue, 20 Aug 2019 21:17:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 982D8D1A
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 21:17:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1906A87
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 21:17:28 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 Aug 2019 14:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,410,1559545200"; d="scan'208";a="353738858"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga005.jf.intel.com with ESMTP; 20 Aug 2019 14:17:27 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] iommu/vt-d: remove global page flush support
Date: Tue, 20 Aug 2019 14:21:08 -0700
Message-Id: <1566336068-39416-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Raj Ashok <ashok.raj@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Global pages support is removed from VT-d spec 3.0. Since global pages G
flag only affects first-level paging structures and because DMA request
with PASID are only supported by VT-d spec. 3.0 and onward, we can
safely remove global pages support.

For kernel shared virtual address IOTLB invalidation, PASID
granularity and page selective within PASID will be used. There is
no global granularity supported. Without this fix, IOTLB invalidation
will cause invalid descriptor error in the queued invalidation (QI)
interface.

Reported-by:   Sanjay K Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 36 +++++++++++++++---------------------
 include/linux/intel-iommu.h |  3 ---
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index c6edef2..55f4128 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -101,24 +101,19 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
 }
 
 static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
-				       unsigned long address, unsigned long pages, int ih, int gl)
+				unsigned long address, unsigned long pages, int ih)
 {
 	struct qi_desc desc;
 
-	if (pages == -1) {
-		/* For global kernel pages we have to flush them in *all* PASIDs
-		 * because that's the only option the hardware gives us. Despite
-		 * the fact that they are actually only accessible through one. */
-		if (gl)
-			desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
-					QI_EIOTLB_DID(sdev->did) |
-					QI_EIOTLB_GRAN(QI_GRAN_ALL_ALL) |
-					QI_EIOTLB_TYPE;
-		else
-			desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
-					QI_EIOTLB_DID(sdev->did) |
-					QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
-					QI_EIOTLB_TYPE;
+	/*
+	 * Do PASID granu IOTLB invalidation if page selective capability is
+	 * not available.
+	 */
+	if (pages == -1 || !cap_pgsel_inv(svm->iommu->cap)) {
+		desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
+			QI_EIOTLB_DID(sdev->did) |
+			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
+			QI_EIOTLB_TYPE;
 		desc.qw1 = 0;
 	} else {
 		int mask = ilog2(__roundup_pow_of_two(pages));
@@ -128,7 +123,6 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
 				QI_EIOTLB_TYPE;
 		desc.qw1 = QI_EIOTLB_ADDR(address) |
-				QI_EIOTLB_GL(gl) |
 				QI_EIOTLB_IH(ih) |
 				QI_EIOTLB_AM(mask);
 	}
@@ -163,13 +157,13 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 }
 
 static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
-				  unsigned long pages, int ih, int gl)
+				unsigned long pages, int ih)
 {
 	struct intel_svm_dev *sdev;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list)
-		intel_flush_svm_range_dev(svm, sdev, address, pages, ih, gl);
+		intel_flush_svm_range_dev(svm, sdev, address, pages, ih);
 	rcu_read_unlock();
 }
 
@@ -181,7 +175,7 @@ static void intel_invalidate_range(struct mmu_notifier *mn,
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
 
 	intel_flush_svm_range(svm, start,
-			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0, 0);
+			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
 }
 
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -204,7 +198,7 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
 		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
-		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
+		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 	}
 	rcu_read_unlock();
 
@@ -612,7 +606,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			 * large and has to be physically contiguous. So it's
 			 * hard to be as defensive as we might like. */
 			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
-			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
+			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 682eafa1..f09813f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -350,7 +350,6 @@ enum {
 #define QI_PC_PASID_SEL		1
 
 #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
-#define QI_EIOTLB_GL(gl)	(((u64)gl) << 7)
 #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
 #define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
 #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
@@ -386,8 +385,6 @@ enum {
 #define QI_RESP_INVALID		0x1
 #define QI_RESP_FAILURE		0xf
 
-#define QI_GRAN_ALL_ALL			0
-#define QI_GRAN_NONG_ALL		1
 #define QI_GRAN_NONG_PASID		2
 #define QI_GRAN_PSI_PASID		3
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
