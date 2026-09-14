Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6BF3DA7F9
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392006; cv=none; b=X7jDQePoZ6cg4EmryoO6D8KMkq4FjyRHCE5uP5DqSWpFrt3kjM9qncdFZXTiMCfBAlQfYDTLxFyeoREFw45UH+XO8wsxeJ7OR78AmPmWhm3p7rGUT/ckqS2bvdpKY5E6vt+ywI7LPlS7nLvmwK6I+348FIttgQGxUacE/mMlKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392006; c=relaxed/simple;
	bh=DYsCVEamYA1bwYPY4cojkrrGjPEK31kxR7k7y+uD3iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjV7LFJxEqOR2yn1qHWaJTJXcMTMIDtdcAcAmyuf1NB1NB8IVmccWvCwap4gdrJgvMm5w5lB3gepR8xNIA4J/KZa/PK8nWns5vt6giBFuB22KF18qVP0Ldeu3+7Lx5ecDyulZo3tDOk98fmummKRAH8NPg/nQOvg3sw3qTl/Ff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPLw96wR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPLw96wR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789392005; x=1820928005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYsCVEamYA1bwYPY4cojkrrGjPEK31kxR7k7y+uD3iA=;
  b=kPLw96wRgDbK+NCsmnFUL7NCNNJgrmmmtXG1I3yTEX8k1jsVAReybY0r
   l+BjYqe2Ey/rLJND+4SvyAkDI+lN0aSAmzauSlmZBQZM2mUkeAb7DPYKl
   nbeBrlkRhcml3k7/qsQ77TDBR4d/Vesrq5Nc1Ru/6byu0GHwhSzP8yxVQ
   bLTDmExVRi3flGXCzl2nocI5XdwMEnCWiXVZXvuVrKu/E0IxCEPKJMIAP
   Q50rBpIcvx2q1xwn1BIv0SvK6ums6fxtTHoslvq/4Jr1pvzIVQmOALsIj
   3iZaiF9rEwPhfSsSkIDSQkLVi9zI5fprmIDBDTEwy2Pj9sc1+XfZPAgJK
   Q==;
X-CSE-ConnectionGUID: ohGgFvKMRyGnLxv00v7jfg==
X-CSE-MsgGUID: hYzxm09UQ+anJ8o+V+BIWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="101259921"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="101259921"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 06:19:57 -0700
X-CSE-ConnectionGUID: GxErGtC9RWSX5ZjUVLnYDw==
X-CSE-MsgGUID: oNOw4u72R4yyf/NleyOa0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="870785"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by fmviesa012.fm.intel.com with ESMTP; 14 Sep 2026 06:19:54 -0700
From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
To: Ning Sun <ning.sun@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Michal Camacho Romero <michal.camacho.romero@intel.com>,
	x86@kernel.org,
	iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>
Subject: [PATCH v2 1/2] x86/tboot: Add support for parsing DTPR table and disabling TPRs
Date: Mon, 14 Sep 2026 15:19:53 +0200
Message-ID: <20260914131953.669975-1-michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260603114500.2771319-2-michal.camacho.romero@intel.com>
References: <20260603114500.2771319-2-michal.camacho.romero@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Camacho Romero <michal.camacho.romero@intel.com>

Add functions to locate and parse the DMA TXT Protection Ranges (DTPR)
table from the TXT heap's SinitMleData extended data elements (requires
SINIT MLE version >= 9).

* tboot_get_dtpr_table() - function walks through the TXT heap to find
                           the DTPR extended data element
                           (type HEAP_EXTDATA_TYPE_DTPR) and returns
                           pointer to the DTPR table.

* tboot_parse_dtpr_table() - function iterates over TPR instances and
                             disables each TPR region by setting bit 4
                             in the TPRn_BASE register via MMIO.

Using these functions will allow the kernel to deactivate SINIT
ACM-established TPRs prior to the Linux OS launch.

Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.pdf
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
---
 arch/x86/kernel/tboot.c | 230 +++++++++++++++++++++++++++++++++++++---
 include/linux/tboot.h   |  10 ++
 2 files changed, 225 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 46b8f1f16676..b745683c1ed9 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/tboot.h>
 #include <linux/debugfs.h>
+#include <acpi/actbl1.h>
 
 #include <asm/realmode.h>
 #include <asm/processor.h>
@@ -223,6 +224,30 @@ static int tboot_setup_sleep(void)
 
 #endif
 
