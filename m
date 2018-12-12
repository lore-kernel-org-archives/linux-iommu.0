From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 10/24] memory: tegra: Read client ID on GART page fault
Date: Wed, 12 Dec 2018 23:38:53 +0300
Message-ID: <20181212203907.23461-11-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

With the device tree binding changes, now Memory Controller has access to
GART registers. Hence it is now possible to read client ID on GART page
fault to get information about what memory client causes the fault.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/mc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 59db13287b47..ce8cf81b55d7 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -38,6 +38,7 @@
 
 #define MC_ERR_ADR 0x0c
 
+#define MC_GART_ERROR_REQ		0x30
 #define MC_DECERR_EMEM_OTHERS_STATUS	0x58
 #define MC_SECURITY_VIOLATION_STATUS	0x74
 
@@ -575,8 +576,15 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 			break;
 
 		case MC_INT_INVALID_GART_PAGE:
-			dev_err_ratelimited(mc->dev, "%s\n", error);
-			continue;
+			reg = MC_GART_ERROR_REQ;
+			value = mc_readl(mc, reg);
+
+			id = (value >> 1) & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(0))
+				direction = "write";
+			break;
 
 		case MC_INT_SECURITY_VIOLATION:
 			reg = MC_SECURITY_VIOLATION_STATUS;
-- 
2.20.0
