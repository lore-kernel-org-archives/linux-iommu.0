Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46343348C6B
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797758; cv=none; b=hT04l1G3JjllPEMSDlIkcL3hcPkRY5qSLJclaJFKUSS2Ltt0PpO06CHA1zGD8F1bVYXBBvXymLT7Iud0uJr/1+wuKr+QhA56FdePL+xYNXMXVVGugKmZADVFJzFwWugzIhf2x5jFnkaswh3eWr+peePVKBAZkZSHTGjvUB6UGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797758; c=relaxed/simple;
	bh=xWtVzxVXZou7zkCZTpk+9S1eCvspCz1V6tzPG7Bttmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCJNuEyIyuY71vW3haRC+T2xsFih6HQ2/+YeolpOYt7EsC7mFSqn+1rEhmbqIrDc0zim89q/p1yJdqNbuKoyeB02IQBk3TEQ/8cmFQev2mrrc0WuLWT1FUAkBdiDXZJluRqbkpmqocSRxwr6zCuNl0/YjmJgCYG2Ah4lZt/CHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHqS8vzQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHqS8vzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791797756; x=1823333756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xWtVzxVXZou7zkCZTpk+9S1eCvspCz1V6tzPG7Bttmc=;
  b=oHqS8vzQbtzLY48kvdCmkQ3ZmO+svmRSxLF0rlXcTuFN7L/NhN4IeQHP
   oHKZaTO8TU0s7QewqK2vo9Zoy3a8B6h/bHw189Y7TlMWihjgZmX9toATv
   Swcc5hFxgk0XIbHFjB1E2q+ZuU/UqtV78wHLDzNm5xJjhwYn1WR+zhzfi
   4Foqs6gXZk9SgYmzDMqC+HzL76rwSL9oQqWUi86CD7pUnR0JcclKJ374T
   F2nca1u72G1Groi9dd2//X9Cr3yvQZY2sQwxa78LAX7aWD3L+W9SYRhyH
   5u6CKbBW4yNhRNepjgqK/FypkII3uj6dUS7ZGTaOZxtRX64L7sV0yEBLN
   Q==;
X-CSE-ConnectionGUID: 99xXDieBQUWSi/3sV+AaBQ==
X-CSE-MsgGUID: p/wRW/9OQBeRVZZzu06D4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="386634"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="386634"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:35:55 -0700
X-CSE-ConnectionGUID: 311jLB6FRjGLsAQkfsW9uQ==
X-CSE-MsgGUID: FGoYpnUqQxmfRqMqrnVAnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="774100"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by orviesa009.jf.intel.com with ESMTP; 12 Oct 2026 02:35:53 -0700
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
Subject: [PATCH v6 1/2] x86/tboot: Add support for parsing DTPR table and disabling TPRs
Date: Mon, 12 Oct 2026 11:35:40 +0200
Message-ID: <20261012093540.1737905-1-michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <PH8PR11MB687819AC0462AEC8B83E480987962@PH8PR11MB6878.namprd11.prod.outlook.com>
References: <PH8PR11MB687819AC0462AEC8B83E480987962@PH8PR11MB6878.namprd11.prod.outlook.com>
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

* tboot_check_tprs()                    - function iterates over
                                          TPR instances and counts
                                          number of the enabled TPRs.

* tboot_check_txt_heap_section_bounds() - function checks if a given
                                          TXT heap section is within
                                          the bounds of the heap.

* tboot_disable_tprs()                  - function iterates over TPR
                                          instances and disables each
                                          active TPR region by setting
                                          bit 4 in the TPRn_BASE
                                          register via MMIO.

* tboot_free_txt_heap_mem()             - function frees the memory
                                          allocated for the TXT heap.

* tboot_get_dtpr_table()                - function walks through the
                                          TXT heap to find the DTPR
                                          extended data element (type
                                          HEAP_EXTDATA_TYPE_DTPR) and
                                          returns pointer to the DTPR
                                          table.

Using these functions will allow the kernel to deactivate SINIT
ACM-established TPRs prior to the Linux OS launch.

Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.pdf
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
---
Hi Ning Sun,

Thanks for review. Recently, Lu Baolu (IOMMU code maintainer)- has pointed me
the additional requirements for the DTPR table handling, which required me to
introduce another modification in the DTPR Table handling functions:

