From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 07/12] iommu/rockchip: Control clocks needed to access the
	IOMMU
Date: Wed, 17 Jan 2018 23:25:37 +0800
Message-ID: <20180117152542.26429-8-jeffy.chen@rock-chips.com>
References: <20180117152542.26429-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180117152542.26429-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Current code relies on master driver enabling necessary clocks before
IOMMU is accessed, however there are cases when the IOMMU should be
accessed while the master is not running yet, for example allocating
V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
mapping API and doesn't engage the master driver at all.

This patch fixes the problem by letting clocks needed for IOMMU
operation to be listed in Device Tree and making the driver enable them
for the time of accessing the hardware.

Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/iommu/rockchip,iommu.txt   |   8 ++
 drivers/iommu/rockchip-iommu.c                     | 114 +++++++++++++++++++--
 2 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
index 2098f7732264..33dd853359fa 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
@@ -14,6 +14,13 @@ Required properties:
                     "single-master" device, and needs no additional information
                     to associate with its master device.  See:
                     Documentation/devicetree/bindings/iommu/iommu.txt
+Optional properties:
+- clocks : A list of master clocks requires for the IOMMU to be accessible
+           by the host CPU. The number of clocks depends on the master
+           block and might as well be zero. See [1] for generic clock
+           bindings description.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 
 Optional properties:
 - rockchip,disable-mmu-reset : Don't use the mmu reset operation.
@@ -27,5 +34,6 @@ Example:
 		reg = <0xff940300 0x100>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopl_mmu";
+		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
 		#iommu-cells = <0>;
 	};
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 1914ac52042c..9b85a3050449 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -4,6 +4,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -89,6 +90,8 @@ struct rk_iommu {
 	struct device *dev;
 	void __iomem **bases;
 	int num_mmu;
+	struct clk **clocks;
+	int num_clocks;
 	bool reset_disabled;
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
@@ -443,6 +446,83 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	return 0;
 }
 
+static void rk_iommu_put_clocks(struct rk_iommu *iommu)
+{
+	int i;
+
+	for (i = 0; i < iommu->num_clocks; ++i) {
+		clk_unprepare(iommu->clocks[i]);
+		clk_put(iommu->clocks[i]);
+	}
+}
+
+static int rk_iommu_get_clocks(struct rk_iommu *iommu)
+{
+	struct device_node *np = iommu->dev->of_node;
+	int ret;
+	int i;
+
+	ret = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	if (ret == -ENOENT)
+		return 0;
+	else if (ret < 0)
+		return ret;
+
+	iommu->num_clocks = ret;
+	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
+				     sizeof(*iommu->clocks), GFP_KERNEL);
+	if (!iommu->clocks)
+		return -ENOMEM;
+
+	for (i = 0; i < iommu->num_clocks; ++i) {
+		iommu->clocks[i] = of_clk_get(np, i);
+		if (IS_ERR(iommu->clocks[i])) {
+			iommu->num_clocks = i;
+			goto err_clk_put;
+		}
+		ret = clk_prepare(iommu->clocks[i]);
+		if (ret) {
+			clk_put(iommu->clocks[i]);
+			iommu->num_clocks = i;
+			goto err_clk_put;
+		}
+	}
+
+	return 0;
+
+err_clk_put:
+	rk_iommu_put_clocks(iommu);
+
+	return ret;
+}
+
+static int rk_iommu_enable_clocks(struct rk_iommu *iommu)
+{
+	int i, ret;
+
+	for (i = 0; i < iommu->num_clocks; ++i) {
+		ret = clk_enable(iommu->clocks[i]);
+		if (ret)
+			goto err_disable;
+	}
+
+	return 0;
+
+err_disable:
+	for (--i; i >= 0; --i)
+		clk_disable(iommu->clocks[i]);
+
+	return ret;
+}
+
+static void rk_iommu_disable_clocks(struct rk_iommu *iommu)
+{
+	int i;
+
+	for (i = 0; i < iommu->num_clocks; ++i)
+		clk_disable(iommu->clocks[i]);
+}
+
 static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 {
 	void __iomem *base = iommu->bases[index];
@@ -499,6 +579,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	irqreturn_t ret = IRQ_NONE;
 	int i;
 
+	WARN_ON(rk_iommu_enable_clocks(iommu));
+
 	for (i = 0; i < iommu->num_mmu; i++) {
 		int_status = rk_iommu_read(iommu->bases[i], RK_MMU_INT_STATUS);
 		if (int_status == 0)
@@ -545,6 +627,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_CLEAR, int_status);
 	}
 
+	rk_iommu_disable_clocks(iommu);
+
 	return ret;
 }
 
@@ -587,7 +671,9 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
 	list_for_each(pos, &rk_domain->iommus) {
 		struct rk_iommu *iommu;
 		iommu = list_entry(pos, struct rk_iommu, node);
+		rk_iommu_enable_clocks(iommu);
 		rk_iommu_zap_lines(iommu, iova, size);
+		rk_iommu_disable_clocks(iommu);
 	}
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 }
@@ -816,10 +902,14 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return 0;
 
-	ret = rk_iommu_enable_stall(iommu);
+	ret = rk_iommu_enable_clocks(iommu);
 	if (ret)
 		return ret;
 
+	ret = rk_iommu_enable_stall(iommu);
+	if (ret)
+		goto err_disable_clocks;
+
 	ret = rk_iommu_force_reset(iommu);
 	if (ret)
 		goto err_disable_stall;
@@ -844,11 +934,14 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	dev_dbg(dev, "Attached to iommu domain\n");
 
 	rk_iommu_disable_stall(iommu);
+	rk_iommu_disable_clocks(iommu);
 
 	return 0;
 
 err_disable_stall:
 	rk_iommu_disable_stall(iommu);
+err_disable_clocks:
+	rk_iommu_disable_clocks(iommu);
 
 	return ret;
 }
@@ -871,6 +964,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 
 	/* Ignore error while disabling, just keep going */
+	WARN_ON(rk_iommu_enable_clocks(iommu));
 	rk_iommu_enable_stall(iommu);
 	rk_iommu_disable_paging(iommu);
 	for (i = 0; i < iommu->num_mmu; i++) {
@@ -878,6 +972,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
 	}
 	rk_iommu_disable_stall(iommu);
+	rk_iommu_disable_clocks(iommu);
 
 	iommu->domain = NULL;
 
@@ -1167,21 +1262,28 @@ static int rk_iommu_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	err = rk_iommu_get_clocks(iommu);
+	if (err)
+		return err;
+
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
 	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
 	if (err)
-		return err;
+		goto err_put_clocks;
 
 	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
 	err = iommu_device_register(&iommu->iommu);
-	if (err) {
-		iommu_device_sysfs_remove(&iommu->iommu);
-		return err;
-	}
+	if (err)
+		goto err_remove_sysfs;
 
 	return 0;
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&iommu->iommu);
+err_put_clocks:
+	rk_iommu_put_clocks(iommu);
+	return err;
 }
 
 static const struct of_device_id rk_iommu_dt_ids[] = {
-- 
2.11.0