+static bool tboot_check_txt_heap_section_bounds(const u64 heap_end,
+                                                void *heap_base,
+                                                void *heap_section,
+                                                const u64 heap_section_size,
+                                                const char *section_name)
+{
+	if (heap_section_size == 0)
+	{
+		pr_err("%s has zero size\n", section_name);
+		iounmap(heap_base);
+		heap_base = NULL;
+		return false;
+	}
+
+	if ((u64)heap_section + heap_section_size > heap_end) {
+		pr_err("%s exceeds heap boundary\n", section_name);
+		iounmap(heap_base);
+		heap_base = NULL;
+		return false;
+	}
+
+	return true;
+}
+
 void tboot_shutdown(u32 shutdown_type)
 {
 	void (*shutdown)(void);
@@ -453,22 +478,30 @@ struct sha1_hash {
 	u8 hash[SHA1_SIZE];
 };
 
+struct heap_ext_data_elt {
+	u32 type;
+	u32 size;
+	u8  data[];
+} __packed;
+
 struct sinit_mle_data {
-	u32               version;             /* currently 6 */
-	struct sha1_hash  bios_acm_id;
-	u32               edx_senter_flags;
-	u64               mseg_valid;
-	struct sha1_hash  sinit_hash;
-	struct sha1_hash  mle_hash;
-	struct sha1_hash  stm_hash;
-	struct sha1_hash  lcp_policy_hash;
-	u32               lcp_policy_control;
-	u32               rlp_wakeup_addr;
-	u32               reserved;
-	u32               num_mdrs;
-	u32               mdrs_off;
-	u32               num_vtd_dmars;
-	u32               vtd_dmars_off;
+	u32                      version;             /* currently 9 */
+	struct sha1_hash         bios_acm_id;
+	u32                      edx_senter_flags;
+	u64                      mseg_valid;
+	struct sha1_hash         sinit_hash;
+	struct sha1_hash         mle_hash;
+	struct sha1_hash         stm_hash;
+	struct sha1_hash         lcp_policy_hash;
+	u32                      lcp_policy_control;
+	u32                      rlp_wakeup_addr;
+	u32                      reserved;
+	u32                      num_mdrs;
+	u32                      mdrs_off;
+	u32                      num_vtd_dmars;
+	u32                      vtd_dmars_off;
+	u32                      proc_scrtm_status; /* version 8 or later only*/
+	struct heap_ext_data_elt ext_data_elts[];
 } __packed;
 
 struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tbl)
@@ -514,3 +547,170 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
 
 	return dmar_tbl;
 }
