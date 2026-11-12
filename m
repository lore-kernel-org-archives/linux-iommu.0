Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458659;
	b=yC4e5Mxmw1mSeBMuC9en+Q0rTdgeD7gLFrmHEJiW0PU84AyXzG+rTYXy+vt421Wm5PqI
	 Wr1nJ1+1jfc6ZYWgaPbPtb+02kezNN8uEcylwk6YuOxwZufxyVNyLBs2CmRDeQExkWBmU
	 cc5O0GqzZrg/zR8RyA21kH3f2lXVuNBlDzIxtShmJQKe60WFFApFixiD76p24mB1W6XHl
	 7Aifo1Dq+AOQLZ+l+96NH2xY6a3ZxV6Tm1eAqfo0bl+W1FM4sQBQhlDjuQFmil2/3drol
	 pxJPKWWIBqDfD41E4gqog3osxnP58kmAJ0euRrOoBt7LY1QKq7JH5Qj6aOSqc2yMoNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458659;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lFaTxub9P4DHIt/6xTUd6qW2koN6adpXh68Zn76OYVg=;
	b=vskl6ezkSypL62DTUfDC7qyQ7ohUOCH/RHuydbzl1DQz8L2oCrsOB8aRAIGm/wZWtar2
	 /StUBJXhg1Z0aVE/QUcqg5avzK8NJUIyEJGMOt+W2a1ZyWmUb+c/uQ3D7MbusodKRAsFR
	 Nto5QltWv9R7xluVAkRWZXrd8llNUGPUsocP0YSSwvvyy7XP2cfgBm5DaeQAZjRDrHM95
	 AKdFko2cSxHNFfk2+YW/4h9hpzaPWWyaMEFEHDeXIvEqlTV8BSTOOZeNC7MGm8hS3pmfF
	 gwfkaZ5PkCk/TJI/EqPpc6Dxxo2tkMYnxBxrzHydjdIF3lK39sa+0qYSjy8ksKdUdaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FWBtSyy0;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6E460A383F;
	Thu, 12 Nov 2026 04:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA6E460A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FWBtSyy0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458659; x=1825994659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2f49//eMco8dMFMx/hYGlnlOiz1YijRIkY0Z0Ao4+g=;
  b=FWBtSyy0QGlZlWTB9nlPynNvrBT028Fp4qUt3BxZjm9a2csBoPA0erJG
   IooVNMubeheAG5O7TCsDMqiVLPZw5q/nUR2SGgGWXiB/ny7EZuhgDjD7s
   BsEQIeg+STnBudZB3eWeWQOXojewi6HryRq77V1Alouux6870+oz0/4YB
   Zl3/zUN+gOAE8jzwuqt1wT6xu/kibSl/UpSGP1RJ21yLnab/IzrwsxCQq
   FUySM46KlaQKoywOprZY+e2H8f7yrfPJ5CPkI30iK4gjiImJBg2IUl9Mv
   rDGoGQ8gdo4mJ/Uht1MR7Lwe0+JLPW7IRwWt5+AYtBz9FaMdEK7W33CiK
   g==;
X-CSE-ConnectionGUID: 3OfSfeB7RvuBAzTxCCmO1g==
X-CSE-MsgGUID: prYr4k7FSIm2OZBUNoALZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318386"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318386"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:44:19 -0800
X-CSE-ConnectionGUID: DWN9GQY1TteX4YrqTVwkcQ==
X-CSE-MsgGUID: cN2RYtNRRzSfokzxwzQKhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728686"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:44:15 -0800
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
Subject: [PATCH v3 9/9] coco/tdx-host: Enable trusted DMA on IOMMUs on device connect
Date: Thu, 12 Nov 2026 12:30:54 +0800
Message-ID: <20261112043054.2664857-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assigning a device to a TD for private memory access requires that DMA
from that device be translated by structures the TDX module controls.
An Intel IOMMU that implements the trusted DMA extension provides a
parallel set of translation and invalidation resources for this purpose.
They become usable once TDH.IOMMU.SETUP puts the IOMMU into Secure TDX
Mode and the TDX module initializes them. The host keeps the regular
translation path.

Issue TDH.IOMMU.SETUP on demand, when the first device behind an IOMMU
is connected through the TSM, rather than for every capable IOMMU at
probe time. Secure TDX Mode costs host resources: the TDX module's
metadata pages and half of the IOMMU's domain ID space. That cost should
only be paid for IOMMUs that actually serve such devices.

