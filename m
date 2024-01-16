Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD72111A
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+ddEdFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367595; x=1736903595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FBnPWofDiRJtbWe00UWVf7l+EDe0aeln4nlHHk54hyk=;
  b=Q+ddEdFiztRLwGiXQHEOFRxsr6u1ytkK9o1qk4pimVHN0CfqDFty/dxB
   cFyONJYPXfn7lR/Ar5UfWcgVNbiyHm7ooe1nf8jliF++jLoQix3k7m9hm
   zCZgGja5V32oOoVKaKxa+sr8D+2Fcq9PO/JasAY7Hqu5saeV4pHEjBqsB
   ytURr5Yx0GpIDwguZMMPH23S7RmSSPOaWumMn/QDHupq63xyZjgfXGWLp
   Gl4mZKOP3Fji0+DCx8vZnoZiHYmLAB1TrilmIOYWPsdgdIwOuvQHbpw2m
   tbeiyqrcr2dJMqi+0/VqQJGWw7N6YPkl/9lobJYT6rodoTQWn2jpPTAmG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004469"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004469"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427466"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427466"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:13:12 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 11/11] iommu/vt-d: Remove superfluous IOMMU IOTLB invalidations
Date: Tue, 16 Jan 2024 09:11:46 +0800
Message-Id: <20240116011146.18645-12-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Devices behind different IOMMUs can be bound to one sva domain. When a
range of a sva domain address is being invalidated, VT-d driver needs to
issue IOMMU IOTLB and Dev-IOTLB invalidation commands to ask IOMMU
hardware and related devices to invalidate their caches.

The current logic issues both IOTLB invalidation command and device-TLB
command per device, which leads to superfluous IOTLB invalidation (e.g.,
if there are four devices behind a IOMMU are attached to one sva domain.
In the current logic, during handing intel_invalidate_range(), four IOTLB
invalidation commands and four Dev-IOTLB invalidation commands will be
issued. However, only one IOTLB invalidation command and four Dev-IOTLB
invalidation command are necessary.), and therefore impacts run-time
performance.

The patch removes the redundant IOMMU IOTLB invalidations by allowing
issuing IOMMU IOTLB invalidation command per iommu instead of per device.

Suggested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 53 ++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 79d1f3107847..bf4962eb229c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -134,31 +134,39 @@ void intel_svm_check(struct intel_iommu *iommu)
 	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
 }
 
-static void __flush_svm_range_dev(struct dmar_domain *domain,
-				  struct dev_pasid_info *dev_pasid,
+static void __flush_svm_range(struct iommu_domain *domain,
 				  unsigned long address,
 				  unsigned long pages, int ih)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev_pasid->dev);
-	u32 pasid = mm_get_enqcmd_pasid(domain->domain.mm);
+	u32 pasid = mm_get_enqcmd_pasid(domain->mm);
+	struct device_domain_info *dev_info;
+	struct iommu_domain_info *iommu_info;
+	struct dev_pasid_info *dev_pasid;
+	unsigned long idx;
 
 	if (WARN_ON(!pages))
 		return;
 
-	qi_flush_piotlb(info->iommu, dev_pasid->did, pasid, address, pages, ih);
-	if (info->ats_enabled) {
-		qi_flush_dev_iotlb_pasid(info->iommu, dev_pasid->sid, info->pfsid,
-					 pasid, dev_pasid->qdep, address,
-					 order_base_2(pages));
-		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
-					  pasid, dev_pasid->qdep);
+	rcu_read_lock();
+	xa_for_each(&to_dmar_domain(domain)->iommu_array, idx, iommu_info)
+		qi_flush_piotlb(iommu_info->iommu, dev_pasid->did,
+				pasid, address, pages, ih);
+
+	list_for_each_entry_rcu(dev_pasid, &to_dmar_domain(domain)->dev_pasids, link_domain) {
+		dev_info = dev_iommu_priv_get(dev_pasid->dev);
+		if (dev_info->ats_enabled) {
+			qi_flush_dev_iotlb_pasid(dev_info->iommu, dev_pasid->sid, dev_info->pfsid,
+						 pasid, dev_pasid->qdep, address,
+						 order_base_2(pages));
+			quirk_extra_dev_tlb_flush(dev_info, address, order_base_2(pages),
+						  pasid, dev_pasid->qdep);
+		}
 	}
+	rcu_read_unlock();
 }
 
-static void intel_flush_svm_range_dev(struct dmar_domain *domain,
-				      struct dev_pasid_info *dev_pasid,
-				      unsigned long address,
-				      unsigned long pages, int ih)
+static void intel_flush_svm_range(struct iommu_domain *domain, unsigned long address,
+				unsigned long pages, int ih)
 {
 	unsigned long shift = ilog2(__roundup_pow_of_two(pages));
 	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
@@ -166,22 +174,11 @@ static void intel_flush_svm_range_dev(struct dmar_domain *domain,
 	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
 
 	while (start < end) {
-		__flush_svm_range_dev(domain, dev_pasid, start, align >> VTD_PAGE_SHIFT, ih);
+		__flush_svm_range(domain, start, align >> VTD_PAGE_SHIFT, ih);
 		start += align;
 	}
 }
 
-static void intel_flush_svm_range(struct dmar_domain *domain, unsigned long address,
-				unsigned long pages, int ih)
-{
-	struct dev_pasid_info *dev_pasid;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(dev_pasid, &domain->dev_pasids, link_domain)
-		intel_flush_svm_range_dev(domain, dev_pasid, address, pages, ih);
-	rcu_read_unlock();
-}
-
 static void intel_flush_svm_all(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
@@ -216,7 +213,7 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 		return;
 	}
 
-	intel_flush_svm_range(domain, start,
+	intel_flush_svm_range(&domain->domain, start,
 			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
 }
 
-- 
2.39.3

