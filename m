Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F2394EB7;
	Tue, 15 Sep 2026 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458897; cv=none; b=lHH3YPB+ZePQHjs0fEzJx+wvnONJK6JHHZHX07R985a64qTFPjGOoduUObEO1VVcPvBJAsR2PG3I6pS48lTXsD770JJkZHw2Qddpd1NvUOYAHbsKLtdkfzdD9lH89FnRaRt+3xZEfM275Vc2DjFVUhM1o/s6gV0PbHpq/G7yccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458897; c=relaxed/simple;
	bh=ywRy0wMvP9U4+Fd4wK48qc4C/98dgzysR05bPWcQf04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lM6Rzd3YIpDouP+7A2x5ZjXk5okOcjTpTVTTlPGqJ+eKOBjcDO1FSvvmwWI6wp5ZwLUxEn4fNR1STFATMGQjw54InKlruX8LAUXZGCicdtoaEKi6w/cE7E4S3OBlYytGo/wnaJpcVTbcwbdJJ0ToE9wafFEhwB8TkiZMdhtMYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0eLKFuT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0eLKFuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789458895; x=1820994895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ywRy0wMvP9U4+Fd4wK48qc4C/98dgzysR05bPWcQf04=;
  b=M0eLKFuTxETBEzFJWW8otAfMXvOMBIcyo9/HpwjjrOsPyJaThLTDgIzc
   0xCNJfuMsLjRzZlJdNz3Wj1Pju7QCDJz8IWOHPOlNdqvuuGdHcd9rusN1
   0BJijNNlNfFFmRezlp8eOD0T9bdeZ0L84moB9NZIWR8+cxORY+vFLgHFK
   4B5GayBFdk+X/EObEI1h4aDkHurUPjDax1FvEmUBN5wh8HGO7PnQ2GfN+
   HBpdFIfgGvQ3YknK9r9s4SkwpHtZuNIfnHt638PuG+Fa2ZVKqBNbOSd19
   W6AJhxKo7HgogWOOmVtaf7iclyluguRWTcwm4CHRqUjov+vouxCYflp/8
   g==;
X-CSE-ConnectionGUID: y69utdgsT/C6nE0y1XFrWQ==
X-CSE-MsgGUID: fjYVnnePS3Ka9Mxq7SysNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101163797"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101163797"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:54:55 -0700
X-CSE-ConnectionGUID: Q0kT+c7JQ0a1rel8hzzthA==
X-CSE-MsgGUID: Syp7oxSsTlKRvpg87T56tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269205461"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa010.fm.intel.com with ESMTP; 15 Sep 2026 00:54:51 -0700
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
Subject: [PATCH 3/5] iommu/vt-d: Add interfaces for trusted DMA initialization
Date: Tue, 15 Sep 2026 15:42:31 +0800
Message-ID: <20260915074235.1219183-4-baolu.lu@linux.intel.com>
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

Add Intel VT-d interfaces to initialize and tear down TDX Connect trusted
DMA support across active IOMMUs.

Trusted DMA depends on trusted-IOMMU hardware extensions, advertised by
the TDXCS bit in the VT-d Extended Capability Register (ECAP). When
present, the TDX module can transition an IOMMU into Secure TDX Mode via
TDH.IOMMU.SETUP, and return it to normal host operation via
TDH.IOMMU.CLEAR.

In this mode, VT-d provides TDX-managed DMA translation and invalidation
resources (trusted translation root and invalidation queue), and splits
domain ID ownership so the TDX module can use its reserved namespace
independently from host-managed DIDs.

Introduce the following interfaces:
- intel_tdxc_init(): bring up TDX Connect support on all active IOMMUs
  that advertise TDXCS and have DMA translation enabled.
- intel_tdxc_exit(): tear down per-IOMMU TDX Connect state.

Initialization is best-effort at system scope: IOMMUs without required
support are skipped, while failures on attempted bring-up are treated as
errors and trigger teardown of previously initialized units.

These entry points are intended to be called by the Intel TDX Connect
platform TSM driver during module init/exit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/Kconfig  | 14 ++++++
 drivers/iommu/intel/Makefile |  1 +
 drivers/iommu/intel/iommu.h  |  7 +++
 include/linux/dmar.h         | 12 ++++++
 drivers/iommu/intel/iommu.c  | 11 +++++
 drivers/iommu/intel/tdxc.c   | 82 ++++++++++++++++++++++++++++++++++++
 6 files changed, 127 insertions(+)
 create mode 100644 drivers/iommu/intel/tdxc.c

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 5471f814e073..e8c0ea79a31d 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -100,4 +100,18 @@ config INTEL_IOMMU_PERF_EVENTS
 	  to aid performance tuning and debug. These are available on modern
 	  processors which support Intel VT-d 4.0 and later.
 
+config INTEL_IOMMU_TDX_CONNECT
+	bool "Intel IOMMU support for TDX Connect"
+	depends on INTEL_TDX_HOST
+	help
+	  Enable Intel VT-d support required by TDX Connect on TDX host systems.
+
+	  Select this if the host will run TDX Connect workloads that require
+	  trusted assignment/sharing of devices with TDX guests. If enabled,
+	  the Intel IOMMU driver integrates with the TDX host module so DMA
+	  translation state used by those workloads is managed in the TDX trust
+	  domain.
+
+	  If unsure, say N.
+
 endif # INTEL_IOMMU
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index ada651c4a01b..25bf3b970acb 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
+obj-$(CONFIG_INTEL_IOMMU_TDX_CONNECT) += tdxc.o
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 23dbe6c24439..452a381e6a40 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -187,6 +187,7 @@
  */
 
 #define ecap_pms(e)		(((e) >> 51) & 0x1)
