Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090314F77
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFjwFD7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700480059; x=1732016059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4PZaUm84w7H83XcsuQyvk1lkaQccPFbLEhvPQCk0Xc=;
  b=CFjwFD7zekurJBX4eTL69CB2LHrIiPubbEI7fDByqJealX2r7Z6dpURM
   rTxQSbw+HLV98Nlu/cWion1jmkc+gsamUkrSR56muNKRDGQVV3fg7ZXIR
   pBvSq9CJ+OErlWM9hQ7ABEVXzGRT+tuj58y31vHibfvL6xNbNmVNh9HN4
   Lo55mE5P2NYP0RkMm9Y3jd9XY6iBZwIrexSIhTkRldAWMReQ5bjMRHGwb
   ik2scTsjEAajinqaktm744RsU7O6zp+/r+cBejtbtLEpzzYo9GfaNFdrt
   F0ZD31FTwI934Gm6Frkv2fDb8ibv8lMGW14WAHHg7pzCIunyt+akNWxKd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="376634993"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="376634993"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:34:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856963621"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="856963621"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2023 03:34:10 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/5] iommu/vt-d: Remove scalable mode context entry setup from attach_dev
Date: Mon, 20 Nov 2023 19:29:41 +0800
Message-Id: <20231120112944.142741-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120112944.142741-1-baolu.lu@linux.intel.com>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scalable mode context entry is now setup in the probe_device path,
eliminating the need to configure it in the attach_dev path. Removes the
redundant code from the attach_dev path to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 156 ++++++++++--------------------------
 1 file changed, 44 insertions(+), 112 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e34a32cd2b9a..77769ad4706e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1727,34 +1727,17 @@ static void domain_exit(struct dmar_domain *domain)
 	kfree(domain);
 }
 
-/*
- * Get the PASID directory size for scalable mode context entry.
- * Value of X in the PDTS field of a scalable mode context entry
- * indicates PASID directory with 2^(X + 7) entries.
- */
-static unsigned long context_get_sm_pds(struct pasid_table *table)
-{
-	unsigned long pds, max_pde;
-
-	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
-	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
-	if (pds < 7)
-		return 0;
-
-	return pds - 7;
-}
-
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
-				      struct pasid_table *table,
 				      u8 bus, u8 devfn)
 {
 	struct device_domain_info *info =
 			domain_lookup_dev_info(domain, iommu, bus, devfn);
 	u16 did = domain_id_iommu(domain, iommu);
 	int translation = CONTEXT_TT_MULTI_LEVEL;
+	struct dma_pte *pgd = domain->pgd;
 	struct context_entry *context;
-	int ret;
+	int agaw, ret;
 
 	if (hw_pass_through && domain_type_is_si(domain))
 		translation = CONTEXT_TT_PASS_THROUGH;
@@ -1797,65 +1780,37 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	}
 
 	context_clear_entry(context);
+	context_set_domain_id(context, did);
 
-	if (sm_supported(iommu)) {
-		unsigned long pds;
-
-		/* Setup the PASID DIR pointer: */
-		pds = context_get_sm_pds(table);
-		context->lo = (u64)virt_to_phys(table->table) |
-				context_pdts(pds);
-
-		/* Setup the RID_PASID field: */
-		context_set_sm_rid2pasid(context, IOMMU_NO_PASID);
-
+	if (translation != CONTEXT_TT_PASS_THROUGH) {
 		/*
-		 * Setup the Device-TLB enable bit and Page request
-		 * Enable bit:
+		 * Skip top levels of page tables for iommu which has
+		 * less agaw than default. Unnecessary for PT mode.
 		 */
+		for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
+			ret = -ENOMEM;
+			pgd = phys_to_virt(dma_pte_addr(pgd));
+			if (!dma_pte_present(pgd))
+				goto out_unlock;
+		}
+
 		if (info && info->ats_supported)
-			context_set_sm_dte(context);
-		if (info && info->pri_supported)
-			context_set_sm_pre(context);
-		if (info && info->pasid_supported)
-			context_set_pasid(context);
+			translation = CONTEXT_TT_DEV_IOTLB;
+		else
+			translation = CONTEXT_TT_MULTI_LEVEL;
+
+		context_set_address_root(context, virt_to_phys(pgd));
+		context_set_address_width(context, agaw);
 	} else {
-		struct dma_pte *pgd = domain->pgd;
-		int agaw;
-
-		context_set_domain_id(context, did);
-
-		if (translation != CONTEXT_TT_PASS_THROUGH) {
-			/*
-			 * Skip top levels of page tables for iommu which has
-			 * less agaw than default. Unnecessary for PT mode.
-			 */
-			for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-				ret = -ENOMEM;
-				pgd = phys_to_virt(dma_pte_addr(pgd));
-				if (!dma_pte_present(pgd))
-					goto out_unlock;
-			}
-
-			if (info && info->ats_supported)
-				translation = CONTEXT_TT_DEV_IOTLB;
-			else
-				translation = CONTEXT_TT_MULTI_LEVEL;
-
-			context_set_address_root(context, virt_to_phys(pgd));
-			context_set_address_width(context, agaw);
-		} else {
-			/*
-			 * In pass through mode, AW must be programmed to
-			 * indicate the largest AGAW value supported by
-			 * hardware. And ASR is ignored by hardware.
-			 */
-			context_set_address_width(context, iommu->msagaw);
-		}
-
-		context_set_translation_type(context, translation);
+		/*
+		 * In pass through mode, AW must be programmed to
+		 * indicate the largest AGAW value supported by
+		 * hardware. And ASR is ignored by hardware.
+		 */
+		context_set_address_width(context, iommu->msagaw);
 	}
 
