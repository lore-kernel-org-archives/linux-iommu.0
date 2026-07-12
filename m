Received: from out16-185.antispamcloud.com (out16-185.antispamcloud.com [185.201.18.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACEC3438A7;
	Sun, 12 Jul 2026 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892456; cv=none; b=I1QTPN2llUfC65SVc/Bdv+YBGs+uNjVbpJTTb48qZF4i5DX5EkiNyVpWRhYviR1Ii8UIJAok6AhmWaaJibRgNNGFgW/dnYiK/huiR+a8QW6014B7EL7NbKcxj8mrUQBOKO8yHO2e7dAM0/BY0fD+h3HyGiUaFdxEDyic21qBpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892456; c=relaxed/simple;
	bh=kiLrmFwpzAPggSoN+Az6CAtdPI3kMMAr3NzaaQT4LHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXwy/0qOLrknTass3vli6xYyayMsfUjIiw4+fRBl5o8MvdBUVvv7Mf/uSkU1N2zcX/k8jzshFPcPmGvXxRB54J9hrQ/SK8Du2ZeYDEUj3ETwHX4sFjFJp2e7us0qudhh+7h3dWPN3mrJVu2UgzPCjbVPmcAkQlNk9CgrDp3Yvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=Eq69JMP+; arc=none smtp.client-ip=185.201.18.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="Eq69JMP+"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx195.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1wj1a2-00GoTs-B7; Sun, 12 Jul 2026 23:19:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Nw2bPpEopVhz4huPWrcFIaSZzLEvLSlU1l2isca2pS8=; b=Eq69JMP+e5FZjDitvyIpv55lTh
	DUStU+ywBDlDUvj9LkEb9RLvHM+K8NAIPT0lmNz5b1yPPmnU2BqdkN0hd2rEqkRL3vWI46W59CPX2
	x050pq9EkH25wuPjfvWGcDK7P2cqbW+V+zgeBKiZTHvBrvZE+OPMt3KdBPKUETVpYt/nub0qq3iF0
	gzYZOunGxcMGTCOq7x92d7SX8IlzSX+RX+dc7NFGZ5id6lckxWvk19F9+cJPYr/Lz9Rm6KBetQ5vI
	a8QUDGkagZVeXpgP8rYV4B0SrMuBAezM8BS28d0wGXOvOfOitp82/IgbhriISCqct1k6HA8OyIVIt
	Jzv2V40g==;
Received: from [188.251.249.2] (port=43526 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <dan@reactivated.net>)
	id 1wj1Zz-0000000D6jk-1M3S;
	Sun, 12 Jul 2026 21:19:15 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Sun, 12 Jul 2026 22:18:54 +0100
Subject: [PATCH 4/6] iommu/generic_pt: Add Broadcom BCM2712 page table
 format
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-bcm2712-iommu-submit-v1-4-80e10cdde2ea@reactivated.net>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
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
X-Spampanel-Outgoing-Evidence: SB/global_tokens (6.1206878425e-06)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXRiyQmryWV4BRRLjcsacjqHxBeFjvnp6fc
 x8wmmbnGAyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIOV1x5DwgWX55iKFljXm6/4GnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCulNo0fvnzmZPW3MC2/ZtQeB7itP8hgjDRserKv4bhb3RyZlCL9i3kc+ehInPHgYZWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyPIv7c2tg
 uiTnO7hoWdxS2Euf+eM3l5KPnbp/eQthjVPLCh11+xKgET3fXj754wkhoRweeXUyelEFumxqJC98
 W2Chcvueb7X9IVOP0nXi5ScUGZbDvQNAWVsKTgEVkGFZkrTBb08hz2+hQWIE/jMJBRjlXAPIIi6r
 dxgy5Mnu2cDsZps7XJtkUNhIi117bsGJ7ren9RtRNyYim5e3GD8LGd17Yt5uvWRLqYZ7YcWBwuaj
 bB9FLgbTIobDkucCu6K1Qts6ESwZ+TRkjY5CmPXd4fzFwV5PA+Zo1HkEWshOrnfOczv/Rq1TfV/y
 9sPCUZ0yjBqTnQMt5W0GKvZ5TPS+0sUsSnvAz6a57TzpYAKZxAOMmYkwXP3g8rtJn6lRuSHjV8Jw
 2Fxq1Vd7xIu/TP3zxxtadaYgn3OIzsUC2wDRiPKWwieZyauFYqHkIbFa+ipFHuOywN1cBSoAw5Iq
 u8uD6H9vRamlPbOxG7rXq5Czwgf6xGEuqjPYHqCiHsRpKiyawVZCoGB4EfDx2fRuW8Y0o7OCze69
 5wqpq4Ow1lDfcfvX9sw5VBsaDF9CxNBjABkH3hTMjGc3lQAtuckU+MNQlLpWhjjykqbde3UjWoF9
 cBo9q3T2iWmfFRW/Psbz8QFVy0V5rN3M2TZ9grsaBV7hOgCSkfEzb1aIdlnbLZp4DCYOuNFQ+5eG
 III/qgXB3gv2NI/ukWuQBNrXV+EmIqM8SxKOhcObZXWnkEw+6F9CGyYC9AhR1ZLKC40YaZQ+trtn
 Eh9wUysc4uCrhmcWLql8TGOtwIHfmO1Lwr9gQsu1QjGizxFc684o/A69h/CvHI/GeXW8oEyu47TQ
 DqTi6GKwcIp24VOsP5eu885wo+t+ynT3Y80OmAux3oN13+ztUzneZGHdcUfaxYq0ZH+Cc9iqnocR
 WxNUEo38DE53aa5lZFsy2onypIM6qetbKE/25wcBZuuTlaWTvRropeUvYvOMiumkQGhQeK0QxIsV
 8RNXIPpr3Z1SFe+4OrB9Rro7EpOy1Um2iVRPSUxhtw3wz3yqYcOpyKA69LF1Ge2GaGfxmfp09oMS
 l8c4ShQ//ve+MHzjs9MOb3HXByN6cty/LT6lgOv2AzRyYGlsi3xQeIJ6TM5o5F89lTjPCn99uwfA
 g5wm8t3Xj/LzZ5s/OJg1L2asZ/4te3BTDYEBZZ1yPQnIH5IVn/pKnch3lmmwSrgldH+Ps9MOb3HX
 ByN6cty/LT6lgO+c9AHZZ12442bv/l3jZJg=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

The BCM2712 IOMMU implements a 2-level page table format. It is relatively
simple, with one unusual aspect: leaf entries can only be installed at
Level 0.

Adapted from Raspberry Pi's downstream bcm2712-iommu driver (original
author Nick Hollinghurst).

Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 drivers/iommu/generic_pt/.kunitconfig        |   1 +
 drivers/iommu/generic_pt/Kconfig             |  10 ++
 drivers/iommu/generic_pt/fmt/Makefile        |   2 +
 drivers/iommu/generic_pt/fmt/bcm2712.h       | 259 +++++++++++++++++++++++++++
 drivers/iommu/generic_pt/fmt/defs_bcm2712.h  |  18 ++
 drivers/iommu/generic_pt/fmt/iommu_bcm2712.c |  10 ++
 include/linux/generic_pt/common.h            |   7 +
 include/linux/generic_pt/iommu.h             |  13 ++
 8 files changed, 320 insertions(+)

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
index f4ed1add58b7..5c01cebb365f 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -72,6 +72,16 @@ config IOMMU_PT_X86_64
 
 	  Selected automatically by an IOMMU driver that uses this format.
 
+config IOMMU_PT_BCM2712
+	tristate "IOMMU page table for Broadcom BCM2712"
+	depends on !GENERIC_ATOMIC64 # for cmpxchg64
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
index 000000000000..e62d59181bfe
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/bcm2712.h
@@ -0,0 +1,259 @@
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
+/* All leaf entries are installed at level 0 */
+static inline bool bcm2712pt_can_have_leaf(const struct pt_state *pts)
+{
+	return pts->level == 0;
+}
+#define pt_can_have_leaf bcm2712pt_can_have_leaf
+
+/* All leaf entries are installed at level 0 */
+static inline unsigned int bcm2712pt_pgsz_lg2_to_level(struct pt_common *common,
+						       unsigned int pgsize_lg2)
+{
+	return 0;
+}
+#define pt_pgsz_lg2_to_level bcm2712pt_pgsz_lg2_to_level
+
+static inline pt_vaddr_t bcm2712pt_possible_sizes(const struct pt_state *pts)
+{
+	struct pt_bcm2712 *table = common_to_bcm2712pt(pts->range->common);
+
+	if (!bcm2712pt_can_have_leaf(pts))
+		return 0;
+
+	return table->pgsize_bitmap;
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
+	 * Hardware only supports contiguous mapping (really just hinting) via
+	 * PAGESIZE hints on each leaf entry.
+	 */
+	if (pgsz == 3)
+		return ilog2(SZ_4M) - PT_GRANULE_LG2SZ;
+	else if (pgsz == 2 && table->superpage_lg2)
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
+	return pts->level == 0 ? PT_ENTRY_OA : PT_ENTRY_TABLE;
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
+		 * Leaf entries can contain hints indicating multi-page
+		 * contiguous mappings, presumably to permit TLB optimization
+		 */
+		if (oasz_lg2 == ilog2(SZ_4M))
+			entry |= FIELD_PREP(BCM2712PT_PAGESIZE, 3);
+		else if (oasz_lg2 == table->superpage_lg2)
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
+	fmt_table->bcm2712pt.pgsize_bitmap = cfg->pgsize_bitmap;
+	fmt_table->bcm2712pt.bigpage_lg2 = cfg->bigpage_lg2;
+	fmt_table->bcm2712pt.superpage_lg2 = cfg->superpage_lg2;
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
+		.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_4M,
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
index 000000000000..8d87f7ea25f5
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
+typedef pt_bcm2712_entry_t pt_vaddr_t;
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
index 000000000000..059c34360785
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_bcm2712.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define PT_FMT bcm2712
+#define PT_SUPPORTED_FEATURES BIT(PT_FEAT_DMA_INCOHERENT)
+#define PT_FORCE_ENABLED_FEATURES 0
+
+/* BCM2712 has no spare software bits for tracking cache flushes */
+#define PT_SW_BIT_NOT_PRESENT
+
+#include <linux/generic_pt/iommu.h>
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index 07ef1c8341a4..8418e7fc621e 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -204,6 +204,13 @@ struct pt_x86_64 {
 	struct pt_common common;
 };
 
+struct pt_bcm2712 {
+	struct pt_common common;
+	u64 pgsize_bitmap;
+	u8 bigpage_lg2;
+	u8 superpage_lg2;
+};
+
 enum {
 	/*
 	 * The memory backing the tables is encrypted. Use __sme_set() to adjust
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..c4ee54561373 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -346,6 +346,19 @@ struct pt_iommu_x86_64_hw_info {
 
 IOMMU_FORMAT(x86_64, x86_64_pt);
 
+struct pt_iommu_bcm2712_cfg {
+	struct pt_iommu_cfg common;
+	u64 pgsize_bitmap;
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

