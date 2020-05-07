Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2B6C47257
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 00:59:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9939720708
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 00:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9939720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 628812045A;
	Thu,  7 May 2020 00:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8knTPidKUtu; Thu,  7 May 2020 00:59:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 24B0820460;
	Thu,  7 May 2020 00:59:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1158EC0863;
	Thu,  7 May 2020 00:59:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2021C0859
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 00:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9FE2220476
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 00:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TLE4h7a7gnsb for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 00:59:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id 931CD20465
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 00:59:09 +0000 (UTC)
IronPort-SDR: sKGh5Sv5Q+zz9jUs+y4WroEVZaR0bBQpNd/tc4vawQ5bol/dYWMmsPlyy7PJCmKMIZ+iY9cvT7
 jysrIA0T69jg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2020 17:59:09 -0700
IronPort-SDR: S2CGhkIFWXmZk2g3lDg59oHp62/Drkhj0pX4RewaRa8wr43xF1DQS7iPiye5maRFI9mTpJsOSK
 mmYkYv01bh4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; d="scan'208";a="407461806"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga004.jf.intel.com with ESMTP; 06 May 2020 17:59:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault processing
 before unbind
Date: Thu,  7 May 2020 08:55:32 +0800
Message-Id: <20200507005534.3080-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507005534.3080-1-baolu.lu@linux.intel.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
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

When a PASID is used for SVA by the device, it's possible that the PASID
entry is cleared before the device flushes all ongoing DMA requests. The
IOMMU should ignore the non-recoverable faults caused by these requests.
Intel VT-d provides such function through the FPD bit of the PASID entry.
This sets FPD bit when PASID entry is cleared in the mm notifier and
clear it when the pasid is unbound.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |  4 ++--
 drivers/iommu/intel-pasid.c | 26 +++++++++++++++++++++-----
 drivers/iommu/intel-pasid.h |  3 ++-
 drivers/iommu/intel-svm.c   |  9 ++++++---
 4 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d1866c0905b1..7811422b5a68 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5352,7 +5352,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	if (info->dev) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, info->dev,
-					PASID_RID2PASID);
+					PASID_RID2PASID, false);
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(iommu, info->dev);
@@ -5587,7 +5587,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
 	auxiliary_unlink_device(domain, dev);
 
 	spin_lock(&iommu->lock);
-	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
+	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid, false);
 	domain_detach_iommu(domain, iommu);
 	spin_unlock(&iommu->lock);
 
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 7969e3dac2ad..11aef6c12972 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -292,7 +292,20 @@ static inline void pasid_clear_entry(struct pasid_entry *pe)
 	WRITE_ONCE(pe->val[7], 0);
 }
 
-static void intel_pasid_clear_entry(struct device *dev, int pasid)
+static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
+{
+	WRITE_ONCE(pe->val[0], PASID_PTE_FPD);
+	WRITE_ONCE(pe->val[1], 0);
+	WRITE_ONCE(pe->val[2], 0);
+	WRITE_ONCE(pe->val[3], 0);
+	WRITE_ONCE(pe->val[4], 0);
+	WRITE_ONCE(pe->val[5], 0);
+	WRITE_ONCE(pe->val[6], 0);
+	WRITE_ONCE(pe->val[7], 0);
+}
+
+static void
+intel_pasid_clear_entry(struct device *dev, int pasid, bool pf_ignore)
 {
 	struct pasid_entry *pe;
 
@@ -300,7 +313,10 @@ static void intel_pasid_clear_entry(struct device *dev, int pasid)
 	if (WARN_ON(!pe))
 		return;
 
-	pasid_clear_entry(pe);
+	if (pf_ignore)
+		pasid_clear_entry_with_fpd(pe);
+	else
+		pasid_clear_entry(pe);
 }
 
 static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
@@ -533,8 +549,8 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 }
 
-void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
-				 struct device *dev, int pasid)
+void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
+				 int pasid, bool pf_ignore)
 {
 	struct pasid_entry *pte;
 	u16 did;
@@ -544,7 +560,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 		return;
 
 	did = pasid_get_domain_id(pte);
-	intel_pasid_clear_entry(dev, pasid);
+	intel_pasid_clear_entry(dev, pasid, pf_ignore);
 
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index a41b09b3ffde..e6dd95ffe381 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -15,6 +15,7 @@
 #define PASID_MAX			0x100000
 #define PASID_PTE_MASK			0x3F
 #define PASID_PTE_PRESENT		1
+#define PASID_PTE_FPD			2
 #define PDE_PFN_MASK			PAGE_MASK
 #define PASID_PDE_SHIFT			6
 #define MAX_NR_PASID_BITS		20
@@ -120,7 +121,7 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu,
 			     struct iommu_gpasid_bind_data_vtd *pasid_data,
 			     struct dmar_domain *domain, int addr_width);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
-				 struct device *dev, int pasid);
+				 struct device *dev, int pasid, bool pf_ignore);
 int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
 void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 83dc4319f661..9561ba59a170 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -207,7 +207,8 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
-		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
+		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
+					    svm->pasid, true);
 		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 	}
 	rcu_read_unlock();
@@ -400,7 +401,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 		sdev->users--;
 		if (!sdev->users) {
 			list_del_rcu(&sdev->list);
-			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_pasid_tear_down_entry(iommu, dev,
+						    svm->pasid, false);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			/* TODO: Drain in flight PRQ for the PASID since it
 			 * may get reused soon, we don't want to
@@ -643,7 +645,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			 * to use. We have a *shared* PASID table, because it's
 			 * large and has to be physically contiguous. So it's
 			 * hard to be as defensive as we might like. */
-			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_pasid_tear_down_entry(iommu, dev,
+						    svm->pasid, false);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
