From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 2/9] iommu/tegra: gart: Provide access to Memory Controller
	driver
Date: Tue,  8 May 2018 21:16:53 +0300
Message-ID: <20180508181700.5169-3-digetx@gmail.com>
References: <20180508181700.5169-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180508181700.5169-1-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

GART contains registers needed by the Memory Controller driver. Provide
access to the MC driver by utilizing its GART-integration facility.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 89ec24c6952c..de48943bf843 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -31,6 +31,8 @@
 #include <linux/iommu.h>
 #include <linux/of.h>
 
+#include <soc/tegra/mc.h>
+
 #include <asm/cacheflush.h>
 
 /* bitmap of the page sizes currently supported */
@@ -41,6 +43,8 @@
 #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
 #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
 #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
+#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
+#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
 
 #define GART_PAGE_SHIFT		12
 #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
@@ -63,6 +67,8 @@ struct gart_device {
 	struct device		*dev;
 
 	struct iommu_device	iommu;		/* IOMMU Core handle */
+
+	struct tegra_mc_gart_handle mc_gart_handle;
 };
 
 struct gart_domain {
@@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
 	return 0;
 }
 
+static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
+{
+	struct gart_device *gart = container_of(handle, struct gart_device,
+						mc_gart_handle);
+	return readl(gart->regs + GART_ERROR_ADDR);
+}
+
+static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
+{
+	struct gart_device *gart = container_of(handle, struct gart_device,
+						mc_gart_handle);
+	return readl(gart->regs + GART_ERROR_REQ);
+}
+
 static int tegra_gart_probe(struct platform_device *pdev)
 {
 	struct gart_device *gart;
@@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->regs = gart_regs;
 	gart->iovmm_base = (dma_addr_t)res_remap->start;
 	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
+	gart->mc_gart_handle.error_addr = tegra_gart_error_addr;
+	gart->mc_gart_handle.error_req = tegra_gart_error_req;
 
 	gart->savedata = vmalloc(sizeof(u32) * gart->page_count);
 	if (!gart->savedata) {
@@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	do_gart_setup(gart, NULL);
 
 	gart_handle = gart;
+	tegra_mc_register_gart(&gart->mc_gart_handle);
 
 	return 0;
 }
-- 
2.17.0
