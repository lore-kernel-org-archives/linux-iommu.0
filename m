From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH] iommu/vt-d: Fix intel_pasid_max_id
Date: Tue, 30 Apr 2019 09:29:40 +0200
Message-ID: <20190430072940.10467-1-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org
List-Id: iommu@lists.linux-foundation.org

Extended Capability Register PSS field (PASID Size Supported)
corresponds to the PASID bit size -1.

"A value of N in this field indicates hardware supports PASID
field of N+1 bits (For example, value of 7 in this field,
indicates 8-bit PASIDs are supported)".

Fix the computation of intel_pasid_max_id accordingly.

Fixes: 562831747f62 ("iommu/vt-d: Global PASID name space")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 28cb713d728c..c3f1bfc81d2e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3331,7 +3331,7 @@ static int __init init_dmars(void)
 		 * than the smallest supported.
 		 */
 		if (pasid_supported(iommu)) {
-			u32 temp = 2 << ecap_pss(iommu->ecap);
+			u32 temp = 2 << (ecap_pss(iommu->ecap) + 1);
 
 			intel_pasid_max_id = min_t(u32, temp,
 						   intel_pasid_max_id);
-- 
2.20.1
