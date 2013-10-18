From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 02/19] [HACK] ARM: tegra: Populate AHB/IOMMU earlier than others
Date: Fri, 18 Oct 2013 13:26:43 +0300
Message-ID: <1382092020-13170-3-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Populate AHB/IOMMU earlier than others. IOMMU depends on AHB. IOMMU
needs to be instanciated earlier than others so that IOMMU can
register other platform devices as IOMMU'able. Once IOMMU is
populated, IOMMU/AHB nodes are detached to prevent another
registeration.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-tegra/tegra.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 40b031c..9098a88 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -108,6 +108,26 @@ static void __init tegra_dt_init_irq(void)
 	tegra_legacy_irq_syscore_init();
 }
 
+static void tegra_of_platform_populate_iommu(void)
+{
+	int i;
+	struct platform_device *pdev;
+	const char * const path[] = {"/ahb", "/iommu", };
+
+	for (i = 0; i < ARRAY_SIZE(path); i++) {
+		struct device_node *np;
+
+		np  = of_find_node_by_path(path[i]);
+		if (!np)
+			break;
+
+		pdev = of_platform_device_create(np, NULL, NULL);
+		of_node_put(np);
+		if (!pdev)
+			break;
+	}
+}
+
 static void __init tegra_dt_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
@@ -137,6 +157,8 @@ static void __init tegra_dt_init(void)
 
 	parent = soc_device_to_device(soc_dev);
 
+	tegra_of_platform_populate_iommu();
+
 	/*
 	 * Finished with the static registrations now; fill in the missing
 	 * devices
-- 
1.8.1.5
