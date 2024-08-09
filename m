Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79416D9AE
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183098; cv=none; b=AZs4miQWx362zgx36+AbIDD1+qESBD3ClJ6JL6BjPYNkXhxXanMu7TvD1N3RxV0YFIxCCEvvQDTZZCh+wDL7tW8e5JxXhiHQGmtX6EPftM5qtKonD/aI4i7NMz557VbvgwWQzJ8tUEYM5skD8Lbk1giWjg1d8i8TtET0LS4Q4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183098; c=relaxed/simple;
	bh=dGJ807P2NgMXfp/nKRwxut/4ZkS9X3sgQHFPed4vft0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdmlGkFFGD0pelh0VIAvXt3OMYB0Uv9H5IwlC9g8dExsN8NoPGhGDPw6QBrCgpdbtln1iy05jqIH4EepbnEquohhU8+01YgfrytrvTuO4llIrm8fv1O+9vfRvBVIg0cNVTSAKggw711dwbploKQkNfE2jlDCXX7K2yEvcdCGHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgLdeQdk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgLdeQdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723183097; x=1754719097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dGJ807P2NgMXfp/nKRwxut/4ZkS9X3sgQHFPed4vft0=;
  b=XgLdeQdkW6/04pZoAnw63fQovPn0iHEr+Qj0ec6l+jippQY/dnBUIde2
   SD8Mj3wZ5hEGDXyEfTBItPcPn5Sr7bI06+KOPoamW9/RQJnE7fgAerrzj
   0zk0SG0mK6a0CNm/j4rG02QXgvJvWNEJWk1OO5DLzZHJirGdb6kV14YLx
   c5dgaInfLJWgSCjnyTqXPofvUPk3+MPdf+u3OQ7/fFgqmGxPH2Olxlm0+
   NHw57c1uGOmihsGqyHIqfmxE8nKT5ogGi3ewZEV9YcDBUqE7LhYpRu/gc
   7SYrQeWz9ghPYlvR8aTsLgjsYJINTdNF52g9YA97nLXnMENz9FEzUDlaa
   A==;
X-CSE-ConnectionGUID: O9ajknDKRVS9Y6brGBYLzQ==
X-CSE-MsgGUID: j4LtX6kiTGGE6yaRhdrhzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21469171"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21469171"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 22:58:17 -0700
X-CSE-ConnectionGUID: eTYEuUu9SUq7TnnbWPZGzQ==
X-CSE-MsgGUID: fzBSnxkwTYmuVRNuiEp82w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57540936"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 22:58:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 6/7] iommu/vt-d: Add support for static identity domain
Date: Fri,  9 Aug 2024 13:54:30 +0800
Message-Id: <20240809055431.36513-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809055431.36513-1-baolu.lu@linux.intel.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Software determines VT-d hardware support for passthrough translation by
inspecting the capability register. If passthrough translation is not
supported, the device is instructed to use DMA domain for its default
domain.

Add a global static identity domain with guaranteed attach semantics for
IOMMUs that support passthrough translation mode.

The global static identity domain is a dummy domain without corresponding
dmar_domain structure. Consequently, the device's info->domain will be
NULL with the identity domain is attached. Refactor the code accordingly.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 114 ++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7950152bb4e6..14f1fcf17152 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3691,11 +3691,9 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
-	if (info->domain)
-		device_block_translation(dev);
+	device_block_translation(dev);
 
 	ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
@@ -4301,11 +4299,17 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 					 struct iommu_domain *domain)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
 	struct intel_iommu *iommu = info->iommu;
+	struct dmar_domain *dmar_domain;
 	unsigned long flags;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+		return;
+	}
+
+	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
@@ -4532,9 +4536,111 @@ static const struct iommu_dirty_ops intel_dirty_ops = {
 	.read_and_clear_dirty = intel_iommu_read_and_clear_dirty,
 };
 
+static int context_setup_pass_through(struct device *dev, u8 bus, u8 devfn)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct context_entry *context;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, 1);
+	if (!context) {
+		spin_unlock(&iommu->lock);
+		return -ENOMEM;
+	}
+
+	if (context_present(context) && !context_copied(iommu, bus, devfn)) {
+		spin_unlock(&iommu->lock);
+		return 0;
+	}
+
+	copied_context_tear_down(iommu, context, bus, devfn);
+	context_clear_entry(context);
+	context_set_domain_id(context, FLPT_DEFAULT_DID);
+
+	/*
+	 * In pass through mode, AW must be programmed to indicate the largest
+	 * AGAW value supported by hardware. And ASR is ignored by hardware.
+	 */
+	context_set_address_width(context, iommu->msagaw);
+	context_set_translation_type(context, CONTEXT_TT_PASS_THROUGH);
+	context_set_fault_enable(context);
+	context_set_present(context);
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(context, sizeof(*context));
+	context_present_cache_flush(iommu, FLPT_DEFAULT_DID, bus, devfn);
+	spin_unlock(&iommu->lock);
+
+	return 0;
+}
+
+static int context_setup_pass_through_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct device *dev = data;
+
+	if (dev != &pdev->dev)
+		return 0;
+
+	return context_setup_pass_through(dev, PCI_BUS_NUM(alias), alias & 0xff);
+}
+
+static int device_setup_pass_through(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	if (!dev_is_pci(dev))
+		return context_setup_pass_through(dev, info->bus, info->devfn);
+
+	return pci_for_each_dma_alias(to_pci_dev(dev),
+				      context_setup_pass_through_cb, dev);
+}
+
+static int identity_domain_attach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	int ret;
+
+	device_block_translation(dev);
+
+	if (dev_is_real_dma_subdevice(dev))
+		return 0;
+
+	if (sm_supported(iommu)) {
+		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
+		if (!ret)
+			iommu_enable_pci_caps(info);
+	} else {
+		ret = device_setup_pass_through(dev);
+	}
+
+	return ret;
+}
+
+static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	return intel_pasid_setup_pass_through(iommu, dev, pasid);
+}
+
+static struct iommu_domain identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= identity_domain_attach_dev,
+		.set_dev_pasid	= identity_domain_set_dev_pasid,
+	},
+};
+
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
 	.release_domain		= &blocking_domain,
+	.identity_domain	= &identity_domain,
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
-- 
2.34.1

