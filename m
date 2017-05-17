From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 06/08] iommu/ipmmu-vmsa: Use fwspec iommu_priv on ARM64
Date: Wed, 17 May 2017 15:29:43 +0100
Message-ID: <2c64bcfc-e93b-703a-0326-54b6eef73766@arm.com>
References: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
	<149501564036.21593.16964345443958773870.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149501564036.21593.16964345443958773870.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On 17/05/17 11:07, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Convert from archdata to iommu_priv via iommu_fwspec on ARM64 but
> let 32-bit ARM keep on using archdata for now.
> 
> Once the 32-bit ARM code and the IPMMU driver is able to move over
> to CONFIG_IOMMU_DMA=y then coverting to fwspec via ->of_xlate() will
> be easy.
> 
> For now fwspec ids and num_ids are not used to allow code sharing between
> 32-bit and 64-bit ARM code inside the driver.

That's not what I meant at all - this just looks like a crazy
unmaintainable mess that's making things that much harder to unpick in
future.

Leaving the existing code fossilised and building up half of a second
separate driver around it wrapped in ifdefs is not only hideous, it's
more work in the end than simply pulling things into the right shape to
begin with. What I meant was to start with the below (compile-tested
only), and add the of_xlate support on top. AFAICS the arm/arm64
differences overall should only come down to a bit of special-casing in
add_device(), and (optionally) whether you outright reject
IOMMU_DOMAIN_DMA or not.

Sorry, but I just can't agree with the two-drivers-in-one approach.

Robin.

----->8-----
From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/ipmmu-vmsa: Convert to iommu_fwspec

The parent IPMMU pointer and set of uTLB IDs are, as intended, a perfect
fit for the generic iommu_fwspec. Get rid of the architecture-specific
archdata handling in favour of the common solution.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 68
++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index b7e14ee863f9..96479690269f 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -47,12 +47,6 @@ struct ipmmu_vmsa_domain {
 	spinlock_t lock;			/* Protects mappings */
 };

-struct ipmmu_vmsa_archdata {
-	struct ipmmu_vmsa_device *mmu;
-	unsigned int *utlbs;
-	unsigned int num_utlbs;
-};
-
 static DEFINE_SPINLOCK(ipmmu_devices_lock);
 static LIST_HEAD(ipmmu_devices);

@@ -455,6 +449,8 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
  * IOMMU Operations
  */

+static const struct iommu_ops ipmmu_ops;
+
 static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
 {
 	struct ipmmu_vmsa_domain *domain;
@@ -487,18 +483,20 @@ static void ipmmu_domain_free(struct iommu_domain
*io_domain)
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
-	struct ipmmu_vmsa_device *mmu = archdata->mmu;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct ipmmu_vmsa_device *mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
 	unsigned int i;
 	int ret = 0;

-	if (!mmu) {
+	if (!fwspec || fwspec->ops != &ipmmu_ops) {
 		dev_err(dev, "Cannot attach to IPMMU\n");
 		return -ENXIO;
 	}

+	mmu = fwspec->iommu_priv;
+
 	spin_lock_irqsave(&domain->lock, flags);

 	if (!domain->mmu) {
@@ -520,8 +518,8 @@ static int ipmmu_attach_device(struct iommu_domain
*io_domain,
 	if (ret < 0)
 		return ret;

-	for (i = 0; i < archdata->num_utlbs; ++i)
-		ipmmu_utlb_enable(domain, archdata->utlbs[i]);
+	for (i = 0; i < fwspec->num_ids; ++i)
+		ipmmu_utlb_enable(domain, fwspec->ids[i]);

 	return 0;
 }
@@ -529,12 +527,15 @@ static int ipmmu_attach_device(struct iommu_domain
*io_domain,
 static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;

-	for (i = 0; i < archdata->num_utlbs; ++i)
-		ipmmu_utlb_disable(domain, archdata->utlbs[i]);
+	if (!fwspec || fwspec->ops != &ipmmu_ops)
+		return;
+
+	for (i = 0; i < fwspec->num_ids; ++i)
+		ipmmu_utlb_disable(domain, fwspec->ids[i]);

 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -597,7 +598,6 @@ static int ipmmu_find_utlbs(struct ipmmu_vmsa_device
*mmu, struct device *dev,

 static int ipmmu_add_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata;
 	struct ipmmu_vmsa_device *mmu;
 	struct iommu_group *group = NULL;
 	unsigned int *utlbs;
@@ -605,7 +605,7 @@ static int ipmmu_add_device(struct device *dev)
 	int num_utlbs;
 	int ret = -ENODEV;

-	if (dev->archdata.iommu) {
+	if (dev->iommu_fwspec) {
 		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
 			 dev_name(dev));
 		return -EINVAL;
@@ -638,13 +638,20 @@ static int ipmmu_add_device(struct device *dev)
 	spin_unlock(&ipmmu_devices_lock);

 	if (ret < 0)
-		goto error;
+		return ret;
+
+	ret = iommu_fwspec_init(dev, mmu->dev->fwnode, &ipmmu_ops);
+	if (ret)
+		return ret;
+
+	dev->iommu_fwspec->iommu_priv = mmu;

 	for (i = 0; i < num_utlbs; ++i) {
 		if (utlbs[i] >= mmu->num_utlbs) {
 			ret = -EINVAL;
 			goto error;
 		}
+		iommu_fwspec_add_ids(dev, &utlbs[i], 1);
 	}

 	/* Create a device group and add the device to it. */
@@ -664,17 +671,6 @@ static int ipmmu_add_device(struct device *dev)
 		goto error;
 	}

-	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
-	if (!archdata) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	archdata->mmu = mmu;
-	archdata->utlbs = utlbs;
-	archdata->num_utlbs = num_utlbs;
-	dev->archdata.iommu = archdata;
-
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
 	 * VAs. This will allocate a corresponding IOMMU domain.
@@ -710,28 +706,22 @@ static int ipmmu_add_device(struct device *dev)
 error:
 	arm_iommu_release_mapping(mmu->mapping);

-	kfree(dev->archdata.iommu);
-	kfree(utlbs);
-
-	dev->archdata.iommu = NULL;
-
 	if (!IS_ERR_OR_NULL(group))
 		iommu_group_remove_device(dev);

+	iommu_fwspec_free(dev);
+
 	return ret;
 }

 static void ipmmu_remove_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &ipmmu_ops)
+		return;

 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
-
-	kfree(archdata->utlbs);
-	kfree(archdata);
-
-	dev->archdata.iommu = NULL;
+	iommu_fwspec_free(dev);
 }

 static const struct iommu_ops ipmmu_ops = {
