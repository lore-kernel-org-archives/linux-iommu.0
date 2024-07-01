Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2513E881
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833171; cv=none; b=I1CozqbWsWCTInHU4xlZuslH7L03kgu2jGT1HSHnssM/Gu///A1F1NbsUPeFzmYR3K3SDZP0/R+1YHTlAp5jqJ2QsoGAG2H0oJcWcRl08s1bU40ZCXbmjdZcPOp0G1iUSYJyA4tsbLOTBobGI7jOEJDvbw/MnvI6s0e5YdcRmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833171; c=relaxed/simple;
	bh=U1/5xZ88mpV+ZF8ju2FWT/lZTIezJ16/Q9Ox9bMaOwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVM7z1E1930CLaQoEnO95+ik/f7KGheEvJIup7cevntosGW5htHofNFJl7uu+xdEjhPobkSUQfNIrXT25BKyMUffpzM5uJl6jJVIi6ShECMZVCMaAlhoW6GjS7CC+vC7a8GIRK1WjKgorfWVpdW+jYswJi1P/H9zj/9S5JpOo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7xcgQiV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7xcgQiV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719833170; x=1751369170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U1/5xZ88mpV+ZF8ju2FWT/lZTIezJ16/Q9Ox9bMaOwQ=;
  b=F7xcgQiVABwVloRBEKrY7a7CwLVhzNVRTngO5t0DWzABouDe8cFoS0qt
   4FwxDDJUnuqeUr7qawByr/XLfuOwZTHQ4iOvY80V6wGlg59DCqGts9pSj
   083cVqp4S+cprxGw4lw58+CiqLor/4DFZjoRZh4N3bjDS/PrD+RZRkTws
   747ZXJjltgzeADfvhEYzLGcwENUZybK1hIzFLgZJRJOdr9JwvfE1maBoe
   av1KqNSSOhJlRfTYSnMLJ5FSSqved7yu12khtr/c9lqnqPr9zxs44RwTc
   KsmU8X7mJM25lDviQxcJcCQXrXM7WLIfWDKK4Hc2EQ7akoacHed3tL9CV
   Q==;
X-CSE-ConnectionGUID: ahQPIw+aRb+dlPT/ZNFGKQ==
X-CSE-MsgGUID: nY3MgQJ/QDOmCqhdDXYYtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17082666"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17082666"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 04:26:09 -0700
X-CSE-ConnectionGUID: aMtpQnM2Qvu/H75Bg7yBxQ==
X-CSE-MsgGUID: Uen45B8GSkCb6lFbj2Ah1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45481475"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 01 Jul 2024 04:26:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 2/2] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
Date: Mon,  1 Jul 2024 19:23:17 +0800
Message-Id: <20240701112317.94022-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701112317.94022-1-baolu.lu@linux.intel.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
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

