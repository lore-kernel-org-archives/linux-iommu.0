From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v11 11/27] clk: exynos: add gate clock descriptions of System
	MMU
Date: Fri, 14 Mar 2014 14:06:21 +0900
Message-ID: <20140314140621.14df1e40601c4f6a2487b5a8@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This adds gate clocks of all System MMUs and their master IPs
that are not apeared in clk-exynos5250.c and clk-exynos5420.c
Also fixes GATE_IP_ACP to 0x18800 and changed GATE_DA to GATE
for System MMU clocks in clk-exynos4.c

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/clock/exynos5250-clock.txt |    3 +++
 .../devicetree/bindings/clock/exynos5420-clock.txt |    6 +++++-
 drivers/clk/samsung/clk-exynos5250.c               |    5 +++++
 drivers/clk/samsung/clk-exynos5420.c               |   13 +++++++++++--
 include/dt-bindings/clock/exynos5250.h             |    4 ++++
 include/dt-bindings/clock/exynos5420.h             |    6 +++++-
 6 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
index 72ce617..67e50ba 100644
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
@@ -162,6 +162,9 @@ clock which they consume.
   g2d			345
   mdma0			346
   smmu_mdma0		347
+  smmu_tv		348
+  smmu_fimd1		349
+  smmu_2d		350
 
 
    [Clock Muxes]
diff --git a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
index 458f347..62dabc3 100644
--- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
@@ -146,7 +146,8 @@ clock which they consume.
   hdmi			413
   aclk300_disp1		420
   fimd1			421
-  smmu_fimd1		422
+  smmu_fimd1m0		422
+  smmu_fimd1m1		423
   aclk166		430
   mixer			431
   aclk266		440
@@ -172,12 +173,15 @@ clock which they consume.
   mdma0			473
   aclk333_g2d		480
   g2d			481
+  smmu_g2d		482
   aclk333_432_gscl	490
   smmu_3aa		491
   smmu_fimcl0		492
   smmu_fimcl1		493
   smmu_fimcl3		494
   fimc_lite3		495
+  fimc_lite0		496
+  fimc_lite1		497
   aclk_g3d		500
   g3d			501
   smmu_mixer		502
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index e7ee442..6605733 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -615,6 +615,11 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(CLK_WDT, "wdt", "div_aclk66", GATE_IP_PERIS, 19, 0, 0),
 	GATE(CLK_RTC, "rtc", "div_aclk66", GATE_IP_PERIS, 20, 0, 0),
 	GATE(CLK_TMU, "tmu", "div_aclk66", GATE_IP_PERIS, 21, 0, 0),
+	GATE(CLK_SMMU_TV, "smmu_tv", "mout_aclk200_disp1_sub",
+		GATE_IP_DISP1, 2, 0, 0),
+	GATE(CLK_SMMU_FIMD1, "smmu_fimd1", "mout_aclk200_disp1_sub",
+		GATE_IP_DISP1, 8, 0, 0),
+	GATE(CLK_SMMU_2D, "smmu_2d", "div_aclk200", GATE_IP_ACP, 7, 0, 0),
 };
 
 static struct samsung_pll_rate_table vpll_24mhz_tbl[] __initdata = {
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 60b2681..b58e4d3 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -82,6 +82,7 @@
 #define GATE_BUS_PERIC1		0x10754
 #define GATE_BUS_PERIS0		0x10760
 #define GATE_BUS_PERIS1		0x10764
+#define GATE_IP_G2D		0x08800
 #define GATE_IP_GSCL0		0x10910
 #define GATE_IP_GSCL1		0x10920
 #define GATE_IP_MFC		0x1092c
@@ -707,6 +708,10 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_GSCL_WB, "gscl_wb", "aclk300_gscl", GATE_IP_GSCL1, 13, 0, 0),
 	GATE(CLK_SMMU_FIMCL3, "smmu_fimcl3,", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 16, 0, 0),
+	GATE(CLK_FIMC_LITE0, "fimc_lite0", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 5, 0, 0),
+	GATE(CLK_FIMC_LITE1, "fimc_lite1", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 6, 0, 0),
 	GATE(CLK_FIMC_LITE3, "fimc_lite3", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 17, 0, 0),
 
@@ -715,8 +720,10 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_DP1, "dp1", "aclk200_disp1", GATE_IP_DISP1, 4, 0, 0),
 	GATE(CLK_MIXER, "mixer", "aclk166", GATE_IP_DISP1, 5, 0, 0),
 	GATE(CLK_HDMI, "hdmi", "aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
-	GATE(CLK_SMMU_FIMD1, "smmu_fimd1", "aclk300_disp1", GATE_IP_DISP1, 8, 0,
-		0),
+	GATE(CLK_SMMU_FIMD1M0, "smmu_fimd1m0", "aclk300_disp1", GATE_IP_DISP1,
+		7, 0, 0),
+	GATE(CLK_SMMU_FIMD1M1, "smmu_fimd1m1", "aclk300_disp1", GATE_IP_DISP1,
+		8, 0, 0),
 
 	GATE(CLK_MFC, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
 	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
@@ -743,6 +750,8 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 		0),
 	GATE(CLK_SMMU_MIXER, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1, 9, 0,
 		0),
+	GATE(CLK_G2D, "g2d", "aclk333_g2d", GATE_IP_G2D, 3, 0, 0),
+	GATE(CLK_SMMU_G2D, "smmu_g2d", "aclk333_g2d", GATE_IP_G2D, 7, 0, 0),
 };
 
 static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
index 922f2dc..2648ce7 100644
--- a/include/dt-bindings/clock/exynos5250.h
+++ b/include/dt-bindings/clock/exynos5250.h
@@ -150,6 +150,10 @@
 #define CLK_G2D			345
 #define CLK_MDMA0		346
 #define CLK_SMMU_MDMA0		347
+#define CLK_SMMU_TV		348
+#define CLK_SMMU_FIMD1		349
+#define CLK_SMMU_2D		350
+
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		1024
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 5eefd88..25dedca 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -140,7 +140,8 @@
 #define CLK_HDMI		413
 #define CLK_ACLK300_DISP1	420
 #define CLK_FIMD1		421
-#define CLK_SMMU_FIMD1		422
+#define CLK_SMMU_FIMD1M0	422
+#define CLK_SMMU_FIMD1M1	423
 #define CLK_ACLK166		430
 #define CLK_MIXER		431
 #define CLK_ACLK266		440
@@ -166,12 +167,15 @@
 #define CLK_MDMA0		473
 #define CLK_ACLK333_G2D		480
 #define CLK_G2D			481
+#define CLK_SMMU_G2D		482
 #define CLK_ACLK333_432_GSCL	490
 #define CLK_SMMU_3AA		491
 #define CLK_SMMU_FIMCL0		492
 #define CLK_SMMU_FIMCL1		493
 #define CLK_SMMU_FIMCL3		494
 #define CLK_FIMC_LITE3		495
+#define CLK_FIMC_LITE1		496
+#define CLK_FIMC_LITE0		497
 #define CLK_ACLK_G3D		500
 #define CLK_G3D			501
 #define CLK_SMMU_MIXER		502
-- 
1.7.9.5
