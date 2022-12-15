Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439B568B
	for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 16:52:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CF941063;
	Thu, 15 Dec 2022 08:52:46 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C14413F5A1;
	Thu, 15 Dec 2022 08:52:04 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH] iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY even betterer
Date: Thu, 15 Dec 2022 16:51:55 +0000
Message-Id: <d6dc41952961e5c7b21acac08a8bf1eb0f69e124.1671123115.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although it's vanishingly unlikely that anyone would integrate an SMMU
within a coherent interconnect without also making the pagetable walk
interface coherent, the same effect happens if a coherent SMMU fails to
advertise CTTW correctly. This turns out to be the case on some popular
NXP SoCs, where VFIO started failing the IOMMU_CAP_CACHE_COHERENCY test,
even though IOMMU_CACHE *was* previously achieving the desired effect
anyway thanks to the underlying integration.

While those SoCs stand to gain some more general benefits from a
firmware update to override CTTW correctly in DT/ACPI, it's also easy
to work around this in Linux as well, to avoid imposing too much on
affected users - since the upstream client devices *are* correctly
marked as coherent, we can trivially infer their coherent paths through
the SMMU as well.

Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Fixes: df198b37e72c ("iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY better")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 30dab1418e3f..0e679ad3171f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1319,8 +1319,14 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
-		/* Assume that a coherent TCU implies coherent TBUs */
-		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
+		/*
+		 * It's overwhelmingly the case in practice that when the pagetable
+		 * walk interface is connected to a coherent interconnect, all the
+		 * translation interfaces are too. Furthermore if the device is
+		 * natively coherent, then its translation interface must also be.
+		 */
+		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK ||
+			device_get_dma_attr(dev) == DEV_DMA_COHERENT;
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
-- 
2.36.1.dirty