+
+struct acpi_table_dtpr *tboot_get_dtpr_table(void **heap_base)
+{
+	void *heap_ptr, *config;
+	struct sinit_mle_data *sinit_mle;
+	struct heap_ext_data_elt *elt;
+	u64 heap_end, heap_size, sinit_mle_size, heap_section_size;
+
+	if (!heap_base)
+		return NULL;
+
+	if (!tboot_enabled())
+		return NULL;
+	/*
+	 * ACPI tables may not be DMA protected by tboot, so use DMAR copy
+	 * SINIT saved in SinitMleData in TXT heap (which is DMA protected)
+	 */
+
+	/* map config space in order to get heap addr */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, NR_TXT_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config)
+		return NULL;
+
+	/* now map TXT heap */
+	*heap_base = ioremap(*(u64 *)(config + TXTCR_HEAP_BASE),
+			    *(u64 *)(config + TXTCR_HEAP_SIZE));
+	heap_size = *(u64 *)(config + TXTCR_HEAP_SIZE);
+	heap_end = (u64)*heap_base + heap_size;
+	iounmap(config);
+
+	if (!(*heap_base))
+		return NULL;
+
+	/* walk heap to SinitMleData */
+	/* skip BiosData */
+	/* get BiosData section size */
+	heap_section_size = *(u64 *) (*heap_base);
+	if (!tboot_check_txt_heap_section_bounds(heap_end, *heap_base,*heap_base,
+	                                         heap_section_size, "BiosData")) {
+		return NULL;
+	}
+
+	/* skip OsMleData */
+	heap_ptr = *heap_base + heap_section_size;
+	/* get OsMleData section size */
+	heap_section_size = *(u64 *)heap_ptr;
+	if (!tboot_check_txt_heap_section_bounds(heap_end, *heap_base, heap_ptr,
+	                                         heap_section_size, "OsMleData")) {
+		return NULL;
+	}
+
+	/* skip OsSinitData */
+	heap_ptr += heap_section_size;
+	/* get OsSinitData section size */
+	heap_section_size = *(u64 *)heap_ptr;
+	if (!tboot_check_txt_heap_section_bounds(heap_end, *heap_base, heap_ptr,
+	                                         heap_section_size, "OsSinitData")) {
+		return NULL;
+	}
+
+	/* jump to the SinitMleData */
+	heap_ptr += heap_section_size;
+	/* now points to SinitMleDataSize; set to SinitMleData */
+	sinit_mle_size = *(u64 *)heap_ptr;
+	if(!tboot_check_txt_heap_section_bounds(heap_end, *heap_base, heap_ptr,
+	                                        sinit_mle_size, "SinitMleData")) {
+		return NULL;
+	}
+
+	heap_ptr += sizeof(u64);
+
+	sinit_mle = (struct sinit_mle_data *)heap_ptr;
+	if (sinit_mle->version < 9) {
+		iounmap(*heap_base);
+		*heap_base = NULL;
+		return NULL;
+	}
+
+	elt = sinit_mle->ext_data_elts;
+	while (elt->type != HEAP_EXTDATA_TYPE_DTPR &&
+		   elt->type != HEAP_EXTDATA_TYPE_END) {
+		elt = (void *)elt + elt->size;
+		/*
+		 * Check if the element is beyond the SinitMleData boundary or has an
+		 * invalid size. It's size should be at least 8 bytes.
+		 */
+		if (((u64)elt > (u64)sinit_mle + sinit_mle_size) || (elt->size < 8)) {
+			iounmap(*heap_base);
+			*heap_base = NULL;
+			return NULL;
+		}
+	}
+
+	if (elt->type == HEAP_EXTDATA_TYPE_END) {
+		pr_info("DTPR element not found in SinitMleData\n");
+		iounmap(*heap_base);
+		*heap_base = NULL;
+		return NULL;
+	}
+
+	return (struct acpi_table_dtpr *)elt->data;
+}
+
+static bool tboot_tpr_enabled = false;
+void tboot_parse_dtpr_table(struct acpi_table_dtpr *dtpr)
+{
+	struct acpi_tpr_instance *tpr_inst;
+	struct acpi_tpr_array    *tpr_arr;
+	u32 *instance_cnt;
+	u64 *base;
+	u32 i, j;
+	u32 ref_tpr_cnt;
+
+	if (dtpr == NULL)
+		return;
+
+	if (!tboot_enabled())
+		return;
+
+	instance_cnt = (u32*)(&dtpr->ins_cnt);
+	tpr_inst = (struct acpi_tpr_instance *)(instance_cnt + 1);
+	ref_tpr_cnt = tpr_inst->tpr_cnt;
+	for (i = 0; i < *instance_cnt; ++i) {
+		if (tpr_inst->tpr_cnt < 2) {
+			pr_err("TPR Instance %d has less than 2 TPRs, further DTPR "
+			       "processing interrupted.\n", i);
+			return;
+		}
+		if (tpr_inst->tpr_cnt != ref_tpr_cnt) {
+			pr_err("TPR Instance %d has inconsistent TPR count: expected %d,"
+			       " found %d\n", i, ref_tpr_cnt, tpr_inst->tpr_cnt);
+			return;
+		}
+
+		for (j = 0; j < tpr_inst->tpr_cnt; ++j) {
+			tpr_arr =  (struct acpi_tpr_array*)((u8*) tpr_inst +
+			            sizeof(struct acpi_tpr_instance) +
+			            j * sizeof(struct acpi_tpr_array));
+
+			base = ioremap(tpr_arr->base, 16);
+			if (!base) {
+				pr_warn("TPR Instance %d, TPR No.%d disabling failure.\n",
+				        i, j);
+				continue;
+			}
+
+			pr_info("TPR instance %d, TPR %d:base %llx limit %llx\n", i, j,
+			        readq(base), readq(base + 1));
+			writeq(readq(base) | BIT(4), base);
+			if (tboot_tpr_enabled == false)
+				tboot_tpr_enabled = true;
+			iounmap(base);
+		}
+
+		tpr_inst = (struct acpi_tpr_instance *)((u8*)tpr_inst +
+		            sizeof(*tpr_inst) + j * sizeof(struct acpi_tpr_array));
+	}
+
+	if (tboot_tpr_enabled)
+		pr_debug("TPR protection detected, PMR will be disabled\n");
+}
+
+bool tboot_is_tpr_enabled(void)
+{
+	return tboot_tpr_enabled;
+}
diff --git a/include/linux/tboot.h b/include/linux/tboot.h
index d2279160ef39..39fb2e3ba80b 100644
--- a/include/linux/tboot.h
+++ b/include/linux/tboot.h
@@ -24,6 +24,10 @@ enum {
 #include <linux/acpi.h>
 /* used to communicate between tboot and the launched kernel */
 
+/*TXT Extended Data Element Types*/
+#define HEAP_EXTDATA_TYPE_END   0
+#define HEAP_EXTDATA_TYPE_DTPR 14
+
 #define TB_KEY_SIZE             64   /* 512 bits */
 
 #define MAX_TB_MAC_REGIONS      32
@@ -126,6 +130,9 @@ extern void tboot_probe(void);
 extern void tboot_shutdown(u32 shutdown_type);
 extern struct acpi_table_header *tboot_get_dmar_table(
 				      struct acpi_table_header *dmar_tbl);
+extern struct acpi_table_dtpr *tboot_get_dtpr_table(void **);
+extern void tboot_parse_dtpr_table(struct acpi_table_dtpr *);
+extern bool tboot_is_tpr_enabled(void);
 
 #else
 
@@ -135,6 +142,9 @@ extern struct acpi_table_header *tboot_get_dmar_table(
 #define tboot_sleep(sleep_state, pm1a_control, pm1b_control)	\
 					do { } while (0)
 #define tboot_get_dmar_table(dmar_tbl)	(dmar_tbl)
+#define tboot_get_dtpr_table(txt_heap) NULL
+#define tboot_parse_dtpr_table(dtpr) do { } while (0)
+#define tboot_is_tpr_enabled() 0
 
 #endif /* !CONFIG_INTEL_TXT */
 
-- 
2.55.0

