From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH/RFC 09/10] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
Date: Tue, 15 Dec 2015 22:06:32 +0900
Message-ID: <20151215130632.13535.48038.sendpatchset@little-apple>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151215130508.13535.26186.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Introduce a new set of iommu_ops suitable for 64-bit ARM
and IOMMU_OF_DECLARE() used on r8a7795. The ->of_xlate()
callback is wrapped in #ifdefs to also compile of x86_64.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 drivers/iommu/ipmmu-vmsa.c |   89 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

--- 0020/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 21:23:05.770513000 +0900
@@ -10,6 +10,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/delay.h>
+#include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -895,6 +896,92 @@ static const struct iommu_ops ipmmu_ops
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 };
 
+static struct iommu_domain *ipmmu_domain_alloc_dma(unsigned type)
+{
+	struct iommu_domain *io_domain;
+
+	if (type != IOMMU_DOMAIN_DMA)
+		return NULL;
+
+	io_domain = __ipmmu_domain_alloc(type);
+	if (io_domain)
+		iommu_get_dma_cookie(io_domain);
+
+	return io_domain;
+}
+
+static void ipmmu_domain_free_dma(struct iommu_domain *io_domain)
+{
+	iommu_put_dma_cookie(io_domain);
+	ipmmu_domain_free(io_domain);
+}
+
+static int ipmmu_add_device_dma(struct device *dev)
+{
+	struct iommu_group *group;
+
+	/* only accept devices with iommus property */
+	if (of_count_phandle_with_args(dev->of_node, "iommus",
+				       "#iommu-cells") < 0)
+		return -ENODEV;
+
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	return 0;
+}
+
+static void ipmmu_remove_device_dma(struct device *dev)
+{
+	iommu_group_remove_device(dev);
+}
+
+static struct iommu_group *ipmmu_device_group_dma(struct device *dev)
+{
+	struct iommu_group *group;
+	int ret;
+
+	group = generic_device_group(dev);
+	if (IS_ERR(group))
+		return group;
+
+	ret = ipmmu_init_platform_device(dev, group);
+	if (ret) {
+		iommu_group_put(group);
+		group = ERR_PTR(ret);
+	}
+
+	return group;
+}
+
+#ifdef CONFIG_OF_IOMMU
+static int ipmmu_of_xlate_dma(struct device *dev,
+			      struct of_phandle_args *spec)
+{
+	/* dummy callback to satisfy of_iommu_configure() */
+	return 0;
+}
+#endif
+
+static const struct iommu_ops ipmmu_ops_dma = {
+	.domain_alloc = ipmmu_domain_alloc_dma,
+	.domain_free = ipmmu_domain_free_dma,
+	.attach_dev = ipmmu_attach_device,
+	.detach_dev = ipmmu_detach_device,
+	.map = ipmmu_map,
+	.unmap = ipmmu_unmap,
+	.map_sg = default_iommu_map_sg,
+	.iova_to_phys = ipmmu_iova_to_phys,
+	.add_device = ipmmu_add_device_dma,
+	.remove_device = ipmmu_remove_device_dma,
+	.device_group = ipmmu_device_group_dma,
+	.pgsize_bitmap = SZ_4K,
+#ifdef CONFIG_OF_IOMMU
+	.of_xlate = ipmmu_of_xlate_dma,
+#endif
+};
+
 /* -----------------------------------------------------------------------------
  * Probe/remove and init
  */
@@ -1068,7 +1155,7 @@ static int __init ipmmu_vmsa_iommu_of_se
 {
 	const struct of_device_id *match;
 	const struct ipmmu_features *feature;
-	static const struct iommu_ops *ops = &ipmmu_ops;
+	static const struct iommu_ops *ops = &ipmmu_ops_dma;
 
 	ipmmu_init();
 
