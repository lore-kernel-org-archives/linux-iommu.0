Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8C178CC8
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684491; cv=none; b=hMsLs+CEuU5FSNnwkkcb4jzvtSs0BtnVC+pElZVvUVuxmvAGwFe7c6D2HOjiMVNHUEUOzZmhPSSAFl1BDtDqMlg17LQ8Zqxmkn9XnX0Zp/dlkq5q9ybKbOQtE787zpCQUhIzFiatRaT9rABMQxRqku0gW58rZSLE6QPv0YEBocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684491; c=relaxed/simple;
	bh=riqzV7n0J43EYO2oOas0nWwgMpv9u0/7uVb/Lj6CGcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+tWOvISCARK5bj+dhz+otvYqT7hvP18k8npZQRG+Bh4/Amx79m4tAqJlB6bmvMeYhRgGHYjC60BIsjjHu3QzXRQ+Z3hfRR2q8XBcDO4RfGwAwdxuk1AZ4nevTCKrt8Qz1jEWlkofcoYmUDlg3MwrYve1pV4ci8/ZHO973+OZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HehJXwM7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HehJXwM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684490; x=1762220490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=riqzV7n0J43EYO2oOas0nWwgMpv9u0/7uVb/Lj6CGcc=;
  b=HehJXwM7M1BMTO6b6sdGf5P3cEsP2pBl/0L9yDjl8XCXl6cEaDGfixwE
   ba95miuI2DkgM1m3gOVV4Wr8imgeTi89aBDysDVCVhCIRc1m5lDVKTioC
   Kx513RMN5fA3cv0ljHriWXnHB8nPEhY8dAs9XioBGXH0SCtxSnT/PLifa
   psKFY8x6f+dkvkQi2S6InEdjjZbAMudhKhXr8lKkNnSlLGipp6ZX9W0jY
   AXOueIs89C5zyYy36chqz4AJ6ump/3uxNojml6PbfqsVbwLTbwTjiwk18
   j1rxOhk5y42xKC3g7koci2LtJg4BiNMwUSQEWzq2HPIexAft276wvxJO0
   A==;
X-CSE-ConnectionGUID: sq8+m/+BT4OPslHiWl8nfA==
X-CSE-MsgGUID: gNnEjMpZQwiE+2WXrFigZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221921"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221921"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:29 -0800
X-CSE-ConnectionGUID: PjrgVal9TY6n/R3+Kugcaw==
X-CSE-MsgGUID: mpNyRWr+S1eovx3qCsso5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020880"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/19] iommu/vt-d: Remove domain_update_iommu_cap()
Date: Mon,  4 Nov 2024 09:40:24 +0800
Message-ID: <20241104014040.106100-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The attributes of a paging domain are initialized during the allocation
process, and any attempt to attach a domain that is not compatible will
result in a failure. Therefore, there is no need to update the domain
attributes at the time of domain attachment.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20241021085125.192333-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 83 -------------------------------------
 drivers/iommu/intel/iommu.h |  1 -
 2 files changed, 84 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0fca84ac6794..d148274e7135 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -352,36 +352,6 @@ static bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 			ecap_smpwc(iommu->ecap) : ecap_coherent(iommu->ecap);
 }
 
-static void domain_update_iommu_coherency(struct dmar_domain *domain)
-{
-	struct iommu_domain_info *info;
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	bool found = false;
-	unsigned long i;
-
-	domain->iommu_coherency = true;
-	xa_for_each(&domain->iommu_array, i, info) {
-		found = true;
-		if (!iommu_paging_structure_coherency(info->iommu)) {
-			domain->iommu_coherency = false;
-			break;
-		}
-	}
-	if (found)
-		return;
-
-	/* No hardware attached; use lowest common denominator */
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (!iommu_paging_structure_coherency(iommu)) {
-			domain->iommu_coherency = false;
-			break;
-		}
-	}
-	rcu_read_unlock();
-}
-
 static int domain_update_iommu_superpage(struct dmar_domain *domain,
 					 struct intel_iommu *skip)
 {
@@ -412,29 +382,6 @@ static int domain_update_iommu_superpage(struct dmar_domain *domain,
 	return fls(mask);
 }
 
-static int domain_update_device_node(struct dmar_domain *domain)
-{
-	struct device_domain_info *info;
-	int nid = NUMA_NO_NODE;
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		/*
-		 * There could possibly be multiple device numa nodes as devices
-		 * within the same domain may sit behind different IOMMUs. There
-		 * isn't perfect answer in such situation, so we select first
-		 * come first served policy.
-		 */
-		nid = dev_to_node(info->dev);
-		if (nid != NUMA_NO_NODE)
-			break;
-	}
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return nid;
-}
-
 /* Return the super pagesize bitmap if supported. */
 static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 {
@@ -452,34 +399,6 @@ static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 	return bitmap;
 }
 
-/* Some capabilities may be different across iommus */
-void domain_update_iommu_cap(struct dmar_domain *domain)
-{
-	domain_update_iommu_coherency(domain);
-	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
-
-	/*
-	 * If RHSA is missing, we should default to the device numa domain
-	 * as fall back.
-	 */
-	if (domain->nid == NUMA_NO_NODE)
-		domain->nid = domain_update_device_node(domain);
-
-	/*
-	 * First-level translation restricts the input-address to a
-	 * canonical address (i.e., address bits 63:N have the same
-	 * value as address bit [N-1], where N is 48-bits with 4-level
-	 * paging and 57-bits with 5-level paging). Hence, skip bit
-	 * [N-1].
-	 */
-	if (domain->use_first_level)
-		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
-	else
-		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
-
-	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
-}
-
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 					 u8 devfn, int alloc)
 {
@@ -1493,7 +1412,6 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 		ret = xa_err(curr) ? : -EBUSY;
 		goto err_clear;
 	}
-	domain_update_iommu_cap(domain);
 
 	spin_unlock(&iommu->lock);
 	return 0;
@@ -1519,7 +1437,6 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 		clear_bit(info->did, iommu->domain_ids);
 		xa_erase(&domain->iommu_array, iommu->seq_id);
 		domain->nid = NUMA_NO_NODE;
-		domain_update_iommu_cap(domain);
 		kfree(info);
 	}
 	spin_unlock(&iommu->lock);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b1928ca3aaa8..f9fba9a26dac 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1231,7 +1231,6 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
-void domain_update_iommu_cap(struct dmar_domain *domain);
 
 int dmar_ir_support(void);
 
-- 
2.43.0

