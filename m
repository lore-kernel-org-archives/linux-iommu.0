From: Artem Savkov <asavkov@redhat.com>
Subject: [PATCH v2] iommu/arm-smmu: fix null-pointer dereference in arm_smmu_add_device
Date: Tue,  8 Aug 2017 12:26:02 +0200
Message-ID: <1502187962-16861-1-git-send-email-asavkov@redhat.com>
References: <20170808092614.GB12887@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170808092614.GB12887@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Commit c54451a "iommu/arm-smmu: Fix the error path in arm_smmu_add_device"
removed fwspec assignment in legacy_binding path as redundant which is
wrong. It needs to be updated after fwspec initialisation in
arm_smmu_register_legacy_master() as it is dereferenced later. Without
this there is a NULL-pointer dereference panic during boot on some hosts.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 drivers/iommu/arm-smmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b97188a..2d80fa8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1519,6 +1519,13 @@ static int arm_smmu_add_device(struct device *dev)
 
 	if (using_legacy_binding) {
 		ret = arm_smmu_register_legacy_master(dev, &smmu);
+
+		/*
+		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
+		 * will allocate/initialise a new one. Thus we need to update fwspec for
+		 * later use.
+		 */
+		fwspec = dev->iommu_fwspec;
 		if (ret)
 			goto out_free;
 	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
-- 
2.7.5
