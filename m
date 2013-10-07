From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v10 10/20] clk: exynos: add gate clock descriptions of System
	MMU
Date: Mon, 07 Oct 2013 10:56:51 +0900
Message-ID: <20131007105651.da0427edf3fa77fe4038d65b@samsung.com>
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
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This adds gate clocks of all System MMUs and their master IPs
that are not apeared in clk-exynos5250.c and clk-exynos5420.c
Also fixes GATE_IP_ACP to 0x18800 and changed GATE_DA to GATE
for System MMU clocks in clk-exynos4.c

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/clock/exynos5250-clock.txt |   28 +++++++++++
 .../devicetree/bindings/clock/exynos5420-clock.txt |    3 +
 drivers/clk/samsung/clk-exynos5250.c               |   49 ++++++++++++++++++-
 drivers/clk/samsung/clk-exynos5420.c               |   12 ++++-
 4 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
index 24765c1..929cfba 100644
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
@@ -159,6 +159,34 @@ clock which they consume.
   mixer			343
   hdmi			344
   g2d			345
+  smmu_fimc_lite0	346
+  smmu_fimc_lite1	347
+  smmu_fimc_lite2	348
+  smmu_tv		349
+  smmu_fimd1		350
+  smmu_2d		351
+  fimc_isp		352
+  fimc_drc		353
+  fimc_fd		354
+  fimc_scc		355
+  fimc_scp		356
+  fimc_mcuctl		357
+  fimc_odc		358
+  fimc_dis		359
+  fimc_3dnr		360
+  smmu_fimc_isp		361
+  smmu_fimc_drc		362
+  smmu_fimc_fd		363
+  smmu_fimc_scc		364
+  smmu_fimc_scp		365
+  smmu_fimc_mcuctl	366
+  smmu_fimc_odc		367
+  smmu_fimc_dis0	368
+  smmu_fimc_dis1	369
+  smmu_fimc_3dnr	370
+  camif_top		371
+  mdma0			372
+  smmu_mdma0		373
 
 
    [Clock Muxes]
diff --git a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
index 32aa34e..09dfa44 100644
--- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
@@ -172,12 +172,15 @@ clock which they consume.
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
index adf3234..c0312db 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -34,6 +34,7 @@
 #define VPLL_CON0		0x10140
 #define GPLL_CON0		0x10150
 #define SRC_TOP0		0x10210
+#define SRC_TOP1		0x10214
 #define SRC_TOP2		0x10218
 #define SRC_GSCL		0x10220
 #define SRC_DISP1_0		0x1022c
@@ -64,6 +65,8 @@
 #define DIV_PERIC3		0x10564
 #define DIV_PERIC4		0x10568
 #define DIV_PERIC5		0x1056c
+#define GATE_IP_ISP0		0x0C800
+#define GATE_IP_ISP1		0x0C800
 #define GATE_IP_GSCL		0x10920
 #define GATE_IP_MFC		0x1092c
 #define GATE_IP_GEN		0x10934
@@ -75,7 +78,7 @@
 #define SRC_CDREX		0x20200
 #define PLL_DIV2_SEL		0x20a24
 #define GATE_IP_DISP1		0x10928
