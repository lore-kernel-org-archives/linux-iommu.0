From: Rob Clark <robdclark@gmail.com>
Subject: [RFC 3/3] iommu/arm-smmu: detach DMA domain if driver is managing iommu
Date: Wed,  1 Feb 2017 10:23:41 -0500
Message-ID: <20170201152341.29142-4-robdclark@gmail.com>
References: <20170201152341.29142-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170201152341.29142-1-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Sricharan R <sricharan@codeaurora.org>, Jordan Crouse <jcrouse@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Before the driver is probed, arm_smmu_add_device() helpfully attaches
an IOMMU_DOMAIN_DMA domain.  Which ofc does not support stalling, and
when the driver later attaches a domain that can_stall to an smmu that
can stall, the default _DMA domain prevents stalling from being enabled.
(And will cause further problems later)

One simple way to deal with this is simply toss the default _DMA domain
if the driver attaches it's own domain.

TODO maybe the tracking of list of attached domains should be done in
iommu core, so the detach can happen outside of group->mutex.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/iommu/arm-smmu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 96a1be6..50bf135 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1323,6 +1323,21 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	smmu = fwspec_smmu(fwspec);
 
+	/*
+	 * If driver is explicitly managing the iommu, detatch any previously
+	 * attached _DMA domains.
+	 *
+	 * TODO maybe this logic should be in iommu_attach_device() so it can
+	 * happen outside of holding group->mutex??
+	 */
+	if (domain->type != IOMMU_DOMAIN_DMA) {
+		struct arm_smmu_domain *other_domain, *n;
+
+		list_for_each_entry_safe(other_domain, n, &smmu->domain_list, domain_node)
+			if (other_domain->domain.type == IOMMU_DOMAIN_DMA)
+				arm_smmu_detach_dev(&other_domain->domain, dev);
+	}
+
 	if (WARN_ON(!list_empty(&smmu_domain->domain_node)))
 		return -EINVAL;
 
-- 
2.9.3
