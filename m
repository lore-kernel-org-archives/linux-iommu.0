Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8241A1D04B8
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454799; cv=none; b=ZOmlylyPiTkSeVM0sccacGHXZ6R7xhk4Wd/+1iBME/BHaT2r3C0+ZJOdGPlGTTTKyQ2jBErSa/7gpg6o8e6FakUpaaDEv2Prz+c66oAhI0/Dgda9B19f3NY/hhuTcchvROaWSo/VOcE4JJzN5n2i8h95f5OMR5lKl6QoOrh6taQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454799; c=relaxed/simple;
	bh=UApVNWrRY9AAnXV+XoL9iKaOPQDnurammK0XV70bfJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tL9Wr74s9jORed0g5bNTgBG/LrNFyJBNTqf44zaO8Btm3MjfjnXmxyOxvL+y1b0b2wISB9thDR2A39EUoat3a3fOmLvkZx4yKFOcAYoB05sW5PY/MgboDaSatlSm0p54Dr3FRavx5i1SMpa6Q3YJy07yrkPUhaYL0/rOZBJiumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=sqJ0eBES; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="sqJ0eBES"
Received: from cap.home.8bytes.org (p4ffe1f47.dip0.t-ipconnect.de [79.254.31.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 390CC2886F9;
	Wed,  4 Sep 2024 14:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1725454795;
	bh=UApVNWrRY9AAnXV+XoL9iKaOPQDnurammK0XV70bfJk=;
	h=From:To:Cc:Subject:Date:From;
	b=sqJ0eBES7LSguNd8Z1DQlCQWehki/caf388QA2Tb3Zp5vGiPzz8psSPuf4owycevq
	 GKk6xdXcoDxqsaJM3ao5WkfIPeIQ/+xbW0cnoC6QVKp1nJpZJxy0NmimnVsIovbLX/
	 MKshaNxbZH8nIA9b6qa9tbuarKceWdWOz6By8fWpogJRRl/4EpDoNhH1wyk/LTn0uP
	 PnoMV3apyP0vQqcS7/qphsidK5UPraqmy3E18NAptZp0DCNqiTLzEAqscAB+Lg2Cxr
	 +IbRMOEs4RPWyoKHLmJNM62N1xdFVz1x9CWWTuPTW1MWCsbWPydeQFWnMmwDhM57jx
	 w3ie9No63Fc0w==
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
Subject: [PATCH] iommu/amd: Add parameter to limit V1 page-sizes to 4 KiB
Date: Wed,  4 Sep 2024 14:59:46 +0200
Message-ID: <20240904125946.4677-1-joro@8bytes.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

Add the 'pgsize_4k' as a valid value to the amd_iommu= command line
parameter to limit the page-sizes used for V1 page-tables for 4 KiB.
This is needed to make some devices working when attached to an AMD
SEV-SNP virtual machine.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 drivers/iommu/amd/amd_iommu.h                   | 1 +
 drivers/iommu/amd/amd_iommu_types.h             | 4 ++++
 drivers/iommu/amd/init.c                        | 5 +++++
 drivers/iommu/amd/io_pgtable.c                  | 2 +-
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..3187976ae052 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -339,6 +339,8 @@
 			pgtbl_v1     - Use v1 page table for DMA-API (Default).
 			pgtbl_v2     - Use v2 page table for DMA-API.
 			irtcachedis  - Disable Interrupt Remapping Table (IRT) caching.
+			pgsize_4k    - Limit the available page-sizes for v1 page-tables
+				       to 4 KiB.
 
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
index 6b15ce09e78d..63439f8f0a72 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -192,6 +192,8 @@ bool amdr_ivrs_remap_support __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
+unsigned long amd_iommu_pgsize_bitmap __ro_after_init = AMD_IOMMU_PGSIZES;
+
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
@@ -3492,6 +3494,9 @@ static int __init parse_amd_iommu_options(char *str)
 			amd_iommu_pgtable = AMD_IOMMU_V2;
 		} else if (strncmp(str, "irtcachedis", 11) == 0) {
 			amd_iommu_irtcachedis = true;
+		} else if (strncmp(str, "pgsize_4k", 9) == 0) {
+			pr_info("Restricting V1 page-sizes to 4KiB");
+			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_4K;
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