+#define ecap_tdxcs(e)		(((e) >> 50) & 0x1)
 #define ecap_rps(e)		(((e) >> 49) & 0x1)
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
@@ -1323,6 +1324,12 @@ static inline void intel_iommu_debugfs_create_dev_pasid(struct dev_pasid_info *d
 static inline void intel_iommu_debugfs_remove_dev_pasid(struct dev_pasid_info *dev_pasid) {}
 #endif /* CONFIG_INTEL_IOMMU_DEBUGFS */
 
+#ifdef CONFIG_INTEL_IOMMU_TDX_CONNECT
+extern bool intel_tdxc_initialized;
+#else
+#define intel_tdxc_initialized (0)
+#endif /* CONFIG_INTEL_IOMMU_TDX_CONNECT */
+
 extern const struct attribute_group *intel_iommu_groups[];
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 					 u8 devfn, int alloc);
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 63e35df2cef4..361c0d4a45fb 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -167,6 +167,18 @@ static inline int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 }
 #endif /* CONFIG_INTEL_IOMMU */
 
+#ifdef CONFIG_INTEL_IOMMU_TDX_CONNECT
+int intel_tdxc_init(void);
+void intel_tdxc_exit(void);
+#else
+static inline int intel_tdxc_init(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void intel_tdxc_exit(void) { }
+#endif /* CONFIG_INTEL_IOMMU_TDX_CONNECT */
+
 #ifdef CONFIG_IRQ_REMAP
 extern int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert);
 #else  /* CONFIG_IRQ_REMAP */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8..e88457d96b53 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2168,6 +2168,17 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	iommu_set_root_entry(iommu);
 	iommu_enable_translation(iommu);
 
+	/*
+	 * If an IOMMU is hot-added after intel_tdxc_initialized is set, it is
+	 * not enrolled into TDX secure mode. Ideally this should be integrated
+	 * with dmar_iommu_hotplug() so intel_iommu_bringup_tdxc() can run on
+	 * hotplug. This is currently skipped due to lack of hardware validation.
+	 * Log this limitation to make it visible.
+	 */
+	if (intel_tdxc_initialized && ecap_tdxcs(iommu->ecap))
+		pr_info("Trusted DMA for TEE is not enabled on hot-added IOMMU %s\n",
+			iommu->name);
+
 	iommu_disable_protect_mem_regions(iommu);
 	return 0;
 
diff --git a/drivers/iommu/intel/tdxc.c b/drivers/iommu/intel/tdxc.c
new file mode 100644
index 000000000000..559c752a1527
--- /dev/null
+++ b/drivers/iommu/intel/tdxc.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tdxc.c - Intel TDX Connect Extensions support
+ *
+ * Copyright (C) 2026 Intel Corporation
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/pci.h>
+#include <asm/vmx.h>
+#include <asm/tdx.h>
+#include "iommu.h"
+
+bool intel_tdxc_initialized;
+
+static int intel_iommu_bringup_tdxc(struct intel_iommu *iommu, unsigned int nr_pages)
+{
+	/*
+	 * Nothing to do if the iommu doesn't support TDX extension or the
+	 * DMA translation has not been enabled.
+	 */
+	if (!ecap_tdxcs(iommu->ecap) || !(iommu->gcmd & DMA_GCMD_TE))
+		return 0;
+
+	/* Bring-up is not complete yet; report as unsupported for now. */
+	return -EOPNOTSUPP;
+}
+
+static void intel_iommu_teardown_tdxc(struct intel_iommu *iommu)
+{
+}
+
+void intel_tdxc_exit(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+
+	guard(rwsem_write)(&dmar_global_lock);
+	if (!intel_tdxc_initialized)
+		return;
+
+	for_each_active_iommu(iommu, drhd)
+		intel_iommu_teardown_tdxc(iommu);
+	intel_tdxc_initialized = false;
+}
+EXPORT_SYMBOL_GPL(intel_tdxc_exit);
+
+int intel_tdxc_init(void)
+{
+	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
+	struct dmar_drhd_unit *drhd;
+	unsigned int mt_page_count;
+	struct intel_iommu *iommu;
+	int ret;
+
+	if (!intel_iommu_enabled)
+		return -EOPNOTSUPP;
+
+	if (!tdx_sysinfo ||
+	    !(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
+		return -EOPNOTSUPP;
+
+	mt_page_count = tdx_sysinfo->tdx_connect.iommu_mt_page_count;
+	guard(rwsem_write)(&dmar_global_lock);
+	if (intel_tdxc_initialized)
+		return 0;
+
+	for_each_active_iommu(iommu, drhd) {
+		ret = intel_iommu_bringup_tdxc(iommu, mt_page_count);
+		if (ret) {
+			for_each_active_iommu(iommu, drhd)
+				intel_iommu_teardown_tdxc(iommu);
+
+			return ret;
+		}
+	}
+	intel_tdxc_initialized = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_tdxc_init);
-- 
2.43.0

