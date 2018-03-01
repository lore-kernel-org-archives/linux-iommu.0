From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RESEND PATCH v6 05/14] iommu/rockchip: Use iopoll helpers to wait
	for hardware
Date: Thu,  1 Mar 2018 18:18:28 +0800
Message-ID: <20180301101837.27969-6-jeffy.chen@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180301101837.27969-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

This patch converts the rockchip-iommu driver to use the in-kernel
iopoll helpers to wait for certain status bits to change in registers
instead of an open-coded custom macro.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Changes in v6: None
Changes in v5:
Use RK_MMU_POLL_PERIOD_US instead of 100.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 75 ++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f7ff3a3645ea..baba283ccdf9 100644
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
@@ -36,7 +36,10 @@
 #define RK_MMU_AUTO_GATING	0x24
 
 #define DTE_ADDR_DUMMY		0xCAFEBABE
-#define FORCE_RESET_TIMEOUT	100	/* ms */
+
+#define RK_MMU_POLL_PERIOD_US		100
+#define RK_MMU_FORCE_RESET_TIMEOUT_US	100000
+#define RK_MMU_POLL_TIMEOUT_US		1000
 
 /* RK_MMU_STATUS fields */
 #define RK_MMU_STATUS_PAGING_ENABLED       BIT(0)
@@ -73,8 +76,6 @@
   */
 #define RK_IOMMU_PGSIZE_BITMAP 0x007ff000
 
-#define IOMMU_REG_POLL_COUNT_FAST 1000
-
 struct rk_iommu_domain {
 	struct list_head iommus;
 	struct platform_device *pdev;
@@ -109,27 +110,6 @@ static struct rk_iommu_domain *to_rk_domain(struct iommu_domain *dom)
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
@@ -333,9 +313,21 @@ static bool rk_iommu_is_paging_enabled(struct rk_iommu *iommu)
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
@@ -346,7 +338,9 @@ static int rk_iommu_enable_stall(struct rk_iommu *iommu)
 
 	rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_STALL);
 
-	ret = rk_wait_for(rk_iommu_is_stall_active(iommu), 1);
+	ret = readx_poll_timeout(rk_iommu_is_stall_active, iommu, val,
+				 val, RK_MMU_POLL_PERIOD_US,
+				 RK_MMU_POLL_TIMEOUT_US);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)
 			dev_err(iommu->dev, "Enable stall request timed out, status: %#08x\n",
@@ -358,13 +352,16 @@ static int rk_iommu_enable_stall(struct rk_iommu *iommu)
 static int rk_iommu_disable_stall(struct rk_iommu *iommu)
 {
 	int ret, i;
+	bool val;
 
 	if (!rk_iommu_is_stall_active(iommu))
 		return 0;
 
 	rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_STALL);
 
-	ret = rk_wait_for(!rk_iommu_is_stall_active(iommu), 1);
+	ret = readx_poll_timeout(rk_iommu_is_stall_active, iommu, val,
+				 !val, RK_MMU_POLL_PERIOD_US,
+				 RK_MMU_POLL_TIMEOUT_US);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)
 			dev_err(iommu->dev, "Disable stall request timed out, status: %#08x\n",
@@ -376,13 +373,16 @@ static int rk_iommu_disable_stall(struct rk_iommu *iommu)
 static int rk_iommu_enable_paging(struct rk_iommu *iommu)
 {
 	int ret, i;
+	bool val;
 
 	if (rk_iommu_is_paging_enabled(iommu))
 		return 0;
 
 	rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_PAGING);
 
-	ret = rk_wait_for(rk_iommu_is_paging_enabled(iommu), 1);
+	ret = readx_poll_timeout(rk_iommu_is_paging_enabled, iommu, val,
+				 val, RK_MMU_POLL_PERIOD_US,
+				 RK_MMU_POLL_TIMEOUT_US);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)
 			dev_err(iommu->dev, "Enable paging request timed out, status: %#08x\n",
@@ -394,13 +394,16 @@ static int rk_iommu_enable_paging(struct rk_iommu *iommu)
 static int rk_iommu_disable_paging(struct rk_iommu *iommu)
 {
 	int ret, i;
+	bool val;
 
 	if (!rk_iommu_is_paging_enabled(iommu))
 		return 0;
 
 	rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_PAGING);
 
-	ret = rk_wait_for(!rk_iommu_is_paging_enabled(iommu), 1);
+	ret = readx_poll_timeout(rk_iommu_is_paging_enabled, iommu, val,
+				 !val, RK_MMU_POLL_PERIOD_US,
+				 RK_MMU_POLL_TIMEOUT_US);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)
 			dev_err(iommu->dev, "Disable paging request timed out, status: %#08x\n",
@@ -413,6 +416,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 {
 	int ret, i;
 	u32 dte_addr;
+	bool val;
 
 	if (iommu->reset_disabled)
 		return 0;
@@ -433,13 +437,12 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 
 	rk_iommu_command(iommu, RK_MMU_CMD_FORCE_RESET);
 
-	for (i = 0; i < iommu->num_mmu; i++) {
-		ret = rk_wait_for(rk_iommu_read(iommu->bases[i], RK_MMU_DTE_ADDR) == 0x00000000,
-				  FORCE_RESET_TIMEOUT);
-		if (ret) {
-			dev_err(iommu->dev, "FORCE_RESET command timed out\n");
-			return ret;
-		}
+	ret = readx_poll_timeout(rk_iommu_is_reset_done, iommu, val,
+				 val, RK_MMU_FORCE_RESET_TIMEOUT_US,
+				 RK_MMU_POLL_TIMEOUT_US);
+	if (ret) {
+		dev_err(iommu->dev, "FORCE_RESET command timed out\n");
+		return ret;
 	}
 
 	return 0;
-- 
2.11.0
