Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BC8BF9
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KyZ7DXs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697512900; x=1729048900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4nxTmLQvKKPzHqteeuuuNrIO9LndgZ0wCZAz7jCVpac=;
  b=KyZ7DXs/3xpqM9xf0AyqUF4aamNMQNPQLANDdY8v+qcT3wJTyZ8kvlys
   mEOMWA9ATz2GAhsHdrd21ezg8oaefYgcafs6pKysVcbANB5yHPm60IT9t
   gdxq+s7wA0YkgJWNQGYai0AlseIIMDRiMoe8Mxoxgyo5BmJjbiFgTmOFp
   LRlHn4xoOCWXVPo05pITVN0RlJ8OLJtJSAaUa7BLTU4e0oIQPWN7Uwi+6
   Z89+Hc3h161hgjCQ3c6RkNP4yaPdqXQiebM7L0i/ggyPxeEgkjsaun2qb
   gYHUsFxR6wUOBx0RA1/JEMl/Yi8aWJ5HDGbi9cGs57g0JPGa9u0s2xYZE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="389560908"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="389560908"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 20:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826270114"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826270114"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2023 20:21:38 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 12/12] iommu/vt-d: Remove superfluous IOMMU IOTLB invalidations
Date: Tue, 17 Oct 2023 11:20:45 +0800
Message-Id: <20231017032045.114868-14-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017032045.114868-1-tina.zhang@intel.com>
References: <20231017032045.114868-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices behind different IOMMUs can be bound to one sva domain. When a
range of a sva domain address is being invalidated, vt-d driver needs to
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

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 56 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c9a703935908..f684b92a1241 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -135,32 +135,41 @@ void intel_svm_check(struct intel_iommu *iommu)
 	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
 }
 
-static void __flush_svm_range_dev(struct dmar_domain *domain,
-				  struct dev_pasid_info *dev_pasid,
+static void __flush_svm_range(struct iommu_domain *domain,
 				  unsigned long address,
 				  unsigned long pages, int ih)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev_pasid->dev);
-	struct intel_iommu *iommu = dev_to_intel_iommu(dev_pasid->dev);
-	u32 pasid = mm_get_enqcmd_pasid(domain->domain.mm);
+	u32 pasid = mm_get_enqcmd_pasid(domain->mm);
+	struct device_domain_info *dev_info;
+	struct iommu_domain_info *iommu_info;
+	struct dev_pasid_info *dev_pasid;
+	struct intel_iommu *iommu;
+	unsigned long idx;
 
 	if (WARN_ON(!pages))
 		return;
 
-	qi_flush_piotlb(iommu, FLPT_DEFAULT_DID, pasid, address, pages, ih);
-	if (info->ats_enabled) {
-		qi_flush_dev_iotlb_pasid(iommu, dev_pasid->sid, info->pfsid,
-					 pasid, dev_pasid->qdep, address,
-					 order_base_2(pages));
-		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
-					  pasid, dev_pasid->qdep);
+	rcu_read_lock();
+	xa_for_each(&to_dmar_domain(domain)->iommu_array, idx, iommu_info)
+		qi_flush_piotlb(iommu_info->iommu, FLPT_DEFAULT_DID,
+				pasid, address, pages, ih);
+
+	list_for_each_entry_rcu(dev_pasid, &to_dmar_domain(domain)->dev_pasids, link_domain) {
+		dev_info = dev_iommu_priv_get(dev_pasid->dev);
+		iommu = dev_to_intel_iommu(dev_pasid->dev);
+		if (dev_info->ats_enabled) {
+			qi_flush_dev_iotlb_pasid(iommu, dev_pasid->sid, dev_info->pfsid,
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
@@ -168,22 +177,11 @@ static void intel_flush_svm_range_dev(struct dmar_domain *domain,
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
 /* Pages have been freed at this point */
 static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 					struct mm_struct *mm,
@@ -191,7 +189,7 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 {
 	struct iommu_domain *domain = container_of(mn, struct iommu_domain, notifier);
 
-	intel_flush_svm_range(to_dmar_domain(domain), start,
+	intel_flush_svm_range(domain, start,
 			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
 }
 
-- 
2.39.3

