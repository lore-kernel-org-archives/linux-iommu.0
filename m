Received: from out13-174.antispamcloud.com (out13-174.antispamcloud.com [185.201.17.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DC427FA8;
	Mon, 27 Jul 2026 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.17.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785188516; cv=none; b=MvSnWSm2pqwaoP4N1tAi9zZqh1sBK2VGI8Z/DpkQe0H0jwtAB0McMKqLPNLPv+RwXF6xFxoFtmh9CZptgRHQl0W3CqOvD8gc2LlxKkXF7Sz/ECPRxNV/n+OeyfreCJ6bwlQb/mcR8ZPG9QKzb4fqCNBzo4ZiuysqLuSgfn+p4YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785188516; c=relaxed/simple;
	bh=u5r5dsQ48lmVdQ+G9PZwIoTlFiOPuFmmyDjA2lKhMNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZaqv8xmxXqUseko+pyGXhKYxmVo7w8pE8A0QX/EF6ZQzfDBzcVJBjlc/kecxgGaMOP2CwryVXaWdrmpoCE8s870QUu/6H/Qe9cGcuytqcH7i143K65v6JbgmN9IJtjPiG2U7eGwY8jjI7PG+oLPqpLbdbs7XzNCHVfUWLqWAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=On8ZNFYl; arc=none smtp.client-ip=185.201.17.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="On8ZNFYl"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx198.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1woSC6-00FE3e-Uo; Mon, 27 Jul 2026 22:45:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YvKrPG7wXSe34W5AglWqnp93vGlewdDzeUOiEfvTYmQ=; b=On8ZNFYlVsVWa1FQ4NTedIsSRP
	7nhAHE4kpS2TuK54lH26W3Pe+K1W4mby1fR8oPzmBG7OVn+D3s3MqCmcgkTxAH5qdfuRs7OuMTj/C
	DcbKJ/jkgc0boo4pnKI6HurbM9bzXxo5X3YLS77rvNCG/1suEWUPCfH+wQ3TiJQbBeo3AW5C4fjfH
	AVPPuJHvDut3JPqcyL0xYP3LdAgWdG4DBC37YZETXXArZWqMa0t/0cLjNFWO+FR54QB+yhplo5sBl
	D2HZ+jdq8MtsjRQcGyVQWiK32txwH1RapUlnV1JSPaI060NCBK7+b2BX3K+VtM97uy9rf8qdyphch
	YqaMU3BA==;
Received: from [188.251.249.2] (port=52006 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <dan@reactivated.net>)
	id 1woSC4-0000000AlhO-2dba;
	Mon, 27 Jul 2026 20:45:00 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Mon, 27 Jul 2026 21:43:58 +0100
Subject: [PATCH v2 3/5] iommu/generic_pt: Add Broadcom BCM2712 page table
 format
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-bcm2712-iommu-submit-v2-3-0247b5c03de8@reactivated.net>
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
In-Reply-To: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Daniel Drake <dan@reactivated.net>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (2.04711461543e-06)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVzj7ouivDTWGPH5FoP4Kkh8QsYYqY/Coa1
 ospiJlZ3tyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIO/94J7/pmBUUMRH2/87nPNGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWAIN4GsiK0O3K+JEByc7IobeB7itP8hgjDRserKv4bhb/pXHHNX+LCF5x5jewa7FkNWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyO3cajqKP
 N2TQucmsPqkADN9YaMSDrgb8f3EnZj8JSSVcMQtcPaBj0oM3kYoQzFFh/1fSrLRlrfqhJUG8z4R9
 /uECIyfb59UKcPyKB7/seAhbEXLAIlQO41grCDpV7x4SG0sbLPkEPwaTR9JCgIIwUaKDJQlUrg+c
 sO2wlDq1j4FhXBjpwUH3T5DwogMcW3n9eq+zqef+wJHXDp70tdmxlpLzlnjbD/7Y4GiVM0Vs+iZc
 VYJfyg12CBbscT1cNN1Jsfa3HCw6gGU1+SdwTBKf9HkMLWk/C0vLNlLzxrmqyasitZFgJIlVn1LH
 h1zXo+HQWBsS3EZt9a+xyS/dOq7TUqYyGJZd46kBXaReSYigCAhlVRgJDS0AzAOltsq3PRbZ63Kg
 QzPNdZuTKxU6aj16VjYz3CPunnl+LI7l5fzInLuGrwLN0VeqvzLlcRxwGgEvNMtirEVgSD8PZy6W
 zRj7WHIZl76lsW55eQV2n2lY9hpC2YtTBQO/Nu6TVwO6CV7e9KZY7AUftyem5JXm2HSubn2WKeN5
 PBvIRkiU4E8H4e7X9sw5VBsaDF9CxNBjABkH3hTMjGc3lQAtuckU+MNQlLpWhjjykqbde3UjWoF9
 cBo9q3T2iWmfFRW/Psbz8QFVy0V5rN3M2TZ9grsaBV7hOgCSkfEzb1aIdlnbLZp4DCYOuNFQ+5eG
 III/qgXB3gv2NI/ukWuQBNrXV+EmIqM8SxKOhcObZXWnkEw+6F9CGyYC9AhR1ZLKC40YaZQ+trtn
 c3HOUHNRces2OQfEVEXjAs190pw9vbXB/fDYbK4zbQOizxFc684o/A69h/CvHI/GeXW8oEyu47TQ
 DqTi6GKwcIp24VOsP5eu885wo+t+ynT3Y80OmAux3oN13+ztUzneZGHdcUfaxYq0ZH+Cc9iqnocR
 WxNUEo38DE53aa5lZFsy2onypIM6qetbKE/25wcBNqo/0fwiRTLlHdXA0y/rguAKl2WEToNozZ+h
 HTgqsldr3Z1SFe+4OrB9Rro7EpOy1Um2iVRPSUxhtw3wz3yqYcOpyKA69LF1Ge2GaGfxmfp09oMS
 l8c4ShQ//ve+MHzjs9MOb3HXByN6cty/LT6lgOv2AzRyYGlsi3xQeIJ6TM5o5F89lTjPCn99uwfA
 g5wm8t3Xj/LzZ5s/OJg1L2asZ/4te3BTDYEBZZ1yPQnIH5IVn/pKnch3lmmwSrgldH+Ps9MOb3HX
 ByN6cty/LT6lgO+c9AHZZ12442bv/l3jZJg=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

Implement generic_pt support for the 2-level page table format used by
the BCM2712 IOMMUs.

Adapted from Raspberry Pi's downstream bcm2712-iommu driver (original
author Nick Hollinghurst).

Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 drivers/iommu/bcm2712-iommu.h                |  22 +++
 drivers/iommu/generic_pt/.kunitconfig        |   1 +
 drivers/iommu/generic_pt/Kconfig             |  10 +
 drivers/iommu/generic_pt/fmt/Makefile        |   2 +
 drivers/iommu/generic_pt/fmt/bcm2712.h       | 283 +++++++++++++++++++++++++++
 drivers/iommu/generic_pt/fmt/defs_bcm2712.h  |  18 ++
 drivers/iommu/generic_pt/fmt/iommu_bcm2712.c |   8 +
 include/linux/generic_pt/common.h            |   6 +
 include/linux/generic_pt/iommu.h             |  12 ++
 9 files changed, 362 insertions(+)

diff --git a/drivers/iommu/bcm2712-iommu.h b/drivers/iommu/bcm2712-iommu.h
new file mode 100644
index 000000000000..18969b703e8c
--- /dev/null
+++ b/drivers/iommu/bcm2712-iommu.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _BCM2712_IOMMU_H
+#define _BCM2712_IOMMU_H
+
+#include <linux/sizes.h>
+
+/*
+ * Define an aperture inside which IOMMU mappings are operated.
+ *
+ * This aperture must be placed within a high, unused part of the address space:
+ * the IOMMU hardware caps the maximum reachable address at the top of the
+ * aperture, and we ensure that regular RAM/MMIO is available to non-IOMMU-users
+ * by creating a bypass window for all addresses below the aperture start.
+ *
+ * The aperture is hardcoded to 40GiB here, which is safely above RAM/MMIO
+ * on the BCM2712 SoC.
+ */
+#define BCM2712_APERTURE_BASE    (40ULL << 30)
+#define BCM2712_APERTURE_SIZE    SZ_4G
+#define BCM2712_APERTURE_END     (BCM2712_APERTURE_BASE + BCM2712_APERTURE_SIZE)
+
+#endif
diff --git a/drivers/iommu/generic_pt/.kunitconfig b/drivers/iommu/generic_pt/.kunitconfig
index 0bb98fe581fe..a3da74328f12 100644
--- a/drivers/iommu/generic_pt/.kunitconfig
+++ b/drivers/iommu/generic_pt/.kunitconfig
@@ -7,6 +7,7 @@ CONFIG_IOMMU_PT_AMDV1=y
 CONFIG_IOMMU_PT_VTDSS=y
 CONFIG_IOMMU_PT_RISCV64=y
 CONFIG_IOMMU_PT_X86_64=y
+CONFIG_IOMMU_PT_BCM2712=y
 CONFIG_IOMMU_PT_KUNIT_TEST=y
 
 CONFIG_IOMMUFD=y
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index f4ed1add58b7..2a81dac960ac 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -72,6 +72,15 @@ config IOMMU_PT_X86_64
 
 	  Selected automatically by an IOMMU driver that uses this format.
 
+config IOMMU_PT_BCM2712
+	tristate "IOMMU page table for Broadcom BCM2712"
+	help
+	  iommu_domain implementation for the Broadcom BCM2712 IOMMU found on
+	  Raspberry Pi 5. It supports 4K page sizes over a 2-level page table
+	  format.
+
+	  Selected automatically by an IOMMU driver that uses this format.
+
 config IOMMU_PT_KUNIT_TEST
 	tristate "IOMMU Page Table KUnit Test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
@@ -79,6 +88,7 @@ config IOMMU_PT_KUNIT_TEST
 	depends on IOMMU_PT_RISCV64 || !IOMMU_PT_RISCV64
 	depends on IOMMU_PT_X86_64 || !IOMMU_PT_X86_64
 	depends on IOMMU_PT_VTDSS || !IOMMU_PT_VTDSS
+	depends on IOMMU_PT_BCM2712 || !IOMMU_PT_BCM2712
 	default KUNIT_ALL_TESTS
 	help
 	  Enable kunit tests for GENERIC_PT and IOMMU_PT that covers all the
diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index ea024d582594..82ca3c36823d 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -9,6 +9,8 @@ iommu_pt_fmt-$(CONFIG_IOMMU_PT_RISCV64) += riscv64
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_X86_64) += x86_64
 
