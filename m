From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFT] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Tue, 15 Mar 2016 15:12:06 -0700
Message-ID: <1458079926-18716-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: iommu@lists.linux-foundation.org

We need to ensure amd iommu v2 initializes before
driver uses such as drivers/gpu/drm/amd/amdkfd/kfd_module.c,
to do this make its init routine a subsys_initcall() which
ensures its load init is called first than modules when
built-in.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---

Can someone test if this patch enables both CONFIG_AMD_IOMMU_V2 and
CONFIG_HSA_AMD to be =y (built-in) without any conflicts ?

 drivers/iommu/amd_iommu_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 56999d2fac07..60df645b9927 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -1004,5 +1004,5 @@ static void __exit amd_iommu_v2_exit(void)
 	destroy_workqueue(iommu_wq);
 }
 
-module_init(amd_iommu_v2_init);
+subsys_initcall(amd_iommu_v2_init);
 module_exit(amd_iommu_v2_exit);
-- 
2.7.2
