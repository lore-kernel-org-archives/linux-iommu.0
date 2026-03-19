Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7C3DEAFC
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933883; cv=none; b=RFMo+mWLK61Rf+sn3l/5UUcE5aLPFlr8ZmPkBcDTUuGTxkyTc0/fc0phxwWyshpDP40GoS2DSr7xXwuG6EjwqG40fbWUWzh9nhG4UJE21pE9kFaz3YPaTW3vOvvcv5VYvXxZjCCvINRuBl+dUeMWebqfakVQs97And2s4SGeWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933883; c=relaxed/simple;
	bh=KvRqE2MZ+E0Z/gxL14gQ5f15Do/UBpfTbDSMAduVpUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SRa9mJZBNEc6I2EbFpWm5HZvcjM6Yr7w9LgxtLEmN8oKGYnCncVMp/hnPXkcl1+AkFL8ZxQFHhNnJ+LrkIsXAMI88BErjSsyop7w9gEyAbqIzWMrEHs2B18jOhgQA5J+AN0PL9COAbxnAoIN7Ap72lZvEVELmIsUlc75wnfUFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 510961A25;
	Thu, 19 Mar 2026 08:24:35 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82BC83F778;
	Thu, 19 Mar 2026 08:24:40 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	daizhiyuan@phytium.com.cn
Subject: [PATCH v2] iommu/arm-smmu-v3: Update Arm errata
Date: Thu, 19 Mar 2026 15:24:34 +0000
Message-Id: <4c4664b2427cef212a06efdd78a9faa8d9ded302.1773933699.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
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
v2: Decouple from unrelated silicon-errata cleanup

 Documentation/arch/arm64/silicon-errata.rst |  8 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 4c300caad901..c81d7fc2c68c 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -207,8 +207,14 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982,1209401| N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-700         | #2268618,2812531| N/A                         |
+| ARM            | MMU-700         | #2133013,       | N/A                         |
+|                |                 | #2268618,       |                             |
+|                |                 | #2812531,       |                             |
+|                |                 | #3777127        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
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

