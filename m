From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [RFC PATCH 2/3] memory: tegra: add TLB cache line size
Date: Tue, 29 Sep 2015 14:25:25 +0900
Message-ID: <1443504379-31841-3-git-send-email-tfiga@chromium.org>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443504379-31841-1-git-send-email-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This patch adds SMMU line size to Tegra SoC data struct to enable SMMU
driver to use this knowledge in code added by further patch.

Also add the missing TLB line number for Tegra124.

Signed-off-by: Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
[tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org: Rebased, revised commit message.]
Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/memory/tegra/tegra114.c | 1 +
 drivers/memory/tegra/tegra124.c | 3 +++
 drivers/memory/tegra/tegra210.c | 1 +
 drivers/memory/tegra/tegra30.c  | 1 +
 include/soc/tegra/mc.h          | 1 +
 5 files changed, 7 insertions(+)

diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index ba8fff3..173d2dd 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -920,6 +920,7 @@ static const struct tegra_smmu_soc tegra114_smmu_soc = {
 	.supports_round_robin_arbitration = false,
 	.supports_request_limit = false,
 	.num_tlb_lines = 32,
+	.tlb_line_size = 16,
 	.num_asids = 4,
 };
 
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 21e7255..ff12487 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1007,6 +1007,8 @@ static const struct tegra_smmu_soc tegra124_smmu_soc = {
 	.num_swgroups = ARRAY_SIZE(tegra124_swgroups),
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
+	.num_tlb_lines = 32,
+	.tlb_line_size = 32,
 	.num_asids = 128,
 };
 
@@ -1031,6 +1033,7 @@ static const struct tegra_smmu_soc tegra132_smmu_soc = {
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
 	.num_tlb_lines = 32,
+	.tlb_line_size = 32,
 	.num_asids = 128,
 };
 
diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index 5e144ab..bf6a9c1 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1067,6 +1067,7 @@ static const struct tegra_smmu_soc tegra210_smmu_soc = {
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
 	.num_tlb_lines = 32,
+	.tlb_line_size = 32,
 	.num_asids = 128,
 };
 
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index b447378..08951db 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -942,6 +942,7 @@ static const struct tegra_smmu_soc tegra30_smmu_soc = {
 	.supports_round_robin_arbitration = false,
 	.supports_request_limit = false,
 	.num_tlb_lines = 16,
+	.tlb_line_size = 16,
 	.num_asids = 4,
 };
 
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 44202ff..a6dbb35 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -62,6 +62,7 @@ struct tegra_smmu_soc {
 	bool supports_request_limit;
 
 	unsigned int num_tlb_lines;
+	unsigned int tlb_line_size;
 	unsigned int num_asids;
 };
 
-- 
2.6.0.rc2.230.g3dd15c0
