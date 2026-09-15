Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C93A8FE6;
	Tue, 15 Sep 2026 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458903; cv=none; b=JzsYWodtJ4+ZNIeWaHo1yQZtmr427bXVfKxBHUjX2yBdWuqBp+J8sEpSZA1+jmMRRiUPMvqxbsjQBcjAGHTo92ut9o4727tNYz9E92tvS71uuX2sgkn/UiN/xDTo2T7bZcy1IZOYuzNZfJM38STkTI5Q03XtHgoI08uMt7qJL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458903; c=relaxed/simple;
	bh=PSP+Ld5/cNJ/yoPq1JAlz1JzfiwAv9LxOh9c5RJ+RhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwwPLCRxHBxVRDgeXK13HXHXyT9TIHlfrFBzYvfLxPYQLNAmO/p+LaynORaMegsKvdf/W5KdlU6BmCoe9sfhO1XrO2Twspxr7rdicJqqgGTZFM+pMTkE60XCDLPyY3tdnK+2MO2U5t1beQng1e/06MYXuBzEImw9/lZhnKMR4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atXb8THI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atXb8THI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789458900; x=1820994900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSP+Ld5/cNJ/yoPq1JAlz1JzfiwAv9LxOh9c5RJ+RhE=;
  b=atXb8THIO0ZHxgC6RP6TKtF1WmFmwobNxSnJvz5YTxb+sAvkgoLQQaPv
   kwG1GYuLFFtAC3P0n7inyXPJpP4MMIrfQ4M9L1bRzno73OEhH6UeFCPWW
   +cwh0zp7S4wkUJ0niQIzQ2LAtLCiUTFoPtsPhux+h/dFv147cy+XrpDZc
   DR4h/sWy9LqjNKDUtp1QfSHg9fb16GWpd27eNLLOKe1yQZmFki+1APjA2
   pzF0AUvSozZsXw6hSlA1FLGEtLB7ktMgjVwm7W2BZLA2sWgIE34Owjx33
   vw+41/Y/sgxbRCrYaMvTN4nd/gFt2zeRoencGh2eQrmKrL24RJTx7p2ud
   g==;
X-CSE-ConnectionGUID: vAixSc3uSEeJPU30ti3vMw==
X-CSE-MsgGUID: nHhcr8S6Sn2q2aDH06Jw0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101163807"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101163807"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:54:59 -0700
X-CSE-ConnectionGUID: FsJmtf+PQDuLTerQxrA4JA==
X-CSE-MsgGUID: /N9wrT6bQqiKew+1t9Dhfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269205484"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa010.fm.intel.com with ESMTP; 15 Sep 2026 00:54:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/5] iommu/vt-d: Add helpers to set up and tear down TDX extensions
Date: Tue, 15 Sep 2026 15:42:32 +0800
Message-ID: <20260915074235.1219183-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
References: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement per-IOMMU TDX Connect bring-up/tear-down helpers.

For each active IOMMU that advertises TDXCS and has DMA translation
enabled, the driver allocates and populates the IOMMU_MT parameter
layout required by TDH.IOMMU.SETUP:

- two contiguous invalidation-queue buffers, and
- IOMMU_MT_PAGES_COUNT metadata pages.

The driver invokes tdh_iommu_setup() to transition the IOMMU into Secure
TDX Mode, then stores the returned tdx_iommu_id and allocation state for
later cleanup.

On teardown, or on partial-init rollback, the driver calls
tdh_iommu_clear() for each initialized IOMMU and frees all associated
IOMMU_MT pages.

Completion handling:

- TDX_SUCCESS: setup completed successfully.
- TDX_OPERAND_INVALID: treated as "not supported on this IOMMU" and
  skipped.
- all other return codes: treated as failures and abort initialization
  with rollback.

