Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5BAC432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFDC20679
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFDC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E7ADB25E6F;
	Fri, 22 Nov 2019 03:08:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VgFV-7QnJ1oZ; Fri, 22 Nov 2019 03:08:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E192F25E5B;
	Fri, 22 Nov 2019 03:08:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0160C1DD8;
	Fri, 22 Nov 2019 03:08:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A903AC18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8D33D870D2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1IIlymyUVllw for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 03:08:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DD6918709E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:26 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 19:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; d="scan'208";a="232540449"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2019 19:08:25 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/5] iommu/vt-d: Consolidate device tlb invalidation
Date: Fri, 22 Nov 2019 11:04:47 +0800
Message-Id: <20191122030449.28892-4-baolu.lu@linux.intel.com>
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

Merge device tlb invalidation into iommu->flush.dev_tlb_inv.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c        | 23 -----------------------
 drivers/iommu/intel-iommu.c | 31 +++++++++++++++++++++++++++++--
 drivers/iommu/intel-pasid.c |  3 ++-
 include/linux/intel-iommu.h |  2 --
 4 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 4b6090493f6d..8e26a36369ec 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1307,29 +1307,6 @@ void qi_global_iec(struct intel_iommu *iommu)
 	qi_submit_sync(&desc, iommu);
 }
 
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask)
-{
-	struct qi_desc desc;
-
-	if (mask) {
-		WARN_ON_ONCE(addr & ((1ULL << (VTD_PAGE_SHIFT + mask)) - 1));
-		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
-		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
-	} else
-		desc.qw1 = QI_DEV_IOTLB_ADDR(addr);
-
-	if (qdep >= QI_DEV_IOTLB_MAX_INVS)
-		qdep = 0;
-
-	desc.qw0 = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
-		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(&desc, iommu);
-}
-
 /*
  * Disable Queued Invalidation interface.
  */
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 283382584453..4eeb18942d3c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1465,6 +1465,7 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 {
 	u16 sid, qdep;
 	unsigned long flags;
+	struct intel_iommu *iommu;
 	struct device_domain_info *info;
 
 	if (!domain->has_iotlb_device)
@@ -1477,8 +1478,9 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
 		sid = info->bus << 8 | info->devfn;
 		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				qdep, addr, mask);
+		iommu = info->iommu;
+		iommu->flush.dev_tlb_inv(iommu, sid, info->pfsid,
+					 qdep, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
@@ -3006,6 +3008,30 @@ qi_flush_pasid(struct intel_iommu *iommu, u16 did, u32 pasid, u64 granu)
 	qi_submit_sync(&desc, iommu);
 }
 
+/* Device TLB invalidation */
+static void
+qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+		   u16 qdep, u64 addr, unsigned int mask)
+{
+	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
+
+	if (mask) {
+		WARN_ON_ONCE(addr & ((1ULL << (VTD_PAGE_SHIFT + mask)) - 1));
+		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
+		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
+	} else {
+		desc.qw1 = QI_DEV_IOTLB_ADDR(addr);
+	}
+
+	if (qdep >= QI_DEV_IOTLB_MAX_INVS)
+		qdep = 0;
+
+	desc.qw0 = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
+		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
+
+	qi_submit_sync(&desc, iommu);
+}
+
 static void intel_iommu_init_qi(struct intel_iommu *iommu)
 {
 	/*
@@ -3038,6 +3064,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 		iommu->flush.cc_inv = qi_flush_context;
 		iommu->flush.iotlb_inv = qi_flush_iotlb;
 		iommu->flush.pc_inv = qi_flush_pasid;
+		iommu->flush.dev_tlb_inv = qi_flush_dev_iotlb;
 		pr_info("%s: Using Queued invalidation\n", iommu->name);
 	}
 }
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index dd736f673603..01dd9c86178b 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -388,7 +388,8 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
 
-	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+	iommu->flush.dev_tlb_inv(iommu, sid, pfsid, qdep,
+				 0, 64 - VTD_PAGE_SHIFT);
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index c32ff2a7d958..326146a36dbf 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -665,8 +665,6 @@ extern void dmar_disable_qi(struct intel_iommu *iommu);
 extern int dmar_reenable_qi(struct intel_iommu *iommu);
 extern void qi_global_iec(struct intel_iommu *iommu);
 
-extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask);
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
