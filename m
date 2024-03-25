Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64614AD0A
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 02:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333101; cv=none; b=dEsz31n5tCFZyAH1w5Z5amwry9iuWKFAmFZrDw3rgfx7adQPSTHtvRLGuX207xZsYbz57sibn2KA9zoehewxfgKf1Uuksgi3z/IW+pbEHwqdApnjeH6mtU1SdMhK6R3eQrZNH7DKNkqAXytc8v5XgQZDci787ugD6UZjMfBFD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333101; c=relaxed/simple;
	bh=glq+1FyhuB1qxaNB4WrfvXWGDmm2KzfQ3M2Hznkp84E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kI22MIg79M53QCEeYaw29aR/Ey4lg5Qb9b2xpdQberVjl1BH5sPYK2yAI4WIqUs7nRLJqpDTlwp3dPbNIbFUWmvoi07pHs9ahRSqdoPGYZQ5fYA2c1tmcLS9PKpchJ/4+lAxQdYBey0A1AvAErWrRalTn6jr4rd0ws4wU1Wgzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ru6ZWMv7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ru6ZWMv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333099; x=1742869099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=glq+1FyhuB1qxaNB4WrfvXWGDmm2KzfQ3M2Hznkp84E=;
  b=Ru6ZWMv7S5PG5hu5glDiPMIexK7LeiSyCuApK7/dHQ+aoDRgq5Awf5tB
   Tc38IGA2C18D49a5L6dsPZzLH2c51i4uPTf1VIMEohMuT/0sz17yaohpV
   X/yd20El/T56RL/cic/+LxCkZ9WF2J/QAtAvTqYv1YyokAiDpatb0fIiK
   JyjSnSjoi+lQEvZRSL/UVJn4pDqLnRkUHOpCxtdN2fO+PG3bo54jwbUw2
   j7n3OhtlZG+I4k1e197dRO2oRqHO9/3HPrFu6kTZRlxod6edjZXvSVYPB
   /p1G6Imyiys8XCSQ/jvDbjtIc2JC/s2BgBEY5EdTON5tC215Cb9LJMBmX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271376"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271376"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353962"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 06/12] iommu/vt-d: Use cache_tag_flush_cm_range() in iotlb_sync_map
Date: Mon, 25 Mar 2024 10:16:59 +0800
Message-Id: <20240325021705.249769-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iotlb_sync_map callback is called by the iommu core after non-present
to present mappings are created. The iommu driver uses this callback to
invalidate caches if IOMMU is working in caching mode and second-only
translation is used for the domain. Use cache_tag_flush_cm_range() in this
callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1c03d2dafb9d..2dcab1e5cd4d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1504,20 +1504,6 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
-/* Notification for newly created mappings */
-static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *domain,
-				 unsigned long pfn, unsigned int pages)
-{
-	/*
-	 * It's a non-present to present mapping. Only flush if caching mode
-	 * and second level.
-	 */
-	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
-		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
-	else
-		iommu_flush_write_buffer(iommu);
-}
-
 /*
  * Flush the relevant caches in nested translation if the domain
  * also serves as a parent
@@ -4549,14 +4535,8 @@ static bool risky_device(struct pci_dev *pdev)
 static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				      unsigned long iova, size_t size)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long pages = aligned_nrpages(iova, size);
-	unsigned long pfn = iova >> VTD_PAGE_SHIFT;
-	struct iommu_domain_info *info;
-	unsigned long i;
+	cache_tag_flush_cm_range(to_dmar_domain(domain), iova, iova + size - 1);
 
-	xa_for_each(&dmar_domain->iommu_array, i, info)
-		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
 	return 0;
 }
 
-- 
2.34.1

