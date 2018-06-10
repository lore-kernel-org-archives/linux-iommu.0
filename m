From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 3/5] iommu/amd: use default branch to deal with all non-supported capabilities
Date: Sun, 10 Jun 2018 19:07:21 +0800
Message-ID: <1528628843-10280-4-git-send-email-thunder.leizhen@huawei.com>
References: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, Guozhu Li <liguozhu@hisilicon.com>, Xinwei Hu <huxinwei@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Avoid below warning when new capabilities added:

drivers/iommu/amd_iommu.c: In function 'amd_iommu_capable':
drivers/iommu/amd_iommu.c:3053:2: warning: enumeration value 'IOMMU_CAP_NON_STRICT' not handled in switch [-Wswitch]
     switch (cap) {

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/amd_iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1912e91..8b0ba6d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3059,11 +3059,9 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
 		return (irq_remapping_enabled == 1);
-	case IOMMU_CAP_NOEXEC:
+	default:
 		return false;
 	}
-
-	return false;
 }

 static void amd_iommu_get_resv_regions(struct device *dev,
--
1.8.3
