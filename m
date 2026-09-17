Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A037AA83
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638116; cv=none; b=RRJ7w4HCyUSwbBWkWvYJq2xd06V3LCalF/nEJdGa5zywaekrfzLRPRJOy5MWRcvPzS36ev7daWQH+Ng15DLK7RgdSLvln69I411o0HPEzGFk7sUMzo2UJsBDgTrG57yN0a8QymWUrtgRquceOZ0WVR5NP1SGjxHkWjEFSNPLmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638116; c=relaxed/simple;
	bh=8D6G7Ae5J//jgEv6IHw+UpzQvqiu1LXaFmi0I8y7rz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CX3yfw2QaTgP4v6hgV0CCo2cV2r33WlIw/Ope2G6+6pLRVZq6N9DYgjV5pdcz1YGFmyZDMcENQSKf8piOfxxNav0DGoxdYvXRHTTvOFuGJOx/HXfYsKIbEOxXrVUKeb+OnbAM3aKWxmPz5VcG0tcc6wjO7jG7s4Z2/gcxG+fGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLgBgIdx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLgBgIdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789638101; x=1821174101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8D6G7Ae5J//jgEv6IHw+UpzQvqiu1LXaFmi0I8y7rz4=;
  b=jLgBgIdxU/Ldw4aCdZXSuUDDHADFYV2qEQMqhL4Noj5nUeT3QHyCyxzk
   nRxmoNy3oc+snTGcZhllY19Z4304WdeFrwpLeMvBFKbimUHKOnh0qN2qe
   LBpVtKGQ3EQRP4U2XDqZhY7BAp09FwSgXBP33hXesAQmw+n6p6QfYr+2h
   muwrEt1X6wFfPn3HpyFnbawKcKsJKFaX8EWlaC4U7PRDd/2dYkuYcRldw
   o0VCfA7G5KgqP4K2n7kRQYxPUxDysQg3b0sN8//3WkzCdIZph6deNY8Ql
   o7K8VroCz4QYK8RFHTbGUt/eB5jwOGkBZUUFwkPuMwRt+A5HGyIaF5827
   A==;
X-CSE-ConnectionGUID: a+Lzug4nRPWVfb3zDLOHQg==
X-CSE-MsgGUID: Q9AiJWr0TzerlndlkEfKPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89178677"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89178677"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:41:37 -0700
X-CSE-ConnectionGUID: 0stjcwqySzKtLZbf2CNPPw==
X-CSE-MsgGUID: fCfhf0jFQFi8YDrG7Tkwrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1887921"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by fmviesa011.fm.intel.com with ESMTP; 17 Sep 2026 02:41:34 -0700
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
Subject: [PATCH 1/1] x86/tboot: Add support for parsing DTPR table and disabling TPRs
Date: Thu, 17 Sep 2026 11:41:33 +0200
Message-ID: <20260917094133.765149-1-michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <PH8PR11MB6878FA66E30AC9A4E01B60A687BA2@PH8PR11MB6878.namprd11.prod.outlook.com>
References: <PH8PR11MB6878FA66E30AC9A4E01B60A687BA2@PH8PR11MB6878.namprd11.prod.outlook.com>
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
 arch/x86/kernel/tboot.c | 358 ++++++++++++++++++++++++++++++++++++++--
 include/linux/tboot.h   |  18 ++
 2 files changed, 361 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 46b8f1f16676..f7ccd3e4e9d2 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/tboot.h>
 #include <linux/debugfs.h>
+#include <acpi/actbl1.h>
 
 #include <asm/realmode.h>
 #include <asm/processor.h>
@@ -223,6 +224,132 @@ static int tboot_setup_sleep(void)
 
 #endif
 
