From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/04] iommu/ipmmu-vmsa: Consistent ->of_xlate() handling
Date: Thu, 15 Jun 2017 19:29:27 +0900
Message-ID: <149752256764.21887.17904093211691192196.sendpatchset@little-apple>
References: <149752254550.21887.15183665699230243235.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149752254550.21887.15183665699230243235.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

The 32-bit ARM code gets updated to make use of ->of_xlate() and the
code is shared between 64-bit and 32-bit ARM. The of_device_is_available()
check gets dropped since it is included in of_iommu_xlate().

Suggested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 drivers/iommu/ipmmu-vmsa.c |   51 ++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

--- 0009/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-06-15 17:22:27.460607110 +0900
@@ -680,6 +680,10 @@ static int ipmmu_init_platform_device(st
 	int num_utlbs;
 	int ret = -ENODEV;
 
+	/* Initialize once - xlate() will call multiple times */
+	if (to_priv(dev))
+		return 0;
+
 	/* Find the master corresponding to the device. */
 
 	num_utlbs = of_count_phandle_with_args(dev->of_node, "iommus",
@@ -734,6 +738,12 @@ error:
 	return ret;
 }
 
+static int ipmmu_of_xlate(struct device *dev,
+			  struct of_phandle_args *spec)
+{
+	return ipmmu_init_platform_device(dev);
+}
+
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 
 static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
@@ -750,11 +760,11 @@ static int ipmmu_add_device(struct devic
 	struct iommu_group *group;
 	int ret;
 
-	if (to_priv(dev)) {
-		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
-			 dev_name(dev));
-		return -EINVAL;
-	}
+	/*
+	 * Only let through devices that have been verified in xlate()
+	 */
+	if (!to_priv(dev))
+		return -ENODEV;
 
 	/* Create a device group and add the device to it. */
 	group = iommu_group_alloc();
@@ -773,10 +783,6 @@ static int ipmmu_add_device(struct devic
 		goto error;
 	}
 
-	ret = ipmmu_init_platform_device(dev);
-	if (ret < 0)
-		goto error;
-
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
 	 * VAs. This will allocate a corresponding IOMMU domain.
@@ -817,24 +823,13 @@ error:
 	if (!IS_ERR_OR_NULL(group))
 		iommu_group_remove_device(dev);
 
-	kfree(to_priv(dev)->utlbs);
-	kfree(to_priv(dev));
-	set_priv(dev, NULL);
-
 	return ret;
 }
 
 static void ipmmu_remove_device(struct device *dev)
 {
-	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
-
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
-
-	kfree(priv->utlbs);
-	kfree(priv);
-
-	set_priv(dev, NULL);
 }
 
 static const struct iommu_ops ipmmu_ops = {
@@ -849,6 +844,7 @@ static const struct iommu_ops ipmmu_ops
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
+	.of_xlate = ipmmu_of_xlate,
 };
 
 #endif /* !CONFIG_ARM && CONFIG_IOMMU_DMA */
@@ -958,19 +954,6 @@ static struct iommu_group *ipmmu_find_gr
 	return group;
 }
 
-static int ipmmu_of_xlate_dma(struct device *dev,
-			      struct of_phandle_args *spec)
-{
-	/* If the IPMMU device is disabled in DT then return error
-	 * to make sure the of_iommu code does not install ops
-	 * even though the iommu device is disabled
-	 */
-	if (!of_device_is_available(spec->np))
-		return -ENODEV;
-
-	return ipmmu_init_platform_device(dev);
-}
-
 static const struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc_dma,
 	.domain_free = ipmmu_domain_free_dma,
@@ -984,7 +967,7 @@ static const struct iommu_ops ipmmu_ops
 	.remove_device = ipmmu_remove_device_dma,
 	.device_group = ipmmu_find_group_dma,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
-	.of_xlate = ipmmu_of_xlate_dma,
+	.of_xlate = ipmmu_of_xlate,
 };
 
 #endif /* CONFIG_IOMMU_DMA */
