Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5200D36492F
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129438; cv=none; b=G+VeYTIdD2LJfo4qfAuCYoSxhw6Q0gP6QJj4dt6J3ky+3d4SdT854Aseh1FXOItYocO/UCNfSVwZskY7qh7JvOes+0bmjGVePZW6m9AlVHWYFuxvCA+JeCi/1QeDqOZIKjOm5zfRfSfOv2r3KbvhcfYLfP4jiH4UgQB/+xeOGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129438; c=relaxed/simple;
	bh=lN2ZnhMiPEf+TLSB7jvS5uVTw3/q7Zui+o8BqXUCi0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CYV8cv1F4GH79MbUx7ZiEZ5ICphuWqCoZZmq/MSe2IMZLho0k0Yhjs0T90ygnfnVUdRbcOMgE/RG4OZn28Nka+wdQ4OYmQPBlknZe8yQyOBgagrJf5pyYyvwWxZenAnO6Cu91VwJ+MzfXC4sLmfZIrnUmlVKzM82TAm4i3CmCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA6841762;
	Thu, 26 Feb 2026 10:10:24 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DC893F73B;
	Thu, 26 Feb 2026 10:10:29 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	daizhiyuan@phytium.com.cn
Subject: [PATCH 2/3] iommu/arm-smmu-v3: Update Arm errata
Date: Thu, 26 Feb 2026 18:10:21 +0000
Message-Id: <06b86c11a4642ee64a7735eca02406e43ee2105f.1772125743.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1772125743.git.robin.murphy@arm.com>
References: <cover.1772125743.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MMU-700 r1p1 has subsequently fixed some of the errata for which we've
been applying the workarounds unconditionally, so we can now make those
conditional. However, there have also been some more new cases
identified where we must rely on range invalidation commands, and thus
still nominally avoid DVM being inadvertently enabled.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 10 ++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 2e8f57657de7..745ff25f5854 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -212,8 +212,14 @@ stable kernels.
 | ARM            | MMU-600         | #1076982,       | N/A                         |
 |                |                 | #1209401        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-700         | #2268618,       | N/A                         |
-|                |                 | #2812531        |                             |
+| ARM            | MMU-700         | #2133013,       | N/A                         |
+|                |                 | #2268618,       |                             |
+|                |                 | #2812531,       |                             |
+|                |                 | #3777127        |                             |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU L1          | #3878312        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU S3          | #3995052        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f078..3d816c67508d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4308,6 +4308,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 #define IIDR_IMPLEMENTER_ARM		0x43b
 #define IIDR_PRODUCTID_ARM_MMU_600	0x483
 #define IIDR_PRODUCTID_ARM_MMU_700	0x487
+#define IIDR_PRODUCTID_ARM_MMU_L1	0x48a
+#define IIDR_PRODUCTID_ARM_MMU_S3	0x498
 
 static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 {
@@ -4332,11 +4334,19 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			break;
 		case IIDR_PRODUCTID_ARM_MMU_700:
-			/* Arm erratum 2812531 */
+			/* Many errata... */
+			smmu->features &= ~ARM_SMMU_FEAT_BTM;
+			if (variant < 1 || revision < 1) {
+				/* Arm erratum 2812531 */
+				smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+				/* Arm errata 2268618, 2812531 */
+				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
+			}
+			break;
+		case IIDR_PRODUCTID_ARM_MMU_L1:
+		case IIDR_PRODUCTID_ARM_MMU_S3:
+			/* Arm errata 3878312/3995052 */
 			smmu->features &= ~ARM_SMMU_FEAT_BTM;
-			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
-			/* Arm errata 2268618, 2812531 */
-			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			break;
 		}
 		break;
-- 
2.39.2.101.g768bb238c484.dirty

