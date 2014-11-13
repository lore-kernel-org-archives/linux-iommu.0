From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 12/12] memory: tegra: Add Tegra132 support
Date: Thu, 13 Nov 2014 10:32:37 +0100
Message-ID: <1415871157-21968-13-git-send-email-thierry.reding@gmail.com>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415871157-21968-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The memory controller on Tegra132 is very similar to the one found on
Tegra124. But the Denver CPUs don't have an outer cache, so dcache
maintenance is done slightly differently.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes in v7:
- update help text

 drivers/iommu/Kconfig           |  2 +-
 drivers/memory/tegra/Makefile   |  1 +
 drivers/memory/tegra/mc.c       |  3 +++
 drivers/memory/tegra/mc.h       |  4 ++++
 drivers/memory/tegra/tegra124.c | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 30f0e61341c5..11518808417d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -183,7 +183,7 @@ config TEGRA_IOMMU_SMMU
 	select IOMMU_API
 	help
 	  This driver supports the IOMMU hardware (SMMU) found on NVIDIA Tegra
-	  SoCs (Tegra30 up to Tegra124).
+	  SoCs (Tegra30 up to Tegra132).
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
index 0d9f497b786c..9d4f4319b527 100644
--- a/drivers/memory/tegra/Makefile
+++ b/drivers/memory/tegra/Makefile
@@ -3,5 +3,6 @@ tegra-mc-y := mc.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_3x_SOC)  += tegra30.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_114_SOC) += tegra114.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_124_SOC) += tegra124.o
+tegra-mc-$(CONFIG_ARCH_TEGRA_132_SOC) += tegra124.o
 
 obj-$(CONFIG_TEGRA_MC) += tegra-mc.o
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index fe3c44e7e1d1..9b7c1645fd59 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -58,6 +58,9 @@ static const struct of_device_id tegra_mc_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 	{ .compatible = "nvidia,tegra124-mc", .data = &tegra124_mc_soc },
 #endif
+#ifdef CONFIG_ARCH_TEGRA_132_SOC
+	{ .compatible = "nvidia,tegra132-mc", .data = &tegra132_mc_soc },
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 28b1528f4fa0..f714c309b960 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -50,4 +50,8 @@ extern const struct tegra_mc_soc tegra114_mc_soc;
 extern const struct tegra_mc_soc tegra124_mc_soc;
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_132_SOC
+extern const struct tegra_mc_soc tegra132_mc_soc;
+#endif
+
 #endif /* MEMORY_TEGRA_MC_H */
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 278d40b854c1..ccd19d83ee91 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -993,3 +993,36 @@ const struct tegra_mc_soc tegra124_mc_soc = {
 	.smmu = &tegra124_smmu_soc,
 };
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
+
+#ifdef CONFIG_ARCH_TEGRA_132_SOC
+static void tegra132_flush_dcache(struct page *page, unsigned long offset,
+				  size_t size)
+{
+	void *virt = page_address(page) + offset;
+
+	__flush_dcache_area(virt, size);
+}
+
+static const struct tegra_smmu_ops tegra132_smmu_ops = {
+	.flush_dcache = tegra132_flush_dcache,
+};
+
+static const struct tegra_smmu_soc tegra132_smmu_soc = {
+	.clients = tegra124_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
+	.swgroups = tegra124_swgroups,
+	.num_swgroups = ARRAY_SIZE(tegra124_swgroups),
+	.supports_round_robin_arbitration = true,
+	.supports_request_limit = true,
+	.num_asids = 128,
+	.ops = &tegra132_smmu_ops,
+};
+
+const struct tegra_mc_soc tegra132_mc_soc = {
+	.clients = tegra124_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
+	.num_address_bits = 34,
+	.atom_size = 32,
+	.smmu = &tegra132_smmu_soc,
+};
+#endif /* CONFIG_ARCH_TEGRA_132_SOC */
-- 
2.1.3
