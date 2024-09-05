Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700248CCC
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520973; cv=none; b=N8XOkoaX/iElo2meuMvtBz8IzAEfgbwkq1NmBkxte8LpNjwS0QHa86GiVDozfgR4aN1otgPlI82EjeewHp/1mru7ABTNhOkX3qOut/gZFVV46vK3xCeIKH2Fmtna2jQgEVkE2POMyYXoXAYkUYESPr49IWim5k4LO2y0Fg7rT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520973; c=relaxed/simple;
	bh=OlKQTydSLYfSzGLWaKzn+3UqDr6nSljVW7vlF9x1xLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSLJ1MAydpMVxmrtCP7rxQ89tBretfiaCyigSaGcpiS4FGFoX/AfilN2ahZzgRKIXfVjA9ym4MdxRRN1Z4vnSikF+BDLAkxV1wiMrx0/Ylqqrf8fJGNUSynsXHdLhwhfnckzasFQYlnhmGToAdckYuW6cCRYaL6cO+mpX6Gp5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=SCZbC90B; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="SCZbC90B"
Received: from cap.home.8bytes.org (p4ffe1f47.dip0.t-ipconnect.de [79.254.31.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E1B92288172;
	Thu,  5 Sep 2024 09:22:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1725520970;
	bh=OlKQTydSLYfSzGLWaKzn+3UqDr6nSljVW7vlF9x1xLc=;
	h=From:To:Cc:Subject:Date:From;
	b=SCZbC90BNLxqNGCJJUERQF8bbODvE9qfO6lx/rulvDeZKRf+ClvYgrGHtb99LHCP0
	 O3oJw2oC/msunb3QC4dPFI1tZ00Tde5FyO8M5LHqjW1sSUYa09y9TX1SKQcqsk1GVs
	 pPk0eJQGc5Euruh5rJMUSo561n2BdL/UGgfu/otVo4ztM7MIoCcc4owz90DCUYg2vV
	 UKk1i4p8s4Hrluf+Xe7f7qxhFnuKIru9GweUomRzivLe9ph2AOZJ/fUUiA8jMgCnKa
	 LrCEntwSnA7kGumOU6NJwWi8hIEUCUoDGtVnKCZi8PZRBuhy8M8IkdbGotoJW2yg5Y
	 kRTDGFyS7DTXg==
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	linux-doc@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
Date: Thu,  5 Sep 2024 09:22:40 +0200
Message-ID: <20240905072240.253313-1-joro@8bytes.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

Add two new kernel command line parameters to limit the page-sizes
used for v1 page-tables:

	nohugepages     - Limits page-sizes to 4KiB

	v2_pgsizes_only - Limits page-sizes to 4Kib/2Mib/1GiB; The
	                  same as the sizes used with v2 page-tables

This is needed for multiple scenarios. When assigning devices to
SEV-SNP guests the IOMMU page-sizes need to match the sizes in the RMP
table, otherwise the device will not be able to access all shared
memory.

Also, some ATS devices do not work properly with arbitrary IO
page-sizes as supported by AMD-Vi, so limiting the sizes used by the
driver is a suitable workaround.

All-in-all, these parameters are only workarounds until the IOMMU core
and related APIs gather the ability to negotiate the page-sizes in a
better way.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++------
 drivers/iommu/amd/amd_iommu.h                   |  1 +
 drivers/iommu/amd/amd_iommu_types.h             |  4 ++++
 drivers/iommu/amd/init.c                        |  8 ++++++++
 drivers/iommu/amd/io_pgtable.c                  |  2 +-
 5 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..6d6630aec46c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -333,12 +333,17 @@
 					  allowed anymore to lift isolation
 					  requirements as needed. This option
 					  does not override iommu=pt
-			force_enable - Force enable the IOMMU on platforms known
-				       to be buggy with IOMMU enabled. Use this
-				       option with care.
-			pgtbl_v1     - Use v1 page table for DMA-API (Default).
-			pgtbl_v2     - Use v2 page table for DMA-API.
-			irtcachedis  - Disable Interrupt Remapping Table (IRT) caching.
+			force_enable    - Force enable the IOMMU on platforms known
+				          to be buggy with IOMMU enabled. Use this
+				          option with care.
+			pgtbl_v1        - Use v1 page table for DMA-API (Default).
+			pgtbl_v2        - Use v2 page table for DMA-API.
+			irtcachedis     - Disable Interrupt Remapping Table (IRT) caching.
+			nohugepages     - Limit page-sizes used for v1 page-tables
+				          to 4 KiB.
+			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
+				          to 4KiB/2Mib/1GiB.
+
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 29e6e71f7f9a..6386fa4556d9 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -43,6 +43,7 @@ int amd_iommu_enable_faulting(unsigned int cpu);
 extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
+extern unsigned long amd_iommu_pgsize_bitmap;
 
 /* Protection domain ops */
 struct protection_domain *protection_domain_alloc(unsigned int type, int nid);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 35aa4ff020f5..601fb4ee6900 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -293,6 +293,10 @@
  * Page sizes >= the 52 bit max physical address of the CPU are not supported.
  */
 #define AMD_IOMMU_PGSIZES	(GENMASK_ULL(51, 12) ^ SZ_512G)
+
+/* Special mode where page-sizes are limited to 4 KiB */
+#define AMD_IOMMU_PGSIZES_4K	(PAGE_SIZE)
+
 /* 4K, 2MB, 1G page sizes are supported */
 #define AMD_IOMMU_PGSIZES_V2	(PAGE_SIZE | (1ULL << 21) | (1ULL << 30))
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6b15ce09e78d..43131c3a2172 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -192,6 +192,8 @@ bool amdr_ivrs_remap_support __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
+unsigned long amd_iommu_pgsize_bitmap __ro_after_init = AMD_IOMMU_PGSIZES;
+
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
@@ -3492,6 +3494,12 @@ static int __init parse_amd_iommu_options(char *str)
 			amd_iommu_pgtable = AMD_IOMMU_V2;
 		} else if (strncmp(str, "irtcachedis", 11) == 0) {
 			amd_iommu_irtcachedis = true;
+		} else if (strncmp(str, "nohugepages", 11) == 0) {
+			pr_info("Restricting V1 page-sizes to 4KiB");
+			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_4K;
+		} else if (strncmp(str, "v2_pgsizes_only", 15) == 0) {
+			pr_info("Restricting V1 page-sizes to 4KiB/2MiB/1GiB");
+			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 14f62c420e4a..804b788f3f16 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -548,7 +548,7 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 		return NULL;
 	pgtable->mode = PAGE_MODE_3_LEVEL;
 
-	cfg->pgsize_bitmap  = AMD_IOMMU_PGSIZES;
+	cfg->pgsize_bitmap  = amd_iommu_pgsize_bitmap;
 	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
 	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE;
 
-- 
2.46.0

