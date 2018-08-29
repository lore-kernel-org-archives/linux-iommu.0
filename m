From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] sparc: set a default 32-bit dma mask for OF devices
Date: Wed, 29 Aug 2018 08:24:00 +0200
Message-ID: <20180829062401.8701-3-hch@lst.de>
References: <20180829062401.8701-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, Meelis Roos <mroos@linux.ee>, Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linus.walleij@linaro.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This keeps the historic default behavior for devices without a DMA mask,
but removes the warning about a lacking DMA mask for doing DMA without
a mask.

Reported-by: Meelis Roos <mroos@linux.ee>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/of_device_32.c | 5 +++++
 arch/sparc/kernel/of_device_64.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 3641a294ed54..7f3dec7e1e78 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
 #include <asm/leon.h>
 #include <asm/leon_amba.h>
 
@@ -381,6 +382,10 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	else
 		dev_set_name(&op->dev, "%08x", dp->phandle);
 
+	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	op->dev.dma_mask = &op->dma_mask;
+	op->dma_mask = DMA_BIT_MASK(32);
+
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
 		       dp->full_name);
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 44e4d4435bed..d94c31822da1 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -2,6 +2,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/mod_devicetable.h>
@@ -675,6 +676,9 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 		dev_set_name(&op->dev, "root");
 	else
 		dev_set_name(&op->dev, "%08x", dp->phandle);
+	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	op->dev.dma_mask = &op->dma_mask;
+	op->dma_mask = DMA_BIT_MASK(32);
 
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
-- 
2.18.0
