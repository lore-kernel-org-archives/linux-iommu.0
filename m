Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D423E25B
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487118; cv=none; b=Gb8SNklFJjM3PdKMZ+nW76Tc3npLS7F9c9KZ5JHY8bfW96Uml//3VpOBOLmzk1um6yS6fsrES+A/VALbzCwSqsTcYq+Xv5QMKo14Y5KVYVKwQg2s0RYJE/z4fdU0CtxuRYI84qIEtY0BjWmH1VMb3cRKOWl9/h2wNwMPJ4chr/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487118; c=relaxed/simple;
	bh=YN0mkH21n2Fww1yvZcUPiKtLFBiQiDMKuesKUZXOrWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjlQEnyBCHHOrMTQyFQvM3+zVjQZm3S/WVm4INFRsc9B1l2fnAGim09hotJYCuePqATUkycf4AIEUszuAYprPJxgb8yk+0FfWoDA2rHveMfop9nJ567Fm1FH8hCdPSYzxv+v481hNCeFHD8wbl4rR5rUD2YMEdxx5/EtMMPK5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuiRmamT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuiRmamT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780487117; x=1812023117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YN0mkH21n2Fww1yvZcUPiKtLFBiQiDMKuesKUZXOrWY=;
  b=SuiRmamTAuCfHT4XjfsPqcxZ93a2JxUC/jfSpv0SgwmsdxGcUK6/U1wA
   ru4sgh9N+t/1OIX5CkbLedeyUsefg54mMtzqjHxe1kwxjGIyCuOczMZJ1
   hCYqJwXOvrlmOhHABrc0qq1HxXrXn3U1EMfpgAHYOfxHOeLaL8Lp1bzYY
   5tA1OpTM2VP6x/G+SLUpY6Asf2r+J3QfbStSqA9osmP0SYmgS7xqEMASX
   UcO7QWBDs8Ka99WU1NzIozNXAUEfUD35RTmjOSj5GmWrBujoyEcSTdbht
   Na06B8QMAhh2xKZXFKDjoxa5CF4h1t7N+MT51Nml3lcAuEt1IBAPg60gn
   w==;
X-CSE-ConnectionGUID: j0x+jB9CSOWtSDirzPEiPQ==
X-CSE-MsgGUID: Q/DV6AYYTT+y3xcNZgvo9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85180028"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="85180028"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:45:16 -0700
X-CSE-ConnectionGUID: hgwgjV74RKCIzKwNIp0Ndw==
X-CSE-MsgGUID: lJoTqjF6TDuMulP9jD/M/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="243355972"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by orviesa010.jf.intel.com with ESMTP; 03 Jun 2026 04:45:13 -0700
From: Michal Camacho Romero <michal.camacho.romero@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Ning Sun <ning.sun@intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: x86@kernel.org,
	iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@intel.com>
Subject: [PATCH v1 1/2] x86/tboot: Add support for parsing DTPR table and disabling TPRs
Date: Wed,  3 Jun 2026 13:44:59 +0200
Message-ID: <20260603114500.2771319-2-michal.camacho.romero@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603114500.2771319-1-michal.camacho.romero@intel.com>
References: <20260603114500.2771319-1-michal.camacho.romero@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
 arch/x86/kernel/tboot.c | 146 +++++++++++++++++++++++++++++++++++-----
 include/linux/tboot.h   |  10 +++
 2 files changed, 141 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 46b8f1f16676..8825e5ee916c 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/tboot.h>
 #include <linux/debugfs.h>
+#include <acpi/actbl1.h>
 
 #include <asm/realmode.h>
 #include <asm/processor.h>
@@ -453,22 +454,30 @@ struct sha1_hash {
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
@@ -514,3 +523,110 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
 
 	return dmar_tbl;
 }
+
+struct acpi_table_dtpr *tboot_get_dtpr_table(void **heap_base)
+{
+	void *heap_ptr, *config;
+	struct sinit_mle_data *sinit_mle;
+	struct heap_ext_data_elt *elt;
+	u64 sinit_mle_size;
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
+	iounmap(config);
+
+	if (!(*heap_base))
+		return NULL;
+
+	/* walk heap to SinitMleData */
+	/* skip BiosData */
+	heap_ptr = *heap_base + *(u64 *) (*heap_base);
+	/* skip OsMleData */
+	heap_ptr += *(u64 *)heap_ptr;
+	/* skip OsSinitData */
+	heap_ptr += *(u64 *)heap_ptr;
+	/* now points to SinitMleDataSize; set to SinitMleData */
+	sinit_mle_size = *(u64 *)heap_ptr;
+	heap_ptr += sizeof(u64);
+
+	sinit_mle = (struct sinit_mle_data *)heap_ptr;
+	if (sinit_mle->version < 9) {
+		iounmap(*heap_base);
+		return NULL;
+	}
+
+	elt = sinit_mle->ext_data_elts;
+	while (elt->type != HEAP_EXTDATA_TYPE_DTPR &&
+		   elt->type != HEAP_EXTDATA_TYPE_END) {
+		elt = (void *)elt + elt->size;
+		if ((u64)elt > (u64)sinit_mle + sinit_mle_size) {
+			iounmap(*heap_base);
+			return NULL;
+		}
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
+
+	if (!tboot_enabled())
+		return;
+
+	tboot_tpr_enabled = true;
+	instance_cnt = (u32*)(&dtpr->ins_cnt);
+	tpr_inst = (struct acpi_tpr_instance *)(instance_cnt + 1);
+	for (i = 0; i < *instance_cnt; ++i) {
+		for (j = 0; j < tpr_inst->tpr_cnt; ++j) {
+			tpr_arr =  (struct acpi_tpr_array*)((u8*) tpr_inst +
+			            sizeof(struct acpi_tpr_instance) +
+			            j * sizeof(struct acpi_tpr_array));
+
+			base = ioremap(tpr_arr->base, 16);
+			if (!base) {
+				pr_warn("TPR Instance %d, TPR No.%d disabling failure.\n", i, j);
+				continue;
+			}
+
+			pr_info("TPR instance %d, TPR %d:base %llx limit %llx\n", i, j,
+			        readq(base), readq(base + 1));
+			writeq(readq(base) | BIT(4), base);
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
2.53.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

