From: Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] Correct AMD IOMMU printing
Date: Mon,  1 Oct 2012 15:41:13 +0800
Message-ID: <1349077273-17297-1-git-send-email-daniel@quora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Daniel J Blueman <daniel@quora.org>
List-Id: iommu@lists.linux-foundation.org

When an AMD IOMMU is detected, prevent printing unintended blank line.

Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/iommu/amd_iommu_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 18a89b7..49d9d32 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1115,8 +1115,8 @@ static void print_iommu_info(void)
 				if (iommu_feature(iommu, (1ULL << i)))
 					pr_cont(" %s", feat_str[i]);
 			}
+			pr_cont("\n");
 		}
-		pr_cont("\n");
 	}
 }
 
-- 
1.7.9.5
