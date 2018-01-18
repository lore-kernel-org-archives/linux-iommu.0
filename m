From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v4 05/13] iommu/rockchip: Use iopoll helpers to wait for hardware
Date: Thu, 18 Jan 2018 19:52:43 +0800
Message-ID: <20180118115251.5542-6-jeffy.chen@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Tomasz Figa <tfiga@chromium.org>

This patch converts the rockchip-iommu driver to use the in-kernel
iopoll helpers to wait for certain status bits to change in registers
instead of an open-coded custom macro.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 68 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 37065a7127c9..4a1c710408af 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -13,7 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/jiffies.h>
+#include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -36,7 +36,8 @@
 #define RK_MMU_AUTO_GATING	0x24
 
 #define DTE_ADDR_DUMMY		0xCAFEBABE
-#define FORCE_RESET_TIMEOUT	100	/* ms */
+#define FORCE_RESET_TIMEOUT	100000	/* us */
+#define POLL_TIMEOUT		1000	/* us */
 
 /* RK_MMU_STATUS fields */
 #define RK_MMU_STATUS_PAGING_ENABLED       BIT(0)
@@ -73,8 +74,6 @@
   */
 #define RK_IOMMU_PGSIZE_BITMAP 0x007ff000
 
-#define IOMMU_REG_POLL_COUNT_FAST 1000
-
 struct rk_iommu_domain {
 	struct list_head iommus;
 	struct platform_device *pdev;
@@ -109,27 +108,6 @@ static struct rk_iommu_domain *to_rk_domain(struct iommu_domain *dom)
 	return container_of(dom, struct rk_iommu_domain, domain);
 }
 
-/**
- * Inspired by _wait_for in intel_drv.h
- * This is NOT safe for use in interrupt context.
- *
- * Note that it's important that we check the condition again after having
- * timed out, since the timeout could be due to preemption or similar and
- * we've never had a chance to check the condition before the timeout.
- */
-#define rk_wait_for(COND, MS) ({ \
-	unsigned long timeout__ = jiffies + msecs_to_jiffies(MS) + 1;	\
-	int ret__ = 0;							\
-	while (!(COND)) {						\
-		if (time_after(jiffies, timeout__)) {			\
-			ret__ = (COND) ? 0 : -ETIMEDOUT;		\
-			break;						\
-		}							\
-		usleep_range(50, 100);					\
-	}								\
-	ret__;								\
-})
-
 /*
  * The Rockchip rk3288 iommu uses a 2-level page table.
  * The first level is the "Directory Table" (DT).
@@ -333,9 +311,21 @@ static bool rk_iommu_is_paging_enabled(struct rk_iommu *iommu)
 	return enable;
 }
 
+static bool rk_iommu_is_reset_done(struct rk_iommu *iommu)
+{
+	bool done = true;
+	int i;
+
+	for (i = 0; i < iommu->num_mmu; i++)
+		done &= rk_iommu_read(iommu->bases[i], RK_MMU_DTE_ADDR) == 0;
+
+	return done;
+}
+
 static int rk_iommu_enable_stall(struct rk_iommu *iommu)
 {
 	int ret, i;
+	bool val;
 
 	if (rk_iommu_is_stall_active(iommu))
 		return 0;
@@ -346,7 +336,8 @@ static int rk_iommu_enable_stall(struct rk_iommu *iommu)
 
 	rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_STALL);
 
-	ret = rk_wait_for(rk_iommu_is_stall_active(iommu), 1);
+	ret = readx_poll_timeout(rk_iommu_is_stall_active, iommu, val,
+				 val, 100, POLL_TIMEOUT);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)
 			dev_err(iommu->dev, "Enable stall request timed out, status: %#08x\n",
@@ -358,13 +349,15 @@ static int rk_iommu_enable_stall(struct rk_iommu *iommu)
 static int rk_iommu_disable_stall(struct rk_iommu *iommu)
 {
 	int ret, i;
+	bool val;
 
 	if (!rk_iommu_is_stall_active(iommu))
 		return 0;
 
 	rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_STALL);
 
-	ret = rk_wait_for(!rk_iommu_is_stall_active(iommu), 1);
+	ret = readx_poll_timeout(rk_iommu_is_stall_active, iommu, val,
+				 !val, 100, POLL_TIMEOUT);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)
 			dev_err(iommu->dev, "Disable stall request timed out, status: %#08x\n",
@@ -376,13 +369,15 @@ static int rk_iommu_disable_stall(struct rk_iommu *iommu)
 static int rk_iommu_enable_paging(struct rk_iommu *iommu)
 {
 	int ret, i;
+	bool val;
 
 	if (rk_iommu_is_paging_enabled(iommu))
 		return 0;
 
 	rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_PAGING);
 
-	ret = rk_wait_for(rk_iommu_is_paging_enabled(iommu), 1);
+	ret = readx_poll_timeout(rk_iommu_is_paging_enabled, iommu, val,
+				 val, 100, POLL_TIMEOUT);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)
 			dev_err(iommu->dev, "Enable paging request timed out, status: %#08x\n",
@@ -394,13 +389,15 @@ static int rk_iommu_enable_paging(struct rk_iommu *iommu)
 static int rk_iommu_disable_paging(struct rk_iommu *iommu)
 {
 	int ret, i;
+	bool val;
 
 	if (!rk_iommu_is_paging_enabled(iommu))
 		return 0;
 
 	rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_PAGING);
 
-	ret = rk_wait_for(!rk_iommu_is_paging_enabled(iommu), 1);
+	ret = readx_poll_timeout(rk_iommu_is_paging_enabled, iommu, val,
+				 !val, 100, POLL_TIMEOUT);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)
 			dev_err(iommu->dev, "Disable paging request timed out, status: %#08x\n",
@@ -413,6 +410,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 {
 	int ret, i;
 	u32 dte_addr;
+	bool val;
 
 	if (iommu->reset_disabled)
 		return 0;
@@ -433,13 +431,11 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 
 	rk_iommu_command(iommu, RK_MMU_CMD_FORCE_RESET);
 
-	for (i = 0; i < iommu->num_mmu; i++) {
-		ret = rk_wait_for(rk_iommu_read(iommu->bases[i], RK_MMU_DTE_ADDR) == 0x00000000,
-				  FORCE_RESET_TIMEOUT);
-		if (ret) {
-			dev_err(iommu->dev, "FORCE_RESET command timed out\n");
-			return ret;
-		}
+	ret = readx_poll_timeout(rk_iommu_is_reset_done, iommu, val,
+				 val, 100, FORCE_RESET_TIMEOUT);
+	if (ret) {
+		dev_err(iommu->dev, "FORCE_RESET command timed out\n");
+		return ret;
 	}
 
 	return 0;
-- 
2.11.0
