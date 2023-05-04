Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC0C124
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 21:11:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BB242F4;
	Thu,  4 May 2023 14:11:46 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D76B13F67D;
	Thu,  4 May 2023 14:11:00 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	jgg@nvidia.com
Cc: will@kernel.org,
	schnelle@linux.ibm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu: Add a capability for flush queue support
Date: Thu,  4 May 2023 22:10:55 +0100
Message-Id: <f0086a93dbccb92622e1ace775846d81c1c4b174.1683233867.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1683233867.git.robin.murphy@arm.com>
References: <cover.1683233867.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing a special type to domain_alloc to indirectly query whether flush
queues are a worthwhile optimisation with the given driver is a bit
clunky, and looking increasingly anachronistic. Let's put that into an
explicit capability instead.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/iommu.c                   | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 +
 drivers/iommu/intel/iommu.c                 | 1 +
 include/linux/iommu.h                       | 5 +++++
 5 files changed, 10 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4a314647d1f7..9b7bd6bed664 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2293,6 +2293,8 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 		return amdr_ivrs_remap_support;
 	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
 		return true;
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
 	default:
 		break;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3fd83fb75722..6d65a7e81df4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2008,6 +2008,7 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 		/* Assume that a coherent TCU implies coherent TBUs */
 		return master->smmu->features & ARM_SMMU_FEAT_COHERENCY;
 	case IOMMU_CAP_NOEXEC:
+	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
 	default:
 		return false;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6e0813b26fb6..7f4ee365912c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1325,6 +1325,7 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK ||
 			device_get_dma_attr(dev) == DEV_DMA_COHERENT;
 	case IOMMU_CAP_NOEXEC:
+	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
 	default:
 		return false;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b871a6afd803..ff923298f8ed 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4369,6 +4369,7 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
+	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
 	case IOMMU_CAP_PRE_BOOT_PROTECTION:
 		return dmar_platform_optin();
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e8c9a7da1060..1b7180d6edae 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -127,6 +127,11 @@ enum iommu_cap {
 	 * this device.
 	 */
 	IOMMU_CAP_ENFORCE_CACHE_COHERENCY,
+	/*
+	 * IOMMU driver does not issue TLB maintenance during .unmap, so can
+	 * usefully support the non-strict DMA flush queue.
+	 */
+	IOMMU_CAP_DEFERRED_FLUSH,
 };
 
 /* These are the possible reserved region types */
-- 
2.39.2.101.g768bb238c484.dirty

