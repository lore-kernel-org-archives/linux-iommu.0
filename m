From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/amd: Add default branch in amd_iommu_capable()
Date: Mon,  8 Oct 2018 10:24:19 +0800
Message-ID: <20181008022419.31865-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Recent gcc warns about switching on an enumeration, but not having
an explicit case statement for all members of the enumeration. To
show the compiler this is intentional, we simply add a default case
with nothing more than a break statement.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index bee0dfb7b93b..1167ff0416cf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3083,6 +3083,8 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 		return (irq_remapping_enabled == 1);
 	case IOMMU_CAP_NOEXEC:
 		return false;
+	default:
+		break;
 	}
 
 	return false;
-- 
2.17.1
