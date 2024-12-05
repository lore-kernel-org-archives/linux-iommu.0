Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43481DED77
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406500; cv=none; b=WNNUbo6bWuxndV01NlUsO1FbJG+/suvz+m6OfmbV9Mr+zuGHNGogw66A8/1TDliExyd9TTfXX6Qbv1mD/q4A56Zhum7Sks2BvHeC2MFbaY+yTyWMgq/w7g5/rMHrVtcYwigwcQb4CBwjW1I4qxskKXS/Qwkd+0c4ioAH/Jue6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406500; c=relaxed/simple;
	bh=l8eX4eOGzPzd1p3fBuq0cIHrQYw6Fcob5MIlJ8rBHCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qRYqGahpgvueUUzOGiR58qK5xo0bysajjPRnbVPDlf+yxrVCwi6CUkcqon1WjIVADD8miyqPpZjflh8xJpK8x+kJVBzzGAiEl2YyiuCiubQy7nRwxPiwxqJmIk6/Di2lWo8a6eZq0HMNBnO9pHfubsKXEbNE8evTbQuLFDEFUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B6201063;
	Thu,  5 Dec 2024 05:48:44 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BFC6D3F71E;
	Thu,  5 Dec 2024 05:48:14 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com
Cc: joro@8bytes.org,
	jean-philippe@linaro.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Document SVA interaction with new pagetable features
Date: Thu,  5 Dec 2024 13:48:09 +0000
Message-Id: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Process pagetables may now be using new permission-indirection-based
features which an SMMU may not understand when given such a table for
SVA. Although SMMUv3.4 does add its own S1PIE feature, realistically
we're still going to have to cope with feature mismatches between CPUs
and SMMUs, so let's start simple and essentially just document the
expectations for what falls out as-is. Although it seems unlikely for
SVA applications to also depend on memory-hardening features, or
vice-versa, the relative lifecycles make it tricky to enforce mutual
exclusivity. Thankfully our PIE index allocation makes it relatively
benign for an SMMU to keep interpreting them as direct permissions, the
only real implication is that an SVA application cannot harden itself
against its own devices with these features. Thus, inform the user about
that just in case they have other expectations.

Also we don't (yet) support LPA2, so deny SVA entirely if we're going to
misunderstand the pagetable format altogether.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 1d3e71569775..9ba596430e7c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -112,6 +112,15 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 	 * from the current CPU register
 	 */
 	target->data[3] = cpu_to_le64(read_sysreg(mair_el1));
+
+	/*
+	 * Note that we don't bother with S1PIE on the SMMU, we just rely on
+	 * our default encoding scheme matching direct permissions anyway.
+	 * SMMU has no notion of S1POE nor GCS, so make sure that is clear if
+	 * either is enabled for CPUs, just in case anyone imagines otherwise.
+	 */
+	if (system_supports_poe() || system_supports_gcs())
+		dev_warn_once(master->smmu->dev, "SVA devices ignore permission overlays and GCS\n");
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_sva_cd);
 
@@ -206,8 +215,12 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 	unsigned long asid_bits;
 	u32 feat_mask = ARM_SMMU_FEAT_COHERENCY;
 
-	if (vabits_actual == 52)
+	if (vabits_actual == 52) {
+		/* We don't support LPA2 */
+		if (PAGE_SIZE != SZ_64K)
+			return false;
 		feat_mask |= ARM_SMMU_FEAT_VAX;
+	}
 
 	if ((smmu->features & feat_mask) != feat_mask)
 		return false;
-- 
2.39.2.101.g768bb238c484.dirty