tdx_iommu_get() and tdx_iommu_put() keep a per-IOMMU refcount. The first
get() issues TDH.IOMMU.SETUP and the last put() issues TDH.IOMMU.CLEAR.
A single mutex covers both the refcount and the SEAMCALL that follows,
so a device cannot join an IOMMU that is being cleared or whose setup
has not finished. The refcount lives here rather than in the VT-d
driver because tdx-host already owns the per-IOMMU state that must
outlive TDH.IOMMU.SETUP: the IOMMU_MT pages and the TDX IOMMU ID.

The IOMMU_MT parameter page lists two contiguous buffers for the
trusted invalidation queue, followed by the metadata pages. The TDX
module reports how many metadata pages it needs in its global metadata.

With Dynamic PAMT, every 4K page given to the TDX module needs PAMT
backing first. Take it for each page of the invalidation queue buffers
and the metadata pages before TDH.IOMMU.SETUP, and drop it if setup
fails or once TDH.IOMMU.CLEAR succeeds. The parameter page itself only
carries the page list into the SEAMCALL and needs no backing.

If TDH.IOMMU.CLEAR fails, the TDX module may still reference the
IOMMU_MT pages, so they are leaked together with their PAMT backing,
and the IOMMU is marked unusable. Later get() calls for that IOMMU fail
with -EBUSY rather than reuse an IOMMU in an unknown state. tdx-host
pins itself while such an IOMMU exists, so unloading can't lose track
of it. If the failure happens during unload itself, only the tracking
entry is freed; the VT-d driver still has the IOMMU acquired and keeps
rejecting it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/virt/coco/tdx-host/Kconfig   |   5 +
 drivers/virt/coco/tdx-host/Makefile  |   1 +
 drivers/virt/coco/tdx-host/private.h |  21 ++
 drivers/virt/coco/tdx-host/main.c    |  11 +
 drivers/virt/coco/tdx-host/viommu.c  | 401 +++++++++++++++++++++++++++
 5 files changed, 439 insertions(+)
 create mode 100644 drivers/virt/coco/tdx-host/private.h
 create mode 100644 drivers/virt/coco/tdx-host/viommu.c

diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index f8c8cc29d46c..1395929f05bb 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -6,3 +6,8 @@ config TDX_HOST_SERVICES
 	select FW_UPLOAD
 	select PCI_TSM
 	default m
+
+config TDX_CONNECT
+	def_bool y
+	depends on TDX_HOST_SERVICES
+	depends on INTEL_IOMMU
diff --git a/drivers/virt/coco/tdx-host/Makefile b/drivers/virt/coco/tdx-host/Makefile
index a90ffba13a49..bfef8567f16a 100644
--- a/drivers/virt/coco/tdx-host/Makefile
+++ b/drivers/virt/coco/tdx-host/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_TDX_HOST_SERVICES) += tdx-host.o
 
 tdx-host-y := main.o