1) Improvement of the TPRs activity verification mechanism, by counting the
   number of enabled TPRs and ensuring it matches the expected configuration.
2) Defining function, responsible for TXT Heap memory releas
   - tboot_free_txt_heap_mem function
3) Improvement of the TPRs disabling mechanism, by iterating over TPR instances,
   disabling each active TPR region and their status verification.

Please review this changes.

Regards,
Michal Camacho Romero

 arch/x86/kernel/tboot.c | 502 ++++++++++++++++++++++++++++++++++++++--
 include/linux/tboot.h   |  26 +++
 2 files changed, 513 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 46b8f1f16676..c46399bbe7f8 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/tboot.h>
 #include <linux/debugfs.h>
+#include <acpi/actbl1.h>
 
 #include <asm/realmode.h>
 #include <asm/processor.h>
@@ -223,6 +224,143 @@ static int tboot_setup_sleep(void)
 
 #endif
 
+static bool tboot_check_txt_heap_section_bounds(const u64 heap_end,
+                                                void *heap_section,
+                                                u64* heap_section_size,
+                                                const char *section_name)
+{
+	if (!heap_section) {
+		pr_err("%s section is NULL\n", section_name);
+		return false;
+	}
+
+	if (!heap_section_size) {
+		pr_err("%s section size pointer is NULL\n", section_name);
+		return false;
+	}
+
+	*heap_section_size = 0;
+
+	if ((u64)heap_section > heap_end || heap_end - (u64)heap_section < 8) {
+		pr_err("%s size field exceeds heap boundary\n", section_name);
+		return false;
+	}
+
+	/* Read the size of the current TXT Heap section */
+	*heap_section_size = *(u64 __force *)heap_section;
+
+	if (*heap_section_size < 8) {
+		pr_err("%s size is too small\n", section_name);
+		return false;
+	}
+
+	if (*heap_section_size > heap_end - (u64)heap_section) {
+		pr_err("%s exceeds heap boundary\n", section_name);
+		return false;
+	}
+
+	return true;
+}
+
+static bool tboot_check_dtpr_size(const struct heap_ext_data_elt *elt)
+{
+	u64 dtpr_payload_size, dtpr_offset;
+	u32 i, ref_tpr_cnt;
+
+	struct acpi_table_dtpr   *dtpr        = NULL;
+	struct acpi_tpr_instance *tpr_inst    = NULL;
+	struct acpi_tpr_aux_sr   *tpr_aux_srl = NULL;
+
+	if (!elt) {
+		pr_err("DTPR element heap extension data is NULL\n");
+		return false;
+	}
+
+	dtpr              = (struct acpi_table_dtpr *)elt->data;
+	dtpr_payload_size = elt->size - sizeof(*elt);
+
+	if (dtpr_payload_size < sizeof(struct acpi_table_dtpr)) {
+		pr_err("DTPR element payload too small for a DTPR header\n");
+		return false;
+	}
+
+	if (dtpr->header.length != dtpr_payload_size) {
+		pr_err("Mismatch between DTPR table length and payload size\n");
+		return false;
+	}
+
+	dtpr_offset = sizeof(struct acpi_table_dtpr);
+
+	if (dtpr_offset > dtpr_payload_size) {
+		pr_err("TPR header exceeds table's declared size\n");
+		return false;
+	}
+
+	if (dtpr->ins_cnt < 1) {
+		pr_err("DTPR table declares no TPR instances\n");
+		return false;
+	}
+
+	for (i = 0; i < dtpr->ins_cnt; i++) {
+		/* prove this instance's header is in bounds before reading it */
+		if (dtpr_offset + sizeof(struct acpi_tpr_instance) > dtpr_payload_size) {
+			pr_err("TPR instance No.%u header exceeds DTPR table size\n", i);
+			return false;
+		}
+
+		/* iterate to the current TPR instance */
+		tpr_inst = (struct acpi_tpr_instance *)((u8 *)dtpr + dtpr_offset);
+
+		if (tpr_inst->tpr_cnt < 2) {
+			pr_err("TPR Instance %u has less than 2 TPRs, further DTPR "
+			       "processing interrupted.\n", i);
+			return false;
+		}
+
+		/* all instances must carry the same TPR count as the first */
+		if (i == 0)
+			ref_tpr_cnt = tpr_inst->tpr_cnt;
+		else if (tpr_inst->tpr_cnt != ref_tpr_cnt) {
+			pr_err("TPR Instance %u has inconsistent TPR count: expected %u,"
+			       " found %u\n", i, ref_tpr_cnt, tpr_inst->tpr_cnt);
+			return false;
+		}
+
+		/* iterate over each TPR instance */
+		dtpr_offset += sizeof(struct acpi_tpr_instance) +
+		               (u64)tpr_inst->tpr_cnt * sizeof(struct acpi_tpr_array);
+
+		/* verify TPR array size for this instance */
+		if (dtpr_offset > dtpr_payload_size) {
+			pr_err("TPR instance No.%u TPR entries exceed DTPR table size\n",
+			       i);
+			return false;
+		}
+	}
+
+	tpr_aux_srl = (struct acpi_tpr_aux_sr *)((u8 *)dtpr + dtpr_offset);
+	dtpr_offset += sizeof(u32);
+
+	if (dtpr_offset > dtpr_payload_size) {
+		pr_err("TPR SRL count field exceeds DTPR table size\n");
+		return false;
+	}
+
+	dtpr_offset += (u64)tpr_aux_srl->srl_cnt *
+	               sizeof(struct acpi_tpr_serialize_request);
+	if (dtpr_offset > dtpr_payload_size) {
+		pr_err("TPR SRL entries exceed DTPR table size\n");
+		return false;
+	}
+
+	if (dtpr_offset < dtpr_payload_size) {
+		pr_err("DTPR table is smaller than expected\n");
+		return false;
+	}
+
+	return true;
+}
+
 void tboot_shutdown(u32 shutdown_type)
 {
 	void (*shutdown)(void);
@@ -454,21 +592,23 @@ struct sha1_hash {
 };
 
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
@@ -514,3 +654,335 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
 
 	return dmar_tbl;
 }
