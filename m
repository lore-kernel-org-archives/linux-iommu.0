Return-Path: <SRS0=RRah=66=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2435DC433E1
	for <iommu@archiver.kernel.org>; Sat, 16 May 2020 06:25:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F158F20767
	for <iommu@archiver.kernel.org>; Sat, 16 May 2020 06:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F158F20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD0AB88291;
	Sat, 16 May 2020 06:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w8czJxj8waLN; Sat, 16 May 2020 06:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BE81887E3D;
	Sat, 16 May 2020 06:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAAE7C0893;
	Sat, 16 May 2020 06:25:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A852C016F
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ED6148826A
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l8fY2xbq478r for <iommu@lists.linux-foundation.org>;
 Sat, 16 May 2020 06:24:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2242988281
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:24:59 +0000 (UTC)
IronPort-SDR: LHIA4WjLkaqiWrKOWQSNDi17vO2qSr0JyiLOAk0K/05Guz1KEWCLH2W36MPJiFR6PBBxTSHGLv
 c/a2ThO/S6hw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 23:24:58 -0700
IronPort-SDR: tCbT2+Q4RUVxk3aucp7VSsNEAwRH1Zx2WcxXD4JzJWqV/UmxiC72XBPgPuxBaEmRozU4BdXI9q
 N4oaEFTFAxqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; d="scan'208";a="281442455"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga002.jf.intel.com with ESMTP; 15 May 2020 23:24:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 14/18] iommu/vt-d: Disable non-recoverable fault processing
 before unbind
Date: Sat, 16 May 2020 14:20:57 +0800
Message-Id: <20200516062101.29541-15-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200516062101.29541-1-baolu.lu@linux.intel.com>
References: <20200516062101.29541-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>
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
IOMMU should tolerate and ignore the non-recoverable faults caused by the
untranslated requests from this device.

For example, when an exception happens, the process terminates before the
device driver stops DMA and call IOMMU driver to unbind PASID. The flow
of process exist is as follows:

do_exit() {
     exit_mm() {
             mm_put();
             exit_mmap() {
                     intel_invalidate_range() //mmu notifier
                     tlb_finish_mmu()
                     mmu_notifier_release(mm) {
                             intel_iommu_release() {
[2]                                  intel_iommu_teardown_pasid();
                                     intel_iommu_flush_tlbs();
                             }
                     }
                     unmap_vmas();
                     free_pgtables();
             };
     }
     exit_files(tsk) {
             close_files() {
                     dsa_close();
[1]                  dsa_stop_dma();
                     intel_svm_unbind_pasid();
             }
     }
}

Care must be taken on VT-d to avoid unrecoverable faults between the time
window of [1] and [2]. [Process exist flow was contributed by Jacob Pan.]

Intel VT-d provides such function through the FPD bit of the PASID entry.
This sets FPD bit when PASID entry is changing from present to nonpresent
in the mm notifier and will clear it when the pasid is unbound.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |  4 ++--
 drivers/iommu/intel-pasid.c | 26 +++++++++++++++++++++-----
 drivers/iommu/intel-pasid.h |  4 +++-
 drivers/iommu/intel-svm.c   |  9 ++++++---
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7d28ef2e6fe2..3c5cc3424e90 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5005,7 +5005,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	if (info->dev) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, info->dev,
-					PASID_RID2PASID);
+					PASID_RID2PASID, false);
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(iommu, info->dev);
@@ -5234,7 +5234,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
 	auxiliary_unlink_device(domain, dev);
 
 	spin_lock(&iommu->lock);
-	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
+	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid, false);
 	domain_detach_iommu(domain, iommu);
 	spin_unlock(&iommu->lock);
 
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 45e9b5b291bc..25d749830500 100644
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
+intel_pasid_clear_entry(struct device *dev, int pasid, bool fault_ignore)
 {
 	struct pasid_entry *pe;
 
@@ -300,7 +313,10 @@ static void intel_pasid_clear_entry(struct device *dev, int pasid)
 	if (WARN_ON(!pe))
 		return;
 
-	pasid_clear_entry(pe);
+	if (fault_ignore && pasid_pte_is_present(pe))
+		pasid_clear_entry_with_fpd(pe);
+	else
+		pasid_clear_entry(pe);
 }
 
 static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
@@ -473,8 +489,8 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 }
 
-void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
-				 struct device *dev, int pasid)
+void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
+				 int pasid, bool fault_ignore)
 {
 	struct pasid_entry *pte;
 	u16 did;
@@ -484,7 +500,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 		return;
 
 	did = pasid_get_domain_id(pte);
-	intel_pasid_clear_entry(dev, pasid);
+	intel_pasid_clear_entry(dev, pasid, fault_ignore);
 
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index a41b09b3ffde..c5318d40e0fa 100644
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
@@ -120,7 +121,8 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu,
 			     struct iommu_gpasid_bind_data_vtd *pasid_data,
 			     struct dmar_domain *domain, int addr_width);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
-				 struct device *dev, int pasid);
+				 struct device *dev, int pasid,
+				 bool fault_ignore);
 int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
 void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 5133b2d4428f..960a3610e852 100644
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
@@ -396,7 +397,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 			sdev->users--;
 		if (!sdev->users) {
 			list_del_rcu(&sdev->list);
-			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_pasid_tear_down_entry(iommu, dev,
+						    svm->pasid, false);
 			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			/* TODO: Drain in flight PRQ for the PASID since it
 			 * may get reused soon, we don't want to
@@ -639,7 +641,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
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
