Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9EE1642F
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 15:39:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB5A512FC;
	Wed, 10 May 2023 08:39:39 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D0F93F67D;
	Wed, 10 May 2023 08:38:54 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	nicolinc@nvidia.com,
	jean-philippe@linaro.org
Subject: [PATCH 1/4] iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
Date: Wed, 10 May 2023 16:38:43 +0100
Message-Id: <08adbe3d01024d8382a478325f73b56851f76e49.1683731256.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1683731256.git.robin.murphy@arm.com>
References: <cover.1683731256.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MMU-600 versions prior to r1p0 fail to correctly generate a WFE wakeup
event when the command queue transitions fom full to non-full. We can
easily work around this by simply hiding the SEV capability such that we
fall back to polling for space in the queue - since MMU-600 implements
MSIs we wouldn't expect to need SEV for sync completion either, so this
should have little to no impact.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/arm64/silicon-errata.rst      |  2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 +++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 9e311bc43e05..951d8d42c248 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -140,6 +140,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU-600         | #1076982        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 86aab34a70bb..eb6d4423c533 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3432,6 +3432,33 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	return 0;
 }
 
+#define IIDR_IMPLEMENTER_ARM		0x43b
+#define IIDR_PRODUCTID_ARM_MMU_600	0x483
+
+static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	unsigned int implementer, productid, variant, revision;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
+	implementer = FIELD_GET(IIDR_IMPLEMENTER, reg);
+	productid = FIELD_GET(IIDR_PRODUCTID, reg);
+	variant = FIELD_GET(IIDR_VARIANT, reg);
+	revision = FIELD_GET(IIDR_REVISION, reg);
+
+	switch (implementer) {
+	case IIDR_IMPLEMENTER_ARM:
+		switch (productid) {
+		case IIDR_PRODUCTID_ARM_MMU_600:
+			/* Arm erratum 1076982 */
+			if (variant == 0 && revision <= 2)
+				smmu->features &= ~ARM_SMMU_FEAT_SEV;
+			break;
+		}
+		break;
+	}
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -3633,6 +3660,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	arm_smmu_device_iidr_probe(smmu);
+
 	if (arm_smmu_sva_supported(smmu))
 		smmu->features |= ARM_SMMU_FEAT_SVA;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b574c58a3487..5ce47f2e3402 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -69,6 +69,12 @@
 #define IDR5_VAX			GENMASK(11, 10)
 #define IDR5_VAX_52_BIT			1
 
+#define ARM_SMMU_IIDR			0x18
+#define IIDR_PRODUCTID			GENMASK(31, 20)
+#define IIDR_VARIANT			GENMASK(19, 16)
+#define IIDR_REVISION			GENMASK(15, 12)
+#define IIDR_IMPLEMENTER		GENMASK(11, 0)
+
 #define ARM_SMMU_CR0			0x20
 #define CR0_ATSCHK			(1 << 4)
 #define CR0_CMDQEN			(1 << 3)
-- 
2.39.2.101.g768bb238c484.dirty

