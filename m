From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 03/05] iommu/ipmmu-vmsa: Use fwspec on both 32 and 64-bit
	ARM
Date: Mon, 17 Jul 2017 22:05:31 +0900
Message-ID: <150029673120.22030.6013637834677159530.sendpatchset@little-apple>
References: <150029669967.22030.8059216113725566341.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <150029669967.22030.8059216113725566341.sendpatchset@little-apple>
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

From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Consolidate the 32-bit and 64-bit code to make use of fwspec instead
of archdata for the 32-bit ARM case.

This is a simplified version of the fwspec handling code from Robin
posted as [PATCH] iommu/ipmmu-vmsa: Convert to iommu_fwspec

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V1:
 - Rebased to apply on top of earlier changes in series

 drivers/iommu/ipmmu-vmsa.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

--- 0004/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-07-17 21:04:54.850607110 +0900
@@ -73,22 +73,9 @@ static struct ipmmu_vmsa_domain *to_vmsa
 	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
 }
 
-
 static struct ipmmu_vmsa_iommu_priv *to_priv(struct device *dev)
 {
-#if defined(CONFIG_ARM)
-	return dev->archdata.iommu;
-#else
-	return dev->iommu_fwspec->iommu_priv;
-#endif
-}
-static void set_priv(struct device *dev, struct ipmmu_vmsa_iommu_priv *p)
-{
-#if defined(CONFIG_ARM)
-	dev->archdata.iommu = p;
-#else
-	dev->iommu_fwspec->iommu_priv = p;
-#endif
+	return dev->iommu_fwspec ? dev->iommu_fwspec->iommu_priv : NULL;
 }
 
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
@@ -726,7 +713,7 @@ static int ipmmu_init_platform_device(st
 	priv->utlbs = utlbs;
 	priv->num_utlbs = num_utlbs;
 	priv->dev = dev;
-	set_priv(dev, priv);
+	dev->iommu_fwspec->iommu_priv = priv;
 	return 0;
 
 error:
@@ -887,14 +874,12 @@ static void ipmmu_domain_free_dma(struct
 
 static int ipmmu_add_device_dma(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct iommu_group *group;
 
 	/*
 	 * Only let through devices that have been verified in xlate()
-	 * We may get called with dev->iommu_fwspec set to NULL.
 	 */
-	if (!fwspec || !fwspec->iommu_priv)
+	if (!to_priv(dev))
 		return -ENODEV;
 
 	group = iommu_group_get_for_dev(dev);
