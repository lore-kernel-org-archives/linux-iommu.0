From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 00/04] iommu/ipmmu-vmsa: 32-bit ARM update
Date: Mon, 19 Jun 2017 17:23:20 +0100
Message-ID: <96ccaaf2-0fca-fb15-7f1b-86e69ba995fb@arm.com>
References: <149752254550.21887.15183665699230243235.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <149752254550.21887.15183665699230243235.sendpatchset@little-apple>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>, joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, sricharan@codeaurora.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On 15/06/17 11:29, Magnus Damm wrote:
> iommu/ipmmu-vmsa: 32-bit ARM update
> 
> [PATCH 01/04] iommu/ipmmu-vmsa: Use iommu_device_register()/unregister()
> [PATCH 02/04] iommu/ipmmu-vmsa: Consistent ->of_xlate() handling
> [PATCH 03/04] iommu/ipmmu-vmsa: Use fwspec on both 32 and 64-bit ARM
> [PATCH 04/04] iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids
> 
> This series updates the IPMMU driver to make use of recent IOMMU framework
> changes and also improves code sharing in the driver between the 32-bit and
> 64-bit dma-mapping architecture glue code.

Nice! I did try rebasing my original patch myself but it quickly got
very messy. I also had the below beforehand as preliminary cleanup for
getting rid of the ipmmu_vmsa_iommu_priv structure altogether (i.e. so
fwspec->priv can just hold the ipmmu_vmsa_device pointer directly) - if
it does actually work as intended, feel free to take it ;)

Thanks,
Robin.

> Suggested-by: Robin Murphy <robin.murphy@arm.com> (Patch 2 and 4)
> Signed-off-by: Robin Murphy <robin.murphy@arm.com> (Patch 3)
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Developed on renesas-drivers-2017-06-13-v4.12-rc5 and rebased to next-20170614
> 
>  drivers/iommu/ipmmu-vmsa.c |  186 +++++++++++---------------------------------
>  1 file changed, 49 insertions(+), 137 deletions(-)
> 

---->8-----
From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/ipmmu-vmsa: Clean up group allocation

With the new IOMMU group support, we go through quite the merry dance
in order to find masters behind the same IPMMU instance, so that we can
ensure they are grouped together. None of which is really necessary,
since the master's private data already points to the particular IPMMU
it is associated with, and that IPMMU instance data is the perfect place
to keep track of a per-instance group.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/ipmmu-vmsa.c | 53
+++++++---------------------------------------
 1 file changed, 8 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 2a38aa15be17..9d75d7553e20 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -43,6 +43,7 @@ struct ipmmu_vmsa_device {
 	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];

 	struct dma_iommu_mapping *mapping;
+	struct iommu_group *group;
 };

 struct ipmmu_vmsa_domain {
@@ -60,8 +61,6 @@ struct ipmmu_vmsa_iommu_priv {
 	struct ipmmu_vmsa_device *mmu;
 	unsigned int *utlbs;
 	unsigned int num_utlbs;
-	struct device *dev;
-	struct list_head list;
 };

 static DEFINE_SPINLOCK(ipmmu_devices_lock);
@@ -724,7 +723,6 @@ static int ipmmu_init_platform_device(struct device
*dev)
 	priv->mmu = mmu;
 	priv->utlbs = utlbs;
 	priv->num_utlbs = num_utlbs;
-	priv->dev = dev;
 	set_priv(dev, priv);
 	return 0;

@@ -854,9 +852,6 @@ static const struct iommu_ops ipmmu_ops = {

 #ifdef CONFIG_IOMMU_DMA

-static DEFINE_SPINLOCK(ipmmu_slave_devices_lock);
-static LIST_HEAD(ipmmu_slave_devices);
-
 static struct iommu_domain *ipmmu_domain_alloc_dma(unsigned type)
 {
 	struct iommu_domain *io_domain = NULL;
@@ -904,57 +899,25 @@ static int ipmmu_add_device_dma(struct device *dev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);

-	spin_lock(&ipmmu_slave_devices_lock);
-	list_add(&to_priv(dev)->list, &ipmmu_slave_devices);
-	spin_unlock(&ipmmu_slave_devices_lock);
 	return 0;
 }

 static void ipmmu_remove_device_dma(struct device *dev)
 {
-	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
-
-	spin_lock(&ipmmu_slave_devices_lock);
-	list_del(&priv->list);
-	spin_unlock(&ipmmu_slave_devices_lock);
-
 	iommu_group_remove_device(dev);
 }

-static struct device *ipmmu_find_sibling_device(struct device *dev)
-{
-	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
-	struct ipmmu_vmsa_iommu_priv *sibling_priv = NULL;
-	bool found = false;
-
-	spin_lock(&ipmmu_slave_devices_lock);
-
-	list_for_each_entry(sibling_priv, &ipmmu_slave_devices, list) {
-		if (priv == sibling_priv)
-			continue;
-		if (sibling_priv->mmu == priv->mmu) {
-			found = true;
-			break;
-		}
-	}
-
-	spin_unlock(&ipmmu_slave_devices_lock);
-
-	return found ? sibling_priv->dev : NULL;
-}
-
 static struct iommu_group *ipmmu_find_group_dma(struct device *dev)
 {
-	struct iommu_group *group;
-	struct device *sibling;
+	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
+	struct ipmmu_vmsa_device *mmu = priv->mmu;

-	sibling = ipmmu_find_sibling_device(dev);
-	if (sibling)
-		group = iommu_group_get(sibling);
-	if (!sibling || IS_ERR(group))
-		group = generic_device_group(dev);
+	if (mmu->group)
+		return iommu_group_ref_get(mmu->group);

-	return group;
+	mmu->group = generic_device_group(dev);
+
+	return mmu->group;
 }

 static int ipmmu_of_xlate_dma(struct device *dev,
