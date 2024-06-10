Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52C79B84
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009976; cv=none; b=N22kIc0XMKvwQ9Wsw/u9HbdTvCdjG4ORKqxrOAX2PfCXaRYdOP6MpI/rgUuEvqkJShuWI5DsdiMOVsP11qrIuWE9DyRbyvHODv+9lLM8POUqhNuIsmPE8SVff7LxJ4gVyjJEKW4r0vHBA9MmkEHoCifVV62t0Uz0RrWkgqsPXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009976; c=relaxed/simple;
	bh=kAf7SPBLso5zp49wUYubqs0YKzd/lC+tt+i0+MOxu64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjrYeoJTQZA39YnvhirzUpwhmOnLbkj53iXiidupRL9IaiHc0O8oOPs7ZYOJcLJQpU4Bzr1aA4+jBxp70txhtj8uZH/SJRmshzf/EU0Jj/x0PDheiWyUZ0blYLvBpB57ArsXJamhjR3FTWZ5hqfZnZ3iUJSWfjb87fL5w/ClttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uq1ealpY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uq1ealpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009974; x=1749545974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAf7SPBLso5zp49wUYubqs0YKzd/lC+tt+i0+MOxu64=;
  b=Uq1ealpY4p14ZSL7xW/ZJSu5oMw2bkJy+4y5B7rZSU2KCvMWBLysszFS
   2A5tq4lBAwzYR8zUDAGiirNmQxHkUyHUMeX75r/KivKQyT7v0G+1niwH3
   kzBnsZ6uidEv77gRspEkt7KUjFuNAjDJ3WiA3OtVeIgo0XQKFsyATUHSU
   wxMJv6QOwxNGDGGe+o6JhScDjv/lFvZaWXwUpsGPxj5BP5bpDoDCT3rZg
   3YHELKRNiOvuZYA6+y1yJ9H0GDqp06UGmqQDToVatgL++ChrOQ4mqaUbF
   uYlV0XtFYfJ7f4t/XeLmFXYlNwMJyWYAkXGHSNM2UHbKb1GzTsSakXQXm
   w==;
X-CSE-ConnectionGUID: Govj0b1ZROeoQ4yNVMSV+A==
X-CSE-MsgGUID: /LXN+IAGQXeFxSej1QRYKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581889"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581889"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:59:34 -0700
X-CSE-ConnectionGUID: IZUNZ8cdRjO1AyWUbBMniA==
X-CSE-MsgGUID: oS6yPYCwQEWB97mfMcpzCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432851"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 15/21] iommu/vt-d: Add helper to allocate paging domain
Date: Mon, 10 Jun 2024 16:55:49 +0800
Message-Id: <20240610085555.88197-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The domain_alloc_user operation is currently implemented by allocating a
paging domain using iommu_domain_alloc(). This is because it needs to fully
initialize the domain before return. Add a helper to do this to avoid using
iommu_domain_alloc().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 87 +++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e9811bf2a4e..ccde5f5972e4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3633,6 +3633,79 @@ static struct iommu_domain blocking_domain = {
 	}
 };
 
+static int iommu_superpage_capability(struct intel_iommu *iommu, bool first_stage)
+{
+	if (!intel_iommu_superpage)
+		return 0;
+
+	if (first_stage)
+		return cap_fl1gp_support(iommu->cap) ? 2 : 1;
+
+	return fls(cap_super_page_val(iommu->cap));
+}
+
+static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_stage)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct dmar_domain *domain;
+	int addr_width;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->dev_pasids);
+	INIT_LIST_HEAD(&domain->cache_tags);
+	spin_lock_init(&domain->lock);
+	spin_lock_init(&domain->cache_lock);
+	xa_init(&domain->iommu_array);
+
+	domain->nid = dev_to_node(dev);
+	domain->has_iotlb_device = info->ats_enabled;
+	domain->use_first_level = first_stage;
+
+	/* calculate the address width */
+	addr_width = agaw_to_width(iommu->agaw);
+	if (addr_width > cap_mgaw(iommu->cap))
+		addr_width = cap_mgaw(iommu->cap);
+	domain->gaw = addr_width;
+	domain->agaw = iommu->agaw;
+	domain->max_addr = __DOMAIN_MAX_ADDR(addr_width);
+
+	/* iommu memory access coherency */
+	domain->iommu_coherency = iommu_paging_structure_coherency(iommu);
+
+	/* pagesize bitmap */
+	domain->domain.pgsize_bitmap = SZ_4K;
+	domain->iommu_superpage = iommu_superpage_capability(iommu, first_stage);
+	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
+
+	/*
+	 * IOVA aperture: First-level translation restricts the input-address
+	 * to a canonical address (i.e., address bits 63:N have the same value
+	 * as address bit [N-1], where N is 48-bits with 4-level paging and
+	 * 57-bits with 5-level paging). Hence, skip bit [N-1].
+	 */
+	domain->domain.geometry.force_aperture = true;
+	domain->domain.geometry.aperture_start = 0;
+	if (first_stage)
+		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
+	else
+		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
+
+	/* always allocate the top pgd */
+	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_KERNEL);
+	if (!domain->pgd) {
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
+
+	return domain;
+}
+
 static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
@@ -3695,15 +3768,11 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	/*
-	 * domain_alloc_user op needs to fully initialize a domain before
-	 * return, so uses iommu_domain_alloc() here for simple.
-	 */
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
-		return ERR_PTR(-ENOMEM);
-
-	dmar_domain = to_dmar_domain(domain);
+	/* Do not use first stage for user domain translation. */
+	dmar_domain = paging_domain_alloc(dev, false);
+	if (IS_ERR(dmar_domain))
+		return ERR_CAST(dmar_domain);
+	domain = &dmar_domain->domain;
 
 	if (nested_parent) {
 		dmar_domain->nested_parent = true;
-- 
2.34.1

