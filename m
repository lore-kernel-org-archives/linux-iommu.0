Received: from out12-31.antispamcloud.com (out12-31.antispamcloud.com [185.201.16.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83E3CF21A;
	Tue, 25 Aug 2026 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.16.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695916; cv=none; b=hYlThHRaGKCn++kVw/QHHrKiv+wHo3+ivbb2HOmCv0K2cB2KFNww3Xwc1J1qET+TYlp0vAWMUYqaQBEMXZIpb8+sn3AjMQqLrQyprKI5Ybmt4T+6ickNwhIOtBi9m6cbX10uL1yZUl7/t/mRy5gjnlSHIwyQhNs3ZrzOYHpjIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695916; c=relaxed/simple;
	bh=1Qv4QO0mYj04bidhIcIVyvnPCODoC2PdwDMGX31mlp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCXfUztxOGXOITkt+5fuF9Oa1hLiPyxPn4NGnNKpPSSbrtsqrQUAQ6DWEQVOtqj137LWFGxFvkj4o2+gK9lExnpa57V+XVzDWfpliVn+4AnrbyLsNFcmc3cKFElRD6pSKcVPCha8WquppzsBYWl3QNVhWJf04urMC3bhdgXcILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=l/XPe56m; arc=none smtp.client-ip=185.201.16.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="l/XPe56m"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx321.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1wyyCj-009y3s-SR; Tue, 25 Aug 2026 22:57:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m3+cWN21jKC43vl0SHCd4LqY7s3DjLiUP+ZmW8swaMk=; b=l/XPe56mHiEpHr0thFZAPQmbFh
	Ctwb15Eq9qrg+CrB0Nrb8oVSh+7+CgBxr6iJuZpGTyEQNcjjY2Q7g8i+hu9guYT6RTeC+nJGjzkvg
	qQY6tgoe8G8m8qq/rRHo6lbCz8EYuNN6X7SIVI97deZCtFmS+sSYKCL76ZkTmt95d5V/934gLYqwX
	/nhpiT5B/iHBCCnndlRdrK4ymFes5Z4YJazdgK+YlMwiN49SkIncrlgzS13uBBtVDCvuKORY7BTU+
	1CJQbkGp6LVMS63xGxImG7ks7Fs8qjAuhRF91Rq1hRPdavTo1KJg3O4TCfjECa8rfvPy+lOqX+kJX
	KjUEQ8NQ==;
Received: from [188.251.249.2] (port=59110 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <dan@reactivated.net>)
	id 1wyyCg-00000007Cd8-330I;
	Tue, 25 Aug 2026 20:57:06 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Tue, 25 Aug 2026 21:56:06 +0100
Subject: [PATCH v3 3/5] iommu/generic_pt: Add Broadcom BCM2712 page table
 format
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-bcm2712-iommu-submit-v3-3-7f143e7289b6@reactivated.net>
References: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
In-Reply-To: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
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
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (2.06786173701e-06)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXGK67EY6JoK5TrxASMgC1daBB7KH5SF4AY
 kGHYxc1Cyiu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVINOfm+scjG5w1mxwQchycJ7GnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWD7cCGtDjbxRVgnsKOrWMc2eB7itP8hgjDRserKv4bhb7ubyJcscJCC/8jhyq4eIIJWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AygJMVWPun
 1fB37VxVhASG8hN+IElQvHervZEzNuSEoswa+OggXLEoEANlDvY/gFZy/MXBXk8D5mjUeQRayE6u
 dz97s/DG8E3upRpJ0bS+wzRBHUR15RaqDwm4ioO24b2V/xoVM7xa9YKQVz3PCbzL9B0khM/Q6RX5
 n4wBXe4eJbd26ZpMsCKGEUNQoHD1dBwhSjvFGee+Sma/00rxpBtmA6JtX1tl9hlvVkB9JeTcvfje
 ogVSYoS8EzjRInfDtnb9xonw6auRGB+OqkfrxZvcAu63p/UbUTcmIpuXtxg/CxkM6Ccrh6NgeWPZ
 s2GGiUiSf3BA53ZrBURq7d95Cv9KDCFTYFcUbz5aS+1lWj4m3FNu1rSqDrVNGOYEXgKxu9VpMkhE
 mWb0+yA4G0yKmjhEqma1+/4Wol0EDMzOaSXdF5ul5d/P34eiOeGg3eceP8JBR+Z2rauNhtOAipyU
 VUOpJpoR8LmZMG0KW2fLvmDcwq5ovx/jotULrGAMzuIdJELu9Wrt/oF2ofKYeezPZTW+uJOuOlF5
 x2YtjfaUnDylc396zd5b9fxPYcgbuN9DD1eMzs1Q66kV+UAovquwsOu3XxP+6w9smK/hg5o9u16q
 yIzlag+DgD9xY7Yj7fvC65xWAU3TJceJXG+jXar6FtDTl6SazWHDhW0k3iY0Nxd1+egvPpyylyRk
 sDtvh9EglVwlBP3PkVHlQGQFk2KBEkFw3+vw1RS8zKP8o2x05FSSJsC7k+LzVpQY05oubiJ9GrzY
 ++DuIQUs/5JJj4C/n4CILpFTKQlqbzX/LSb50zWeMLtz8gacq+U9Dqtm91PWIuQmSNCVU02RYqut
 /9/ZY7JgbKJfN6DTVjUszJAalIcW0Bh5dbygTK7jtNAOpOLoYrBwYYKC6XIWdfPsJXrcrDW6vfdj
 zQ6YC7Heg3Xf7O1TOd7yUx++SDY6V9XDGiqeh8jJhxFbE1QSjfwMTndprmVkWxS1mi+nw+nJxqi8
 G/0EWIUjYWwLR6imeMTHTjvQuEg0VOblqea4u8lsncS+Zo8zrnNHf6G/7NjKIViWFaEeldR/m2+i
 TN8ji+Mhbk3TTo2Lw6nIoDr0sXUZ7YZoZ/GZ+slJL25ATsZTVifNjYlkFmCz0w5vcdcHI3py3L8t
 PqWAmEN/CjKjK3VVq9SDkpBDU8/nN9BMID38D/++xf97O23y3deP8vNnmz84mDUvZqxnHNc/wp8s
 bbUui5b8WkACIg5AB/ilm4apSU2goW8TQ8+z0w5vcdcHI3py3L8tPqWAC7xZyfryQF81aCkSJYKS
 vg==
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

Implement generic_pt support for the 2-level page table format used by
the BCM2712 IOMMUs.

Adapted from Raspberry Pi's downstream bcm2712-iommu driver (original
author Nick Hollinghurst).

Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 drivers/iommu/generic_pt/.kunitconfig        |   1 +
 drivers/iommu/generic_pt/Kconfig             |  10 +
 drivers/iommu/generic_pt/fmt/Makefile        |   2 +
 drivers/iommu/generic_pt/fmt/bcm2712.h       | 288 +++++++++++++++++++++++++++
 drivers/iommu/generic_pt/fmt/defs_bcm2712.h  |  18 ++
 drivers/iommu/generic_pt/fmt/iommu_bcm2712.c |   6 +
 include/linux/generic_pt/common.h            |   6 +
 include/linux/generic_pt/iommu.h             |  12 ++
 8 files changed, 343 insertions(+)

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
index 000000000000..2c5b034441c1
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/bcm2712.h
@@ -0,0 +1,288 @@
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
+	/* Leaf entries encode a 25-bit PFN */
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 25 + PT_GRANULE_LG2SZ,
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
+	BCM2712PT_PFN = GENMASK(24, 0),
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
+static inline unsigned int bcm2712pt_max_sw_bit(struct pt_common *common)
+{
+	return 2;
+}
+#define pt_max_sw_bit bcm2712pt_max_sw_bit
+
+static inline u32 bcm2712pt_sw_bit(unsigned int bitnr)
+{
+	if (__builtin_constant_p(bitnr) && bitnr > 2)
+		BUILD_BUG();
+	if (PT_WARN_ON(bitnr > 2))
+		return 0;
+
+	/* Bits 27, 26 and 25 are believed spare */
+	return BIT(27 - bitnr);
+}
+#define pt_sw_bit bcm2712pt_sw_bit
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
+		.common.hw_max_oasz_lg2 = 37,
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
index 000000000000..43fbc3cf3adc
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_bcm2712.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define PT_FMT bcm2712
+#define PT_SUPPORTED_FEATURES BIT(PT_FEAT_DMA_INCOHERENT)
+
+#include <linux/generic_pt/iommu.h>
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index 07ef1c8341a4..1b39b27f0cfa 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -213,4 +213,10 @@ enum {
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

