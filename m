Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767130EF91;
	Thu, 15 Oct 2026 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027184; cv=none; b=OSDvABHO+jJeE1NbP4tOZ1kYmQXH0OZFXOmcw210luqUg4INnXQ733D9ei7GnZ2eOBUnsXE3xlG+EN1bRRL6lu5Y7tdVtGPuoAj+xtdH7bMe6EFxdB/+PW8jfEZ32VS0SP3nfuEzCadeQQjjHif+u/QCH5IssUApKrgVcOoiY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027184; c=relaxed/simple;
	bh=6zHhDR9K0MlrC2n9XT9czJkOS4eZeQhQDzTHtLj690Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Us2w2de57wgpTTTXkFUxvMwqn5DjdmHlMEUE02wVn+bIdIdDN39l/CrbDIiZkz+yxdG97a+fjrXnQrhUpy7Oyn0WIWZvX8us/6XvmwEVjFeX65qDbS62A59E+5kTyb+naWSsHw4JzMQtq+iEURv+Qdb14aDbgrrAexjO7DgWV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbloW3uT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbloW3uT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792027182; x=1823563182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6zHhDR9K0MlrC2n9XT9czJkOS4eZeQhQDzTHtLj690Q=;
  b=lbloW3uTRvReqxqUgHvvDzXlc1nWj7B1BWG+tyfZDadBPMPspb+lczF+
   0maJ6E6PKU4gOdodIvV0QC17BzFDPfRgnF6s2e8VwWrT51l5F8AfYlWql
   01b0/Eexx+xJlDkV0ZqqjG54tovDaUZbKTuQcfPbMPfJMMRkknuvwvVdn
   CCnq504oeoAyE6INngxRkiD9Gimw1fxOLafmsaLeC+k0ikiaEAOrIzx4A
   WWt/pULpBwWOMWX9E42blhLQMb8KACN04syv0+diZ0rxCovS3xy2v69cr
   uaXebi+1/dbPHy1XsLmO7+S1GtovNLjYNaEMyCTAL7nPaS6bwNy6Fc+IW
   Q==;
X-CSE-ConnectionGUID: uXsbfUqRSniADb/vdE0qOQ==
X-CSE-MsgGUID: kus/YW/vQ4qzTroUNVN15w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="789204"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="789204"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 18:19:42 -0700
X-CSE-ConnectionGUID: n7togZEWTaeTPwFvWYidGQ==
X-CSE-MsgGUID: //CkVuZAS7SLxD9UBGcRiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1595543"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2026 18:19:38 -0700
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
Subject: [PATCH v2 1/4] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU setup/clear
Date: Thu, 15 Oct 2026 09:07:02 +0800
Message-ID: <20261015010705.1973284-2-baolu.lu@linux.intel.com>
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

Add SEAMCALL wrappers for TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR.

TDH.IOMMU.SETUP transitions an IOMMU and related I/O stack into Secure
TDX Mode. During this transition, the TDX module validates and protects
relevant I/O resources from further untrusted host access, providing the
trusted foundation required before enabling TEE-IO security protocols
(e.g. SPDM/IDE).

TDH.IOMMU.CLEAR performs the reverse operation and tears down the Secure
TDX Mode state for the target IOMMU.

The caller is responsible for allocating the required pages and
populating the parameter page in the ABI-defined format.

See Intel TDX Connect ABI Specification [1], Section 3.2 (TDX Connect
Host-Side (SEAMCALL) Interface Functions).

Thanks to Xu Yilun for the initial draft.

[1] https://cdrdv2.intel.com/v1/dl/getContent/858625

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 ++
 arch/x86/virt/vmx/tdx/tdx.h |  2 ++
 arch/x86/virt/vmx/tdx/tdx.c | 56 +++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d8..8b5411d3eb67 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -176,6 +176,8 @@ u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, enum pg_level level, u64 *ex
 u64 tdh_phymem_cache_wb(bool resume);
 u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
 u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn);
+u64 tdh_iommu_setup(u64 reg_base, void *root, u64 *tdx_iommu_id);
+u64 tdh_iommu_clear(u64 tdx_iommu_id);
 #else
 static inline void tdx_init(void) { }
 static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index bdfd0e1e337a..d7beb42cf972 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -49,6 +49,8 @@
 #define TDH_SYS_SHUTDOWN		52
 #define TDH_SYS_UPDATE			53
 #define TDH_SYS_DISABLE			69
+#define TDH_IOMMU_SETUP			128
+#define TDH_IOMMU_CLEAR			129
 
 /*
  * SEAMCALL leaf:
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 1b9ff749dd8e..5d31c1b0890a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2034,3 +2034,59 @@ void tdx_sys_disable(void)
 	if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
 		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
 }
+
+/*
+ * Wrapper for TDH.IOMMU.SETUP leaf, which transitions the IOMMU and related
+ * I/O stack into Secure TDX Mode.
+ *
+ * The @root page format is defined by the TDX Connect ABI spec (Table 3.35,
+ * Structure of IOMMU_MT Parameter): the first two entries describe the size
+ * and HPA (Host Physical Address) of the two contiguous buffers for the
+ * invalidation queue; the remaining entries provide HPAs of
+ * IOMMU_MT_PAGES_COUNT metadata pages. IOMMU_MT_PAGES_COUNT is obtained from
+ * trusted IOMMU global metadata.
+ */
+u64 tdh_iommu_setup(u64 reg_base, void *root, u64 *tdx_iommu_id)
+{
+	struct tdx_module_args args = {
+		.rcx = reg_base,
+		.rdx = __pa(root),
+	};
+	u64 ret;
+
+	/*
+	 * Don't loop forever:
+	 *
+	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
+	 *    calls.
+	 *  - On TDX_INTERRUPTED_RESUMABLE, all registers except RAX remain
+	 *    unchanged.
+	 */
+	do {
+		ret = seamcall_ret(TDH_IOMMU_SETUP, &args);
+	} while (ret == TDX_INTERRUPTED_RESUMABLE);
+
+	*tdx_iommu_id = args.rcx;
+
+	return ret;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_setup, "tdx-host");
+
+/*
+ * Wrapper for TDH.IOMMU.CLEAR leaf, which terminates Secure TDX Mode for the
+ * target IOMMU and restores control of related hardware resources to the host.
+ */
+u64 tdh_iommu_clear(u64 tdx_iommu_id)
+{
+	struct tdx_module_args args = {
+		.rcx = tdx_iommu_id,
+	};
+	u64 ret;
+
+	do {
+		ret = seamcall(TDH_IOMMU_CLEAR, &args);
+	} while (ret == TDX_INTERRUPTED_RESUMABLE);
+
+	return ret;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_clear, "tdx-host");
-- 
2.43.0