+
+struct acpi_table_dtpr *tboot_get_dtpr_table(void __iomem **heap_base)
+{
+	void *heap_ptr, *config, *sinit_mle_end;
+	struct sinit_mle_data *sinit_mle;
+	struct heap_ext_data_elt *elt;
+	u64 heap_end, heap_size, sinit_mle_size, heap_section_size;
+
+	if (!heap_base) {
+		pr_warn("Heap base pointer is NULL.\n");
+		return NULL;
+	}
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
+	heap_size  = *(u64 __force *)(config + TXTCR_HEAP_SIZE);
+	*heap_base = ioremap(*(u64 __force *)(config + TXTCR_HEAP_BASE), heap_size);
+	iounmap(config);
+
+	if (!(*heap_base))
+		return NULL;
+
+	if (heap_size == 0 || (u64)(*heap_base) + heap_size < (u64)(*heap_base)) {
+		pr_err("TXT heap size invalid or overflows\n");
+		goto teardown;
+	}
+
+	heap_end   = (u64)(*heap_base) + heap_size;
+
+	/* walk heap to SinitMleData */
+	/* skip BiosData */
+	/* get BiosData section size */
+	if (!tboot_check_txt_heap_section_bounds(heap_end, *heap_base,
+	                                         &heap_section_size, "BiosData")) {
+		goto teardown;
+	}
+
+	/* skip OsMleData */
+	heap_ptr = *heap_base + heap_section_size;
+	/* get OsMleData section size */
+	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_ptr,
+	                                         &heap_section_size, "OsMleData")) {
+		goto teardown;
+	}
+
+	/* skip OsSinitData */
+	heap_ptr += heap_section_size;
+	/* get OsSinitData section size */
+	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_ptr,
+	                                         &heap_section_size, "OsSinitData")) {
+		goto teardown;
+	}
+
+	/* jump to the SinitMleData */
+	heap_ptr += heap_section_size;
+	sinit_mle_size = 0;
+	/* now points to SinitMleDataSize; set to SinitMleData */
+	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_ptr,
+	                                        &sinit_mle_size, "SinitMleData")) {
+		goto teardown;
+	}
+
+	heap_ptr += sizeof(u64);
+	sinit_mle = (struct sinit_mle_data *)heap_ptr;
+	sinit_mle_end = (void *)sinit_mle + sinit_mle_size;
+	if (sizeof(struct sinit_mle_data) > sinit_mle_size) {
+		pr_err("SinitMleData size is smaller than expected.\n");
+		goto teardown;
+	}
+
+	if (sinit_mle->version < 9) {
+		pr_err("Unsupported SinitMleData version: %u\n", sinit_mle->version);
+		goto teardown;
+	}
+
+	heap_ptr += sizeof(struct sinit_mle_data);
+	if (heap_ptr > sinit_mle_end) {
+		pr_err("SinitMleData header out of bounds.\n");
+		goto teardown;
+	}
+
+	/*
+	 * The SinitMleData extended-data area is a self-describing list of
+	 * variable-length elements with no stored element count; it is
+	 * terminated only by a HEAP_EXTDATA_TYPE_END element. Traversal must
+	 * therefore be driven by each element's own size field. Forward
+	 * progress and termination are guaranteed on every iteration:
+	 *   - the 8-byte header is bounds-checked before type/size are read,
+	 *   - elt->size >= sizeof(*elt) enforces a strictly-positive advance,
+	 *   - the "elt <= sinit_mle_end" cap bounds the number of steps.
+	 */
+	elt = sinit_mle->ext_data_elts;
+	do {
+		if ((u8 *)elt + sizeof(*elt) > (u8 *)sinit_mle_end) {
+			pr_err("SinitMleData element header out of bounds.\n");
+			goto teardown;
+		}
+
+		if (elt->size < sizeof(*elt)) {
+			pr_err("Invalid SinitMleData element size: %u\n", elt->size);
+			goto teardown;
+		}
+
+		if (elt->type == HEAP_EXTDATA_TYPE_END ||
+		    elt->type == HEAP_EXTDATA_TYPE_DTPR) {
+		    break;
+		}
+
+		elt = (void *)elt + elt->size;
+	} while ((void *)elt <= sinit_mle_end);
+
+	if ((void *)elt >= sinit_mle_end){
+		pr_err("Reached the end of SinitMleData without finding DTPR nor END"
+		       " element.\n");
+		goto teardown;
+	}
+
+	if (elt->type == HEAP_EXTDATA_TYPE_END) {
+		pr_err("DTPR element not found in SinitMleData\n");
+		goto teardown;
+	}
+
+	if ((u8 *)elt + elt->size > (u8 *)sinit_mle_end) {
+		pr_err("DTPR Table exceeds SinitMleData bounds.\n");
+		goto teardown;
+	}
+
+	if (!tboot_check_dtpr_size(elt)) {
+		pr_err("Invalid DTPR Table size.\n");
+		goto teardown;
+	}
+
+	return (struct acpi_table_dtpr *)elt->data;
+
+teardown:
+	tboot_free_txt_heap_mem(heap_base);
+	return NULL;
+}
+
+s64 tboot_check_tprs(struct acpi_table_dtpr *dtpr, void __iomem **heap_base)
+{
+	struct acpi_tpr_instance *tpr_inst;
+	struct acpi_tpr_array    *tpr_arr;
+	u32 *instance_cnt;
+	void __iomem *base;
+	u32 i, j;
+	u64 tpr_base_val;
+	s64 num_of_enabled_tprs = 0;
+
+	if (!heap_base) {
+		pr_warn("Heap base pointer is NULL.\n");
+		return -1;
+	}
+
+	if (!(*heap_base)) {
+		pr_warn("Heap base is NULL.\n");
+		return -1;
+	}
+
+	if (dtpr == NULL) {
+		pr_warn("DTPR Table is NULL.\n");
+		goto teardown;
+	}
+
+	if (!tboot_enabled()) {
+		pr_warn("TBOOT is not enabled. TPRs weren't set by TBOOT nor"
+		        " SINIT ACM.\n");
+		goto teardown;
+	}
+
+	instance_cnt = (u32 *)(&dtpr->ins_cnt);
+	tpr_inst = (struct acpi_tpr_instance *)(instance_cnt + 1);
+
+	for (i = 0; i < *instance_cnt; ++i) {
+		for (j = 0; j < tpr_inst->tpr_cnt; ++j) {
+			tpr_arr =  (struct acpi_tpr_array *)((u8 *) tpr_inst +
+			            sizeof(struct acpi_tpr_instance) +
+			            j * sizeof(struct acpi_tpr_array));
+
+			/*
+			 * Each TPR base address has already been verified by the SINIT ACM,
+			 * so it can be treated as trustworthy and used safely for I/O
+			 * mapping.
+			 */
+			base = ioremap(tpr_arr->base, 16);
+			if (!base) {
+				pr_warn("TPR Instance %u, TPR No.%u verification failure.\n",
+				        i, j);
+				continue;
+			}
+
+			tpr_base_val = readq(base);
+			pr_info("TPR instance %u, TPR %u:base 0x%llx, limit 0x%llx\n", i, j,
+			        tpr_base_val, readq((u8 __iomem *)base + 8));
+
+			/* Verify if the TPR base is enabled */
+			if ((tpr_base_val & (u64)TPR_BASE_DISABLE_BIT) == 0)
+				num_of_enabled_tprs++;
+
+			iounmap(base);
+		}
+
+		tpr_inst = (struct acpi_tpr_instance *)((u8 *)tpr_inst +
+		            sizeof(*tpr_inst) + j * sizeof(struct acpi_tpr_array));
+	}
+
+	pr_info("Number of enabled TPRs: %lld\n", num_of_enabled_tprs);
+	if (num_of_enabled_tprs > 0) {
+		pr_info("TPR protection is active. PMR will be disabled\n");
+	}
+
+	return num_of_enabled_tprs;
+
+teardown:
+	tboot_free_txt_heap_mem(heap_base);
+	return -1;
+}
+
+s64 tboot_disable_tprs(struct acpi_table_dtpr *dtpr,
+                       void __iomem **heap_base, s64 num_of_enabled_tprs)
+{
+	struct acpi_tpr_instance *tpr_inst;
+	struct acpi_tpr_array    *tpr_arr;
+	u32 *instance_cnt;
+	void __iomem *base;
+	u32 i, j;
+	u64 tpr_base_val;
+	s64 ret = 0;
+
+	if (!heap_base) {
+		pr_warn("Heap base pointer is NULL.\n");
+		return -1;
+	}
+
+	if (!(*heap_base)) {
+		pr_warn("Heap base is NULL.\n");
+		return -1;
+	}
+
+	if (dtpr == NULL) {
+		pr_warn("DTPR Table is NULL.\n");
+		ret = -1;
+		goto teardown;
+	}
+
+	if (!tboot_enabled()) {
+		pr_warn("TBOOT is not enabled. TPR weren't set by TBOOT and"
+		        " SINIT ACM.\n");
+		ret = -1;
+		goto teardown;
+	}
+
+	instance_cnt = (u32 *)(&dtpr->ins_cnt);
+	tpr_inst = (struct acpi_tpr_instance *)(instance_cnt + 1);
+
+	for (i = 0; i < *instance_cnt; ++i) {
+		for (j = 0; j < tpr_inst->tpr_cnt; ++j) {
+			tpr_arr = (struct acpi_tpr_array *)((u8 *) tpr_inst +
+			           sizeof(struct acpi_tpr_instance) +
+			           j * sizeof(struct acpi_tpr_array));
+
+			/*
+			 * Each TPR base address has already been verified by the SINIT ACM,
+			 * so it can be treated as trustworthy and used safely for I/O
+			 * mapping.
+			 */
+			base = ioremap(tpr_arr->base, 16);
+			if (!base) {
+				pr_warn("TPR Instance %u, TPR No.%u disabling failure.\n",
+				        i, j);
+				continue;
+			}
+
+			tpr_base_val = readq(base);
+			pr_info("TPR instance %u, TPR %u:base 0x%llx, limit 0x%llx\n", i, j,
+			        tpr_base_val, readq((u8 __iomem *)base + 8));
+
+			/* If the given TPR is active, disable it */
+			if ((tpr_base_val & (u64)TPR_BASE_DISABLE_BIT) == 0) {
+				writeq(tpr_base_val | TPR_BASE_DISABLE_BIT, base);
+				num_of_enabled_tprs--;
+			}
+			iounmap(base);
+		}
+
+		tpr_inst = (struct acpi_tpr_instance *)((u8 *)tpr_inst +
+		            sizeof(*tpr_inst) + j * sizeof(struct acpi_tpr_array));
+	}
+
+	if (num_of_enabled_tprs > 0) {
+		pr_err("TPR disabling failed for some instances.\n");
+		pr_err("Number of still enabled TPRs: %lld\n", num_of_enabled_tprs);
+	} else if (num_of_enabled_tprs < 0) {
+		pr_err("Number of enabled TPRs is negative, which indicates an "
+		       "error.\n");
+		pr_err("TPR disabling resulted in a negative count: %lld\n",
+		       num_of_enabled_tprs);
+	} else
+		pr_info("All of TPRs have been successfully disabled.\n");
+
+	ret = num_of_enabled_tprs;
+	goto teardown;
+
+teardown:
+	tboot_free_txt_heap_mem(heap_base);
+	return ret;
+}
+
+void tboot_free_txt_heap_mem(void __iomem **heap_base)
+{
+	if (heap_base && *heap_base) {
+		iounmap(*heap_base);
+		*heap_base = NULL;
+	}
+}
+
+bool tboot_is_tpr_protection_enabled(s64 num_of_enabled_tprs)
+{
+	return num_of_enabled_tprs > 0;
+}
diff --git a/include/linux/tboot.h b/include/linux/tboot.h
index d2279160ef39..5a5544dcfaad 100644
--- a/include/linux/tboot.h
+++ b/include/linux/tboot.h
@@ -24,10 +24,17 @@ enum {
 #include <linux/acpi.h>
 /* used to communicate between tboot and the launched kernel */
 
+/*TXT Extended Data Element Types*/
+#define HEAP_EXTDATA_TYPE_END   0
+#define HEAP_EXTDATA_TYPE_DTPR 14
+
 #define TB_KEY_SIZE             64   /* 512 bits */
 
 #define MAX_TB_MAC_REGIONS      32
 
+/*TPR Base Disable BIT*/
+#define TPR_BASE_DISABLE_BIT  BIT(4)
+
 struct tboot_mac_region {
 	u64  start;         /* must be 64 byte -aligned */
 	u32  size;          /* must be 64 byte -granular */
@@ -58,6 +65,15 @@ struct tboot_acpi_sleep_info {
 	u64 kernel_s3_resume_vector;
 } __packed;
 
+/*
+ * structure for tboot extended data elements
+ */
+struct heap_ext_data_elt {
+	u32 type;
+	u32 size;
+	u8  data[];
+} __packed;
+
 /*
  * shared memory page used for communication between tboot and kernel
  */
@@ -122,19 +138,29 @@ struct tboot {
 			 0xaa, 0x19, 0xea, 0x4d, 0x5, 0x7a, 0x8}
 
 bool tboot_enabled(void);
+extern s64 tboot_check_tprs(struct acpi_table_dtpr *, void __iomem **);
+extern s64 tboot_disable_tprs(struct acpi_table_dtpr *, void __iomem **, s64);
+extern void tboot_free_txt_heap_mem(void __iomem **);
 extern void tboot_probe(void);
 extern void tboot_shutdown(u32 shutdown_type);
 extern struct acpi_table_header *tboot_get_dmar_table(
 				      struct acpi_table_header *dmar_tbl);
+extern struct acpi_table_dtpr *tboot_get_dtpr_table(void __iomem **);
+extern bool tboot_is_tpr_protection_enabled(s64);
 
 #else
 
 #define tboot_enabled()			0
+#define tboot_check_tprs(dtpr, heap_base)   0
+#define tboot_disable_tprs(dtpr, heap_base, num_of_enabled_tprs) 0
 #define tboot_probe()			do { } while (0)
 #define tboot_shutdown(shutdown_type)	do { } while (0)
 #define tboot_sleep(sleep_state, pm1a_control, pm1b_control)	\
 					do { } while (0)
 #define tboot_get_dmar_table(dmar_tbl)	(dmar_tbl)
+#define tboot_get_dtpr_table(heap_base) NULL
+#define tboot_free_txt_heap_mem(heap_base) do { } while (0)
+#define tboot_is_tpr_protection_enabled(num_of_enabled_tprs) 0
 
 #endif /* !CONFIG_INTEL_TXT */
 
-- 
2.55.0

