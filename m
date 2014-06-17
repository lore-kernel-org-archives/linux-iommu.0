From: Jeff Liu <jeff.liu@oracle.com>
Subject: [PATCH 09/24]  drivers/iommu: check actual error on iommu_init
Date: Tue, 17 Jun 2014 22:29:19 +0800
Message-ID: <53A050BF.3000101@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

From: Jie Liu <jeff.liu@oracle.com>

kset_create_and_add() has been fixed to return the actual error
code ptr rather than NULL, so update iommu_init() to check the
return value via IS_ERR() accordingly.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jie Liu <jeff.liu@oracle.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e5555fc..297b5ad 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -925,7 +925,7 @@ static int __init iommu_init(void)
 	ida_init(&iommu_group_ida);
 	mutex_init(&iommu_group_mutex);
 
-	BUG_ON(!iommu_group_kset);
+	BUG_ON(IS_ERR(iommu_group_kset));
 
 	return 0;
 }
-- 
1.8.3.2