+	context_set_translation_type(context, translation);
 	context_set_fault_enable(context);
 	context_set_present(context);
 	if (!ecap_coherent(iommu->ecap))
@@ -1885,43 +1840,29 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	return ret;
 }
 
-struct domain_context_mapping_data {
-	struct dmar_domain *domain;
-	struct intel_iommu *iommu;
-	struct pasid_table *table;
-};
-
 static int domain_context_mapping_cb(struct pci_dev *pdev,
 				     u16 alias, void *opaque)
 {
-	struct domain_context_mapping_data *data = opaque;
+	struct device_domain_info *info = dev_iommu_priv_get(&pdev->dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct dmar_domain *domain = opaque;
 
-	return domain_context_mapping_one(data->domain, data->iommu,
-					  data->table, PCI_BUS_NUM(alias),
-					  alias & 0xff);
+	return domain_context_mapping_one(domain, iommu,
+					  PCI_BUS_NUM(alias), alias & 0xff);
 }
 
 static int
 domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct domain_context_mapping_data data;
 	struct intel_iommu *iommu = info->iommu;
 	u8 bus = info->bus, devfn = info->devfn;
-	struct pasid_table *table;
-
-	table = intel_pasid_get_table(dev);
 
 	if (!dev_is_pci(dev))
-		return domain_context_mapping_one(domain, iommu, table,
-						  bus, devfn);
-
-	data.domain = domain;
-	data.iommu = iommu;
-	data.table = table;
+		return domain_context_mapping_one(domain, iommu, bus, devfn);
 
 	return pci_for_each_dma_alias(to_pci_dev(dev),
-				      &domain_context_mapping_cb, &data);
+				      domain_context_mapping_cb, domain);
 }
 
 /* Returns a number of VTD pages, but aligned to MM page size */
@@ -2278,28 +2219,19 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	/* PASID table is mandatory for a PCI device in scalable mode. */
-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
-		/* Setup the PASID entry for requests without PASID: */
-		if (hw_pass_through && domain_type_is_si(domain))
-			ret = intel_pasid_setup_pass_through(iommu,
-					dev, IOMMU_NO_PASID);
-		else if (domain->use_first_level)
-			ret = domain_setup_first_level(iommu, domain, dev,
-					IOMMU_NO_PASID);
-		else
-			ret = intel_pasid_setup_second_level(iommu, domain,
-					dev, IOMMU_NO_PASID);
-		if (ret) {
-			dev_err(dev, "Setup RID2PASID failed\n");
-			device_block_translation(dev);
-			return ret;
-		}
-	}
+	if (dev_is_real_dma_subdevice(dev))
+		return 0;
+
+	if (!sm_supported(iommu))
+		ret = domain_context_mapping(domain, dev);
+	else if (hw_pass_through && domain_type_is_si(domain))
+		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
+	else if (domain->use_first_level)
+		ret = domain_setup_first_level(iommu, domain, dev, IOMMU_NO_PASID);
+	else
+		ret = intel_pasid_setup_second_level(iommu, domain, dev, IOMMU_NO_PASID);
 
-	ret = domain_context_mapping(domain, dev);
 	if (ret) {
-		dev_err(dev, "Domain context map failed\n");
 		device_block_translation(dev);
 		return ret;
 	}
-- 
2.34.1

