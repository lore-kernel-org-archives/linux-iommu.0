From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 17/19] iommu: exynos: remove excessive includes and sort
 others alphabetically
Date: Wed, 19 Nov 2014 12:15:46 +0100
Message-ID: <1416395748-10731-18-git-send-email-m.szyprowski@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Removed following unused includes: <linux/mm.h>, <linux/errno.h>,
<linux/memblock.h> and <linux/export.h>.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a5b32cdeec2d..cd28dc09db39 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -12,19 +12,15 @@
 #define DEBUG
 #endif
 
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/mm.h>
+#include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/list.h>
-#include <linux/memblock.h>
-#include <linux/export.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
-- 
1.9.2
