From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] memory: tegra: Create SMMU display groups
Date: Mon, 27 Nov 2017 10:50:55 +0100
Message-ID: <20171127095055.21486-3-thierry.reding@gmail.com>
References: <20171127095055.21486-1-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171127095055.21486-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Create SMMU display groups for Tegra30, Tegra114, Tegra124 and Tegra210.
This allows the display controllers on these devices to share the same
IOMMU domain using the standard IOMMU group mechanism.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/memory/tegra/tegra114.c | 15 +++++++++++++++
 drivers/memory/tegra/tegra124.c | 17 +++++++++++++++++
 drivers/memory/tegra/tegra210.c | 15 +++++++++++++++
 drivers/memory/tegra/tegra30.c  | 15 +++++++++++++++
 include/soc/tegra/mc.h          |  9 +++++++++
 5 files changed, 71 insertions(+)

diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index ba8fff3d66a6..b20e6e3e208e 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -912,11 +912,26 @@ static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
 	{ .name = "tsec",      .swgroup = TEGRA_SWGROUP_TSEC,      .reg = 0x294 },
 };
 
+static const unsigned int tegra114_group_display[] = {
+	TEGRA_SWGROUP_DC,
+	TEGRA_SWGROUP_DCB,
+};
+
+static const struct tegra_smmu_group_soc tegra114_groups[] = {
+	{
+		.name = "display",
+		.swgroups = tegra114_group_display,
+		.num_swgroups = ARRAY_SIZE(tegra114_group_display),
+	},
+};
+
 static const struct tegra_smmu_soc tegra114_smmu_soc = {
 	.clients = tegra114_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra114_mc_clients),
 	.swgroups = tegra114_swgroups,
 	.num_swgroups = ARRAY_SIZE(tegra114_swgroups),
+	.groups = tegra114_groups,
+	.num_groups = ARRAY_SIZE(tegra114_groups),
 	.supports_round_robin_arbitration = false,
 	.supports_request_limit = false,
 	.num_tlb_lines = 32,
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 5a58e440f4a7..8b6360eabb8a 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -999,12 +999,27 @@ static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
 	{ .name = "vi",        .swgroup = TEGRA_SWGROUP_VI,        .reg = 0x280 },
 };
 
+static const unsigned int tegra124_group_display[] = {
+	TEGRA_SWGROUP_DC,
+	TEGRA_SWGROUP_DCB,
+};
+
+static const struct tegra_smmu_group_soc tegra124_groups[] = {
+	{
+		.name = "display",
+		.swgroups = tegra124_group_display,
+		.num_swgroups = ARRAY_SIZE(tegra124_group_display),
+	},
+};
+
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 static const struct tegra_smmu_soc tegra124_smmu_soc = {
 	.clients = tegra124_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
 	.swgroups = tegra124_swgroups,
 	.num_swgroups = ARRAY_SIZE(tegra124_swgroups),
+	.groups = tegra124_groups,
+	.num_groups = ARRAY_SIZE(tegra124_groups),
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
 	.num_tlb_lines = 32,
@@ -1029,6 +1044,8 @@ static const struct tegra_smmu_soc tegra132_smmu_soc = {
 	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
 	.swgroups = tegra124_swgroups,
 	.num_swgroups = ARRAY_SIZE(tegra124_swgroups),
+	.groups = tegra124_groups,
+	.num_groups = ARRAY_SIZE(tegra124_groups),
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
 	.num_tlb_lines = 32,
diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index 5e144abe4c18..d398bcd3fc57 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1059,11 +1059,26 @@ static const struct tegra_smmu_swgroup tegra210_swgroups[] = {
 	{ .name = "tsecb",     .swgroup = TEGRA_SWGROUP_TSECB,     .reg = 0xad4 },
 };
 
+static const unsigned int tegra210_group_display[] = {
+	TEGRA_SWGROUP_DC,
+	TEGRA_SWGROUP_DCB,
+};
+
+static const struct tegra_smmu_group_soc tegra210_groups[] = {
+	{
+		.name = "display",
+		.swgroups = tegra210_group_display,
+		.num_swgroups = ARRAY_SIZE(tegra210_group_display),
+	},
+};
+
 static const struct tegra_smmu_soc tegra210_smmu_soc = {
 	.clients = tegra210_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra210_mc_clients),
 	.swgroups = tegra210_swgroups,
 	.num_swgroups = ARRAY_SIZE(tegra210_swgroups),
+	.groups = tegra210_groups,
+	.num_groups = ARRAY_SIZE(tegra210_groups),
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
 	.num_tlb_lines = 32,
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index b44737840e70..d756c837f23e 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -934,11 +934,26 @@ static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
 	{ .name = "isp",  .swgroup = TEGRA_SWGROUP_ISP,  .reg = 0x258 },
 };
 
+static const unsigned int tegra30_group_display[] = {
+	TEGRA_SWGROUP_DC,
+	TEGRA_SWGROUP_DCB,
+};
+
+static const struct tegra_smmu_group_soc tegra30_groups[] = {
+	{
+		.name = "display",
+		.swgroups = tegra30_group_display,
+		.num_swgroups = ARRAY_SIZE(tegra30_group_display),
+	},
+};
+
 static const struct tegra_smmu_soc tegra30_smmu_soc = {
 	.clients = tegra30_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra30_mc_clients),
 	.swgroups = tegra30_swgroups,
 	.num_swgroups = ARRAY_SIZE(tegra30_swgroups),
+	.groups = tegra30_groups,
+	.num_groups = ARRAY_SIZE(tegra30_groups),
 	.supports_round_robin_arbitration = false,
 	.supports_request_limit = false,
 	.num_tlb_lines = 16,
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 44202ff897fd..233bae954970 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -51,6 +51,12 @@ struct tegra_smmu_swgroup {
 	unsigned int reg;
 };
 
+struct tegra_smmu_group_soc {
+	const char *name;
+	const unsigned int *swgroups;
+	unsigned int num_swgroups;
+};
+
 struct tegra_smmu_soc {
 	const struct tegra_mc_client *clients;
 	unsigned int num_clients;
@@ -58,6 +64,9 @@ struct tegra_smmu_soc {
 	const struct tegra_smmu_swgroup *swgroups;
 	unsigned int num_swgroups;
 
+	const struct tegra_smmu_group_soc *groups;
+	unsigned int num_groups;
+
 	bool supports_round_robin_arbitration;
 	bool supports_request_limit;
 
-- 
2.15.0
