Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9C1E0DA6
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400891; cv=none; b=Qhgs9FnoSnQjcIehfvT7oNzNZhh7hZ0mq1vK+VWlqpZyANrM86+q8ZWsZj8rO4oOqctfPl+a+LqDtRBSqSZyeGhzns1M+BNiDZnX/14AgzC35/C5S6w0V+i1rZsoMQA32DgUSg0KJ1ODjPr/TRLlJ0QSSiEuK9TWcNCCkmr5Zg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400891; c=relaxed/simple;
	bh=c6lM3Ne+KMtnsLO/DIxA6d+Q6qFvHijdjHK+uTZwCrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eWkAPo4dbvHpghcaNEkJk9XwCv2g2dANGD0uQRlQKRm2kVL69YrST9tDAJmTq6V+uz6Hfyg5eo/0fEnzrt2+G7fvSdMDuVFKl8//+nik3eep567WnBxAC5KKMplvGRFkcYYYbgqStApp6sF8hkn03OH+P9A9Vzb+W0h2iw3d0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 912EADA7;
	Tue,  8 Oct 2024 08:21:57 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 445AF3F73F;
	Tue,  8 Oct 2024 08:21:27 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] iommu/arm-smmu: Clarify MMU-500 CPRE workaround
Date: Tue,  8 Oct 2024 16:21:17 +0100
Message-Id: <dfa82171b5248ad7cf1f25592101a6eec36b8c9a.1728400877.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPRE workarounds are implicated in at least 5 MMU-500 errata, some of
which remain unfixed. The comment and warning message have proven to be
unhelpfully misleading about this scope, so reword them to get the point
across with less risk of going out of date or confusing users.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---
v2: Further clarify that SACR is the likely culprit, not ACR which we
    do already configure
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 9dc772f2cbb2..99030e6b16e7 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -130,7 +130,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 
 	/*
 	 * Disable MMU-500's not-particularly-beneficial next-page
-	 * prefetcher for the sake of errata #841119 and #826419.
+	 * prefetcher for the sake of at least 5 known errata.
 	 */
 	for (i = 0; i < smmu->num_context_banks; ++i) {
 		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
@@ -138,7 +138,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
 		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
 		if (reg & ARM_MMU500_ACTLR_CPRE)
-			dev_warn_once(smmu->dev, "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
+			dev_warn_once(smmu->dev, "Failed to disable prefetcher for errata workarounds, check SACR.CACHE_LOCK\n");
 	}
 
 	return 0;
-- 
2.39.2.101.g768bb238c484.dirty

