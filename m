From: Jan Vesely <jan.vesely@rutgers.edu>
Subject: [PATCH 2/2] iommu/amd: Destroy api_lock mutex when freeing domain
Date: Sat, 21 May 2016 14:11:04 -0400
Message-ID: <1463854264-26445-2-git-send-email-jan.vesely@rutgers.edu>
References: <1463854264-26445-1-git-send-email-jan.vesely@rutgers.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463854264-26445-1-git-send-email-jan.vesely@rutgers.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jan Vesely <jan.vesely@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Jan Vesely <jan.vesely@amd.com>

Signed-off-by: Jan Vesely <jan.vesely@amd.com>
---
 drivers/iommu/amd_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 17c76f2..4ff5e40 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3016,6 +3016,7 @@ static void protection_domain_free(struct protection_domain *domain)
 
 	del_domain_from_list(domain);
 
+	mutex_destroy(&domain->api_lock);
 	if (domain->id)
 		domain_id_free(domain->id);
 
-- 
2.5.5
