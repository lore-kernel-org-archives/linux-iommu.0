From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 13/30] iommu/io-pgtable-arm: Factor out ARM LPAE register
	defines
Date: Mon, 27 Feb 2017 19:54:24 +0000
Message-ID: <20170227195441.5170-14-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

For unified address space, we'll need to extract CPU page table
information and mirror it in the substream setup. Move relevant defines
to a common header.

Fix TCR_SZ_MASK while we're at it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 MAINTAINERS                    |  1 +
 drivers/iommu/io-pgtable-arm.c | 48 +-----------------------------
 drivers/iommu/io-pgtable-arm.h | 67 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 47 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d97b1d83c3e..bb089396cdd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2025,6 +2025,7 @@ S:	Maintained
 F:	drivers/iommu/arm-smmu.c
 F:	drivers/iommu/arm-smmu-v3.c
 F:	drivers/iommu/io-pgtable-arm.c
+F:	drivers/iommu/io-pgtable-arm.h
 F:	drivers/iommu/io-pgtable-arm-v7s.c
 
 ARM64 PORT (AARCH64 ARCHITECTURE)
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index feacc54bec68..973c335afd04 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -30,6 +30,7 @@
 #include <asm/barrier.h>
 
 #include "io-pgtable.h"
+#include "io-pgtable-arm.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		48
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
@@ -115,53 +116,6 @@
 #define ARM_LPAE_PTE_MEMATTR_DEV	(((arm_lpae_iopte)0x1) << 2)
 
 /* Register bits */
-#define ARM_32_LPAE_TCR_EAE		(1 << 31)
-#define ARM_64_LPAE_S2_TCR_RES1		(1 << 31)
-
-#define ARM_LPAE_TCR_EPD1		(1 << 23)
-
-#define ARM_LPAE_TCR_TG0_4K		(0 << 14)
-#define ARM_LPAE_TCR_TG0_64K		(1 << 14)
-#define ARM_LPAE_TCR_TG0_16K		(2 << 14)
-
-#define ARM_LPAE_TCR_SH0_SHIFT		12
-#define ARM_LPAE_TCR_SH0_MASK		0x3
-#define ARM_LPAE_TCR_SH_NS		0
-#define ARM_LPAE_TCR_SH_OS		2
-#define ARM_LPAE_TCR_SH_IS		3
-
-#define ARM_LPAE_TCR_ORGN0_SHIFT	10
-#define ARM_LPAE_TCR_IRGN0_SHIFT	8
-#define ARM_LPAE_TCR_RGN_MASK		0x3
-#define ARM_LPAE_TCR_RGN_NC		0
-#define ARM_LPAE_TCR_RGN_WBWA		1
-#define ARM_LPAE_TCR_RGN_WT		2
-#define ARM_LPAE_TCR_RGN_WB		3
-
-#define ARM_LPAE_TCR_SL0_SHIFT		6
-#define ARM_LPAE_TCR_SL0_MASK		0x3
-
-#define ARM_LPAE_TCR_T0SZ_SHIFT		0
-#define ARM_LPAE_TCR_SZ_MASK		0xf
-
-#define ARM_LPAE_TCR_PS_SHIFT		16
-#define ARM_LPAE_TCR_PS_MASK		0x7
-
-#define ARM_LPAE_TCR_IPS_SHIFT		32
-#define ARM_LPAE_TCR_IPS_MASK		0x7
-
-#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
-#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
-#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
-#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
-#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
-#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
-
-#define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
-#define ARM_LPAE_MAIR_ATTR_MASK		0xff
-#define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
-#define ARM_LPAE_MAIR_ATTR_NC		0x44
-#define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
 #define ARM_LPAE_MAIR_ATTR_IDX_NC	0
 #define ARM_LPAE_MAIR_ATTR_IDX_CACHE	1
 #define ARM_LPAE_MAIR_ATTR_IDX_DEV	2
diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
new file mode 100644
index 000000000000..cb31314971ac
--- /dev/null
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -0,0 +1,67 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (C) 2017 ARM Limited
+ */
+#ifndef __IO_PGTABLE_ARM_H
+#define __IO_PGTABLE_ARM_H
+
+#define ARM_32_LPAE_TCR_EAE		(1 << 31)
+#define ARM_64_LPAE_S2_TCR_RES1		(1 << 31)
+
+#define ARM_LPAE_TCR_EPD1		(1 << 23)
+
+#define ARM_LPAE_TCR_TG0_4K		(0 << 14)
+#define ARM_LPAE_TCR_TG0_64K		(1 << 14)
+#define ARM_LPAE_TCR_TG0_16K		(2 << 14)
+
+#define ARM_LPAE_TCR_SH0_SHIFT		12
+#define ARM_LPAE_TCR_SH0_MASK		0x3
+#define ARM_LPAE_TCR_SH_NS		0
+#define ARM_LPAE_TCR_SH_OS		2
+#define ARM_LPAE_TCR_SH_IS		3
+
+#define ARM_LPAE_TCR_ORGN0_SHIFT	10
+#define ARM_LPAE_TCR_IRGN0_SHIFT	8
+#define ARM_LPAE_TCR_RGN_MASK		0x3
+#define ARM_LPAE_TCR_RGN_NC		0
+#define ARM_LPAE_TCR_RGN_WBWA		1
+#define ARM_LPAE_TCR_RGN_WT		2
+#define ARM_LPAE_TCR_RGN_WB		3
+
+#define ARM_LPAE_TCR_SL0_SHIFT		6
+#define ARM_LPAE_TCR_SL0_MASK		0x3
+
+#define ARM_LPAE_TCR_T0SZ_SHIFT		0
+#define ARM_LPAE_TCR_SZ_MASK		0x3f
+
+#define ARM_LPAE_TCR_PS_SHIFT		16
+#define ARM_LPAE_TCR_PS_MASK		0x7
+
+#define ARM_LPAE_TCR_IPS_SHIFT		32
+#define ARM_LPAE_TCR_IPS_MASK		0x7
+
+#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
+#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
+#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
+#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
+#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
+#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
+
+#define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
+#define ARM_LPAE_MAIR_ATTR_MASK		0xff
+#define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
+#define ARM_LPAE_MAIR_ATTR_NC		0x44
+#define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
+
+#endif /* __IO_PGTABLE_ARM_H */
-- 
2.11.0
