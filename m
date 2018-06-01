From: "yzhai003@ucr.edu" <yzhai003@ucr.edu>
Subject: [PATCH] iommu/amd: Argument page_size could be uninitialized
Date: Fri,  1 Jun 2018 11:30:14 -0700
Message-ID: <1527877815-11132-1-git-send-email-yzhai003@ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: yzhai003@ucr.edu, csong@cs.ucr.edu, zhiyunq@cs.ucr.edu
List-Id: iommu@lists.linux-foundation.org

Argument "page_size" passing to function "fetch_pte" could be
uninitialized if the function returns NULL

The caller "iommu_unmap_page" checks the return value but the page_size is
used outside the if block.

Signed-off-by: yzhai003@ucr.edu <yzhai003@ucr.edu>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8fb8c73..7c15eaf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1398,6 +1398,8 @@ static u64 *fetch_pte(struct protection_domain *domain,
 	int level;
 	u64 *pte;
 
+	*page_size = 0;
+
 	if (address > PM_LEVEL_SIZE(domain->mode))
 		return NULL;
 
-- 
2.7.4