+static bool tboot_check_txt_heap_section_bounds(const u64 heap_end,
+                                                void **heap_base,
+                                                void *heap_section,
+                                                const u64 heap_section_size,
+                                                const char *section_name)
+{
+	if (heap_section_size < 8)
+	{
+		pr_err("%s size is too small\n", section_name);
+		iounmap(*heap_base);
+		*heap_base = NULL;
+		return false;
+	}
+
+	if ((u64)heap_section + heap_section_size > heap_end) {
+		pr_err("%s exceeds heap boundary\n", section_name);
+		iounmap(*heap_base);
+		*heap_base = NULL;
+		return false;
+	}
+
+	return true;
+}
+
+static bool tboot_check_dtpr_size(const struct acpi_table_dtpr *dtpr,
+                                  const u64 dtpr_payload_size)
+{
+	u64 dtpr_offset, dtpr_ref_size;
+	u32 i, j, ref_tpr_cnt;
+
+	struct acpi_tpr_instance *tpr_inst    = NULL;
+	struct acpi_tpr_aux_sr   *tpr_aux_srl = NULL;
+
+	if (!dtpr)
+		return false;
+
+	if (dtpr_payload_size < sizeof(struct acpi_table_dtpr)) {
+		pr_err("DTPR element payload too small for a DTPR header\n");
+		return false;
+	}
+
+	dtpr_ref_size = dtpr->header.length;
+	dtpr_offset   = 0;
+
+	if (dtpr_ref_size < sizeof(struct acpi_table_dtpr)) {
+		pr_err("DTPR table header exceeds expected size\n");
+		return false;
+	}
+
+	dtpr_offset += sizeof(struct acpi_table_dtpr);
+	tpr_inst = (struct acpi_tpr_instance *)((u8 *)dtpr + dtpr_offset);
+	if (dtpr_offset + sizeof(struct acpi_tpr_instance) > dtpr_ref_size) {
+		pr_err("TPR instance No.0 header exceeds DTPR table size\n");
+		return false;
+	}
+
+	ref_tpr_cnt = tpr_inst->tpr_cnt;
+	if (ref_tpr_cnt < 2) {
+		pr_err("Reference TPR count is less than 2, further DTPR processing "
+		       "interrupted.\n");
+		return false;
+	}
+
+	for (i = 0; i < dtpr->ins_cnt; i++) {
+		/* iterate over each TPR instance */
+		dtpr_offset += sizeof(struct acpi_tpr_instance);
+		if (dtpr_offset > dtpr_ref_size && i != 0) {
+			pr_err("TPR instance No.%d header exceeds DTPR table size\n", i);
+			return false;
+		}
+
+		/* verify TPR count for the given Instance. It should be 2 at least*/
+		if (tpr_inst->tpr_cnt < 2 && i != 0) {
+			pr_err("TPR Instance %d has less than 2 TPRs, further DTPR "
+			       "processing interrupted.\n", i);
+			return false;
+		}
+
+		/* compare TPR count for the given Instance with the expected one */
+		/* each TPR Instance should have the equal number of TPRs */
+		if (tpr_inst->tpr_cnt != ref_tpr_cnt && i != 0) {
+			pr_err("TPR Instance %d has inconsistent TPR count: expected %d,"
+			       " found %d\n", i, ref_tpr_cnt, tpr_inst->tpr_cnt);
+			return false;
+		}
+
+		/* verify TPR array size for this instance */
+		dtpr_offset += tpr_inst->tpr_cnt * sizeof(struct acpi_tpr_array);
+		if (dtpr_offset > dtpr_ref_size) {
+			pr_err("TPR instance No.%d TPR entries exceed DTPR table size\n",
+			       i);
+			return false;
+		}
+
+		/* move to the next TPR instance */
+		tpr_inst = (struct acpi_tpr_instance *)((u8 *)dtpr + dtpr_offset);
+	}
+
+	tpr_aux_srl = (struct acpi_tpr_aux_sr *)((u8 *)dtpr + dtpr_offset);
+	dtpr_offset += sizeof(u32);
+
+	if (dtpr_offset > dtpr_ref_size) {
+		pr_err("TPR SRL count field exceeds DTPR table size\n");
+		return false;
+	}
+
+	dtpr_offset += tpr_aux_srl->srl_cnt *
+	               sizeof(struct acpi_tpr_serialize_request);
+	if (dtpr_offset > dtpr_ref_size) {
+		pr_err("TPR SRL entries exceed DTPR table size\n");
+		return false;
+	}
+
+	if (dtpr_offset < dtpr_ref_size) {
+		pr_err("DTPR table is smaller than expected\n");
+		return false;
+	}
+
+	if (dtpr_offset != dtpr_payload_size) {
+		pr_err("DTPR table size mismatch\n");
+		return false;
+	}
+
+	return true;
+}
+
 void tboot_shutdown(u32 shutdown_type)
 {
 	void (*shutdown)(void);
@@ -453,22 +580,30 @@ struct sha1_hash {
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
@@ -514,3 +649,196 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
 
 	return dmar_tbl;
 }
+
+struct acpi_table_dtpr *tboot_get_dtpr_table(void **heap_base)
+{
+	void *heap_ptr, *config, *sinit_mle_end;
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
+	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_base, *heap_base,
+	                                         heap_section_size, "BiosData")) {
+		return NULL;
+	}
+
+	/* skip OsMleData */
+	heap_ptr = *heap_base + heap_section_size;
+	/* get OsMleData section size */
+	heap_section_size = *(u64 *)heap_ptr;
+	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_base, heap_ptr,
+	                                         heap_section_size, "OsMleData")) {
+		return NULL;
+	}
+
+	/* skip OsSinitData */
+	heap_ptr += heap_section_size;
+	/* get OsSinitData section size */
+	heap_section_size = *(u64 *)heap_ptr;
+	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_base, heap_ptr,
+	                                         heap_section_size, "OsSinitData")) {
+		return NULL;
+	}
+
+	/* jump to the SinitMleData */
+	heap_ptr += heap_section_size;
+	/* now points to SinitMleDataSize; set to SinitMleData */
+	sinit_mle_size = *(u64 *)heap_ptr;
+	if(!tboot_check_txt_heap_section_bounds(heap_end, heap_base, heap_ptr,
+	                                        sinit_mle_size, "SinitMleData")) {
+		return NULL;
+	}
+
+	heap_ptr += sizeof(u64);
+	sinit_mle = (struct sinit_mle_data *)heap_ptr;
+	sinit_mle_end = (void *)sinit_mle + sinit_mle_size;
+	if (sizeof(struct sinit_mle_data) > sinit_mle_size) {
+		pr_err("SinitMleData size is smaller than expected.\n");
+		goto err;
+	}
+
+	if (sinit_mle->version < 9) {
+		pr_err("Unsupported SinitMleData version: %u\n", sinit_mle->version);
+		goto err;
+	}
+
+	heap_ptr += sizeof(struct sinit_mle_data);
+	if (heap_ptr > sinit_mle_end) {
+		pr_err("SinitMleData header out of bounds.\n");
+		goto err;
+	}
+
+	elt = sinit_mle->ext_data_elts;
+	do {
+		if ((u8 *)elt + sizeof(*elt) > (u8 *)sinit_mle_end) {
+			pr_err("SinitMleData element header out of bounds.\n");
+			goto err;
+		}
+
+		if (elt->size < sizeof(*elt)) {
+			pr_err("Invalid SinitMleData element size: %u\n", elt->size);
+			goto err;
+		}
+
+		if (elt->type == HEAP_EXTDATA_TYPE_END || elt->type == HEAP_EXTDATA_TYPE_DTPR) {
+			break;
+		}
+
+		elt = (void *)elt + elt->size;
+	} while (elt <= sinit_mle_end);
+
+	if (elt >= sinit_mle_end){
+		pr_err("Reached the end of SinitMleData without finding DTPR nor END"
+		       " element.\n");
+		goto err;
+	}
+
+	if (elt->type == HEAP_EXTDATA_TYPE_END) {
+		pr_err("DTPR element not found in SinitMleData\n");
+		iounmap(*heap_base);
+		*heap_base = NULL;
+		return NULL;
+	}
+
+	if ((u8 *)elt + elt->size > (u8 *)sinit_mle_end) {
+		pr_err("DTPR Table exceeds SinitMleData bounds.\n");
+		goto err;
+	}
+
+	if (!tboot_check_dtpr_size((struct acpi_table_dtpr *)elt->data,
+	                           elt->size - sizeof(*elt))) {
+		pr_err("Invalid DTPR Table size.\n");
+		goto err;
+	}
+
+	return (struct acpi_table_dtpr *)elt->data;
+
+err:
+	iounmap(*heap_base);
+	*heap_base = NULL;
+	return NULL;
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
+
+	for (i = 0; i < *instance_cnt; ++i) {
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
index d2279160ef39..7523f8ecdf70 100644
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
@@ -58,6 +62,14 @@ struct tboot_acpi_sleep_info {
 	u64 kernel_s3_resume_vector;
 } __packed;
 
+/*
+ * structure for tboot extended data elements
+ */
+struct heap_ext_data_elt {
+	u32 type;
+	u32 size;
+} __packed;
+
 /*
  * shared memory page used for communication between tboot and kernel
  */
@@ -126,6 +138,9 @@ extern void tboot_probe(void);
 extern void tboot_shutdown(u32 shutdown_type);
 extern struct acpi_table_header *tboot_get_dmar_table(
 				      struct acpi_table_header *dmar_tbl);
+extern struct acpi_table_dtpr *tboot_get_dtpr_table(void **);
+extern void tboot_parse_dtpr_table(struct acpi_table_dtpr *);
+extern bool tboot_is_tpr_enabled(void);
 
 #else
 
@@ -135,6 +150,9 @@ extern struct acpi_table_header *tboot_get_dmar_table(
 #define tboot_sleep(sleep_state, pm1a_control, pm1b_control)	\
 					do { } while (0)
 #define tboot_get_dmar_table(dmar_tbl)	(dmar_tbl)
+#define tboot_get_dtpr_table(txt_heap) NULL
+#define tboot_parse_dtpr_table(dtpr) do { } while (0)
+#define tboot_is_tpr_enabled() 0
 
 #endif /* !CONFIG_INTEL_TXT */
 
-- 
2.55.0

