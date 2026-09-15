Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC533D1CB2;
	Tue, 15 Sep 2026 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458888; cv=none; b=rWqvDUtrNiUOf1gMXKFGNVoD003fbYurddxmtdJbTkhxDP/jIn4UkkFdBkRMwtTdNvkmhUcBpUzD8gjmdjM+PyPSEiFHoGThe7Qra/SWUWAULqc7rBwDPdcH0H5n9nXBfrpuR6yJNRdBQ8DPNggkvw9lUEqucEEUiTmLN0ZJibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458888; c=relaxed/simple;
	bh=ASK/E7FabmZ7RQW6GxGz8ZxGPVC3IwVDssYyutu0wlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+g99RtCswUYX27IM1YoT9KAa/KSWvDnSqcsdAQDAf1F8QZH7tlAU1NMAfT3f1mgGV20szKRNhwhWFOr84nSiFgVmLWKVoKBQs1KdY9rKj7hyVGk1ZVFRbCrjTEyuqPAiESf2QZEkRgefZcMqdilvhhu7x95RQ46kzdcFJP6NHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kp+PlP7w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kp+PlP7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789458886; x=1820994886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ASK/E7FabmZ7RQW6GxGz8ZxGPVC3IwVDssYyutu0wlE=;
  b=kp+PlP7w/kDMuPXIBz36hlXgoYKsb8d453nO8UbjTLHjiYhr37G4nlnf
   zpTEko149dTM4CSSHqvnQTguY2lyzQlVMQPM8HLDuvYdnK5hMi+NxAiN6
   r5dkdonZ1aWFqCD4fVCLraqIqgoibRpxE+vTTeYTHVgG9JOKLC0F9JwbZ
   7VCY83yhelj8m5vcWTbpr9+G34Pg27j7DNwwcfHWEyWoJz8nKmyqvCQO1
   /GcJ3lrZPOvut93WaSIX8u9AsEB+75fjacyRjW1dt3+MU9ldL4upYjP7R
   bUlk/EwM2H6L31AUvBj6iEJ0jnzgOxR9ZMu8nwLuWleyuaRD+sWhUu6zU
   Q==;
X-CSE-ConnectionGUID: MdV+6N76Tla5k0cl5VoaFQ==
X-CSE-MsgGUID: cQKO/AtUQrml1YKzd2s93g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101163777"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101163777"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:54:46 -0700
X-CSE-ConnectionGUID: YVatjIfhSi+FHnIL0ZnjLw==
X-CSE-MsgGUID: vG0Fz1llRRCI/Sf5xXG6yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269205432"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa010.fm.intel.com with ESMTP; 15 Sep 2026 00:54:41 -0700
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
Subject: [PATCH 1/5] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU setup/clear
Date: Tue, 15 Sep 2026 15:42:29 +0800
Message-ID: <20260915074235.1219183-2-baolu.lu@linux.intel.com>
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

Add SEAMCALL wrappers for TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR.

TDH.IOMMU.SETUP transitions an IOMMU and related I/O stack into Secure
TDX Mode. During this transition, the TDX module validates and protects
relevant I/O resources from further untrusted host access, providing the
trusted foundation required before enabling TEE-IO security protocols
(e.g. SPDM/IDE).

TDH.IOMMU.CLEAR performs the reverse operation and tears down the Secure
TDX Mode state for the target IOMMU.

tdh_iommu_setup() takes the IOMMU register base and a host-allocated
parameter page for TDX-module metadata, and returns a unique
tdx_iommu_id for subsequent operations.

tdh_iommu_clear() takes tdx_iommu_id to tear down the Secure TDX Mode
state and return the IOMMU to normal operation.

The caller is responsible for allocating the required pages and
populating the parameter page in the ABI-defined format.

See Intel TDX Connect ABI Specification [1], Section 3.2
(TDX Connect Host-Side (SEAMCALL) Interface Functions).

Thanks to Yilun for the initial draft.

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
index 1b9ff749dd8e..012825fe1c3c 100644
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
+ */
+u64 tdh_iommu_setup(u64 reg_base, void *root, u64 *tdx_iommu_id)
+{
+	/*
+	 * The @root page format is defined by the TDX Connect ABI spec
+	 * (Table 3.35, Structure of IOMMU_MT Parameter): the first two
+	 * entries describe the size and HPA (Host Physical Address) of
+	 * the two contiguous buffers for the invalidation queue; the
+	 * remaining entries provide HPAs of IOMMU_MT_PAGES_COUNT metadata
+	 * pages. IOMMU_MT_PAGES_COUNT is obtained from trusted IOMMU global
+	 * metadata.
+	 */
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
-- 
2.43.0

