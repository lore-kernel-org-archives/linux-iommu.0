Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A86A1CAA9
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645364; cv=none; b=deAnoE4xoWsnLYDck/eJ3xE7meUT/XtxsMBJcgObhxdYj3WFcjg8/p8o22iYtbIr+k9q9YbaFCy+ZoOC9W2Kr3oX04LH3JgA5FaIHLH4R8OO7zZyed2cWbHA1UCzmrr+w1cPkRZ9l6RQ2B6NmxTIuzdoTSDWSfxddwqWOBT/ug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645364; c=relaxed/simple;
	bh=+/KH7Dt/gunYlOnwVVcGKIkZIvdq00WPW2Ix2BGRdk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dCfR9J2OwTE7mHQy5vwvvFDZtxPgJEWiv1ijIgUopAt7YiF4CGPFTLn1fyaob5aI00LaBSZyvmqZlOboj5E+uep/JqaH7LysqPbBXK/udV7MQzgXj8gHl3BR6NeziYqVVIvkYH81FN6fUO0H5RBRCUpC/s5OyDgvtZdFT3ztCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKZbW8ya; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKZbW8ya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717645362; x=1749181362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+/KH7Dt/gunYlOnwVVcGKIkZIvdq00WPW2Ix2BGRdk0=;
  b=ZKZbW8yaJZ2OIqPZKIi2PgOB+cn8web0FIHvfLAT6ai72uKkxhelsKi6
   qsc0bBQ+CiqUV6HZ6V2/QJd/UMaZoOzPEfdlG7RtuynJzCkgj9zTSpFIY
   JxEWdGhY8nfn0Io4sbyBsHQofznSwAj59OMCt6kpqI5WqUvayUgIMWVQJ
   0nJEFBtR0MLXw0cnLu5bU1EM20qni0e9n+H6wXKHnf/cbuC/aDh0QiCA3
   yMBdVsadgTr7JxNBo0N62pVNgLfF6AQN+IF/c0B+XS35oxRPhGypVavM3
   aYhLM2Pc9W/445ihWSdb+8wdaRMyEc5J+7PwfwAmnZ90a1ZbHBBxi2VvZ
   A==;
X-CSE-ConnectionGUID: TZeih+zRQmm38s8Z0YYHTw==
X-CSE-MsgGUID: BglXQ9UFRteII2kSFR72kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="31790050"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="31790050"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 20:42:41 -0700
X-CSE-ConnectionGUID: eEeBY0UNT3u3DlMV5iHCXw==
X-CSE-MsgGUID: wAibKvBGQvC4FgeNYjCrig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="75296815"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 05 Jun 2024 20:42:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
Date: Thu,  6 Jun 2024 11:40:19 +0800
Message-Id: <20240606034019.42795-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0095bf83554f8 ("iommu: Improve iopf_queue_remove_device()")
specified the flow for disabling the PRI on a device. Refactor the
PRI callbacks in the intel iommu driver to better manage PRI
enabling and disabling and align it with the device queue interfaces
in the iommu core.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  9 +++++
 drivers/iommu/intel/iommu.c | 77 ++++++++++++++++++++++++++++++++++---
 drivers/iommu/intel/pasid.c |  2 -
 3 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index eaf015b4353b..3d5d8f786906 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1047,6 +1047,15 @@ static inline void context_set_sm_pre(struct context_entry *context)
 	context->lo |= BIT_ULL(4);
 }
 
+/*
+ * Clear the PRE(Page Request Enable) field of a scalable mode context
+ * entry.
+ */
+static inline void context_clear_sm_pre(struct context_entry *context)
+{
+	context->lo &= ~BIT_ULL(4);
+}
+
 /* Returns a number of VTD pages, but aligned to MM page size */
 static inline unsigned long aligned_nrpages(unsigned long host_addr, size_t size)
 {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e9811bf2a4e..2d4b122bcc1c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4213,6 +4213,57 @@ static int intel_iommu_enable_sva(struct device *dev)
 	return 0;
 }
 
+/*
+ * Invalidate the caches for a present-to-present change in a context
+ * table entry according to the Spec 6.5.3.3 (Guidance to Software for
+ * Invalidations).
+ *
+ * Since context entry is not encoded by domain-id when operating in
+ * scalable-mode (refer Section 6.2.1), this performs coarser
+ * invalidation than the domain-selective granularity requested.
+ */
+static void invalidate_present_context_change(struct device_domain_info *info)
+{
+	struct intel_iommu *iommu = info->iommu;
+
+	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+	if (sm_supported(iommu))
+		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
+	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
+}
+
+static int context_flip_pri(struct device_domain_info *info, bool enable)
+{
+	struct intel_iommu *iommu = info->iommu;
+	u8 bus = info->bus, devfn = info->devfn;
+	struct context_entry *context;
+
+	spin_lock(&iommu->lock);
+	if (context_copied(iommu, bus, devfn)) {
+		spin_unlock(&iommu->lock);
+		return -EINVAL;
+	}
+
+	context = iommu_context_addr(iommu, bus, devfn, false);
+	if (!context || !context_present(context)) {
+		spin_unlock(&iommu->lock);
+		return -ENODEV;
+	}
+
+	if (enable)
+		context_set_sm_pre(context);
+	else
+		context_clear_sm_pre(context);
+
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(context, sizeof(*context));
+	invalidate_present_context_change(info);
+	spin_unlock(&iommu->lock);
+
+	return 0;
+}
+
 static int intel_iommu_enable_iopf(struct device *dev)
 {
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
@@ -4242,15 +4293,23 @@ static int intel_iommu_enable_iopf(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = context_flip_pri(info, true);
+	if (ret)
+		goto err_remove_device;
+
 	ret = pci_enable_pri(pdev, PRQ_DEPTH);
-	if (ret) {
-		iopf_queue_remove_device(iommu->iopf_queue, dev);
-		return ret;
-	}
+	if (ret)
+		goto err_clear_pri;
 
 	info->pri_enabled = 1;
 
 	return 0;
+err_clear_pri:
+	context_flip_pri(info, false);
+err_remove_device:
+	iopf_queue_remove_device(iommu->iopf_queue, dev);
+
+	return ret;
 }
 
 static int intel_iommu_disable_iopf(struct device *dev)
@@ -4261,6 +4320,15 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	if (!info->pri_enabled)
 		return -EINVAL;
 
+	/* Disable new PRI reception: */
+	context_flip_pri(info, false);
+
+	/*
+	 * Remove device from fault queue and acknowledge all outstanding
+	 * PRQs to the device:
+	 */
+	iopf_queue_remove_device(iommu->iopf_queue, dev);
+
 	/*
 	 * PCIe spec states that by clearing PRI enable bit, the Page
 	 * Request Interface will not issue new page requests, but has
@@ -4271,7 +4339,6 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	 */
 	pci_disable_pri(to_pci_dev(dev));
 	info->pri_enabled = 0;
-	iopf_queue_remove_device(iommu->iopf_queue, dev);
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index abce19e2ad6f..286a8a7d66f5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -768,8 +768,6 @@ static int context_entry_set_pasid_table(struct context_entry *context,
 
 	if (info->ats_supported)
 		context_set_sm_dte(context);
-	if (info->pri_supported)
-		context_set_sm_pre(context);
 	if (info->pasid_supported)
 		context_set_pasid(context);
 
-- 
2.34.1

