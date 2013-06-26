From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 09/23] amba: Move AHB to core_initcall
Date: Wed, 26 Jun 2013 12:28:12 +0300
Message-ID: <1372238906-9346-10-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Move AHB to core_initcall in order to instanciate this device earlier
than others since IOMMU depends on AHB and then IOMMU driver needs to
reigster other platform devices as IOMMU'able.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/amba/tegra-ahb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 1f44e56..08e898d 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -283,7 +283,12 @@ static struct platform_driver tegra_ahb_driver = {
 		.pm = &tegra_ahb_pm,
 	},
 };
-module_platform_driver(tegra_ahb_driver);
+
+static int tegra_ahb_init(void)
+{
+	return platform_driver_register(&tegra_ahb_driver);
+}
+core_initcall(tegra_ahb_init);
 
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
 MODULE_DESCRIPTION("Tegra AHB driver");
-- 
1.8.1.5
