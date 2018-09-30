From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v5 12/21] memory: tegra: Use relaxed versions of readl/writel
Date: Mon,  1 Oct 2018 01:48:24 +0300
Message-ID: <20180930224833.28809-13-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

There is no need for inserting of memory barriers to access registers of
Memory Controller. Hence use the relaxed versions of the accessors.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 9856f085e487..887a3b07334f 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -26,13 +26,13 @@
 
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
-	return readl(mc->regs + offset);
+	return readl_relaxed(mc->regs + offset);
 }
 
 static inline void mc_writel(struct tegra_mc *mc, u32 value,
 			     unsigned long offset)
 {
-	writel(value, mc->regs + offset);
+	writel_relaxed(value, mc->regs + offset);
 }
 
 extern const struct tegra_mc_reset_ops terga_mc_reset_ops_common;
-- 
2.19.0
