From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 01/12] ARM: EXYNOS: Add clk_ops for gating clocks of System
	MMU
Date: Thu, 22 Nov 2012 20:32:30 +0900
Message-ID: <002201cdc8a5$0e9fb8c0$2bdf2a40$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Touching some System MMU needs its master devices' clock to be enabled
before. This commit adds clk_ops.set_parent of gating clocks of System
MMU to ensure gating clocks of System MMU's mater devices are enabled
when enabling gating clocks of System MMU.

Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-exynos/clock-exynos5.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index e48d7c2..a86e88e 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -614,6 +614,16 @@ static struct clksrc_clk exynos5_clk_aclk_300_gscl = {
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
@@ -855,71 +865,85 @@ static struct clk exynos5_init_clocks_off[] = {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(mfc_l, 0),
 		.enable		= &exynos5_clk_ip_mfc_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(mfc_r, 1),
 		.enable		= &exynos5_clk_ip_mfc_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(tv, 2),
 		.enable		= &exynos5_clk_ip_disp1_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 9)
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(jpeg, 3),
 		.enable		= &exynos5_clk_ip_gen_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(rot, 4),
 		.enable		= &exynos5_clk_ip_gen_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 6)
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(gsc0, 5),
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(gsc1, 6),
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(gsc2, 7),
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(gsc3, 8),
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(isp, 9),
 		.enable		= &exynos5_clk_ip_isp0_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (0x3F << 8),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME2,
 		.devname	= SYSMMU_CLOCK_DEVNAME(isp, 9),
 		.enable		= &exynos5_clk_ip_isp1_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (0xF << 4),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(camif0, 12),
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 11),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(camif1, 13),
 		.enable		= &exynos5_clk_ip_gscl_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(2d, 14),
 		.enable		= &exynos5_clk_ip_acp_ctrl,
+		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 7)
 	}
 };
-- 
1.8.0
