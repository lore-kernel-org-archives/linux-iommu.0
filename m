Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6015962809
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153821; cv=none; b=kywuI/NTfUWS/nZg5PWf2azhJowTuuKFNa2pqCsrsVBJ5LhTlNLFOJkkMWPwBhs2OoMp/a95ztFWT71x0fx3awECrT0bCI0CEwIuLfl+4kQqN4ebE1V/jmTnE80xR7qdDKFzgIf2aNMJVJQaPyULi8U6ShmBKhQBxORrwqTsouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153821; c=relaxed/simple;
	bh=pPbk3JrquoOrp7mUJ2q1dVdxnnLQvl3I6n/QjgbKBBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfVSZ6lgK6ofZ5/32BW9B6vSvC8RYKkqGFH0X8smfegZzQHsRAjl0tNhlDnxwuJOfyYceP1nadgilI7Dc6rw2OLf02GsAc8YChv922scJYyeRr4Qeqzh2QqwNsjEEoqKqBThRgkWr0XtOyFOTz4Gg/nrNbI2w09o+/hSnRQI1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S3yFmYsS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S3yFmYsS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F881596;
	Mon, 27 Jul 2026 05:03:34 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A54103F86F;
	Mon, 27 Jul 2026 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785153818; bh=pPbk3JrquoOrp7mUJ2q1dVdxnnLQvl3I6n/QjgbKBBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3yFmYsSSanHZBACdAo989g4AKDAdOVvp1VurOoMv5tZ4XejtSK8FL3yqk9I/Hnn+
	 G5srGczrKQtrW3KwqJQCsNYoYOtug5ZXf00hSVpPizIpQMYJOQczH31jZN+bCs5RqJ
	 cdAvC+dH2xnJsxpR3F3iJ1pOhLmoIYJR7CLM1UW4=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com,
	joro@8bytes.org
Cc: jpb@kernel.org,
	jgg@nvidia.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] iommu/arm-smmu-v3: Add HAFT support for SVA
Date: Mon, 27 Jul 2026 13:03:29 +0100
Message-ID: <829b1d7eee64869d5c4231e80747367acb41b82b.1785153415.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1785153415.git.robin.murphy@arm.com>
References: <cover.1785153415.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since table access flags cannot be software-managed, if process
pagetables are using HAFT then SVA must require the SMMU to support and
enable it too, otherwise page aging is liable to get out of whack.

For unbinding, we can't disable HAFT atomically with HA as might be
desired, but luckily we can get away with just not disabling HA either.

Cc: <stable@vger.kernel.org>
Fixes: 62df5870ebf7 ("arm64: Enable ARCH_HAS_NONLEAF_PMD_YOUNG")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Make all HTTU settings unconditional WRT mm.

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 24 +++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 ++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +++
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 1ed8a6f29dc4..4cd60d3c450a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -92,16 +92,6 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 
 		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
 					      CTXDESC_CD_1_TTB0_MASK);
-
-		/*
-		 * Enable Hardware Access and Dirty updates (DBM) if supported.
-		 * This is safe to enable by default, as PTE_WRITE and PTE_DBM
-		 * share the same bit.
-		 */
-		if (master->smmu->features & ARM_SMMU_FEAT_HA)
-			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
-		if (master->smmu->features & ARM_SMMU_FEAT_HD)
-			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
 	} else {
 		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);
 
@@ -114,6 +104,17 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 			target->data[0] &=
 				cpu_to_le64(~(CTXDESC_CD_0_S | CTXDESC_CD_0_R));
 	}
+	/*
+	 * Enable Hardware Access and Dirty updates (DBM) if supported. This is
+	 * safe to enable by default, as PTE_WRITE and PTE_DBM share the same bit,
+	 * while the EPD0 config can't get as far as fetching any PTEs anyway.
+	 */
+	if (master->smmu->features & ARM_SMMU_FEAT_HA)
+		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
+	if (master->smmu->features & ARM_SMMU_FEAT_HD)
+		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
+	if (master->smmu->features & ARM_SMMU_FEAT_HAFT && system_supports_haft())
+		target->data[1] |= cpu_to_le64(CTXDESC_CD_1_HAFT);
 
 	/*
 	 * MAIR value is pretty much constant and global, so we can just get it
@@ -211,6 +212,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 	if (system_supports_bbml2_noabort())
 		feat_mask |= ARM_SMMU_FEAT_BBML2;
 
+	if (system_supports_haft())
+		feat_mask |= ARM_SMMU_FEAT_HAFT;
+
 	if ((smmu->features & feat_mask) != feat_mask)
 		return false;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..14e5b3f08962 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4921,10 +4921,14 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 
 static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
 {
-	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
+	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD |
+					    ARM_SMMU_FEAT_HAFT);
 	u32 hw_features = 0;
 
 	switch (FIELD_GET(IDR0_HTTU, reg)) {
+	case IDR0_HTTU_ACCESS_DIRTY_HAFT:
+		hw_features |= ARM_SMMU_FEAT_HAFT;
+		fallthrough;
 	case IDR0_HTTU_ACCESS_DIRTY:
 		hw_features |= ARM_SMMU_FEAT_HD;
 		fallthrough;
@@ -5256,6 +5260,9 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
 	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
+	case IDR0_HTTU_ACCESS_DIRTY_HAFT:
+		smmu->features |= ARM_SMMU_FEAT_HAFT;
+		fallthrough;
 	case IDR0_HTTU_ACCESS_DIRTY:
 		smmu->features |= ARM_SMMU_FEAT_HD;
 		fallthrough;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538..61a7df5afb99 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -40,6 +40,7 @@ struct arm_vsmmu;
 #define IDR0_HTTU			GENMASK(7, 6)
 #define IDR0_HTTU_ACCESS		1
 #define IDR0_HTTU_ACCESS_DIRTY		2
+#define IDR0_HTTU_ACCESS_DIRTY_HAFT	3
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF			GENMASK(3, 2)
 #define IDR0_TTF_AARCH64		2
@@ -369,6 +370,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define CTXDESC_CD_0_ASET		(1UL << 47)
 #define CTXDESC_CD_0_ASID		GENMASK_ULL(63, 48)
 
+#define CTXDESC_CD_1_HAFT		(1UL << 3)
 #define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(51, 4)
 
 /*
@@ -921,6 +923,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
 #define ARM_SMMU_FEAT_BBML2		(1 << 24)
+#define ARM_SMMU_FEAT_HAFT		(1 << 25)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.54.0.dirty

