Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01220221DAE;
	Thu, 15 Oct 2026 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027198; cv=none; b=Bz1RWN0mCdKNuAeENhehVzUxOTrr2+BcpiO6TkoRvMVq2WNiZ0nE0OmC+zaKsBZBm+SYAYzaVW0p/2f9wT7gA/L+SdQz6xtgcETg2TmAvlyCvNmjp3Iau2wcHWo74xfm/N3WtLe8adr7mVjExuSs0GhQKrMCFo1nXax+h0ytSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027198; c=relaxed/simple;
	bh=HPrbl+lT5yD2UVYKphnxQ83FYkQzjZQ9ECFf/U33iRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNYCOwvrnL8+2DvBzouGBtemKgAZVFiPBBPKcCPvfhNZRet8RJXGbis1Y6KOeIU0MRZqPFgZATozqEB6bc7AuMbyw/rfbqu+UBmZOP28fEKiYuM07Z5+L/rnW1bCO5WP9jiy8ia357nRmHax60K35yCR2raf9kNVcpcd1M56No8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Man+5uNf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Man+5uNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792027196; x=1823563196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPrbl+lT5yD2UVYKphnxQ83FYkQzjZQ9ECFf/U33iRQ=;
  b=Man+5uNfVl/ipBIEnbw/XBlMSE92sxUTXIuRzyelyU8qGm3jnB3DiWQj
   +crH4yHX3iub793ZZXvVarSCktDUoWg26EB39/O4cb/zLYkJ/CjmBC//S
   FYcqY8uFLeRZhFL6RSVbIk6fQ+qsb7Vv68H9WltQfVF3g9yHTVCu3rqop
   L1Del0lSlTMpFE3wEvNfwftvixm+SUG7JdIBUTrjkcZZ/GIRSLjZ8FPik
   acT6GxzwfVoSDFtDiDfT34QnTcZGVKvS5dEQoTWJRBZK36j2Zdm+el/tq
   +LeiF9NHKuQM28yxOBHPUDHKEl3E9KZZQRdrNQPP7MFVib10pzQ0pLcIC
   g==;
X-CSE-ConnectionGUID: 3i82/XjpQW6xUow2Ik98Kw==
X-CSE-MsgGUID: JwYQwbftRW2oWjwhQanmgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="789221"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="789221"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 18:19:56 -0700
X-CSE-ConnectionGUID: XMcZigJfSpGSuw8JqxfggA==
X-CSE-MsgGUID: aoMPD6+gSc+gMxOLAXfP/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1595603"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2026 18:19:51 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all capable IOMMUs
Date: Thu, 15 Oct 2026 09:07:05 +0800
Message-ID: <20261015010705.1973284-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assigning a device to a TD for private memory access requires that DMA
from that device be translated by structures the TDX module controls.
An Intel IOMMU that implements the trusted DMA extension provides a
parallel set of translation and invalidation resources for this purpose.
These become usable only after the TDX module has placed the IOMMU into
TDX mode, at which point the trusted resources belong exclusively to the
TDX module, while the host retains control of the regular translation
path. The transition is performed by TDH.IOMMU.SETUP, which takes the
register base address of the target IOMMU together with a parameter
page describing memory the host has allocated for the TDX module to
manage trusted DMA on that unit.

Perform this initialization from the tdx-host driver by walking every
IOMMU unit through dmar_tdxcs_iommu_init() and initialize the ones whose
IOMMU implements the extension.

For each such unit the driver builds the IOMMU_MT parameter layout that
TDH.IOMMU.SETUP expects: two contiguous buffers for the trusted
invalidation queue, followed by the number of metadata pages the TDX
module reports in its global metadata. The pages are allocated on the
NUMA node of the IOMMU. The root page is passed to the TDX module, which
returns an identifier naming the initialized IOMMU. That identifier and
the pages backing it are tracked so the state can be released later.

Releasing the state is the reverse: TDH.IOMMU.CLEAR tears down the
trusted DMA resources established by TDH.IOMMU.SETUP, after which the
metadata pages can be freed and the VT-d driver told to lift the domain
ID restriction applied during initialization. If TDH.IOMMU.CLEAR fails
the pages are not freed, as the TDX module may still hold references to
them.

