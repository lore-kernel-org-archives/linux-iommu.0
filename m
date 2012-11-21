From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v3 02/12] ARM: EXYNOS: Add clk_ops for gating clocks of System
 MMU
Date: Wed, 21 Nov 2012 14:03:18 +0900
Message-ID: <002801cdc7a5$8535f6d0$8fa1e470$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: 'Joerg Roedel' <joro@8bytes.org>, sw0312.kim@samsung.com, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>, prathyush.k@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

Touching some System MMU needs its master devices' clock to be enabled
before. This commit adds clk_ops.set_parent of gating clocks of System
MMU to ensure gating clocks of System MMU's mater devices are enabled
when enabling gating clocks of System MMU.

Change-Id: Icd58b12f599e92692c032516331a444f4703ba6b
Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 9e815ae..9dfb845 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -613,6 +613,16 @@ static struct clksrc_clk exynos5_clk_aclk_300_gscl = {
 	.reg_src = { .reg = EXYNOS5_CLKSRC_TOP3, .shift = 10, .size = 1 },
 };
 
+static int exynos5_gate_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	clk->parent = parent;
+	return 0;
+}
+
+static struct clk_ops exynos5_gate_clk_ops = {
+	.set_parent = exynos5_gate_clk_set_parent
+};
+
 static struct clk exynos5_init_clocks_off[] = {
 	{
 		.name		= "timers",
@@ -854,76 +864,91 @@ static struct clk exynos5_init_clocks_off[] = {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.0",
 		.enable		= &exynos5_clk_ip_mfc_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.1",
 		.enable		= &exynos5_clk_ip_mfc_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.2",
 		.enable		= &exynos5_clk_ip_disp1_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 9)
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.3",
 		.enable		= &exynos5_clk_ip_gen_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.4",
 		.enable		= &exynos5_clk_ip_gen_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 6)
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.5",
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.6",
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.7",
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.8",
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.9",
 		.enable		= &exynos5_clk_ip_isp0_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (0x3F << 8),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.10",
 		.enable		= &exynos5_clk_ip_isp1_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (0xF << 4),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.11",
 		.enable		= &exynos5_clk_ip_disp1_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 8)
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.12",
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 11),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.13",
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= "sysmmu",
 		.devname	= "exynos-sysmmu.14",
 		.enable		= &exynos5_clk_ip_acp_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 7)
 	}
 };
-- 
1.8.0
