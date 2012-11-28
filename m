From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] iommu/tegra: gart: Move bus_set_iommu after probe for multi arch
Date: Wed, 28 Nov 2012 15:52:54 +0200
Message-ID: <1354110775-11810-2-git-send-email-hdoyu@nvidia.com>
References: <1354110775-11810-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354110775-11810-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

For a single image to support multiple SoCs(GART/SMMU).

Reported-by: Arto Merilainen <amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-gart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index c16e8fc..4c9db62 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -398,6 +398,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	do_gart_setup(gart, NULL);
 
 	gart_handle = gart;
+	bus_set_iommu(&platform_bus_type, &gart_iommu_ops);
 	return 0;
 
 fail:
@@ -450,7 +451,6 @@ static struct platform_driver tegra_gart_driver = {
 
 static int __devinit tegra_gart_init(void)
 {
-	bus_set_iommu(&platform_bus_type, &gart_iommu_ops);
 	return platform_driver_register(&tegra_gart_driver);
 }
 
-- 
1.7.9.5