Rename tdx-host.c to main.c and build the module from a tdx-host-y
object list instead. New functionality can then be added as separate
source files instead of putting everything in a single file.

The code is built only when its dependencies are present, gated by
CONFIG_TDX_CONNECT.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/virt/coco/tdx-host/Kconfig            |   6 +
 drivers/virt/coco/tdx-host/Makefile           |   3 +
 drivers/virt/coco/tdx-host/private.h          |  33 +++
 drivers/virt/coco/tdx-host/iommu.c            | 255 ++++++++++++++++++
 .../virt/coco/tdx-host/{tdx-host.c => main.c} |  21 +-
 5 files changed, 317 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/coco/tdx-host/private.h
 create mode 100644 drivers/virt/coco/tdx-host/iommu.c
 rename drivers/virt/coco/tdx-host/{tdx-host.c => main.c} (92%)

diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index 57d0c01a4357..62d91d4b41fa 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -4,3 +4,9 @@ config TDX_HOST_SERVICES
 	select FW_LOADER
 	select FW_UPLOAD
 	default m
+
+config TDX_CONNECT
+	def_bool y
+	depends on TDX_HOST_SERVICES
+	depends on PCI_TSM
+	depends on INTEL_IOMMU
diff --git a/drivers/virt/coco/tdx-host/Makefile b/drivers/virt/coco/tdx-host/Makefile
index e61e749a8dff..67bfe5a6e290 100644
--- a/drivers/virt/coco/tdx-host/Makefile
+++ b/drivers/virt/coco/tdx-host/Makefile
@@ -1 +1,4 @@
 obj-$(CONFIG_TDX_HOST_SERVICES) += tdx-host.o
