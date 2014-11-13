From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 01/12] clk: tegra: Implement memory-controller clock
Date: Thu, 13 Nov 2014 10:32:26 +0100
Message-ID: <1415871157-21968-2-git-send-email-thierry.reding@gmail.com>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415871157-21968-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The memory controller clock runs either at half or the same frequency as
the EMC clock.

Reviewed-By: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Mike, as I said in the cover letter there are tight dependencies between the
patches in this series, so I'd like to get your Acked-by on this one so I can
take it through the Tegra tree along with the others.

Thanks,
Thierry

Changes in v4:
- use name and parent name parameters passed in when registering clock

Changes in v3:
- split registration into a separate function that can be reused for all
  SoC generations, but pass in the name and parent parameters for
  clarity as well as the register address (in case it ever changes) and
  the EMC spin-lock since it isn't globally available

 drivers/clk/tegra/clk-divider.c          | 13 +++++++++++++
 drivers/clk/tegra/clk-tegra114.c         |  7 ++++++-
 drivers/clk/tegra/clk-tegra124.c         |  7 ++++++-
 drivers/clk/tegra/clk-tegra20.c          |  8 +++++++-
 drivers/clk/tegra/clk-tegra30.c          |  7 ++++++-
 drivers/clk/tegra/clk.h                  |  2 ++
 include/dt-bindings/clock/tegra114-car.h |  2 +-
 include/dt-bindings/clock/tegra124-car.h |  2 +-
 include/dt-bindings/clock/tegra20-car.h  |  2 +-
 9 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 290f9c1a3749..59a5714dfe18 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -185,3 +185,16 @@ struct clk *tegra_clk_register_divider(const char *name,
 
 	return clk;
 }
+
+static const struct clk_div_table mc_div_table[] = {
+	{ .val = 0, .div = 2 },
+	{ .val = 1, .div = 1 },
+	{ .val = 0, .div = 0 },
+};
+
+struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
+				  void __iomem *reg, spinlock_t *lock)
+{
+	return clk_register_divider_table(NULL, name, parent_name, 0, reg,
+					  16, 1, 0, mc_div_table, lock);
+}
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index f760f31d05c4..0b03d2cf7264 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -173,6 +173,7 @@ static DEFINE_SPINLOCK(pll_d_lock);
 static DEFINE_SPINLOCK(pll_d2_lock);
 static DEFINE_SPINLOCK(pll_u_lock);
 static DEFINE_SPINLOCK(pll_re_lock);
+static DEFINE_SPINLOCK(emc_lock);
 
 static struct div_nmp pllxc_nmp = {
 	.divm_shift = 0,
@@ -1228,7 +1229,11 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
 			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + CLK_SOURCE_EMC,
-			       29, 3, 0, NULL);
+			       29, 3, 0, &emc_lock);
+
+	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
+				    &emc_lock);
+	clks[TEGRA114_CLK_MC] = clk;
 
 	for (i = 0; i < ARRAY_SIZE(tegra_periph_clk_list); i++) {
 		data = &tegra_periph_clk_list[i];
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index e3a85842ce0c..f5f9baca7bb6 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -132,6 +132,7 @@ static DEFINE_SPINLOCK(pll_d2_lock);
 static DEFINE_SPINLOCK(pll_e_lock);
 static DEFINE_SPINLOCK(pll_re_lock);
 static DEFINE_SPINLOCK(pll_u_lock);
+static DEFINE_SPINLOCK(emc_lock);
 
 /* possible OSC frequencies in Hz */
 static unsigned long tegra124_input_freq[] = {
@@ -1127,7 +1128,11 @@ static __init void tegra124_periph_clk_init(void __iomem *clk_base,
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
 			       ARRAY_SIZE(mux_pllmcp_clkm), 0,
 			       clk_base + CLK_SOURCE_EMC,
-			       29, 3, 0, NULL);
+			       29, 3, 0, &emc_lock);
+
+	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
+				    &emc_lock);
+	clks[TEGRA124_CLK_MC] = clk;
 
 	/* cml0 */
 	clk = clk_register_gate(NULL, "cml0", "pll_e", 0, clk_base + PLLE_AUX,
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index dace2b1b5ae6..41272dcc9e22 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -140,6 +140,8 @@ static struct cpu_clk_suspend_context {
 static void __iomem *clk_base;
 static void __iomem *pmc_base;
 
+static DEFINE_SPINLOCK(emc_lock);
+
 #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
 			    _clk_num, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA(_name, NULL, NULL, _parents, _offset,	\
@@ -819,11 +821,15 @@ static void __init tegra20_periph_clk_init(void)
 			       ARRAY_SIZE(mux_pllmcp_clkm),
 			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + CLK_SOURCE_EMC,
-			       30, 2, 0, NULL);
+			       30, 2, 0, &emc_lock);
 	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base, 0,
 				    57, periph_clk_enb_refcnt);
 	clks[TEGRA20_CLK_EMC] = clk;
 
