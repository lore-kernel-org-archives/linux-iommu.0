Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AB0C2D0D2
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 03:17:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D0C2465E
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 03:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D0C2465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 369418852D;
	Thu, 19 Dec 2019 03:17:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0T0OQkZNDCby; Thu, 19 Dec 2019 03:17:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 349998857C;
	Thu, 19 Dec 2019 03:17:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21DC1C1AE8;
	Thu, 19 Dec 2019 03:17:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D020C077D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 03:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4C5D885F6D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 03:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xfiJcaP-COri for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 03:17:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8AADF85CE0
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 03:17:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 19:17:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="222160422"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2019 19:17:43 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v4 5/7] iommu/vt-d: Flush PASID-based iotlb for iova over
 first level
Date: Thu, 19 Dec 2019 11:16:32 +0800
Message-Id: <20191219031634.15168-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219031634.15168-1-baolu.lu@linux.intel.com>
References: <20191219031634.15168-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com
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

When software has changed first-level tables, it should invalidate
the affected IOTLB and the paging-structure-caches using the PASID-
based-IOTLB Invalidate Descriptor defined in spec 6.5.2.4.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c        | 41 +++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c | 56 +++++++++++++++++++++++++++----------
 include/linux/intel-iommu.h |  2 ++
 3 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 3acfa6a25fa2..fb30d5053664 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1371,6 +1371,47 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	qi_submit_sync(&desc, iommu);
 }
 
+/* PASID-based IOTLB invalidation */
+void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
+		     unsigned long npages, bool ih)
+{
+	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
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
+		desc.qw0 = QI_EIOTLB_PASID(pasid) |
+				QI_EIOTLB_DID(did) |
+				QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
+				QI_EIOTLB_TYPE;
+		desc.qw1 = 0;
+	} else {
+		int mask = ilog2(__roundup_pow_of_two(npages));
+		unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
+
+		if (WARN_ON_ONCE(!ALIGN(addr, align)))
+			addr &= ~(align - 1);
+
+		desc.qw0 = QI_EIOTLB_PASID(pasid) |
+				QI_EIOTLB_DID(did) |
+				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
+				QI_EIOTLB_TYPE;
+		desc.qw1 = QI_EIOTLB_ADDR(addr) |
+				QI_EIOTLB_IH(ih) |
+				QI_EIOTLB_AM(mask);
+	}
+
+	qi_submit_sync(&desc, iommu);
+}
+
 /*
  * Disable Queued Invalidation interface.
  */
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f0813997dea2..57ca1d2f0e55 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1507,6 +1507,20 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
+static void domain_flush_piotlb(struct intel_iommu *iommu,
+				struct dmar_domain *domain,
+				u64 addr, unsigned long npages, bool ih)
+{
+	u16 did = domain->iommu_did[iommu->seq_id];
+
+	if (domain->default_pasid)
+		qi_flush_piotlb(iommu, did, domain->default_pasid,
+				addr, npages, ih);
+
+	if (!list_empty(&domain->devices))
+		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, npages, ih);
+}
+
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  struct dmar_domain *domain,
 				  unsigned long pfn, unsigned int pages,
@@ -1520,18 +1534,23 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 
 	if (ih)
 		ih = 1 << 6;
-	/*
-	 * Fallback to domain selective flush if no PSI support or the size is
-	 * too big.
-	 * PSI requires page size to be 2 ^ x, and the base address is naturally
-	 * aligned to the size
-	 */
-	if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu->cap))
-		iommu->flush.flush_iotlb(iommu, did, 0, 0,
-						DMA_TLB_DSI_FLUSH);
-	else
-		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
-						DMA_TLB_PSI_FLUSH);
+
+	if (domain_use_first_level(domain)) {
+		domain_flush_piotlb(iommu, domain, addr, pages, ih);
+	} else {
+		/*
+		 * Fallback to domain selective flush if no PSI support or
+		 * the size is too big. PSI requires page size to be 2 ^ x,
+		 * and the base address is naturally aligned to the size.
+		 */
+		if (!cap_pgsel_inv(iommu->cap) ||
+		    mask > cap_max_amask_val(iommu->cap))
+			iommu->flush.flush_iotlb(iommu, did, 0, 0,
+							DMA_TLB_DSI_FLUSH);
+		else
+			iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
+							DMA_TLB_PSI_FLUSH);
+	}
 
 	/*
 	 * In caching mode, changes of pages from non-present to present require
@@ -1546,8 +1565,11 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 					struct dmar_domain *domain,
 					unsigned long pfn, unsigned int pages)
 {
-	/* It's a non-present to present mapping. Only flush if caching mode */
-	if (cap_caching_mode(iommu->cap))
+	/*
+	 * It's a non-present to present mapping. Only flush if caching mode
+	 * and second level.
+	 */
+	if (cap_caching_mode(iommu->cap) && !domain_use_first_level(domain))
 		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
@@ -1564,7 +1586,11 @@ static void iommu_flush_iova(struct iova_domain *iovad)
 		struct intel_iommu *iommu = g_iommus[idx];
 		u16 did = domain->iommu_did[iommu->seq_id];
 
-		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+		if (domain_use_first_level(domain))
+			domain_flush_piotlb(iommu, domain, 0, -1, 0);
+		else
+			iommu->flush.flush_iotlb(iommu, did, 0, 0,
+						 DMA_TLB_DSI_FLUSH);
 
 		if (!cap_caching_mode(iommu->cap))
 			iommu_flush_dev_iotlb(get_iommu_domain(iommu, did),
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 454c69712131..3a4708a8a414 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -650,6 +650,8 @@ extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 			  unsigned int size_order, u64 type);
 extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask);
+void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
+		     unsigned long npages, bool ih);
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
