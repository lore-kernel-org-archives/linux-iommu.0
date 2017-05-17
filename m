From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 06/08] iommu/ipmmu-vmsa: Use fwspec iommu_priv on ARM64
Date: Wed, 17 May 2017 19:07:20 +0900
Message-ID: <149501564036.21593.16964345443958773870.sendpatchset@little-apple>
References: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
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

Convert from archdata to iommu_priv via iommu_fwspec on ARM64 but
let 32-bit ARM keep on using archdata for now.

Once the 32-bit ARM code and the IPMMU driver is able to move over
to CONFIG_IOMMU_DMA=y then coverting to fwspec via ->of_xlate() will
be easy.

For now fwspec ids and num_ids are not used to allow code sharing between
32-bit and 64-bit ARM code inside the driver.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V7:
 - Rewrote code to use iommu_fwspec, thanks Robin!
 - Dropped reviewed-by from Joerg, also skipped tag from Geert

 drivers/iommu/ipmmu-vmsa.c |   97 ++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 39 deletions(-)

--- 0011/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-05-17 16:45:07.510607110 +0900
@@ -56,7 +56,7 @@ struct ipmmu_vmsa_domain {
 	spinlock_t lock;			/* Protects mappings */
 };
 
-struct ipmmu_vmsa_archdata {
+struct ipmmu_vmsa_iommu_priv {
 	struct ipmmu_vmsa_device *mmu;
 	unsigned int *utlbs;
 	unsigned int num_utlbs;
@@ -72,6 +72,24 @@ static struct ipmmu_vmsa_domain *to_vmsa
 	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
 }
 
+
+static struct ipmmu_vmsa_iommu_priv *to_priv(struct device *dev)
+{
+#if defined(CONFIG_ARM)
+	return dev->archdata.iommu;
+#else
+	return dev->iommu_fwspec->iommu_priv;
+#endif
+}
+static void set_priv(struct device *dev, struct ipmmu_vmsa_iommu_priv *p)
+{
+#if defined(CONFIG_ARM)
+	dev->archdata.iommu = p;
+#else
+	dev->iommu_fwspec->iommu_priv = p;
+#endif
+}
+
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
 
 /* -----------------------------------------------------------------------------
@@ -543,8 +561,8 @@ static void ipmmu_domain_free(struct iom
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
-	struct ipmmu_vmsa_device *mmu = archdata->mmu;
+	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
+	struct ipmmu_vmsa_device *mmu = priv->mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
 	unsigned int i;
@@ -577,8 +595,8 @@ static int ipmmu_attach_device(struct io
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < archdata->num_utlbs; ++i)
-		ipmmu_utlb_enable(domain, archdata->utlbs[i]);
+	for (i = 0; i < priv->num_utlbs; ++i)
+		ipmmu_utlb_enable(domain, priv->utlbs[i]);
 
 	return 0;
 }
@@ -586,12 +604,12 @@ static int ipmmu_attach_device(struct io
 static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;
 
-	for (i = 0; i < archdata->num_utlbs; ++i)
-		ipmmu_utlb_disable(domain, archdata->utlbs[i]);
+	for (i = 0; i < priv->num_utlbs; ++i)
+		ipmmu_utlb_disable(domain, priv->utlbs[i]);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -654,7 +672,7 @@ static int ipmmu_find_utlbs(struct ipmmu
 
 static int ipmmu_init_platform_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata;
+	struct ipmmu_vmsa_iommu_priv *priv;
 	struct ipmmu_vmsa_device *mmu;
 	unsigned int *utlbs;
 	unsigned int i;
@@ -697,17 +715,17 @@ static int ipmmu_init_platform_device(st
 		}
 	}
 
-	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
-	if (!archdata) {
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	archdata->mmu = mmu;
-	archdata->utlbs = utlbs;
-	archdata->num_utlbs = num_utlbs;
-	archdata->dev = dev;
-	dev->archdata.iommu = archdata;
+	priv->mmu = mmu;
+	priv->utlbs = utlbs;
+	priv->num_utlbs = num_utlbs;
+	priv->dev = dev;
+	set_priv(dev, priv);
 	return 0;
 
 error:
@@ -727,12 +745,11 @@ static struct iommu_domain *ipmmu_domain
 
 static int ipmmu_add_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata;
 	struct ipmmu_vmsa_device *mmu = NULL;
 	struct iommu_group *group;
 	int ret;
 
-	if (dev->archdata.iommu) {
+	if (to_priv(dev)) {
 		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
 			 dev_name(dev));
 		return -EINVAL;
@@ -768,8 +785,7 @@ static int ipmmu_add_device(struct devic
 	 * - Make the mapping size configurable ? We currently use a 2GB mapping
 	 *   at a 1GB offset to ensure that NULL VAs will fault.
 	 */
-	archdata = dev->archdata.iommu;
-	mmu = archdata->mmu;
+	mmu = to_priv(dev)->mmu;
 	if (!mmu->mapping) {
 		struct dma_iommu_mapping *mapping;
 
@@ -800,24 +816,24 @@ error:
 	if (!IS_ERR_OR_NULL(group))
 		iommu_group_remove_device(dev);
 
-	kfree(archdata->utlbs);
-	kfree(archdata);
-	dev->archdata.iommu = NULL;
+	kfree(to_priv(dev)->utlbs);
+	kfree(to_priv(dev));
+	set_priv(dev, NULL);
 
 	return ret;
 }
 
 static void ipmmu_remove_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
 
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
 
-	kfree(archdata->utlbs);
-	kfree(archdata);
+	kfree(priv->utlbs);
+	kfree(priv);
 
-	dev->archdata.iommu = NULL;
+	set_priv(dev, NULL);
 }
 
 static const struct iommu_ops ipmmu_ops = {
@@ -874,11 +890,14 @@ static void ipmmu_domain_free_dma(struct
 
 static int ipmmu_add_device_dma(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct iommu_group *group;
 
-	/* The device has been verified in xlate() */
-	if (!archdata)
+	/*
+	 * Only let through devices that have been verified in xlate()
+	 * We may get called with dev->iommu_fwspec set to NULL.
+	 */
+	if (!fwspec || !fwspec->iommu_priv)
 		return -ENODEV;
 
 	group = iommu_group_get_for_dev(dev);
@@ -886,17 +905,17 @@ static int ipmmu_add_device_dma(struct d
 		return PTR_ERR(group);
 
 	spin_lock(&ipmmu_slave_devices_lock);
-	list_add(&archdata->list, &ipmmu_slave_devices);
+	list_add(&to_priv(dev)->list, &ipmmu_slave_devices);
 	spin_unlock(&ipmmu_slave_devices_lock);
 	return 0;
 }
 
 static void ipmmu_remove_device_dma(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
 
 	spin_lock(&ipmmu_slave_devices_lock);
-	list_del(&archdata->list);
+	list_del(&priv->list);
 	spin_unlock(&ipmmu_slave_devices_lock);
 
 	iommu_group_remove_device(dev);
@@ -904,16 +923,16 @@ static void ipmmu_remove_device_dma(stru
 
 static struct device *ipmmu_find_sibling_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
-	struct ipmmu_vmsa_archdata *sibling_archdata = NULL;
+	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
+	struct ipmmu_vmsa_iommu_priv *sibling_priv = NULL;
 	bool found = false;
 
 	spin_lock(&ipmmu_slave_devices_lock);
 
-	list_for_each_entry(sibling_archdata, &ipmmu_slave_devices, list) {
-		if (archdata == sibling_archdata)
+	list_for_each_entry(sibling_priv, &ipmmu_slave_devices, list) {
+		if (priv == sibling_priv)
 			continue;
-		if (sibling_archdata->mmu == archdata->mmu) {
+		if (sibling_priv->mmu == priv->mmu) {
 			found = true;
 			break;
 		}
@@ -921,7 +940,7 @@ static struct device *ipmmu_find_sibling
 
 	spin_unlock(&ipmmu_slave_devices_lock);
 
-	return found ? sibling_archdata->dev : NULL;
+	return found ? sibling_priv->dev : NULL;
 }
 
 static struct iommu_group *ipmmu_find_group_dma(struct device *dev)
