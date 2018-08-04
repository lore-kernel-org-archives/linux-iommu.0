From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 4/8] iommu/tegra: gart: Remove pr_fmt and clean up includes
Date: Sat,  4 Aug 2018 17:29:59 +0300
Message-ID: <20180804143003.15817-5-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Remove unneeded headers inclusion and sort the headers in alphabet order.
Remove pr_fmt macro since there is no pr_*() in the code and it doesn't
affect dev_*() functions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 141ff0c79ee4..9a427cb35340 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -17,24 +17,17 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#define pr_fmt(fmt)	"%s(): " fmt, __func__
-
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/vmalloc.h>
-#include <linux/mm.h>
-#include <linux/list.h>
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/iommu.h>
-#include <linux/of.h>
 
 #include <soc/tegra/mc.h>
 
-#include <asm/cacheflush.h>
-
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
 
-- 
2.18.0
