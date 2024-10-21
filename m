Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91D1E2618
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500993; cv=none; b=EIHZpwJZtAKKhN6PXF7E83iKKkyykhkkkUiF3u71ovIpNGAWcpNlpt3GfkvFtv60mQg9zWsxxqWN5D0Ril8HTYVvgxT8Qx6y8MGSpbHG0W6iVEbcckF/N8aMbnrkFBxFjwrFnDinJ9CUQqImWYtgyv72gFvOJcqyXPh4uuSAsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500993; c=relaxed/simple;
	bh=OKL6Mu2G37CcLVl+q2h1WjYfHr6Z7zwPi0qJcVTBkT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtT84dJOAajo9yHGJ/KiUzTVmDdn8aU5NoSlAGFDbjqCh1KfaURZlCpUGv+4UXPtyBcSJ797K0t2h0aZ4G7kyZtaBG7SV7qIl3Zo37Ho9Z/8UivPKd4/bYME8w3FUY8iCmKJh0g8+nb6+7xBULxDxoX3xR2HG7mpOBGGTRIODTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxiKEyhE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxiKEyhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500993; x=1761036993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OKL6Mu2G37CcLVl+q2h1WjYfHr6Z7zwPi0qJcVTBkT0=;
  b=YxiKEyhEnIGtdrPH3vr9CGFK5+Efp63cBJqmHIB3E0UBWEcKC9OAl1Id
   vabJtOsav7SmUPvgtpu0c7sI7L1RNMzVttizRt5WcAcfxQEZzPFkZTOtL
   Snvy9VhPLlq3a/nX/RNj0D7jptoznqI5KTcw0oadEcflVcRBhn0ruIZws
   V0YGAlSeX8O5CX0+VXKPUlivs7dOxu1QCZlGv/yqBY0/O4gzCrO17xw+F
   coLrkalxnfJbmJijb44Gh6d+WK0nANEQ4gvRUrXXQEQ0VTGK4dYS+MXFS
   X5YpUNI4NogFsWsv48hcqwm1w0LQ01+/xt73s0ZuettvV/ur1HKcu5e57
   Q==;
X-CSE-ConnectionGUID: djpz1PZhTte2InbMEhwiBg==
X-CSE-MsgGUID: zDqawCdGTluG+tpdJAFj2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32780356"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32780356"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:56:33 -0700
X-CSE-ConnectionGUID: QOQ2Z1/aRlqNvFMtrdsYRQ==
X-CSE-MsgGUID: iuLtr2iKQYGPQQQfBlfw7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79812754"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 01:56:29 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 4/7] iommu/vt-d: Remove domain_update_iommu_cap()
Date: Mon, 21 Oct 2024 16:51:21 +0800
Message-ID: <20241021085125.192333-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021085125.192333-1-baolu.lu@linux.intel.com>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 83 -------------------------------------
 2 files changed, 84 deletions(-)

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
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index eeb341aafe3e..756caa24008f 100644
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
-- 
2.43.0

