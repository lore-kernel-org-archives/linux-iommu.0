Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82724284B54
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273429; cv=none; b=HnU5MjeTxtYM5udP1SLT0j/T1COV8LiNaZHGxVoVLa87oelK0IEH32IOx09hL0H33H+SxBfyRagaF4GCgCg2f7rnEb74fRWP0YEcehq1lLdkL8gfORloSt6b0ngjFw6kxMLP8ryKtArnBdmYXBFzhqeTum8J3RUz8xMeu012XqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273429; c=relaxed/simple;
	bh=vpQmtFcYyvXhJjGFzwep4c/sUwuL2zqWsF6tyxvMNNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzNCMfTiOayQuGKTfgZxLgpSGAYlBf2GGMz2FTzL4Sqey+e+UkqE79a4ylN/nVHKt6BlapzCdEmJSIhTYC0W1yuJ0cWbORI1JGa2FuRmgCBxcXTgdA4WMpKYQPXvAMettPRA8cXA1t6EMuiKuu1YzSl0pQ4LcrxhEIsQBKonZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELPU3RSG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELPU3RSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768273412; x=1799809412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vpQmtFcYyvXhJjGFzwep4c/sUwuL2zqWsF6tyxvMNNI=;
  b=ELPU3RSGi7ZZLLNvqzw1Hv26/n0IvF4qb2walS4KG6ULDCJ0iW4K8Ip0
   kisWpQjzhQTbiUdkdH4dBCT19Mw5cTCDOIXFSTsUYbLLMprH87oViDSAz
   /fx/td5vjAr+EYgNJDbSGzYgWwmiv/mWffv3X9AEFGnBF5UJ4vYynUshD
   juiUGlgyhmcJbYigz1XKqvz7j7b4dFZuDifOvgEFlNk5/XYSMwFsquSX+
   FNVeZRQYt/IO1YtWzgy9O5Mvza3kBJVjkvLzN1pvab1GZlqyfNUcN5F9d
   XwLG1nUk+Wk9paZIBSbcHKJ5fb64Xk2SHzjrvkW7fdvg7ccGAn+lwVbAD
   w==;
X-CSE-ConnectionGUID: PFg033u+R/i/JH3cJiHnow==
X-CSE-MsgGUID: PpzjXyYVRsiFbpSBQuP7Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69607488"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69607488"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 19:03:31 -0800
X-CSE-ConnectionGUID: FPedHVmZSGKZpdXvJ5i/Jw==
X-CSE-MsgGUID: VfvaErJISgCSgvVjMPtGfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203466949"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 12 Jan 2026 19:03:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context entries
Date: Tue, 13 Jan 2026 11:00:46 +0800
Message-ID: <20260113030052.977366-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113030052.977366-1-baolu.lu@linux.intel.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Intel IOMMU, device context entries are accessed by hardware in
128-bit chunks. Currently, the driver updates these entries by
programming the 'lo' and 'hi' 64-bit fields individually.

This creates a potential race condition where the IOMMU hardware may fetch
a context entry while the CPU has only completed one of the two 64-bit
writes. This "torn" entry — consisting of half-old and half-new data —
could lead to unpredictable hardware behavior, especially when
transitioning the 'Present' bit or changing translation types.

To ensure the IOMMU hardware always observes a consistent state, use
128-bit atomic updates for context entries. This is achieved by building
context entries on the stack and write them to the table in a single
operation.

As this relies on arch_cmpxchg128_local(), restrict INTEL_IOMMU
dependencies to X86_64.

Fixes: ba39592764ed2 ("Intel IOMMU: Intel IOMMU driver")
Reported-by: Dmytro Maluka <dmaluka@chromium.org>
Closes: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/Kconfig |  2 +-
 drivers/iommu/intel/iommu.h | 22 ++++++++++++++++++----
 drivers/iommu/intel/iommu.c | 30 +++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 18 +++++++++---------
 4 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 5471f814e073..efda19820f95 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -11,7 +11,7 @@ config DMAR_DEBUG
 
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
-	depends on PCI_MSI && ACPI && X86
+	depends on PCI_MSI && ACPI && X86_64
 	select IOMMU_API
 	select GENERIC_PT
 	select IOMMU_PT
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 25c5e22096d4..b8999802f401 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -546,6 +546,16 @@ struct pasid_entry;
 struct pasid_state_entry;
 struct page_req_dsc;
 
