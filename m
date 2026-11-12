Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458631;
	b=QYtFhm/FJmCIHSOXCy9m6hGKwUieycN2WUg5I96VQGSB3FiH3tQmZJnrw1i/fZilzWCt
	 ACuzv12IiY7Ywnwjx9WC2q6V0yS+f4dV/GuVgUpSkDihdVa0WCkqOzwQ1OQpJ1cnAAWRn
	 8/BiOBEUbL4yVHoPBJTroGQxi0JJxvJseVvmZ/4xRzrQoVvgxyDhajUtLYC2KV56/4EMy
	 jAfTOXTH7CHVZ+wNX2mkSiGkEQ/kGXDUzdvHd6a3Aqyl3jNZwCn85q/uwxBEaGH0dsxFT
	 lexauxvVirRPSrD3LZuRphUMOTtbVTWwEYU/VNeywLyJYOdh2FXvHHaEBNOKcHqaHdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458631;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fPMya/7CC6hB+kXWcO6T8ZznCVIjv7SxSeGsQZSqJ8c=;
	b=aP56zDl9p5foNLuacV9p1FPGYHr9LOpmZ/uTcFZfVVHDBGy+ZQOYIUMwleD6g0/JGgiT
	 EreYvWNzhnwRQv2KkwsloOzcISH4nZIwaP8PVHuqIxPgUipLOvinCZjzRY4czdSOT2jr6
	 buZX5C8ZiU39nK2kPy49Czk+19trdTb7maPNyGqrExyumjNlvqwTc9o3gEysi2Ggqh6ZH
	 jq3Rfvyc+LQF218M0+vuTbv/Y1Pg3UvNSNTKWE3tm1l7MscxX08h9TRalVqKynoOaFC1O
	 jiUosgvWESN9eLLRYsezHHrULFBncHW6lnqpO/46Qck8VxO5Om/IQIDnJmU6fdeKuDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Esko/j3l";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D1606A33F;
	Thu, 12 Nov 2026 04:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B2D1606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Esko/j3l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458631; x=1825994631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tMWEa+XEhbWdUTlCa0HhabeKygB3lYdyNYw9Alr5pHQ=;
  b=Esko/j3ln4qsJxURErPFvob1aWl4y5lAm/FnDIYARjKJr0xK3Wi7lLXs
   PB9bF2v5ZJEO8rMo0ZvidRMRcPrILWliAc16B/OPfWOW226s+4XztyWbb
   xUntKbS3JDXU+6+ww+lCyHo51N3+jvh1+vF2bcLfIUA6WXM/XUA8kXBTF
   261gkdirzXvFk9G8s6R2FOYO75KhpIu8wDqB2d8sJjdh0OWSR5XJSTQwL
   8TXHK6WaOY8i4Ct9/BCDm81FvO5cyNMN0nTeglrEiDlp/sG0541nsUYIs
   73DRIkKP1W7qk1F240zJ3Y7gajeXN1Bup1E8RcJlcaZVx/YCzijFeSGT3
   w==;
X-CSE-ConnectionGUID: l2lnrt8yT26sQodqrdDmSw==
X-CSE-MsgGUID: QY+//O8CR7WwJ82DpRMzjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318320"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318320"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:43:51 -0800
X-CSE-ConnectionGUID: ms0X9+49TFuaiCHoTPxuBQ==
X-CSE-MsgGUID: aXA6d7W7TOKWVwE25f1BqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728619"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:43:47 -0800
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
Subject: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU setup/clear
Date: Thu, 12 Nov 2026 12:30:46 +0800
Message-ID: <20261112043054.2664857-2-baolu.lu@linux.intel.com>
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

Intel VT-d hardware gains a second set of DMA translation structures,
managed by the TDX module and used only for devices assigned to TDs.
Each IOMMU has a trusted root-table address register and a trusted
invalidation queue, both accessible only from SEAM. The existing
untrusted DMA translation path of the IOMMU stays under host control.

Before trusted DMA can be used through an IOMMU, the TDX module must
initialize these resources. TDH.IOMMU.SETUP does this: it puts the
IOMMU into Secure TDX Mode, programs the trusted root table and the
trusted invalidation queue, and protects the related I/O resources
from further untrusted host access. The host provides the memory for
this through a parameter page that lists the invalidation queue
buffers and the metadata pages the TDX module needs for the IOMMU.