No explicit clflush is needed for pages shared with the TDX module in
this flow, as cache coherency is handled architecturally.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  17 ++++
 drivers/iommu/intel/dmar.c  |   3 +
 drivers/iommu/intel/tdxc.c  | 150 ++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 452a381e6a40..7bf70113c4c8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -680,6 +680,17 @@ struct iommu_pmu {
 #define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
 #define IOMMU_IRQ_ID_OFFSET_PERF	(2 * DMAR_UNITS_SUPPORTED)
 
+/*
+ * Represents a list of pages for TDX Module defined IOMMU_MT object.
+ * Typically it uses a "root page" as the medium to exchange a list of
+ * data pages between host and TDX Module.
+ */
+struct tdxc_pages {
+	u64 *root;
+	void **pages;
+	unsigned int nr_entries;
+};
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -736,6 +747,12 @@ struct intel_iommu {
 	void *perf_statistic;
 
 	struct iommu_pmu *pmu;
+#ifdef CONFIG_INTEL_IOMMU_TDX_CONNECT
+	/* mutex to protect below tdx state data */
+	struct mutex tdx_lock;
+	u64 tdx_iommu_id;
+	struct tdxc_pages *mt_pages;
+#endif
 };
 
 /* PCI domain-device relationship */
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b08cd20..310b8d0c4132 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1175,6 +1175,9 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	ida_init(&iommu->domain_ida);
 	mutex_init(&iommu->did_lock);
 	iommu->max_domain_id = cap_ndoms(iommu->cap);
+#ifdef CONFIG_INTEL_IOMMU_TDX_CONNECT
+	mutex_init(&iommu->tdx_lock);
+#endif
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
diff --git a/drivers/iommu/intel/tdxc.c b/drivers/iommu/intel/tdxc.c
index 559c752a1527..b5dfdeeb23db 100644
--- a/drivers/iommu/intel/tdxc.c
+++ b/drivers/iommu/intel/tdxc.c
@@ -10,12 +10,128 @@
 #include <linux/pci.h>
 #include <asm/vmx.h>
 #include <asm/tdx.h>
+
+#include "../iommu-pages.h"
 #include "iommu.h"
 
+#define IQ_BUFFERS_NUM		2
+#define IQ_BUFFER_PAGES		2
+#define IQ_BUFFER_SIZE		SZ_8K
+
 bool intel_tdxc_initialized;
 
+static void free_mt_pages(struct tdxc_pages *array)
+{
+	if (!array)
+		return;
+
+	for (int i = 0; i < array->nr_entries; i++)
+		iommu_free_pages(array->pages[i]);
+
+	iommu_free_pages(array->root);
+	kfree(array->pages);
+	kfree(array);
+}
+
+DEFINE_FREE(free_mt_pages, struct tdxc_pages *, free_mt_pages(_T))
+
+static void **alloc_mt_pages(unsigned int nr_entries, int node)
+{
+	void **pages;
+	void *vaddr;
+	int i;
+
+	pages = kzalloc_objs(*pages, nr_entries);
+	if (!pages)
+		return NULL;
+
+	/* Allocate two contiguous buffers for the invalidation queue. */
+	pages[0] = iommu_alloc_pages_node_sz(node, GFP_KERNEL, IQ_BUFFER_SIZE);
+	if (!pages[0])
+		goto free_pages;
+
+	pages[1] = iommu_alloc_pages_node_sz(node, GFP_KERNEL, IQ_BUFFER_SIZE);
+	if (!pages[1])
+		goto free_pages;
+
+	/* Allocate the required number of pages for the IOMMU metadata. */
+	for (i = IQ_BUFFERS_NUM; i < nr_entries; i++) {
+		vaddr = iommu_alloc_pages_node_sz(node, GFP_KERNEL, SZ_4K);
+		if (!vaddr)
+			goto free_pages;
+		pages[i] = vaddr;
+	}
+
+	return pages;
+free_pages:
+	for (i = 0; i < nr_entries; i++) {
+		if (!pages[i])
+			break;
+
+		iommu_free_pages(pages[i]);
+	}
+	kfree(pages);
+
+	return NULL;
+}
+
+static void populate_mt_pages(struct tdxc_pages *array)
+{
+	unsigned int nr_entries = array->nr_entries;
+	void **pages = array->pages;
+	u64 *entries = array->root;
+	int i;
+
+	/*
+	 * Populate the parameter for the TDH_IOMMU_SETUP SEAMCALL according to
+	 * the format defined in "Table 3.35: Structure of IOMMU_MT Parameter"
+	 * of the ABI reference specification.
+	 */
+	for (i = 0; i < nr_entries; i++) {
+		entries[i] = __pa(pages[i]);
+		if (i < IQ_BUFFERS_NUM)
+			entries[i] |= IQ_BUFFER_PAGES;
+	}
+}
+
+static struct tdxc_pages *tdxc_alloc_mt_pages(struct intel_iommu *iommu,
+					      unsigned int nr_mt_pages)
+{
+	unsigned int nr_entries = nr_mt_pages + IQ_BUFFERS_NUM;
+	struct tdxc_pages *array;
+
+	if (!nr_mt_pages || nr_mt_pages > (PAGE_SIZE / sizeof(u64) - IQ_BUFFERS_NUM))
+		return NULL;
+
+	array = kzalloc_obj(*array);
+	if (!array)
+		return NULL;
+
+	array->root = iommu_alloc_pages_node_sz(iommu->node, GFP_KERNEL, SZ_4K);
+	if (!array->root)
+		goto free_array;
+
+	array->nr_entries = nr_entries;
+	array->pages = alloc_mt_pages(nr_entries, iommu->node);
+	if (!array->pages)
+		goto free_root;
+
+	populate_mt_pages(array);
+
+	return array;
+
+free_root:
+	iommu_free_pages(array->root);
+free_array:
+	kfree(array);
+	return NULL;
+}
+
 static int intel_iommu_bringup_tdxc(struct intel_iommu *iommu, unsigned int nr_pages)
 {
+	struct dmar_drhd_unit *drhd = iommu->drhd;
+	u64 r, tdx_iommu_id;
+
 	/*
 	 * Nothing to do if the iommu doesn't support TDX extension or the
 	 * DMA translation has not been enabled.
@@ -23,12 +139,46 @@ static int intel_iommu_bringup_tdxc(struct intel_iommu *iommu, unsigned int nr_p
 	if (!ecap_tdxcs(iommu->ecap) || !(iommu->gcmd & DMA_GCMD_TE))
 		return 0;
 
+	struct tdxc_pages *iommu_mt __free(free_mt_pages) =
+			tdxc_alloc_mt_pages(iommu, nr_pages);
+	if (!iommu_mt)
+		return -ENOMEM;
+
+	guard(mutex)(&iommu->tdx_lock);
+	r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt->root, &tdx_iommu_id);
+	/* TDX Extension is not supported on this iommu. Nothing to do. */
+	if ((r & TDX_SEAMCALL_STATUS_MASK) == TDX_OPERAND_INVALID)
+		return 0;
+	if (r) {
+		pr_err("%s: TDH.IOMMU.SETUP failed, status 0x%llx\n", iommu->name, r);
+		return -EFAULT;
+	}
+
+	iommu->tdx_iommu_id = tdx_iommu_id;
+	iommu->mt_pages = no_free_ptr(iommu_mt);
+
 	/* Bring-up is not complete yet; report as unsupported for now. */
 	return -EOPNOTSUPP;
 }
 
 static void intel_iommu_teardown_tdxc(struct intel_iommu *iommu)
 {
+	u64 r;
+
+	guard(mutex)(&iommu->tdx_lock);
+
+	if (!iommu->mt_pages)
+		return;
+
+	r = tdh_iommu_clear(iommu->tdx_iommu_id);
+	if (r) {
+		pr_err("%s: TDH.IOMMU.CLEAR failed, status 0x%llx\n", iommu->name, r);
+		return;
+	}
+
+	free_mt_pages(iommu->mt_pages);
+	iommu->mt_pages = NULL;
+	iommu->tdx_iommu_id = 0;
 }
 
 void intel_tdxc_exit(void)
-- 
2.43.0

