Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E3207A36
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621135; cv=none; b=LBJ4asOUucEsTCyMdOLxg68LAR7bDKuS/XDsBqfdbh+HgGEJ9IkP1atHdHjs94RgexHRvEUcb3hR7A4wspw9065ievORI3l6X5AjWeN+1yM9eXWxtut/W6UPXdcf/bV8FfYzcvOZGoVgyxOvldmVfCDCxH/o82D1WJFwsx47SnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621135; c=relaxed/simple;
	bh=dofyf/kVAJlM/vTTaWQs6uLAoF7OnNzbz4cPHBZ/QaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1IRmNaQD+Fg3hH4ofpCkPuJzemn9MljBx2L9zzN1Hsnx2X1Dq5eCB0WUy7bG5p5DlYEnnRodCkvZbD0lXRr9STb50EkBFrNZkMaD6jcXHnNl5vmZr+UblLicDKhGaMEjrSP2RByQwozttoTlBX1AaU+govzJLOyG1mUQFUzCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+MSxcrC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+MSxcrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621134; x=1760157134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dofyf/kVAJlM/vTTaWQs6uLAoF7OnNzbz4cPHBZ/QaU=;
  b=Y+MSxcrC8HuAjt/VacnamfbroI7cdWtyrgOmpDdWMOZpfVm60KIeZdAY
   3EsqR6FxOoHDLInFV3MyoYPIT+AlBcwDxCufRcv+20juvwByRAMX7ouEX
   Oef70Uaz9INu+BXSYVmoMnVEFS8PgDYUQhNrVG/0C6/2hKHfxiQhvBxYQ
   V4bLLMZQ2TmtPZSg8WGJ7Yse+U1QADuAPzvm+zeueHeqqcd2IGXNyVeFH
   FBn71LCYQ/6HLKA2rMXUJAZec3VlbCEB18N8cSUvGf7KzsEbrhWAd1Gfo
   RW+2DMmIjsZqqqZcvg/Yh0TrJaZtiMWm8EzHgd7bEec8T9mVIVR5IhE1b
   w==;
X-CSE-ConnectionGUID: lKqStf/NT1Gg5u/VGeRKEw==
X-CSE-MsgGUID: rATR/IIKRXqjcrWtwWETbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28101785"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28101785"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:32:14 -0700
X-CSE-ConnectionGUID: ekGjqVSQSw+CukaEJAad3Q==
X-CSE-MsgGUID: /4iaumopR7SBdjfkgpKSIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81412204"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 21:32:11 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/7] iommu/vt-d: Remove domain_update_iommu_cap()
Date: Fri, 11 Oct 2024 12:27:19 +0800
Message-ID: <20241011042722.73930-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011042722.73930-1-baolu.lu@linux.intel.com>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 83 -------------------------------------
 2 files changed, 84 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1497f3112b12..a4bff90c2d07 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1232,7 +1232,6 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
 int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
-void domain_update_iommu_cap(struct dmar_domain *domain);
 
 int dmar_ir_support(void);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f6a3266b17d4..ada271e7be50 100644
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

