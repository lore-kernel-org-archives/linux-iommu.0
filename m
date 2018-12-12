From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 12/24] memory: tegra: Use relaxed versions of readl/writel
Date: Wed, 12 Dec 2018 23:38:55 +0300
Message-ID: <20181212203907.23461-13-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

There is no need for inserting of memory barriers to access registers of
Memory Controller. Hence use the relaxed versions of the accessors.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
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
2.20.0
