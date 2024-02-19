Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CE3307C
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347483; cv=none; b=VHf+875bxvHyHb54luze+2aMixREPEsNTDsejKjZctvJbm4Bmnsm2KraGlLArAfhgaRBG8mpPOXlxlyIBe3kyeJJBib4Qo+VulXfXz4uv5+8T+Md2VJWZ48gR8bHDkvK8CjzfGydWa21NBzLZDxn0Bw5M+SqCQpUqyYv7jbmb7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347483; c=relaxed/simple;
	bh=9df1Wc/QPv8JKRna5EyaMOIxCaEobk3ZwNEqaEJkrmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jx73muAip36IFS/UCxDouRDjLJa66vhg4V0weYmu2BufSJXmoW4mJ0wRMztQy3QdoxmKMD5AGX8uakzOe6jwYDs+m31vkkht2dPGHm/z4sK6PMwJef1Gjdc7JJF+izpWddnfHhIdds7Fl8VpWAA5m5h8tySkFIXX1pAQ2Cjq9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsOiYIkZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsOiYIkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347482; x=1739883482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9df1Wc/QPv8JKRna5EyaMOIxCaEobk3ZwNEqaEJkrmk=;
  b=RsOiYIkZRfwD2jUvyi8wa9gq6aTTBWQdf5VXlnX4+QzkeRXR06GRJARm
   y2XuF6ZZNAF0VnzyTji+4KRgs1FFniGr+aZRANaTchxI4BGo8Io7IZp1N
   3ub95GEh2hynh69vucV/riqQQIQ/h7S8keYBbHMsjRoVszOPa1Vxnz2jM
   tY3m0b5vmEZhpjuoyZ8r0ify7IUHLscSduVwkEg032yWCy0DLEO1G56lg
   9o7T5RJpRPasEIDqr508JORD9Geubw+IXsNM38VPtQNxjzwbD4pxklRaS
   tg6fwNV/vXT4kWkqPTidxWZ1rZ58zfn4IVrHsqin+WTRnmIbh6dUO2T+X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296478"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296478"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:58:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449316"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:59 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>,
	Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [PATCH v2 13/13] iommu/vt-d: Remove superfluous IOMMU IOTLB invalidations
Date: Mon, 19 Feb 2024 20:57:23 +0800
Message-Id: <20240219125723.1645703-14-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219125723.1645703-1-tina.zhang@intel.com>
References: <20240219125723.1645703-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/iommu/intel/svm.c | 70 +++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 38e9ff95029a..0c4c0e4011d2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -135,31 +135,40 @@ void intel_svm_check(struct intel_iommu *iommu)
 	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
 }
 
-static void __flush_svm_range_dev(struct dmar_domain *domain,
-				  struct dev_pasid_info *dev_pasid,
+static void __flush_svm_range(struct dmar_domain *domain,
 				  unsigned long address,
 				  unsigned long pages, int ih)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev_pasid->dev);
+	struct device_domain_info *dev_info;
+	struct intel_iommu *iommu = NULL;
+	struct dev_pasid_info *dev_pasid;
 	u32 pasid = mm_get_enqcmd_pasid(domain->domain.mm);
 
 	if (WARN_ON(!pages))
 		return;
 
-	qi_flush_piotlb(info->iommu, FLPT_DEFAULT_DID, pasid, address, pages, ih);
-	if (info->ats_enabled) {
-		qi_flush_dev_iotlb_pasid(info->iommu, dev_pasid->sid, info->pfsid,
-					 pasid, dev_pasid->qdep, address,
-					 order_base_2(pages));
-		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
-					  pasid, dev_pasid->qdep);
+	rcu_read_lock();
+	list_for_each_entry_rcu(dev_pasid, &domain->dev_pasids, link_domain) {
+		dev_info = dev_iommu_priv_get(dev_pasid->dev);
+		if (iommu != dev_info->iommu) {
+			iommu = dev_info->iommu;
+			qi_flush_piotlb(iommu, FLPT_DEFAULT_DID,
+					pasid, address, pages, ih);
+		}
+
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
+static void intel_flush_svm_range(struct dmar_domain *domain, unsigned long address,
+				unsigned long pages, int ih)
 {
 	unsigned long shift = ilog2(__roundup_pow_of_two(pages));
 	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
@@ -167,37 +176,32 @@ static void intel_flush_svm_range_dev(struct dmar_domain *domain,
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
-	struct device_domain_info *info;
-	struct dev_pasid_info *dev_pasid = NULL;
+	struct device_domain_info *dev_info;
+	struct intel_iommu *iommu = NULL;
+	struct dev_pasid_info *dev_pasid;
 	u32 pasid = mm_get_enqcmd_pasid(domain->domain.mm);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(dev_pasid, &domain->dev_pasids, link_domain) {
-		info = dev_iommu_priv_get(dev_pasid->dev);
-		qi_flush_piotlb(info->iommu, FLPT_DEFAULT_DID, pasid, 0, -1UL, 0);
-		if (info->ats_enabled) {
-			qi_flush_dev_iotlb_pasid(info->iommu, dev_pasid->sid, info->pfsid,
+		dev_info = dev_iommu_priv_get(dev_pasid->dev);
+		if (iommu != dev_info->iommu) {
+			iommu = dev_info->iommu;
+			qi_flush_piotlb(iommu, FLPT_DEFAULT_DID,
+					pasid, 0, -1UL, 0);
+		}
+
+		if (dev_info->ats_enabled) {
+			qi_flush_dev_iotlb_pasid(dev_info->iommu, dev_pasid->sid, dev_info->pfsid,
 						 pasid, dev_pasid->qdep,
 						 0, 64 - VTD_PAGE_SHIFT);
-			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
+			quirk_extra_dev_tlb_flush(dev_info, 0, 64 - VTD_PAGE_SHIFT,
 						  pasid, dev_pasid->qdep);
 		}
 	}
-- 
2.34.1