+	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
+				    &emc_lock);
+	clks[TEGRA20_CLK_MC] = clk;
+
 	/* dsi */
 	clk = tegra_clk_register_periph_gate("dsi", "pll_d", 0, clk_base, 0,
 				    48, periph_clk_enb_refcnt);
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 5bbacd01094f..4b9d8bd3d0bf 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -177,6 +177,7 @@ static unsigned long input_freq;
 
 static DEFINE_SPINLOCK(cml_lock);
 static DEFINE_SPINLOCK(pll_d_lock);
+static DEFINE_SPINLOCK(emc_lock);
 
 #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
 			    _clk_num, _gate_flags, _clk_id)	\
@@ -1157,11 +1158,15 @@ static void __init tegra30_periph_clk_init(void)
 			       ARRAY_SIZE(mux_pllmcp_clkm),
 			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + CLK_SOURCE_EMC,
-			       30, 2, 0, NULL);
+			       30, 2, 0, &emc_lock);
 	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base, 0,
 				    57, periph_clk_enb_refcnt);
 	clks[TEGRA30_CLK_EMC] = clk;
 
+	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
+				    &emc_lock);
+	clks[TEGRA30_CLK_MC] = clk;
+
 	/* cml0 */
 	clk = clk_register_gate(NULL, "cml0", "pll_e", 0, clk_base + PLLE_AUX,
 				0, 0, &cml_lock);
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 16ec8d6bb87f..4e458aa8d45c 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -86,6 +86,8 @@ struct clk *tegra_clk_register_divider(const char *name,
 		const char *parent_name, void __iomem *reg,
 		unsigned long flags, u8 clk_divider_flags, u8 shift, u8 width,
 		u8 frac_width, spinlock_t *lock);
+struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
+				  void __iomem *reg, spinlock_t *lock);
 
 /*
  * Tegra PLL:
diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
index fc12621fb432..534c03f8ad72 100644
--- a/include/dt-bindings/clock/tegra114-car.h
+++ b/include/dt-bindings/clock/tegra114-car.h
@@ -49,7 +49,7 @@
 #define TEGRA114_CLK_I2S0 30
 /* 31 */
 
-/* 32 */
+#define TEGRA114_CLK_MC 32
 /* 33 */
 #define TEGRA114_CLK_APBDMA 34
 /* 35 */
diff --git a/include/dt-bindings/clock/tegra124-car.h b/include/dt-bindings/clock/tegra124-car.h
index 6bac637fd635..af9bc9a3ddbc 100644
--- a/include/dt-bindings/clock/tegra124-car.h
+++ b/include/dt-bindings/clock/tegra124-car.h
@@ -48,7 +48,7 @@
 #define TEGRA124_CLK_I2S0 30
 /* 31 */
 
-/* 32 */
+#define TEGRA124_CLK_MC 32
 /* 33 */
 #define TEGRA124_CLK_APBDMA 34
 /* 35 */
diff --git a/include/dt-bindings/clock/tegra20-car.h b/include/dt-bindings/clock/tegra20-car.h
index 9406207cfac8..04500b243a4d 100644
--- a/include/dt-bindings/clock/tegra20-car.h
+++ b/include/dt-bindings/clock/tegra20-car.h
@@ -49,7 +49,7 @@
 /* 30 */
 #define TEGRA20_CLK_CACHE2 31
 
-#define TEGRA20_CLK_MEM 32
+#define TEGRA20_CLK_MC 32
 #define TEGRA20_CLK_AHBDMA 33
 #define TEGRA20_CLK_APBDMA 34
 /* 35 */
-- 
2.1.3
