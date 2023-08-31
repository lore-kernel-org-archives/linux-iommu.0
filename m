Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A3125B7
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=v7NZxvNPnyRQlSede9ZISRThidYdm2NHUeIAAgWaTrM=; b=ak1VrsUX0fhsX1qDO1zGgetfEZ
	18uwBG5d55Rm3LBBa7cUeliSClnV8LgqdECppU5GRCDhzhb7hBpxG93fQJebUBOHux5+xETKX37jJ
	wQ+OtGYlhhNhY6SfmmBit8aZJlkCdED6goGr6ViskmdJ3nAnuuBji4NRXbLr3a/CmLkgzIuk26TVc
	ng3zZ7gIjuuy9X+xhk+WEwOcN8e91nZB4rfdjkT2wVH28WXuOa/Ey4LFMzI4Ojlg4qp0zKmFIrXzc
	WGsAjHfJv2gcOIHpWaB8hISWog9wZtwybEi5W9cNkDwUHqqa80dInmSpb2V+S06SHH6nY0l5V9MCN
	NFuZnz0A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qbgpJ-00FHjc-2C;
	Thu, 31 Aug 2023 12:31:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/amd: remove amd_iommu_snp_enable
Date: Thu, 31 Aug 2023 14:31:07 +0200
Message-Id: <20230831123107.280998-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

amd_iommu_snp_enable is unused and has been since it was added in commit
fb2accadaa94 ("iommu/amd: Introduce function to check and enable SNP").

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/amd/init.c  | 38 --------------------------------------
 include/linux/amd-iommu.h |  4 ----
 2 files changed, 42 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ea0f1ab9417837..9f22e469da973b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3744,41 +3744,3 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 
 	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
 }
-
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-int amd_iommu_snp_enable(void)
-{
-	/*
-	 * The SNP support requires that IOMMU must be enabled, and is
-	 * not configured in the passthrough mode.
-	 */
-	if (no_iommu || iommu_default_passthrough()) {
-		pr_err("SNP: IOMMU is disabled or configured in passthrough mode, SNP cannot be supported");
-		return -EINVAL;
-	}
-
-	/*
-	 * Prevent enabling SNP after IOMMU_ENABLED state because this process
-	 * affect how IOMMU driver sets up data structures and configures
-	 * IOMMU hardware.
-	 */
-	if (init_state > IOMMU_ENABLED) {
-		pr_err("SNP: Too late to enable SNP for IOMMU.\n");
-		return -EINVAL;
-	}
-
-	amd_iommu_snp_en = check_feature_on_all_iommus(FEATURE_SNP);
-	if (!amd_iommu_snp_en)
-		return -EINVAL;
-
-	pr_info("SNP enabled\n");
-
-	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
-	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
-		pr_warn("Force to using AMD IOMMU v1 page table due to SNP\n");
-		amd_iommu_pgtable = AMD_IOMMU_V1;
-	}
-
-	return 0;
-}
-#endif
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 953e6f12fa1c30..58e6c3806c09d4 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -206,8 +206,4 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 		u64 *value);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-int amd_iommu_snp_enable(void);
-#endif
-
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.39.2

