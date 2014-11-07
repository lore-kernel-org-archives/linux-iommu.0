From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 12/12] memory: tegra: Add Tegra132 support
Date: Fri,  7 Nov 2014 17:01:03 +0100
Message-ID: <1415376063-17205-13-git-send-email-thierry.reding@gmail.com>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415376063-17205-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The memory controller on Tegra132 is very similar to the one found on
Tegra124. But the Denver CPUs don't have an outer cache, so dcache
maintenance is done slightly differently.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/memory/tegra/Makefile   |  1 +
 drivers/memory/tegra/mc.c       |  3 +++
 drivers/memory/tegra/mc.h       |  4 ++++
 drivers/memory/tegra/tegra124.c | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
index b0732cc5686a..cdae9481c864 100644
--- a/drivers/memory/tegra/Makefile
+++ b/drivers/memory/tegra/Makefile
@@ -4,5 +4,6 @@ tegra-mc-$(CONFIG_TEGRA_IOMMU_SMMU) += smmu.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_3x_SOC)  += tegra30.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_114_SOC) += tegra114.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_124_SOC) += tegra124.o
+tegra-mc-$(CONFIG_ARCH_TEGRA_132_SOC) += tegra124-mc.o
 
 obj-$(CONFIG_TEGRA_MC) += tegra-mc.o
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 359281def893..286b9c52e7fd 100644
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
 
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 7cf7f5bb3cb3..8fabe993d51b 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -122,4 +122,8 @@ extern const struct tegra_mc_soc tegra114_mc_soc;
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