-#define GATE_IP_ACP		0x10000
+#define GATE_IP_ACP		0x18800
 
 /* list of PLLs to be registered */
 enum exynos5250_plls {
@@ -121,6 +124,13 @@ enum exynos5250_clks {
 	hsi2c3, chipid, sysreg, pmu, cmu_top, cmu_core, cmu_mem, tzpc0, tzpc1,
 	tzpc2, tzpc3, tzpc4, tzpc5, tzpc6, tzpc7, tzpc8, tzpc9, hdmi_cec, mct,
 	wdt, rtc, tmu, fimd1, mie1, dsim0, dp, mixer, hdmi, g2d,
+	smmu_fimc_lite0 = 346, smmu_fimc_lite1, smmu_fimc_lite2,
+	smmu_tv, smmu_fimd1, smmu_2d,
+	fimc_isp, fimc_drc, fimc_fd, fimc_scc, fimc_scp, fimc_mcuctl, fimc_odc,
+	fimc_dis, fimc_3dnr,
+	smmu_fimc_isp, smmu_fimc_drc, smmu_fimc_fd, smmu_fimc_scc,
+	smmu_fimc_scp, smmu_fimc_mcuctl, smmu_fimc_odc, smmu_fimc_dis0,
+	smmu_fimc_dis1, smmu_fimc_3dnr, camif_top, mdma0, smmu_mdma0,
 
 	/* mux clocks */
 	mout_hdmi = 1024,
@@ -194,6 +204,7 @@ PNAME(mout_mpll_user_p)	= { "fin_pll", "sclk_mpll" };
 PNAME(mout_bpll_user_p)	= { "fin_pll", "sclk_bpll" };
 PNAME(mout_aclk166_p)	= { "sclk_cpll", "sclk_mpll_user" };
 PNAME(mout_aclk200_p)	= { "sclk_mpll_user", "sclk_bpll_user" };
+PNAME(mout_aclk400_isp_p)	= { "sclk_mpll_user", "sclk_bpll_user" };
 PNAME(mout_hdmi_p)	= { "div_hdmi_pixel", "sclk_hdmiphy" };
 PNAME(mout_usb3_p)	= { "sclk_mpll_user", "sclk_cpll" };
 PNAME(mout_group1_p)	= { "fin_pll", "fin_pll", "sclk_hdmi27m",
@@ -252,6 +263,7 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(none, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
 	MUX(none, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
 	MUX(none, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
+	MUX(none, "mout_aclk400_isp", mout_aclk400_isp_p, SRC_TOP1, 24, 1),
 	MUX(none, "mout_cam_bayer", mout_group1_p, SRC_GSCL, 12, 4),
 	MUX(none, "mout_cam0", mout_group1_p, SRC_GSCL, 16, 4),
 	MUX(none, "mout_cam1", mout_group1_p, SRC_GSCL, 20, 4),
@@ -291,6 +303,7 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	DIV(none, "aclk166", "mout_aclk166", DIV_TOP0, 8, 3),
 	DIV(none, "aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
 	DIV(none, "aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
+	DIV(none, "aclk400_isp", "mout_aclk400_isp", DIV_TOP1, 20, 3),
 	DIV(none, "div_cam_bayer", "mout_cam_bayer", DIV_GSCL, 12, 4),
 	DIV(none, "div_cam0", "mout_cam0", DIV_GSCL, 16, 4),
 	DIV(none, "div_cam1", "mout_cam1", DIV_GSCL, 20, 4),
@@ -353,9 +366,16 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(smmu_gscl1, "smmu_gscl1", "aclk266", GATE_IP_GSCL, 8, 0, 0),
 	GATE(smmu_gscl2, "smmu_gscl2", "aclk266", GATE_IP_GSCL, 9, 0, 0),
 	GATE(smmu_gscl3, "smmu_gscl3", "aclk266", GATE_IP_GSCL, 10, 0, 0),
+	GATE(camif_top, "camif_top", "aclk266", GATE_IP_GSCL, 4, 0, 0),
+	GATE(smmu_fimc_lite0, "smmu_fimc_lite0", "aclk266",
+						GATE_IP_GSCL, 12, 0, 0),
+	GATE(smmu_fimc_lite1, "smmu_fimc_lite1", "aclk266",
+						GATE_IP_GSCL, 13, 0, 0),
+	GATE(smmu_fimc_lite2, "smmu_fimc_lite2", "aclk266",
+						GATE_IP_GSCL, 14, 0, 0),
 	GATE(mfc, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
-	GATE(smmu_mfcl, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
-	GATE(smmu_mfcr, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
+	GATE(smmu_mfcr, "smmu_mfcr", "aclk333", GATE_IP_MFC, 1, 0, 0),
+	GATE(smmu_mfcl, "smmu_mfcl", "aclk333", GATE_IP_MFC, 2, 0, 0),
 	GATE(rotator, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
 	GATE(jpeg, "jpeg", "aclk166", GATE_IP_GEN, 2, 0, 0),
 	GATE(mdma1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
@@ -492,6 +512,29 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(mixer, "mixer", "mout_aclk200_disp1", GATE_IP_DISP1, 5, 0, 0),
 	GATE(hdmi, "hdmi", "mout_aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
 	GATE(g2d, "g2d", "aclk200", GATE_IP_ACP, 3, 0, 0),
+	GATE(smmu_tv, "smmu_tv", "aclk200", GATE_IP_DISP1, 2, 0, 0),
+	GATE(smmu_fimd1, "smmu_fimd1", "aclk200", GATE_IP_DISP1, 8, 0, 0),
+
+	GATE(smmu_fimc_isp, "smmu_fimc_isp", "aclk400_isp", GATE_IP_ISP0, 8, 0, 0),
+	GATE(smmu_fimc_drc, "smmu_fimc_drc", "aclk400_isp", GATE_IP_ISP0, 9, 0, 0),
+	GATE(smmu_fimc_fd, "smmu_fimc_fd", "aclk400_isp", GATE_IP_ISP0, 10, 0, 0),
+	GATE(smmu_fimc_scc, "smmu_fimc_scc", "aclk400_isp",
+							GATE_IP_ISP0, 11, 0, 0),
+	GATE(smmu_fimc_scp, "smmu_fimc_scp", "aclk400_isp",
+							GATE_IP_ISP0, 12, 0, 0),
+	GATE(smmu_fimc_mcuctl, "smmu_fimc_mcuctl", "aclk400_isp",
+							GATE_IP_ISP0, 13, 0, 0),
+	GATE(smmu_fimc_odc, "smmu_fimc_odc", "aclk400_isp", GATE_IP_ISP1, 4, 0, 0),
+	GATE(smmu_fimc_dis0, "smmu_fimc_dis0", "aclk400_isp",
+							GATE_IP_ISP1, 5, 0, 0),
+	GATE(smmu_fimc_dis1, "smmu_fimc_dis1", "aclk400_isp",
+							GATE_IP_ISP1, 6, 0, 0),
+	GATE(smmu_fimc_3dnr, "smmu_fimc_3dnr", "aclk400_isp",
+							GATE_IP_ISP1, 7, 0, 0),
+
+	GATE(smmu_2d, "smmu_2d", "aclk200", GATE_IP_ACP, 7, 0, 0),
+	GATE(mdma0, "mdma0", "aclk200", GATE_IP_ACP, 1, 0, 0),
+	GATE(smmu_mdma0, "smmu_mdma0", "aclk200", GATE_IP_ACP, 5, 0, 0),
 };
 
 static struct samsung_pll_rate_table vpll_24mhz_tbl[] __initdata = {
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 48c4a93..7f379cf 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -80,6 +80,7 @@
 #define GATE_BUS_PERIC1		0x10754
 #define GATE_BUS_PERIS0		0x10760
 #define GATE_BUS_PERIS1		0x10764
+#define GATE_IP_G2D		0x08800
 #define GATE_IP_GSCL0		0x10910
 #define GATE_IP_GSCL1		0x10920
 #define GATE_IP_MFC		0x1092c
@@ -137,8 +138,8 @@ enum exynos5420_clks {
 	smmu_rotator, smmu_mdma1, aclk300_jpeg = 450, jpeg, jpeg2, smmu_jpeg,
 	aclk300_gscl = 460, smmu_gscl0, smmu_gscl1, gscl_wa, gscl_wb, gscl0,
 	gscl1, clk_3aa, aclk266_g2d = 470, sss, slim_sss, mdma0,
-	aclk333_g2d = 480, g2d, aclk333_432_gscl = 490, smmu_3aa, smmu_fimcl0,
-	smmu_fimcl1, smmu_fimcl3, fimc_lite3, aclk_g3d = 500, g3d, smmu_mixer,
+	aclk333_g2d = 480, g2d, smmu_g2d, aclk333_432_gscl = 490, smmu_3aa, smmu_fimcl0,
+	smmu_fimcl1, smmu_fimcl3, fimc_lite3, fimc_lite0, fimc_lite1, aclk_g3d = 500, g3d, smmu_mixer,
 
 	/* mux clocks */
 	mout_hdmi = 640,
@@ -198,6 +199,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	GATE_BUS_PERIC1,
 	GATE_BUS_PERIS0,
 	GATE_BUS_PERIS1,
+	GATE_IP_G2D,
 	GATE_IP_GSCL0,
 	GATE_IP_GSCL1,
 	GATE_IP_MFC,
@@ -701,6 +703,10 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(gscl_wb, "gscl_wb", "aclk300_gscl", GATE_IP_GSCL1, 13, 0, 0),
 	GATE(smmu_fimcl3, "smmu_fimcl3,", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 16, 0, 0),
+	GATE(fimc_lite0, "fimc_lite0", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 5, 0, 0),
+	GATE(fimc_lite1, "fimc_lite1", "aclk333_432_gscl",
+			GATE_IP_GSCL0, 6, 0, 0),
 	GATE(fimc_lite3, "fimc_lite3", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 17, 0, 0),
 
@@ -732,6 +738,8 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(smmu_mscl1, "smmu_mscl1", "aclk400_mscl", GATE_IP_MSCL, 9, 0, 0),
 	GATE(smmu_mscl2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0, 0),
 	GATE(smmu_mixer, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1, 9, 0, 0),
+	GATE(g2d, "g2d", "aclk333_g2d", GATE_IP_G2D, 3, 0, 0),
+	GATE(smmu_g2d, "smmu_g2d", "aclk333_g2d", GATE_IP_G2D, 7, 0, 0),
 };
 
 static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
-- 
1.7.2.5
