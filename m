From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] iommu/ipmmu-vmsa: Fix return value check in ipmmu_find_group_dma()
Date: Tue, 17 Oct 2017 12:11:22 +0000
Message-ID: <1508242282-73764-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

In case of error, the function iommu_group_get() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 3ae47292024f ("iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iommu/ipmmu-vmsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index af81400..00e88a8 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -871,7 +871,7 @@ static struct iommu_group *ipmmu_find_group_dma(struct device *dev)
 	sibling = ipmmu_find_sibling_device(dev);
 	if (sibling)
 		group = iommu_group_get(sibling);
-	if (!sibling || IS_ERR(group))
+	if (!sibling || !group)
 		group = generic_device_group(dev);
 
 	return group;
