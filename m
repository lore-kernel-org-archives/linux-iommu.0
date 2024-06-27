Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2971171C
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455650; cv=none; b=HbEKV6isRS35Is+tAAsJO1cnhWbPVpVBVgWhrKCpJmBcG+UQ+Pd0N6hKg52XHYEPWcOnCutKNahQ9J1g+gtOBqxHul/fpyJhV5MZi5UhZ9ZqrBAI5fHiCdvVWofBRjHwtxEfWzJ2Kj35M9pENuRQDI1ijTrM1yQztWDJke0aNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455650; c=relaxed/simple;
	bh=IPj5UlSmlPQRPZvxU93+IxrZCbUC9raz/ITLzuv5H9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Udd+sA/PBrhrEG7A6q1tyII2dvTzGZETmUtYxB9WVSru+aOPzS01mU5WZHcpWexyezHIVOOZCFZ85H9EcMdw8XXXQfjQgrrln1PNrkKtHjfiVMFW66eFGV552XSzU2R12RnvBWPs16kMvz4dsy4Is8JnBnVAzrnUJp7XPzdZXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+AtQgvL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+AtQgvL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719455649; x=1750991649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPj5UlSmlPQRPZvxU93+IxrZCbUC9raz/ITLzuv5H9Q=;
  b=B+AtQgvL5mXHxenRlc2QbFuLvH+shSWbQrQyakC/bOgbcTFSPahL+6RS
   GelcQ8x/Xl6wT5jXplv+5nQDoS6EkjifGUH7QGxOYdpnf2uKvXcyWdu+7
   cPGxPodXY/AIBJy3hFp7YzGvAqP5HehBVByR/zX7KEmokLp8lsmNXkXwK
   q86gfuybqe42bTJyXRUy5TVzPxbXGs7f9Tig0jk6v4fe9CrPb/X4cXVkN
   BVs2svASpxUN7UVczSYh3Vz+jkS4jh1FTJ3AD2m6vGgsiWBPUtrsV/6ke
   XoVTbj0MoPn9KIN/WKquVt+c1nP2KBzrEpLNOz371VBZlVgXqVGzEFLNI
   Q==;
X-CSE-ConnectionGUID: +0eO+pphTGOW/kO/LvObFg==
X-CSE-MsgGUID: 9naHHgdNQLKQgPXmXj0vmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16786024"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16786024"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:34:09 -0700
X-CSE-ConnectionGUID: 7qjr6PfuRlGSaf135jn9Wg==
X-CSE-MsgGUID: xKp/sHKnQ6K6gz2KZRnA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="49385444"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 26 Jun 2024 19:34:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/2] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
Date: Thu, 27 Jun 2024 10:31:21 +0800
Message-Id: <20240627023121.50166-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627023121.50166-1-baolu.lu@linux.intel.com>
References: <20240627023121.50166-1-baolu.lu@linux.intel.com>
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
index 89f489372138..d51f840715e5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4241,6 +4241,37 @@ static int intel_iommu_enable_sva(struct device *dev)
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
@@ -4270,15 +4301,23 @@ static int intel_iommu_enable_iopf(struct device *dev)
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
@@ -4289,6 +4328,15 @@ static int intel_iommu_disable_iopf(struct device *dev)
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
@@ -4299,7 +4347,6 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	 */
 	pci_disable_pri(to_pci_dev(dev));
 	info->pri_enabled = 0;
-	iopf_queue_remove_device(iommu->iopf_queue, dev);
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index aef4b4afb873..b1ec9660bc11 100644
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

