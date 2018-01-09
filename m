From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 2/3] iommu/ipmmu-vmsa: Remove redundant of_iommu_init_fn hook
Date: Tue,  9 Jan 2018 16:17:26 +0000
Message-ID: <12163854e04da92b5de586912bf7257fc0fed79a.1515512134.git.robin.murphy@arm.com>
References: <da664cf8f60c77cbb657cc2e3849560604eaf6da.1515512134.git.robin.murphy@arm.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <da664cf8f60c77cbb657cc2e3849560604eaf6da.1515512134.git.robin.murphy@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: alex.williamson@redhat.com, joro@8bytes.org
Cc: sricharan@codeaurora.org, laurent.pinchart+renesas@ideasonboard.com, damm+renesas@opensource.se, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Having of_iommu_init() call ipmmu_init() via ipmmu_vmsa_iommu_of_setup()
does nothing that the subsys_initcall wouldn't do slightly later anyway,
since probe-deferral of masters means it is no longer critical to
register the driver super-early. Clean it up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New (somehow v1 was based on 4.14-rc3 so missed this...)

 drivers/iommu/ipmmu-vmsa.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 8dce3a9de9d8..331dad909301 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1108,18 +1108,8 @@ static void __exit ipmmu_exit(void)
 subsys_initcall(ipmmu_init);
 module_exit(ipmmu_exit);
 
-#ifdef CONFIG_IOMMU_DMA
-static int __init ipmmu_vmsa_iommu_of_setup(struct device_node *np)
-{
-	ipmmu_init();
-	return 0;
-}
-
-IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
-		 ipmmu_vmsa_iommu_of_setup);
-IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
-		 ipmmu_vmsa_iommu_of_setup);
-#endif
+IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa", NULL);
+IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795", NULL);
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
-- 
2.13.4.dirty