+iommu_pt_fmt-$(CONFIG_IOMMU_PT_BCM2712) += bcm2712
+
 IOMMU_PT_KUNIT_TEST :=
 define create_format
 obj-$(2) += iommu_$(1).o
diff --git a/drivers/iommu/generic_pt/fmt/bcm2712.h b/drivers/iommu/generic_pt/fmt/bcm2712.h
new file mode 100644
index 000000000000..83af4e5fa53b
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/bcm2712.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Daniel Drake
+ *
+ * BCM2712 IOMMU simple two level page table
+ */
+#ifndef __GENERIC_PT_FMT_BCM2712_H
+#define __GENERIC_PT_FMT_BCM2712_H
+
+#include "defs_bcm2712.h"
+#include "../pt_defs.h"
+
+#include <linux/bitfield.h>
+#include <linux/container_of.h>
+#include <linux/log2.h>
+#include <linux/sizes.h>
+
+#include "../../bcm2712-iommu.h"
+
+enum {
+	/* Hardware provides a two-level page table */
+	PT_MAX_TOP_LEVEL = 1,
+
+	/* Hardware page size is strictly 4kb */
+	PT_GRANULE_LG2SZ = ilog2(SZ_4K),
+	PT_TABLEMEM_LG2SZ = PT_GRANULE_LG2SZ,
+
+	/* Table entries and leaf entries are 32 bits */
+	PT_ITEM_WORD_SIZE = sizeof(pt_bcm2712_entry_t),
+
+	/* Leaf entries encode a 28-bit PFN */
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 28 + PT_GRANULE_LG2SZ,
+
+	/*
+	 * For simplicity, only manage mappings within an address space of
+	 * exactly 4GB. This is because our Level 1 directory page will be 4kb
+	 * in the smallest case, permitting 1024 entries pointing at Level 0
+	 * pages, each permitting 4mb of mapped memory.
+	 */
+	PT_MAX_VA_ADDRESS_LG2 = ilog2(SZ_4G),
+
+	/* Level 1 base address is programmed as a 32-bit PFN */
+	PT_TOP_PHYS_MASK = GENMASK_ULL(31 + PT_GRANULE_LG2SZ, PT_GRANULE_LG2SZ),
+};
+
+/* PTE bits */
+enum {
+	BCM2712PT_VALID = BIT(28),
+	BCM2712PT_WRITE = BIT(29),
+	BCM2712PT_PAGESIZE = GENMASK(31, 30),
+	BCM2712PT_PFN = GENMASK(27, 0),
+};
+
+#define common_to_bcm2712pt(common_ptr) \
+	container_of_const(common_ptr, struct pt_bcm2712, common)
+#define to_bcm2712pt(pts) common_to_bcm2712pt((pts)->range->common)
+
+static inline pt_oaddr_t bcm2712pt_table_pa(const struct pt_state *pts)
+{
+	return oalog2_mul(FIELD_GET(BCM2712PT_PFN, pts->entry),
+			  PT_GRANULE_LG2SZ);
+}
+#define pt_table_pa bcm2712pt_table_pa
+#define pt_item_oa bcm2712pt_table_pa
+
+/*
+ * IOPTEs placed within the page table correspond to addresses within the
+ * preconfigured aperture.
+ */
+static inline pt_vaddr_t
+bcm2712pt_full_va_prefix(const struct pt_common *common)
+{
+	return BCM2712_APERTURE_BASE;
+}
+#define pt_full_va_prefix bcm2712pt_full_va_prefix
+
+static inline bool bcm2712pt_can_have_leaf(const struct pt_state *pts)
+{
+	return true;
+}
+#define pt_can_have_leaf bcm2712pt_can_have_leaf
+
+/* 4MB pages are installed at level 1, everything else at level 0 */
+static inline unsigned int bcm2712pt_pgsz_lg2_to_level(struct pt_common *common,
+						       unsigned int pgsize_lg2)
+{
+	return pgsize_lg2 == ilog2(SZ_4M) ? 1 : 0;
+}
+#define pt_pgsz_lg2_to_level bcm2712pt_pgsz_lg2_to_level
+
+static inline pt_vaddr_t bcm2712pt_possible_sizes(const struct pt_state *pts)
+{
+	struct pt_bcm2712 *table = common_to_bcm2712pt(pts->range->common);
+
+	if (pts->level == 1)
+		return SZ_4M;
+
+	return SZ_4K |
+	       (table->bigpage_lg2 ? BIT_ULL(table->bigpage_lg2) : 0) |
+	       (table->superpage_lg2 ? BIT_ULL(table->superpage_lg2) : 0);
+}
+#define pt_possible_sizes bcm2712pt_possible_sizes
+
+static inline unsigned int
+bcm2712pt_entry_num_contig_lg2(const struct pt_state *pts)
+{
+	struct pt_bcm2712 *table = common_to_bcm2712pt(pts->range->common);
+	u32 pgsz = FIELD_GET(BCM2712PT_PAGESIZE, pts->entry);
+
+	if (pts->level != 0 || !(pts->entry & BCM2712PT_VALID))
+		return 0;
+
+	/*
+	 * Superpage/bigpage contiguous mapping (really just hinting) is handled
+	 * via PAGESIZE bits on each leaf entry.
+	 */
+	if (pgsz == 2 && table->superpage_lg2)
+		return table->superpage_lg2 - PT_GRANULE_LG2SZ;
+	else if (pgsz == 1 && table->bigpage_lg2)
+		return table->bigpage_lg2 - PT_GRANULE_LG2SZ;
+	return 0;
+}
+#define pt_entry_num_contig_lg2 bcm2712pt_entry_num_contig_lg2
+
+static inline unsigned int bcm2712pt_num_items_lg2(const struct pt_state *pts)
+{
+	return PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE);
+}
+#define pt_num_items_lg2 bcm2712pt_num_items_lg2
+
+static inline enum pt_entry_type bcm2712pt_load_entry_raw(struct pt_state *pts)
+{
+	const pt_bcm2712_entry_t *tablep =
+		pt_cur_table(pts, pt_bcm2712_entry_t);
+
+	pts->entry = READ_ONCE(tablep[pts->index]);
+	if (!(pts->entry & BCM2712PT_VALID))
+		return PT_ENTRY_EMPTY;
+
+	if (pts->level == 1) {
+		if (FIELD_GET(BCM2712PT_PAGESIZE, pts->entry) == 3)
+			return PT_ENTRY_OA;
+		return PT_ENTRY_TABLE;
+	}
+
+	return PT_ENTRY_OA;
+}
+#define pt_load_entry_raw bcm2712pt_load_entry_raw
+
+static inline void
+bcm2712pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
+			     unsigned int oasz_lg2,
+			     const struct pt_write_attrs *attrs)
+{
+	pt_bcm2712_entry_t *tablep = pt_cur_table(pts, pt_bcm2712_entry_t);
+	pt_bcm2712_entry_t entry;
+
+	if (!pt_check_install_leaf_args(pts, oa, oasz_lg2))
+		return;
+
+	entry = BCM2712PT_VALID | attrs->descriptor_bits |
+		FIELD_PREP(BCM2712PT_PFN, oalog2_div(oa, PT_GRANULE_LG2SZ));
+
+	if (pts->level == 1) {
+		/* Level 1 hugepage (4MB) */
+		entry |= FIELD_PREP(BCM2712PT_PAGESIZE, 3);
+		WRITE_ONCE(tablep[pts->index], entry);
+		pts->entry = entry;
+		return;
+	}
+
+	if (oasz_lg2 == PT_GRANULE_LG2SZ) {
+		WRITE_ONCE(tablep[pts->index], entry);
+		pts->entry = entry;
+	} else {
+		struct pt_bcm2712 *table =
+			common_to_bcm2712pt(pts->range->common);
+		u32 *end;
+
+		tablep += pts->index;
+		end = tablep + log2_to_int(oasz_lg2 - PT_GRANULE_LG2SZ);
+
+		/*
+		 * Leaf entries can contain hints indicating bigpage/superpage
+		 * contiguous mappings to permit TLB optimization
+		 */
+		if (oasz_lg2 == table->superpage_lg2)
+			entry |= FIELD_PREP(BCM2712PT_PAGESIZE, 2);
+		else if (oasz_lg2 == table->bigpage_lg2)
+			entry |= FIELD_PREP(BCM2712PT_PAGESIZE, 1);
+
+		pts->entry = entry;
+		for (; tablep != end; tablep++, entry++)
+			WRITE_ONCE(*tablep, entry);
+	}
+}
+#define pt_install_leaf_entry bcm2712pt_install_leaf_entry
+
+static inline bool bcm2712pt_install_table(struct pt_state *pts,
+					   pt_oaddr_t table_pa,
+					   const struct pt_write_attrs *attrs)
+{
+	pt_bcm2712_entry_t entry =
+		BCM2712PT_VALID |
+		FIELD_PREP(BCM2712PT_PFN,
+			   oalog2_div(table_pa, PT_GRANULE_LG2SZ));
+
+	return pt_table_install32(pts, entry);
+}
+#define pt_install_table bcm2712pt_install_table
+
+static inline void bcm2712pt_attr_from_entry(const struct pt_state *pts,
+					     struct pt_write_attrs *attrs)
+{
+	attrs->descriptor_bits = pts->entry & BCM2712PT_WRITE;
+}
+#define pt_attr_from_entry bcm2712pt_attr_from_entry
+
+/* --- iommu */
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+#define pt_iommu_table pt_iommu_bcm2712
+
+/* The common struct is in the per-format common struct */
+static inline struct pt_common *common_from_iommu(struct pt_iommu *iommu_table)
+{
+	return &container_of(iommu_table, struct pt_iommu_table, iommu)
+			->bcm2712pt.common;
+}
+
+static inline struct pt_iommu *iommu_from_common(struct pt_common *common)
+{
+	return &container_of(common, struct pt_iommu_table, bcm2712pt.common)
+			->iommu;
+}
+
+static inline int bcm2712_pt_iommu_set_prot(struct pt_common *common,
+					    struct pt_write_attrs *attrs,
+					    unsigned int iommu_prot)
+{
+	attrs->descriptor_bits = 0;
+	if (iommu_prot & IOMMU_WRITE)
+		attrs->descriptor_bits |= BCM2712PT_WRITE;
+	return 0;
+}
+#define pt_iommu_set_prot bcm2712_pt_iommu_set_prot
+
+static inline int bcm2712_pt_fmt_init(struct pt_iommu_table *fmt_table,
+				      const struct pt_iommu_bcm2712_cfg *cfg)
+{
+	fmt_table->bcm2712pt.bigpage_lg2 = cfg->bigpage_lg2;
+	fmt_table->bcm2712pt.superpage_lg2 = cfg->superpage_lg2;
+
+	pt_top_set_level(&fmt_table->bcm2712pt.common, PT_MAX_TOP_LEVEL);
+	return 0;
+}
+#define pt_iommu_fmt_init bcm2712_pt_fmt_init
+
+static inline void
+bcm2712pt_iommu_fmt_hw_info(struct pt_iommu_bcm2712 *table,
+			    const struct pt_range *top_range,
+			    struct pt_iommu_bcm2712_hw_info *info)
+{
+	info->pt_base = virt_to_phys(top_range->top_table);
+	PT_WARN_ON(info->pt_base & ~PT_TOP_PHYS_MASK);
+}
+#define pt_iommu_fmt_hw_info bcm2712pt_iommu_fmt_hw_info
+
+#if defined(GENERIC_PT_KUNIT)
+static const struct pt_iommu_bcm2712_cfg bcm2712_kunit_fmt_cfgs[] = {
+	[0] = {
+		.common.hw_max_vasz_lg2 = 32,
+		.common.hw_max_oasz_lg2 = 40,
+		.bigpage_lg2 = 16,
+		.superpage_lg2 = 20,
+	},
+};
+#define kunit_fmt_cfgs bcm2712_kunit_fmt_cfgs
+enum { KUNIT_FMT_FEATURES = 0 };
+#endif
+
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/defs_bcm2712.h b/drivers/iommu/generic_pt/fmt/defs_bcm2712.h
new file mode 100644
index 000000000000..f1d983be1716
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/defs_bcm2712.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __GENERIC_PT_FMT_DEFS_BCM2712_H
+#define __GENERIC_PT_FMT_DEFS_BCM2712_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/types.h>
+
+typedef u32 pt_bcm2712_entry_t;
+typedef u64 pt_vaddr_t;
+typedef u64 pt_oaddr_t;
+
+struct bcm2712pt_write_attrs {
+	pt_bcm2712_entry_t descriptor_bits;
+	gfp_t gfp;
+};
+#define pt_write_attrs bcm2712pt_write_attrs
+
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_bcm2712.c b/drivers/iommu/generic_pt/fmt/iommu_bcm2712.c
new file mode 100644
index 000000000000..855a3a07fb63
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_bcm2712.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define PT_FMT bcm2712
+#define PT_SUPPORTED_FEATURES (BIT(PT_FEAT_DMA_INCOHERENT) | BIT(PT_FEAT_NO_SW_BIT))
+/* BCM2712 has no spare software bits for tracking cache flushes */
+#define PT_FORCE_ENABLED_FEATURES BIT(PT_FEAT_NO_SW_BIT)
+
+#include <linux/generic_pt/iommu.h>
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index 9e8001f7b069..073332de7400 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -220,4 +220,10 @@ enum {
 	PT_FEAT_X86_64_AMD_ENCRYPT_TABLES = PT_FEAT_FMT_START,
 };
 
+struct pt_bcm2712 {
+	struct pt_common common;
+	u8 bigpage_lg2;
+	u8 superpage_lg2;
+};
+
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..13ebb72a67de 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -346,6 +346,18 @@ struct pt_iommu_x86_64_hw_info {
 
 IOMMU_FORMAT(x86_64, x86_64_pt);
 
+struct pt_iommu_bcm2712_cfg {
+	struct pt_iommu_cfg common;
+	u8 bigpage_lg2;
+	u8 superpage_lg2;
+};
+
+struct pt_iommu_bcm2712_hw_info {
+	phys_addr_t pt_base;
+};
+
+IOMMU_FORMAT(bcm2712, bcm2712pt);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif

-- 
2.55.0

