Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43136827E
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046693; cv=none; b=kytf+O3GAdx4aAFjwfT+ZKhFsp+5U9roXPB3287hdNnTfa3vjdKo+o08yTG298eY/eDNEPIWDy0LiQjkegxUIBerXQ2KK/+fUD/HareFoJNs5RKEkTbT++sd1JTYvK0bpFoeRCQHwsb/K7j1eBnzp+5r5koGcbrYGQGUzSr50ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046693; c=relaxed/simple;
	bh=Kszgw8EuzZbIrSzlqXr9hREhZUa7uq18+lEd0ySC9CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKpJU/Q+PfMvi7iQTixNvs3FTGSKm+raAgMWkJYrp0SKkMi/BXHAXkib7z8ixxYZg+vwyh1YNRc+3AUPQ8CLH8puKZkKYBkkjeoSc5wNqhg0233XIZR4OpYoq8hehQZx5gz12H0eUsamGUyTTvgMU+ppihhCMZQYpZroYAxrJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4aunM4S; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4aunM4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769046691; x=1800582691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kszgw8EuzZbIrSzlqXr9hREhZUa7uq18+lEd0ySC9CI=;
  b=Z4aunM4SZwk6E3Bt4Po22+Vxjy5Mf0n/QnVFis9z8fkwVK2mt85T+5A0
   xDGm2Hw344xnLAhtA7Mcz6H1ET9fq36jjOSlFL+Qrul5yYaTc5C4ljAlt
   Xs7BPQTq+qGzc61Hyw4k5wxr2ZR1qVMx1rJjs9SKzCBifTEA5zcG6zHAk
   k107YT8fAWyjHORu2GWOj8XyuBDvHKH2yvpL4ITAuF/5TkT1DUjASKPxB
   uAxLfa956dGhJyS8XTXyGZrhF5sANDQ7o+ForHY//S73yhPGsrGyd7vGg
   6R5j7avxUffGpqgGvDcBR+aw1FXjuwgpvvkMuDgLp3Xr2652EH2EmpFRT
   Q==;
X-CSE-ConnectionGUID: mTnkHH8mR3mOfszKqI2fGg==
X-CSE-MsgGUID: +J625P5kRkqWMw4PEJfqDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81393052"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="81393052"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:51:31 -0800
X-CSE-ConnectionGUID: HhFqm0wOTR6NKE8F4RgaNg==
X-CSE-MsgGUID: gKGEWUkyTxqVfhJt5pdwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211455640"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa004.fm.intel.com with ESMTP; 21 Jan 2026 17:51:29 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Jinhui Guo <guojinhui.liam@bytedance.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iommu/vt-d: Flush piotlb for SVM and Nested domain
Date: Thu, 22 Jan 2026 09:48:53 +0800
Message-ID: <20260122014856.2457052-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
References: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

Besides the paging domains that use FS, SVM and Nested domains need to
use piotlb invalidation descriptor as well.

Fixes: b33125296b50 ("iommu/vt-d: Create unique domain ops for each stage")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20251223065824.6164-1-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 265e7290256b..385ae5cfb30d 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -363,6 +363,13 @@ static void qi_batch_add_pasid_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16
 	qi_batch_increment_index(iommu, batch);
 }
 
+static bool intel_domain_use_piotlb(struct dmar_domain *domain)
+{
+	return domain->domain.type == IOMMU_DOMAIN_SVA ||
+			domain->domain.type == IOMMU_DOMAIN_NESTED ||
+			intel_domain_is_fs_paging(domain);
+}
+
 static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *tag,
 				  unsigned long addr, unsigned long pages,
 				  unsigned long mask, int ih)
@@ -370,7 +377,7 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	struct intel_iommu *iommu = tag->iommu;
 	u64 type = DMA_TLB_PSI_FLUSH;
 
-	if (intel_domain_is_fs_paging(domain)) {
+	if (intel_domain_use_piotlb(domain)) {
 		qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid, addr,
 				    pages, ih, domain->qi_batch);
 		return;
-- 
2.43.0

