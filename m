Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB9BC433E0
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 08:58:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A161239A1
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 08:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A161239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F3E1586B2D;
	Thu, 14 Jan 2021 08:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WeAhBseLDsvC; Thu, 14 Jan 2021 08:58:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D2D886A91;
	Thu, 14 Jan 2021 08:58:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CFB7C0893;
	Thu, 14 Jan 2021 08:58:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62E8BC013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 08:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 39E168692F
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 08:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id engdJ1DnFBb3 for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 08:58:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 82D0B868D5
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 08:58:42 +0000 (UTC)
IronPort-SDR: kvLwA9Pla8IQ8yR5y3h+IUQ/2j+0Ofo3t+HdxRkphjndWKm9EpdBmZvX3Nadc144syE2OAh/uJ
 fpcExPcxaOxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="166005759"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; d="scan'208";a="166005759"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 00:58:37 -0800
IronPort-SDR: VDfZHKwFzx84YTFDConwZBa/HwsLp8PJtgdveSAV4AesjLfkptxoPYNUZFO3GswIxqBMPAr2br
 qlmpn5FxE5ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; d="scan'208";a="465189266"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2021 00:58:34 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu/vt-d: Consolidate duplicate cache invaliation code
Date: Thu, 14 Jan 2021 16:50:21 +0800
Message-Id: <20210114085021.717041-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The pasid based IOTLB and devTLB invalidation code is duplicate in
several places. Consolidate them by using the common helpers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 18 ++----------
 drivers/iommu/intel/svm.c   | 55 ++++++-------------------------------
 2 files changed, 11 insertions(+), 62 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b92af83b79bd..f26cb6195b2c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -456,20 +456,6 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
-static void
-iotlb_invalidation_with_pasid(struct intel_iommu *iommu, u16 did, u32 pasid)
-{
-	struct qi_desc desc;
-
-	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
-			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) | QI_EIOTLB_TYPE;
-	desc.qw1 = 0;
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(iommu, &desc, 1, 0);
-}
-
 static void
 devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 			       struct device *dev, u32 pasid)
@@ -514,7 +500,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		clflush_cache_range(pte, sizeof(*pte));
 
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-	iotlb_invalidation_with_pasid(iommu, did, pasid);
+	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
 
 	/* Device IOTLB doesn't need to be flushed in caching mode. */
 	if (!cap_caching_mode(iommu->cap))
@@ -530,7 +516,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 
 	if (cap_caching_mode(iommu->cap)) {
 		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		iotlb_invalidation_with_pasid(iommu, did, pasid);
+		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 18a9f05df407..033b25886e57 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -123,53 +123,16 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 				  unsigned long address,
 				  unsigned long pages, int ih)
 {
-	struct qi_desc desc;
+	struct device_domain_info *info = get_domain_info(sdev->dev);
 
-	if (pages == -1) {
-		desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
-			QI_EIOTLB_DID(sdev->did) |
-			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
-			QI_EIOTLB_TYPE;
-		desc.qw1 = 0;
-	} else {
-		int mask = ilog2(__roundup_pow_of_two(pages));
-
-		desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
-				QI_EIOTLB_DID(sdev->did) |
-				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
-				QI_EIOTLB_TYPE;
-		desc.qw1 = QI_EIOTLB_ADDR(address) |
-				QI_EIOTLB_IH(ih) |
-				QI_EIOTLB_AM(mask);
-	}
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-	qi_submit_sync(sdev->iommu, &desc, 1, 0);
-
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
-		qi_submit_sync(sdev->iommu, &desc, 1, 0);
-	}
+	if (WARN_ON(!pages))
+		return;
+
+	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
+	if (info->ats_enabled)
+		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
+					 svm->pasid, sdev->qdep, address,
+					 order_base_2(pages));
 }
 
 static void intel_flush_svm_range_dev(struct intel_svm *svm,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
