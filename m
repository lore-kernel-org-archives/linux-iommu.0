Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1851C38
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 15:26:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51BE41480;
	Mon, 15 Aug 2022 08:26:56 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCA203F70D;
	Mon, 15 Aug 2022 08:26:54 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY better
Date: Mon, 15 Aug 2022 16:26:50 +0100
Message-Id: <106c9741415f0b6358c72d53ae9c78c553a2b45c.1660574547.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com>
References: <d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assuming that any SMMU can enforce coherency for any device is clearly
nonsense. Although technically even a single SMMU instance can be wired
up to only be capable of emitting coherent traffic for some of the
devices it translates, it's a fairly realistic approximation that if the
SMMU's pagetable walker is wired up to a coherent interconnect then all
its translation units probably are too, and conversely that lack of
coherent table walks implies a non-coherent system in general. Either
way it's still less inaccurate than what we've been claiming so far.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 9 ++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab919ec43c4d..fceab59113ba 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1994,9 +1994,12 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
 /* IOMMU API */
 static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
-		return true;
+		/* Assume that a coherent TCU implies coherent TBUs */
+		return master->smmu->features & ARM_SMMU_FEAT_COHERENCY;
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index ce036a053fb8..8039c8bc8470 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1332,13 +1332,12 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 
 static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
+
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
-		/*
-		 * Return true here as the SMMU can always send out coherent
-		 * requests.
-		 */
-		return true;
+		/* Assume that a coherent TCU implies coherent TBUs */
+		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
-- 
2.36.1.dirty