+tdx-host-$(CONFIG_TDX_CONNECT) += viommu.o
diff --git a/drivers/virt/coco/tdx-host/private.h b/drivers/virt/coco/tdx-host/private.h
new file mode 100644
index 000000000000..53a250ddd695
--- /dev/null
+++ b/drivers/virt/coco/tdx-host/private.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Intel Corporation */
+#ifndef __TDX_HOST_PRIVATE_H
+#define __TDX_HOST_PRIVATE_H
+
+#include <linux/dmar.h>
+
+struct pci_dev;
+
+#ifdef CONFIG_TDX_CONNECT
+int tdx_iommu_get(struct pci_dev *pdev);
+void tdx_iommu_put(struct pci_dev *pdev);
+#else
+static inline int tdx_iommu_get(struct pci_dev *pdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void tdx_iommu_put(struct pci_dev *pdev) { }
+#endif /* CONFIG_TDX_CONNECT */
+#endif /* __TDX_HOST_PRIVATE_H */
diff --git a/drivers/virt/coco/tdx-host/main.c b/drivers/virt/coco/tdx-host/main.c
index 0908aaaa28ac..a815dbe5127a 100644
--- a/drivers/virt/coco/tdx-host/main.c
+++ b/drivers/virt/coco/tdx-host/main.c
@@ -18,6 +18,8 @@
 #include <asm/tdx.h>
 #include <asm/tdx_global_metadata.h>
 
+#include "private.h"
+
 static const struct x86_cpu_id tdx_host_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
 	{}
@@ -35,11 +37,20 @@ static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
 
 static int tdx_tsm_link_connect(struct pci_dev *pdev)
 {
+	int ret;
+
+	ret = tdx_iommu_get(pdev);
+	if (ret)
+		return ret;
+
+	/* TDISP connect is not implemented yet. */
+	tdx_iommu_put(pdev);
 	return -ENXIO;
 }
 
 static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
 {
+	tdx_iommu_put(pdev);
 }
 
 static struct pci_tsm *tdx_tsm_link_pf0_probe(struct tsm_dev *tsm_dev,
diff --git a/drivers/virt/coco/tdx-host/viommu.c b/drivers/virt/coco/tdx-host/viommu.c
new file mode 100644
index 000000000000..c0e263926272
--- /dev/null
+++ b/drivers/virt/coco/tdx-host/viommu.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TDX IOMMU Extensions support
+ *
+ * Copyright (C) 2026 Intel Corporation
+ */
+#define pr_fmt(fmt) "tdx-host: " fmt
+
+#include <linux/dmar.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <asm/vmx.h>
+#include <asm/tdx.h>
+
+#include "private.h"
+
+/* These describe the trusted invalidation queue buffers. */
+#define IQ_BUFFER_PAGES		2
+#define IQ_BUFFER_SIZE		SZ_8K
+
+/*
+ * Represents a list of pages for TDX module defined IOMMU_MT object.
+ * Typically it uses a "root page" as the medium to exchange a list of
+ * data pages between host and TDX module.
+ */
+struct tdx_iommu_pages {
+	struct tdx_iommu_mt_param *root;
+	void **pages;
+	unsigned int nr_entries;
+};
+
+/**
+ * struct tdx_iommu - Host state of an IOMMU in Secure TDX Mode
+ * @node: Link in tdx_iommu_list
+ * @params: IOMMU information from the VT-d driver
+ * @tdx_iommu_id: Identifier returned by TDH.IOMMU.SETUP
+ * @mt_pages: Pages handed to the TDX module by TDH.IOMMU.SETUP
+ * @users: Number of devices using trusted DMA through this IOMMU
+ * @stuck: TDH.IOMMU.CLEAR failed. The TDX module may still own
+ *	   @mt_pages, so they are leaked and the IOMMU is not reused.
+ */
+struct tdx_iommu {
+	struct list_head node;
+	struct dmar_tdxc_params params;
+	u64 tdx_iommu_id;
+	struct tdx_iommu_pages *mt_pages;
+	unsigned int users;
+	bool stuck;
+};
+
+/*
+ * Serializes the refcounts together with TDH.IOMMU.SETUP and
+ * TDH.IOMMU.CLEAR, so a device can't join an IOMMU that is being
+ * cleared, or one whose setup hasn't finished.
+ */
+static DEFINE_MUTEX(tdx_iommu_lock);
+static LIST_HEAD(tdx_iommu_list);
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
+/* Number of 4K pages backing IOMMU_MT entry @i. */
+static unsigned int mt_entry_nr_pages(unsigned int i)
+{
+	return i < TDX_IOMMU_MT_IQ_NR ? IQ_BUFFER_SIZE >> PAGE_SHIFT : 1;
+}
+
+/*
+ * Drop the PAMT backing of the first @nr 4K pages handed to the TDX
+ * module, in the order mt_pamt_get() took it. Pass UINT_MAX for all.
+ */
+static void mt_pamt_put(struct tdx_iommu_pages *mt, unsigned int nr)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < mt->nr_entries && nr; i++) {
+		unsigned long pfn = PHYS_PFN(__pa(mt->pages[i]));
+
+		for (j = 0; j < mt_entry_nr_pages(i) && nr; j++, nr--)
+			tdx_pamt_put(pfn + j);
+	}
+}
+
+/*
+ * With Dynamic PAMT, every 4K page handed to the TDX module needs PAMT
+ * backing first. This covers the IQ buffers and the metadata pages, not
+ * the root page, which only carries the list of pages into the
+ * SEAMCALL. tdx_pamt_get() is a no-op without Dynamic PAMT.
+ */
+static int mt_pamt_get(struct tdx_iommu_pages *mt)
+{
+	unsigned int i, j, nr = 0;
+	int ret;
+
+	for (i = 0; i < mt->nr_entries; i++) {
+		unsigned long pfn = PHYS_PFN(__pa(mt->pages[i]));
+
+		for (j = 0; j < mt_entry_nr_pages(i); j++) {
+			ret = tdx_pamt_get(pfn + j, NULL);
+			if (ret) {
+				mt_pamt_put(mt, nr);
+				return ret;
+			}
+			nr++;
+		}
+	}
+
+	return 0;
+}
+
+static void free_mt_pages(struct tdx_iommu_pages *array)
+{
+	unsigned int i;
+
+	if (IS_ERR_OR_NULL(array))
+		return;
+
+	mt_pamt_put(array, UINT_MAX);
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
+	for (i = TDX_IOMMU_MT_IQ_NR; i < nr_entries; i++) {
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
+	struct tdx_iommu_mt_param *param = array->root;
+	void **pages = array->pages;
+	unsigned int i;
+
+	for (i = 0; i < TDX_IOMMU_MT_IQ_NR; i++)
+		param->iq[i] = __pa(pages[i]) | IQ_BUFFER_PAGES;
+
+	for (; i < array->nr_entries; i++)
+		param->mt[i - TDX_IOMMU_MT_IQ_NR] = __pa(pages[i]);
+}
+
+/* Allocate the IOMMU_MT pages with PAMT backing. Free with free_mt_pages(). */
+static struct tdx_iommu_pages *alloc_iommu_mt(int node, unsigned int nr_mt_pages)
+{
+	unsigned int nr_entries = nr_mt_pages + TDX_IOMMU_MT_IQ_NR;
+	struct tdx_iommu_pages *array;
+	unsigned int i;
+	int ret = -ENOMEM;
+
+	if (!nr_mt_pages || nr_mt_pages > TDX_IOMMU_MT_MAX_PAGES)
+		return ERR_PTR(-EINVAL);
+
+	array = kzalloc_obj(*array);
+	if (!array)
+		return ERR_PTR(-ENOMEM);
+
+	array->root = tdx_iommu_alloc_pages(node, sizeof(*array->root));
+	if (!array->root)
+		goto free_array;
+
+	array->nr_entries = nr_entries;
+	array->pages = alloc_mt_pages(nr_entries, node);
+	if (!array->pages)
+		goto free_root;
+
+	populate_mt_pages(array);
+
+	ret = mt_pamt_get(array);
+	if (ret)
+		goto free_pages;
+
+	return array;
+
+free_pages:
+	for (i = 0; i < nr_entries; i++)
+		tdx_iommu_free_pages(array->pages[i]);
+	kfree(array->pages);
+free_root:
+	tdx_iommu_free_pages(array->root);
+free_array:
+	kfree(array);
+	return ERR_PTR(ret);
+}
+
+static struct tdx_iommu *tdx_iommu_find(u64 reg_base_addr)
+{
+	struct tdx_iommu *tiommu;
+
+	lockdep_assert_held(&tdx_iommu_lock);
+
+	list_for_each_entry(tiommu, &tdx_iommu_list, node)
+		if (tiommu->params.reg_base_addr == reg_base_addr)
+			return tiommu;
+
+	return NULL;
+}
+
+/* Allocate the IOMMU_MT pages and issue TDH.IOMMU.SETUP. */
+static int tdx_iommu_setup(struct pci_dev *pdev, struct tdx_iommu *tiommu)
+{
+	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
+	struct dmar_tdxc_params *params = &tiommu->params;
+	u64 r, tdx_iommu_id;
+	int ret;
+
+	if (!sysinfo)
+		return -ENXIO;
+
+	struct tdx_iommu_pages *mt __free(free_mt_pages) =
+			alloc_iommu_mt(params->node,
+				       sysinfo->tdx_connect.iommu_mt_page_count);
+	if (IS_ERR(mt))
+		return PTR_ERR(mt);
+
+	ret = dmar_tdxc_acquire(pdev, params);
+	if (ret)
+		return ret;
+
+	r = tdh_iommu_setup(params->reg_base_addr, mt->root, &tdx_iommu_id);
+	if (r) {
+		dmar_tdxc_release(pdev, params);
+		pr_err("TDH.IOMMU.SETUP failed, regbase 0x%llx status 0x%llx\n",
+		       params->reg_base_addr, r);
+		return -EIO;
+	}
+
+	tiommu->tdx_iommu_id = tdx_iommu_id;
+	tiommu->mt_pages = no_free_ptr(mt);
+
+	pr_info("Trusted DMA initialized, regbase 0x%llx\n", params->reg_base_addr);
+
+	return 0;
+}
+
+/* Issue TDH.IOMMU.CLEAR and release what TDH.IOMMU.SETUP took. */
+static int tdx_iommu_clear(struct pci_dev *pdev, struct tdx_iommu *tiommu)
+{
+	u64 r;
+
+	r = tdh_iommu_clear(tiommu->tdx_iommu_id);
+	if (r) {
+		pr_err("TDH.IOMMU.CLEAR failed, regbase 0x%llx tdx_iommu_id 0x%llx status 0x%llx\n",
+		       tiommu->params.reg_base_addr, tiommu->tdx_iommu_id, r);
+		/* The pages and their PAMT backing stay with the TDX module. */
+		return -EIO;
+	}
+
+	dmar_tdxc_release(pdev, &tiommu->params);
+	free_mt_pages(tiommu->mt_pages);
+	tiommu->mt_pages = NULL;
+
+	return 0;
+}
+
+/*
+ * tdx_iommu_get() - Enable trusted DMA on the IOMMU translating a device
+ * @pdev: PCI device that will use trusted DMA
+ *
+ * The first device behind an IOMMU transitions that IOMMU into Secure
+ * TDX Mode. Later devices only take a reference. Every successful call
+ * must be balanced by tdx_iommu_put().
+ *
+ * Return: 0 on success and error number on failure.
+ */
+int tdx_iommu_get(struct pci_dev *pdev)
+{
+	struct dmar_tdxc_params params;
+	struct tdx_iommu *tiommu;
+	int ret;
+
+	ret = dmar_tdxc_get_params(pdev, &params);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&tdx_iommu_lock);
+
+	tiommu = tdx_iommu_find(params.reg_base_addr);
+	if (tiommu) {
+		if (tiommu->stuck)
+			return -EBUSY;
+		if (WARN_ON(tiommu->users == UINT_MAX))
+			return -EOVERFLOW;
+		tiommu->users++;
+		return 0;
+	}
+
+	tiommu = kzalloc_obj(*tiommu);
+	if (!tiommu)
+		return -ENOMEM;
+
+	tiommu->params = params;
+	ret = tdx_iommu_setup(pdev, tiommu);
+	if (ret) {
+		kfree(tiommu);
+		return ret;
+	}
+
+	tiommu->users = 1;
+	list_add(&tiommu->node, &tdx_iommu_list);
+
+	return 0;
+}
+
+/*
+ * tdx_iommu_put() - Drop a reference taken by tdx_iommu_get()
+ * @pdev: Same device passed to tdx_iommu_get()
+ *
+ * The last device behind an IOMMU takes that IOMMU out of Secure TDX
+ * Mode. If TDH.IOMMU.CLEAR fails, the TDX module may still own the
+ * IOMMU_MT pages, so they are leaked. The IOMMU then stays in Secure TDX
+ * Mode, later tdx_iommu_get() calls for it fail, and the module can no
+ * longer be unloaded.
+ */
+void tdx_iommu_put(struct pci_dev *pdev)
+{
+	struct dmar_tdxc_params params;
+	struct tdx_iommu *tiommu;
+
+	if (WARN_ON(dmar_tdxc_get_params(pdev, &params)))
+		return;
+
+	guard(mutex)(&tdx_iommu_lock);
+
+	tiommu = tdx_iommu_find(params.reg_base_addr);
+	if (WARN_ON(!tiommu || tiommu->stuck || !tiommu->users))
+		return;
+
+	if (--tiommu->users)
+		return;
+
+	if (tdx_iommu_clear(pdev, tiommu)) {
+		/* VT-d still sees it acquired; don't let unload forget it. */
+		if (try_module_get(THIS_MODULE)) {
+			tiommu->stuck = true;
+			return;
+		}
+		/* Unloading: free the entry; IOMMU_MT pages stay leaked. */
+	}
+
+	list_del(&tiommu->node);
+	kfree(tiommu);
+}
-- 
2.43.0