+
+tdx-host-y := main.o
+tdx-host-$(CONFIG_TDX_CONNECT) += iommu.o
diff --git a/drivers/virt/coco/tdx-host/private.h b/drivers/virt/coco/tdx-host/private.h
new file mode 100644
index 000000000000..131c1782cbc1
--- /dev/null
+++ b/drivers/virt/coco/tdx-host/private.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Intel Corporation */
+#ifndef __TDX_HOST_PRIVATE_H
+#define __TDX_HOST_PRIVATE_H
+
+#include <linux/dmar.h>
+
+/*
+ * Represents a list of pages for TDX module defined IOMMU_MT object.
+ * Typically it uses a "root page" as the medium to exchange a list of
+ * data pages between host and TDX module.
+ */
+struct tdx_iommu_pages {
+	u64 *root;
+	void **pages;
+	unsigned int nr_entries;
+};
+
+struct tdx_iommu_state {
+	struct dmar_drhd_unit *drhd;
+	u64 tdx_iommu_id;
+	struct tdx_iommu_pages *mt_pages;
+};
+
+#ifdef CONFIG_TDX_CONNECT
+int tdx_iommu_enable_all(struct device *dev);
+#else
+static inline int tdx_iommu_enable_all(struct device *dev)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_TDX_CONNECT */
+#endif /* __TDX_HOST_PRIVATE_H */
diff --git a/drivers/virt/coco/tdx-host/iommu.c b/drivers/virt/coco/tdx-host/iommu.c
new file mode 100644
index 000000000000..a80e57bf26a1
--- /dev/null
+++ b/drivers/virt/coco/tdx-host/iommu.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TDX IOMMU Extensions support
+ *
+ * Copyright (C) 2026 Intel Corporation
+ */
+#define pr_fmt(fmt) "tdx-host: " fmt
+
+#include <linux/pci.h>
+#include <asm/vmx.h>
+#include <asm/tdx.h>
+
+#include "private.h"
+
+/* These describe the trusted invalidation queue buffers. */
+#define IQ_BUFFERS_NUM		2
+#define IQ_BUFFER_PAGES		2
+#define IQ_BUFFER_SIZE		SZ_8K
+
+/* The IOMMU_MT root page holds one u64 entry per metadata page. */
+#define MT_ROOT_SIZE		SZ_4K
+#define MT_MAX_ENTRIES		(MT_ROOT_SIZE / sizeof(u64))
+
+static void *tdx_iommu_alloc_pages(int node, size_t size)
+{
+	struct folio *folio;
+
+	if (node == NUMA_NO_NODE)
+		node = numa_mem_id();
+
+	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, get_order(size), node);
+	if (!folio)
+		return NULL;
+
+	return folio_address(folio);
+}
+
+static void tdx_iommu_free_pages(void *virt)
+{
+	if (!virt)
+		return;
+
+	folio_put(virt_to_folio(virt));
+}
+
+static void free_mt_pages(struct tdx_iommu_pages *array)
+{
+	unsigned int i;
+
+	if (!array)
+		return;
+
+	for (i = 0; i < array->nr_entries; i++)
+		tdx_iommu_free_pages(array->pages[i]);
+
+	tdx_iommu_free_pages(array->root);
+	kfree(array->pages);
+	kfree(array);
+}
+
+DEFINE_FREE(free_mt_pages, struct tdx_iommu_pages *, free_mt_pages(_T))
+
+static void **alloc_mt_pages(unsigned int nr_entries, int node)
+{
+	unsigned int i;
+	void **pages;
+	void *vaddr;
+
+	pages = kzalloc_objs(*pages, nr_entries);
+	if (!pages)
+		return NULL;
+
+	/* Allocate two contiguous buffers for the invalidation queue. */
+	pages[0] = tdx_iommu_alloc_pages(node, IQ_BUFFER_SIZE);
+	if (!pages[0])
+		goto free_pages;
+
+	pages[1] = tdx_iommu_alloc_pages(node, IQ_BUFFER_SIZE);
+	if (!pages[1])
+		goto free_pages;
+
+	/* Allocate the required number of pages for the IOMMU metadata. */
+	for (i = IQ_BUFFERS_NUM; i < nr_entries; i++) {
+		vaddr = tdx_iommu_alloc_pages(node, SZ_4K);
+		if (!vaddr)
+			goto free_pages;
+		pages[i] = vaddr;
+	}
+
+	return pages;
+
+free_pages:
+	for (i = 0; i < nr_entries; i++)
+		tdx_iommu_free_pages(pages[i]);
+	kfree(pages);
+
+	return NULL;
+}
+
+static void populate_mt_pages(struct tdx_iommu_pages *array)
+{
+	unsigned int nr_entries = array->nr_entries;
+	void **pages = array->pages;
+	u64 *entries = array->root;
+	unsigned int i;
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
+static struct tdx_iommu_pages *
+tdx_iommu_alloc_mt_pages(struct dmar_drhd_unit *drhd, unsigned int nr_mt_pages)
+{
+	unsigned int nr_entries = nr_mt_pages + IQ_BUFFERS_NUM;
+	struct tdx_iommu_pages *array;
+
+	if (!nr_mt_pages || nr_mt_pages > MT_MAX_ENTRIES - IQ_BUFFERS_NUM)
+		return NULL;
+
+	array = kzalloc_obj(*array);
+	if (!array)
+		return NULL;
+
+	array->root = tdx_iommu_alloc_pages(drhd->node, MT_ROOT_SIZE);
+	if (!array->root)
+		goto free_array;
+
+	array->nr_entries = nr_entries;
+	array->pages = alloc_mt_pages(nr_entries, drhd->node);
+	if (!array->pages)
+		goto free_root;
+
+	populate_mt_pages(array);
+
+	return array;
+
+free_root:
+	tdx_iommu_free_pages(array->root);
+free_array:
+	kfree(array);
+	return NULL;
+}
+
+static DEFINE_XARRAY(tdx_iommu_xa);
+
+static int tdx_iommu_clear(struct tdx_iommu_state *iommu_state)
+{
+	u64 r;
+
+	if (!iommu_state->mt_pages)
+		return 0;
+
+	r = tdh_iommu_clear(iommu_state->tdx_iommu_id);
+	if (r) {
+		pr_err("TDH.IOMMU.CLEAR failed, regbase 0x%llx tdx_iommu_id 0x%llx status 0x%llx\n",
+		       iommu_state->drhd->reg_base_addr, iommu_state->tdx_iommu_id, r);
+		return -EFAULT;
+	}
+
+	free_mt_pages(iommu_state->mt_pages);
+	iommu_state->mt_pages = NULL;
+	iommu_state->tdx_iommu_id = 0;
+
+	return 0;
+}
+
+static int tdx_iommu_setup(struct dmar_drhd_unit *drhd)
+{
+	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
+	unsigned int mt_page_count = tdx_sysinfo->tdx_connect.iommu_mt_page_count;
+	struct tdx_iommu_state *state;
+	u64 r, tdx_iommu_id;
+	int ret;
+
+	struct tdx_iommu_state *iommu_state __free(kfree) = kzalloc_obj(*iommu_state);
+	if (!iommu_state)
+		return -ENOMEM;
+
+	struct tdx_iommu_pages *iommu_mt __free(free_mt_pages) =
+			tdx_iommu_alloc_mt_pages(drhd, mt_page_count);
+	if (!iommu_mt)
+		return -ENOMEM;
+
+	r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt->root, &tdx_iommu_id);
+	/* TDX Extension is not supported on this IOMMU. Nothing to do. */
+	if ((r & TDX_SEAMCALL_STATUS_MASK) == TDX_OPERAND_INVALID)
+		return -EOPNOTSUPP;
+	if (r) {
+		pr_err("TDH.IOMMU.SETUP failed, regbase 0x%llx status 0x%llx\n",
+		       drhd->reg_base_addr, r);
+		return -EFAULT;
+	}
+
+	state = no_free_ptr(iommu_state);
+	state->drhd = drhd;
+	state->tdx_iommu_id = tdx_iommu_id;
+	state->mt_pages = no_free_ptr(iommu_mt);
+	ret = xa_insert(&tdx_iommu_xa, (unsigned long)tdx_iommu_id, state, GFP_KERNEL);
+	if (ret) {
+		WARN_ON(tdx_iommu_clear(state));
+		kfree(state);
+		return ret;
+	}
+
+	pr_info("Trusted DMA for TEE initialized, regbase 0x%llx\n",
+		drhd->reg_base_addr);
+
+	return 0;
+}
+
+static void tdx_iommu_disable_all(void)
+{
+	struct tdx_iommu_state *iommu_state;
+	unsigned long tdx_iommu_id;
+
+	xa_for_each(&tdx_iommu_xa, tdx_iommu_id, iommu_state) {
+		/*
+		 * Clear failed: the IOMMU remains in Secure TDX Mode. Keep
+		 * the entry and leave drhd->tdx_mode set so the host stays
+		 * confined to the lower half of the DID space.
+		 */
+		if (tdx_iommu_clear(iommu_state))
+			continue;
+
+		xa_erase(&tdx_iommu_xa, tdx_iommu_id);
+		dmar_tdxcs_iommu_release(iommu_state->drhd);
+		kfree(iommu_state);
+	}
+}
+
+static void tdx_iommu_disable_all_action(void *unused)
+{
+	tdx_iommu_disable_all();
+}
+
+int tdx_iommu_enable_all(struct device *dev)
+{
+	int ret;
+
+	ret = dmar_tdxcs_iommu_init_all(tdx_iommu_setup);
+	if (ret) {
+		tdx_iommu_disable_all();
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, tdx_iommu_disable_all_action, NULL);
+}
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/main.c
similarity index 92%
rename from drivers/virt/coco/tdx-host/tdx-host.c
rename to drivers/virt/coco/tdx-host/main.c
index e8ed8dfa526e..018bdc475715 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/main.c
@@ -14,6 +14,8 @@
 #include <asm/seamldr.h>
 #include <asm/tdx.h>
 
+#include "private.h"
+
 static const struct x86_cpu_id tdx_host_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
 	{}
@@ -202,9 +204,26 @@ static int seamldr_init(struct device *dev)
 	return devm_add_action_or_reset(dev, seamldr_deinit, tdx_fwl);
 }
 
+static int tdx_connect_init(struct device *dev)
+{
+	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
+
+	if (!IS_ENABLED(CONFIG_TDX_CONNECT) || !tdx_sysinfo ||
+	    !(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
+		return 0;
+
+	return tdx_iommu_enable_all(dev);
+}
+
 static int tdx_host_probe(struct faux_device *fdev)
 {
-	return seamldr_init(&fdev->dev);
+	int ret;
+
+	ret = seamldr_init(&fdev->dev);
+	if (ret)
+		return ret;
+
+	return tdx_connect_init(&fdev->dev);
 }
 
 static const struct faux_device_ops tdx_host_ops = {
-- 
2.43.0

