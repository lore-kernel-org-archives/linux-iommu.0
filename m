Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAE0C432C3
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593AD206B6
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593AD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 28F51870D2;
	Fri, 22 Nov 2019 03:08:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-TCIH4Vrs1V; Fri, 22 Nov 2019 03:08:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A56438709E;
	Fri, 22 Nov 2019 03:08:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90D85C1DD8;
	Fri, 22 Nov 2019 03:08:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB1C1C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C7A7F870D2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OgRLcM1e2bhs for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 03:08:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 112988709E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:25 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 19:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; d="scan'208";a="232540444"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2019 19:08:23 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/5] iommu/vt-d: Consolidate pasid cache invalidation
Date: Fri, 22 Nov 2019 11:04:46 +0800
Message-Id: <20191122030449.28892-3-baolu.lu@linux.intel.com>
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

Merge pasid cache invalidation into iommu->flush.pc_inv.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 13 +++++++++++++
 drivers/iommu/intel-pasid.c | 18 ++----------------
 include/linux/intel-iommu.h |  3 +++
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 59e4130161eb..283382584453 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2994,6 +2994,18 @@ qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	qi_submit_sync(&desc, iommu);
 }
 
+/* PASID cache invalidation */
+static void
+qi_flush_pasid(struct intel_iommu *iommu, u16 did, u32 pasid, u64 granu)
+{
+	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
+
+	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
+			QI_PC_GRAN(granu) | QI_PC_TYPE;
+
+	qi_submit_sync(&desc, iommu);
+}
+
 static void intel_iommu_init_qi(struct intel_iommu *iommu)
 {
 	/*
@@ -3025,6 +3037,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 	} else {
 		iommu->flush.cc_inv = qi_flush_context;
 		iommu->flush.iotlb_inv = qi_flush_iotlb;
+		iommu->flush.pc_inv = qi_flush_pasid;
 		pr_info("%s: Using Queued invalidation\n", iommu->name);
 	}
 }
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 3cb569e76642..dd736f673603 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -359,20 +359,6 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
 	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
 }
 
-static void
-pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
-				    u16 did, int pasid)
-{
-	struct qi_desc desc;
-
-	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
-	desc.qw1 = 0;
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(&desc, iommu);
-}
-
 static void
 iotlb_invalidation_with_pasid(struct intel_iommu *iommu, u16 did, u32 pasid)
 {
@@ -421,7 +407,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
 
-	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+	iommu->flush.pc_inv(iommu, did, pasid, QI_PC_GRAN_PSWD);
 	iotlb_invalidation_with_pasid(iommu, did, pasid);
 
 	/* Device IOTLB doesn't need to be flushed in caching mode. */
@@ -437,7 +423,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 		clflush_cache_range(pte, sizeof(*pte));
 
 	if (cap_caching_mode(iommu->cap)) {
-		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+		iommu->flush.pc_inv(iommu, did, pasid, QI_PC_GRAN_PSWD);
 		iotlb_invalidation_with_pasid(iommu, did, pasid);
 	} else {
 		iommu_flush_write_buffer(iommu);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ac725a4ce1c1..c32ff2a7d958 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -344,6 +344,9 @@ enum {
 #define QI_PC_PASID(pasid)	(((u64)pasid) << 32)
 #define QI_PC_DID(did)		(((u64)did) << 16)
 #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
+#define QI_PC_GRAN_DS		0
+#define QI_PC_GRAN_PSWD		1
+#define QI_PC_GRAN_GLOBAL	3
 
 #define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
 #define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
