Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2AEC432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF45206B6
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF45206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 63B528819C;
	Fri, 22 Nov 2019 03:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1lKWAeE3EwT3; Fri, 22 Nov 2019 03:08:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 58BFF8819D;
	Fri, 22 Nov 2019 03:08:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43B4FC1DD8;
	Fri, 22 Nov 2019 03:08:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFEABC18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 996C487247
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J-N8IYllGozF for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 03:08:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DC32E871EB
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:30 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 19:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; d="scan'208";a="232540462"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2019 19:08:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 5/5] iommu/vt-d: Consolidate pasid-based device tlb
 invalidation
Date: Fri, 22 Nov 2019 11:04:49 +0800
Message-Id: <20191122030449.28892-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122030449.28892-1-baolu.lu@linux.intel.com>
References: <20191122030449.28892-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

Merge pasid-based device tlb invalidation into iommu->flush.p_dev_tlb_inv.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 41 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-svm.c   | 33 ++++++-----------------------
 2 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fec78cc877c1..dd16d466320f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3074,6 +3074,46 @@ qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 	qi_submit_sync(&desc, iommu);
 }
 
+/* PASID-based device TLB invalidation */
+static void
+qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+		    u32 pasid, u16 qdep, u64 address, unsigned long npages)
+{
+	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
+
+	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
+			QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
+			QI_DEV_IOTLB_PFSID(pfsid);
+
+	/*
+	 * npages == -1 means a PASID-selective invalidation, otherwise,
+	 * a positive value for Page-selective-within-PASID invalidation.
+	 * 0 is not a valid input.
+	 */
+	if (WARN_ON(!npages)) {
+		pr_err("Invalid input npages = %ld\n", npages);
+		return;
+	}
+
+	if (npages == -1) {
+		desc.qw1 = QI_DEV_EIOTLB_ADDR(((u64)-1) >> 1) |
+				QI_DEV_EIOTLB_SIZE;
+	} else if (npages > 1) {
+		/* The least significant zero bit indicates the size. So,
+		 * for example, an "address" value of 0x12345f000 will
+		 * flush from 0x123440000 to 0x12347ffff (256KiB). */
+		unsigned long last = address + ((unsigned long)(npages - 1) << VTD_PAGE_SHIFT);
+		unsigned long mask = __rounddown_pow_of_two(address ^ last);
+
+		desc.qw1 = QI_DEV_EIOTLB_ADDR((address & ~mask) |
+				(mask - 1)) | QI_DEV_EIOTLB_SIZE;
+	} else {
+		desc.qw1 = QI_DEV_EIOTLB_ADDR(address);
+	}
+
+	qi_submit_sync(&desc, iommu);
+}
+
 static void intel_iommu_init_qi(struct intel_iommu *iommu)
 {
 	/*
@@ -3108,6 +3148,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 		iommu->flush.pc_inv = qi_flush_pasid;
 		iommu->flush.dev_tlb_inv = qi_flush_dev_iotlb;
 		iommu->flush.p_iotlb_inv = qi_flush_piotlb;
+		iommu->flush.p_dev_tlb_inv = qi_flush_dev_piotlb;
 		pr_info("%s: Using Queued invalidation\n", iommu->name);
 	}
 }
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 02c6b14f0568..b6b22989eb46 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -114,39 +114,18 @@ void intel_svm_check(struct intel_iommu *iommu)
 	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
 }
 
-static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
-				unsigned long address, unsigned long pages, int ih)
+static void
+intel_flush_svm_range_dev(struct intel_svm *svm, struct intel_svm_dev *sdev,
+			  unsigned long address, unsigned long pages, int ih)
 {
-	struct qi_desc desc;
 	struct intel_iommu *iommu = svm->iommu;
 
 	iommu->flush.p_iotlb_inv(iommu, sdev->did,
 				 svm->pasid, address, pages, ih);
 
-	if (sdev->dev_iotlb) {
-		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |
-				QI_DEV_EIOTLB_SID(sdev->sid) |
-				QI_DEV_EIOTLB_QDEP(sdev->qdep) |
-				QI_DEIOTLB_TYPE;
-		if (pages == -1) {
-			desc.qw1 = QI_DEV_EIOTLB_ADDR(-1ULL >> 1) |
-					QI_DEV_EIOTLB_SIZE;
-		} else if (pages > 1) {
-			/* The least significant zero bit indicates the size. So,
-			 * for example, an "address" value of 0x12345f000 will
-			 * flush from 0x123440000 to 0x12347ffff (256KiB). */
-			unsigned long last = address + ((unsigned long)(pages - 1) << VTD_PAGE_SHIFT);
-			unsigned long mask = __rounddown_pow_of_two(address ^ last);
-
-			desc.qw1 = QI_DEV_EIOTLB_ADDR((address & ~mask) |
-					(mask - 1)) | QI_DEV_EIOTLB_SIZE;
-		} else {
-			desc.qw1 = QI_DEV_EIOTLB_ADDR(address);
-		}
-		desc.qw2 = 0;
-		desc.qw3 = 0;
-		qi_submit_sync(&desc, svm->iommu);
-	}
+	if (sdev->dev_iotlb)
+		iommu->flush.p_dev_tlb_inv(iommu, sdev->sid, 0, svm->pasid,
+					   sdev->qdep, address, pages);
 }
 
 static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