TDH.IOMMU.CLEAR does the reverse. It tears down the Secure TDX Mode
state of the IOMMU, after which the host can reclaim the memory.

Add wrappers for both SEAMCALLs and export them to the tdx-host driver,
which allocates the memory and issues them.

TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR are defined in the Intel TDX
Connect ABI Specification [1].

[1] https://cdrdv2.intel.com/v1/dl/getContent/858625

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  | 14 ++++++++++
 arch/x86/virt/vmx/tdx/tdx.h |  2 ++
 arch/x86/virt/vmx/tdx/tdx.c | 53 +++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e7628796b0..d077990802b9 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -162,6 +162,17 @@ struct tdx_td {
 	int tdcx_nr_pages;
 };
 
+#define TDX_IOMMU_MT_IQ_NR	2
+#define TDX_IOMMU_MT_MAX_PAGES	(PAGE_SIZE / sizeof(u64) - TDX_IOMMU_MT_IQ_NR)
+
+/* IOMMU_MT parameter page for TDH.IOMMU.SETUP (ABI spec Table 3.35). */
+struct tdx_iommu_mt_param {
+	u64 iq[TDX_IOMMU_MT_IQ_NR];	/* HPA | number of 4K pages */
+	u64 mt[TDX_IOMMU_MT_MAX_PAGES];	/* HPA of each metadata page */
+};
+
+static_assert(sizeof(struct tdx_iommu_mt_param) == PAGE_SIZE);
+
 struct tdx_vp {
 	/* TDVP root page */
 	struct page *tdvpr_page;
@@ -202,6 +213,9 @@ u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, enum pg_level level, u64 *ex
 u64 tdh_phymem_cache_wb(bool resume);
 u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
 u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn);
+u64 tdh_iommu_setup(u64 reg_base, struct tdx_iommu_mt_param *param,
+		    u64 *tdx_iommu_id);
+u64 tdh_iommu_clear(u64 tdx_iommu_id);
 #else
 static inline void tdx_init(void) { }
 static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index cac0a5abbff1..693adda89311 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -53,6 +53,8 @@
 #define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
+#define TDH_IOMMU_SETUP			128
+#define TDH_IOMMU_CLEAR			129
 
 /* TDX page types */
 #define	PT_NDA		0x0
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4cce77b6a31f..a1f35188a272 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2567,3 +2567,56 @@ void tdx_sys_disable(void)
 	if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
 		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
 }
+
+/* No cache flush is needed; hardware keeps caches coherent across KeyIDs. */
+u64 tdh_iommu_setup(u64 reg_base, struct tdx_iommu_mt_param *param,
+		    u64 *tdx_iommu_id)
+{
+	struct tdx_module_args args = {
+		.rcx = reg_base,
+		.rdx = __pa(param),
+	};
+	u64 ret;
+
+	/*
+	 * Retry only on TDX_INTERRUPTED_RESUMABLE:
+	 *
+	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
+	 *    calls.
+	 *  - On TDX_INTERRUPTED_RESUMABLE, all registers except RAX remain
+	 *    unchanged.
+	 *
+	 * The ABI spec also allows retrying on TDX_OPERAND_BUSY, but that
+	 * status doesn't guarantee forward progress, so retrying could spin
+	 * forever. The host serializes all TDH.IOMMU.SETUP and
+	 * TDH.IOMMU.CLEAR calls for an IOMMU, so the TDX module should never
+	 * report the operand as busy.
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
+u64 tdh_iommu_clear(u64 tdx_iommu_id)
+{
+	struct tdx_module_args args = {
+		.rcx = tdx_iommu_id,
+	};
+	u64 ret;
+
+	/*
+	 * Don't retry on TDX_OPERAND_BUSY. See the comment in
+	 * tdh_iommu_setup().
+	 */
+	do {
+		ret = seamcall(TDH_IOMMU_CLEAR, &args);
+	} while (ret == TDX_INTERRUPTED_RESUMABLE);
+
+	return ret;
+}
+EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_clear, "tdx-host");
-- 
2.43.0

