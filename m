From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu: Allow io-pgtable to be used outside of drivers/iommu/
Date: Tue,  5 Feb 2019 10:37:31 -0600
Message-ID: <20190205163731.17864-1-robh@kernel.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Move io-pgtable.h to include/linux/ and export alloc_io_pgtable_ops
and free_io_pgtable_ops. This enables drivers outside drivers/iommu/ to
use the ARM page table library. Specifically, some ARM Mali GPUs use the
ARM page table formats.

Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
This will be needed for an in-progress Mali GPU DRM driver. It's using 
the page table lib, but is not a full IOMMU driver.

It's going to be a few cycles I'd guess before the DRM driver is 
anywhere close to merging. So I can carry this if preferred, but release 
early, release often.

Rob

 drivers/iommu/arm-smmu-v3.c                   | 3 +--
 drivers/iommu/arm-smmu.c                      | 2 +-
 drivers/iommu/io-pgtable-arm-v7s.c            | 3 +--
 drivers/iommu/io-pgtable-arm.c                | 3 +--
 drivers/iommu/io-pgtable.c                    | 5 +++--
 drivers/iommu/ipmmu-vmsa.c                    | 3 +--
 drivers/iommu/msm_iommu.c                     | 2 +-
 drivers/iommu/mtk_iommu.h                     | 3 +--
 drivers/iommu/qcom_iommu.c                    | 2 +-
 {drivers/iommu => include/linux}/io-pgtable.h | 0
 10 files changed, 11 insertions(+), 15 deletions(-)
 rename {drivers/iommu => include/linux}/io-pgtable.h (100%)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 0d284029dc73..d3880010c6cf 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -18,6 +18,7 @@
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/init.h>
@@ -32,8 +33,6 @@
 
 #include <linux/amba/bus.h>
 
-#include "io-pgtable.h"
-
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
 #define IDR0_ST_LVL			GENMASK(28, 27)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index af18a7e7f917..045d93884164 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -39,6 +39,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/init.h>
@@ -56,7 +57,6 @@
 #include <linux/amba/bus.h>
 #include <linux/fsl/mc.h>
 
-#include "io-pgtable.h"
 #include "arm-smmu-regs.h"
 
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index cec29bf45c9b..75a8273d1ae9 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -35,6 +35,7 @@
 #include <linux/atomic.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
@@ -45,8 +46,6 @@
 
 #include <asm/barrier.h>
 
-#include "io-pgtable.h"
-
 /* Struct accessors */
 #define io_pgtable_to_data(x)						\
 	container_of((x), struct arm_v7s_io_pgtable, iop)
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 237cacd4a62b..d3700ec15cbd 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -22,6 +22,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
@@ -31,8 +32,6 @@
 
 #include <asm/barrier.h>
 
-#include "io-pgtable.h"
-
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
 #define ARM_LPAE_MAX_LEVELS		4
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 127558d83667..93f2880be6c6 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -19,11 +19,10 @@
  */
 
 #include <linux/bug.h>
+#include <linux/io-pgtable.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-#include "io-pgtable.h"
-
 static const struct io_pgtable_init_fns *
 io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE
@@ -61,6 +60,7 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
 
 	return &iop->ops;
 }
+EXPORT_SYMBOL_GPL(alloc_io_pgtable_ops);
 
 /*
  * It is the IOMMU driver's responsibility to ensure that the page table
@@ -77,3 +77,4 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops)
 	io_pgtable_tlb_flush_all(iop);
 	io_pgtable_init_table[iop->fmt]->free(iop);
 }
+EXPORT_SYMBOL_GPL(free_io_pgtable_ops);
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 7a4529c61c19..9a380c10655e 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -35,8 +36,6 @@
 #define arm_iommu_detach_device(...)	do {} while (0)
 #endif
 
-#include "io-pgtable.h"
-
 #define IPMMU_CTX_MAX 8
 
 struct ipmmu_features {
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index fc4270733f11..ef7d1f995d6b 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/io-pgtable.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
@@ -37,7 +38,6 @@
 
 #include "msm_iommu_hw-8xxx.h"
 #include "msm_iommu.h"
-#include "io-pgtable.h"
 
 #define MRC(reg, processor, op1, crn, crm, op2)				\
 __asm__ __volatile__ (							\
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 778498b8633f..62c2c3e8c5df 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -19,13 +19,12 @@
 #include <linux/component.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <soc/mediatek/smi.h>
 
-#include "io-pgtable.h"
-
 struct mtk_iommu_suspend_reg {
 	u32				standard_axi_mode;
 	u32				dcm_dis;
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index d8595f0a987d..8cdd3f059513 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/kconfig.h>
@@ -42,7 +43,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-#include "io-pgtable.h"
 #include "arm-smmu-regs.h"
 
 #define SMMU_INTR_SEL_NS     0x2000
diff --git a/drivers/iommu/io-pgtable.h b/include/linux/io-pgtable.h
similarity index 100%
rename from drivers/iommu/io-pgtable.h
rename to include/linux/io-pgtable.h
-- 
2.19.1
