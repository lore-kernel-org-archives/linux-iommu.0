Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0B1A38C9
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925896; cv=none; b=nun09Qi00R70lZl9Xtf6QLJhqqyyG6ep+s1OtMYM6Kr8vGvq2o/QbcLgVM6v3yPKFX96pNEPdk18ZyV4IMLkqyNF9QIdWe0B8aFOLYVdFnW8vI/WkRWiIT/980sN3t9uEVHYAxj50+S5iuD/Y3mNMyDgLh3+946ZrQh421YJssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925896; c=relaxed/simple;
	bh=8DubyyvfbPbhzdVg5JO3BEs+xC3OwobKlE3sMCu9O4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnCSVY633Bhyf5GDcqufmdxKmnkemTNmkO/bhdBG80UY48DyzKfFbl5e7wqRdCQ/WWL0XIeMY47vrHDNgvid/bfjv2COtPRSx7pH3qB0PDs0zv5U6WPR5VUPzNTFoXtyW5JFvOnrTvCjWcxy/7ePkS/QxRD7KNq2n3pZXL0IuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVCitAiu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVCitAiu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719925895; x=1751461895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8DubyyvfbPbhzdVg5JO3BEs+xC3OwobKlE3sMCu9O4M=;
  b=eVCitAiuxxcwz1ly6umnrXvFkl6iZCMuW9wEc/Yr1VK4lVDZ3RUucgtt
   9QnpULqATmgvA2ISZlcHtctjlbAKDUu1xcwBihoZ51HAy83YwCLXeoIEP
   bYAyC7A9+ELzZHjaT8LDVG0JA7C5Cz6gBqX8MHQaKEVLi1alaZ/eIoQ5n
   RhQHmVJvY8OE4IezFkp3bmJPKqRJ4XoJmaktqOsdMaVggpADk7BVhVRno
   k3dFV0kd+0PjrDgV4zGQ+RbRmz/LXS8oT0Ti912tO8qea5+7fEJAB1RI0
   RXtFR+gzVrIu502h8qMqusi4MRSuJ0IimsAeg5ykuxuLnHC4D3/psJSGY
   g==;
X-CSE-ConnectionGUID: HhY9WEyySuGHPuqQsYdMYg==
X-CSE-MsgGUID: pZBjipJCTj234Rsh6c++Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27700042"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27700042"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:11:35 -0700
X-CSE-ConnectionGUID: M7hf1w2UQoang71wr/KrIQ==
X-CSE-MsgGUID: tDJUHapaTXOGi4++D7JPSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50250856"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 06:11:33 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
Date: Tue,  2 Jul 2024 21:08:39 +0800
Message-Id: <20240702130839.108139-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702130839.108139-1-baolu.lu@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240701112317.94022-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  9 ++++++
 drivers/iommu/intel/iommu.c | 57 +++++++++++++++++++++++++++++++++----
 drivers/iommu/intel/pasid.c |  2 --
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 63eb3306c025..b67c14da1240 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1045,6 +1045,15 @@ static inline void context_set_sm_pre(struct context_entry *context)
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
index e84b0fdca107..523407f6f6b2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4244,6 +4244,37 @@ static int intel_iommu_enable_sva(struct device *dev)
 	return 0;
 }
 
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
+	intel_context_flush_present(info, context, true);
+	spin_unlock(&iommu->lock);
+
+	return 0;
+}
+
 static int intel_iommu_enable_iopf(struct device *dev)
 {
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
@@ -4273,15 +4304,23 @@ static int intel_iommu_enable_iopf(struct device *dev)
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
@@ -4292,6 +4331,15 @@ static int intel_iommu_disable_iopf(struct device *dev)
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
@@ -4302,7 +4350,6 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	 */
 	pci_disable_pri(to_pci_dev(dev));
 	info->pri_enabled = 0;
-	iopf_queue_remove_device(iommu->iopf_queue, dev);
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index d6623d2c2050..9a7b5668c723 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -749,8 +749,6 @@ static int context_entry_set_pasid_table(struct context_entry *context,
 
 	if (info->ats_supported)
 		context_set_sm_dte(context);
-	if (info->pri_supported)
-		context_set_sm_pre(context);
 	if (info->pasid_supported)
 		context_set_pasid(context);
 
-- 
2.34.1

