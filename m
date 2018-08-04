From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 1/8] memory: tegra: Provide facility for integration with the GART driver
Date: Sat,  4 Aug 2018 17:29:56 +0300
Message-ID: <20180804143003.15817-2-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

In order to report clients name and access direction on GART's page fault,
MC driver need to access GART registers. Add facility that provides access
to the GART.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 26 +++++++++++++++++++++++---
 include/soc/tegra/mc.h    | 13 +++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index e56862495f36..4940d72b5263 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -72,6 +72,8 @@ static const struct of_device_id tegra_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
 
+static struct tegra_mc_gart_handle *gart_handle;
+
 static int terga_mc_block_dma_common(struct tegra_mc *mc,
 				     const struct tegra_mc_reset *rst)
 {
@@ -543,6 +545,11 @@ static irqreturn_t tegra_mc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+void tegra_mc_register_gart(struct tegra_mc_gart_handle *handle)
+{
+	WRITE_ONCE(gart_handle, handle);
+}
+
 static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 {
 	struct tegra_mc *mc = data;
@@ -565,6 +572,7 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 		switch (BIT(bit)) {
 		case MC_INT_DECERR_EMEM:
 			reg = MC_DECERR_EMEM_OTHERS_STATUS;
+			addr = mc_readl(mc, reg + sizeof(u32));
 			value = mc_readl(mc, reg);
 
 			id = value & mc->soc->client_id_mask;
@@ -575,11 +583,24 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 			break;
 
 		case MC_INT_INVALID_GART_PAGE:
-			dev_err_ratelimited(mc->dev, "%s\n", error);
-			continue;
+			if (gart_handle == NULL) {
+				dev_err_ratelimited(mc->dev, "%s\n", error);
+				continue;
+			}
+
+			addr = gart_handle->error_addr(gart_handle);
+			value = gart_handle->error_req(gart_handle);
+
+			id = (value >> 1) & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(0))
+				direction = "write";
+			break;
 
 		case MC_INT_SECURITY_VIOLATION:
 			reg = MC_SECURITY_VIOLATION_STATUS;
+			addr = mc_readl(mc, reg + sizeof(u32));
 			value = mc_readl(mc, reg);
 
 			id = value & mc->soc->client_id_mask;
@@ -596,7 +617,6 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 		}
 
 		client = mc->soc->clients[id].name;
-		addr = mc_readl(mc, reg + sizeof(u32));
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s)\n",
 				    client, secure, direction, &addr, error,
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index b43f37fea096..5bf72eb4dd51 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -162,4 +162,17 @@ struct tegra_mc {
 void tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
 
+struct tegra_mc_gart_handle {
+	u32 (*error_addr)(struct tegra_mc_gart_handle *handle);
+	u32 (*error_req)(struct tegra_mc_gart_handle *handle);
+};
+
+#ifdef CONFIG_TEGRA_MC
+void tegra_mc_register_gart(struct tegra_mc_gart_handle *handle);
+#else
+static inline void tegra_mc_register_gart(struct tegra_mc_gart_handle *handle)
+{
+}
+#endif
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.18.0