+static __always_inline void intel_iommu_atomic128_set(u128 *ptr, u128 val)
+{
+	/*
+	 * Use the cmpxchg16b instruction for 128-bit atomicity. As updates
+	 * are serialized by a spinlock, we use the local (unlocked) variant
+	 * to avoid unnecessary bus locking overhead.
+	 */
+	arch_cmpxchg128_local(ptr, *ptr, val);
+}
+
 /*
  * 0: Present
  * 1-11: Reserved
@@ -569,8 +579,13 @@ struct root_entry {
  * 8-23: domain id
  */
 struct context_entry {
-	u64 lo;
-	u64 hi;
+	union {
+		struct {
+			u64 lo;
+			u64 hi;
+		};
+		u128 val128;
+	};
 };
 
 struct iommu_domain_info {
@@ -946,8 +961,7 @@ static inline int context_domain_id(struct context_entry *c)
 
 static inline void context_clear_entry(struct context_entry *context)
 {
-	context->lo = 0;
-	context->hi = 0;
+	intel_iommu_atomic128_set(&context->val128, 0);
 }
 
 #ifdef CONFIG_INTEL_IOMMU
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 134302fbcd92..d721061ebda2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1147,8 +1147,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			domain_lookup_dev_info(domain, iommu, bus, devfn);
 	u16 did = domain_id_iommu(domain, iommu);
 	int translation = CONTEXT_TT_MULTI_LEVEL;
+	struct context_entry *context, new = {0};
 	struct pt_iommu_vtdss_hw_info pt_info;
-	struct context_entry *context;
 	int ret;
 
 	if (WARN_ON(!intel_domain_is_ss_paging(domain)))
@@ -1170,19 +1170,19 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		goto out_unlock;
 
 	copied_context_tear_down(iommu, context, bus, devfn);
-	context_clear_entry(context);
-	context_set_domain_id(context, did);
+	context_set_domain_id(&new, did);
 
 	if (info && info->ats_supported)
 		translation = CONTEXT_TT_DEV_IOTLB;
 	else
 		translation = CONTEXT_TT_MULTI_LEVEL;
 
-	context_set_address_root(context, pt_info.ssptptr);
-	context_set_address_width(context, pt_info.aw);
-	context_set_translation_type(context, translation);
-	context_set_fault_enable(context);
-	context_set_present(context);
+	context_set_address_root(&new, pt_info.ssptptr);
+	context_set_address_width(&new, pt_info.aw);
+	context_set_translation_type(&new, translation);
+	context_set_fault_enable(&new);
+	context_set_present(&new);
+	intel_iommu_atomic128_set(&context->val128, new.val128);
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(context, sizeof(*context));
 	context_present_cache_flush(iommu, did, bus, devfn);
@@ -3771,8 +3771,8 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 static int context_setup_pass_through(struct device *dev, u8 bus, u8 devfn)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct context_entry *context, new = {0};
 	struct intel_iommu *iommu = info->iommu;
-	struct context_entry *context;
 
 	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 1);
@@ -3787,17 +3787,17 @@ static int context_setup_pass_through(struct device *dev, u8 bus, u8 devfn)
 	}
 
 	copied_context_tear_down(iommu, context, bus, devfn);
-	context_clear_entry(context);
-	context_set_domain_id(context, FLPT_DEFAULT_DID);
+	context_set_domain_id(&new, FLPT_DEFAULT_DID);
 
 	/*
 	 * In pass through mode, AW must be programmed to indicate the largest
 	 * AGAW value supported by hardware. And ASR is ignored by hardware.
 	 */
-	context_set_address_width(context, iommu->msagaw);
-	context_set_translation_type(context, CONTEXT_TT_PASS_THROUGH);
-	context_set_fault_enable(context);
-	context_set_present(context);
+	context_set_address_width(&new, iommu->msagaw);
+	context_set_translation_type(&new, CONTEXT_TT_PASS_THROUGH);
+	context_set_fault_enable(&new);
+	context_set_present(&new);
+	intel_iommu_atomic128_set(&context->val128, new.val128);
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(context, sizeof(*context));
 	context_present_cache_flush(iommu, FLPT_DEFAULT_DID, bus, devfn);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3e2255057079..298a39183996 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -978,23 +978,23 @@ static int context_entry_set_pasid_table(struct context_entry *context,
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct pasid_table *table = info->pasid_table;
 	struct intel_iommu *iommu = info->iommu;
+	struct context_entry new = {0};
 	unsigned long pds;
 
-	context_clear_entry(context);
-
 	pds = context_get_sm_pds(table);
-	context->lo = (u64)virt_to_phys(table->table) | context_pdts(pds);
-	context_set_sm_rid2pasid(context, IOMMU_NO_PASID);
+	new.lo = (u64)virt_to_phys(table->table) | context_pdts(pds);
+	context_set_sm_rid2pasid(&new, IOMMU_NO_PASID);
 
 	if (info->ats_supported)
-		context_set_sm_dte(context);
+		context_set_sm_dte(&new);
 	if (info->pasid_supported)
-		context_set_pasid(context);
+		context_set_pasid(&new);
 	if (info->pri_supported)
-		context_set_sm_pre(context);
+		context_set_sm_pre(&new);
 
-	context_set_fault_enable(context);
-	context_set_present(context);
+	context_set_fault_enable(&new);
+	context_set_present(&new);
+	intel_iommu_atomic128_set(&context->val128, new.val128);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 
 	return 0;
-- 
2.43.0

