From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V3 8/8] arm64: dma-mapping: Remove the notifier trick to
	handle early setting of dma_ops
Date: Fri, 7 Oct 2016 21:10:20 +0530
Message-ID: <004201d220b1$20a79700$61f6c500$@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<1475600632-21289-9-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1475600632-21289-9-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: 'Sricharan' <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Sricharan R
>Sent: Tuesday, October 04, 2016 10:34 PM
>To: will.deacon-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
>kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org;
>tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org; srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
>Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
>Subject: [PATCH V3 8/8] arm64: dma-mapping: Remove the notifier trick to handle early setting of dma_ops
>
>With arch_setup_dma_ops now being called late during device's probe after the
>device's iommu is probed, the notifier trick required to handle the early
>setup of dma_ops before the iommu group gets created is not required.
>So removing the notifier's here.
>
>Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>---
> arch/arm64/mm/dma-mapping.c | 100 ++------------------------------------------
> 1 file changed, 3 insertions(+), 97 deletions(-)
>
>diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>index faf4b92..eb593af 100644
>--- a/arch/arm64/mm/dma-mapping.c
>+++ b/arch/arm64/mm/dma-mapping.c
>@@ -799,24 +799,6 @@ static struct dma_map_ops iommu_dma_ops = {
> 	.mapping_error = iommu_dma_mapping_error,
> };
>
>-/*
>- * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
>- * everything it needs to - the device is only partially created and the
>- * IOMMU driver hasn't seen it yet, so it can't have a group. Thus we
>- * need this delayed attachment dance. Once IOMMU probe ordering is sorted
>- * to move the arch_setup_dma_ops() call later, all the notifier bits below
>- * become unnecessary, and will go away.
>- */
>-struct iommu_dma_notifier_data {
>-	struct list_head list;
>-	struct device *dev;
>-	const struct iommu_ops *ops;
>-	u64 dma_base;
>-	u64 size;
>-};
>-static LIST_HEAD(iommu_dma_masters);
>-static DEFINE_MUTEX(iommu_dma_notifier_lock);
>-
> static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
> 			   u64 dma_base, u64 size)
> {
>@@ -837,79 +819,9 @@ static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
> 	return true;
> }
>
>-static void queue_iommu_attach(struct device *dev, const struct iommu_ops *ops,
>-			      u64 dma_base, u64 size)
>-{
>-	struct iommu_dma_notifier_data *iommudata;
>-
>-	iommudata = kzalloc(sizeof(*iommudata), GFP_KERNEL);
>-	if (!iommudata)
>-		return;
>-
>-	iommudata->dev = dev;
>-	iommudata->ops = ops;
>-	iommudata->dma_base = dma_base;
>-	iommudata->size = size;
>-
>-	mutex_lock(&iommu_dma_notifier_lock);
>-	list_add(&iommudata->list, &iommu_dma_masters);
>-	mutex_unlock(&iommu_dma_notifier_lock);
>-}
>-
>-static int __iommu_attach_notifier(struct notifier_block *nb,
>-				   unsigned long action, void *data)
>-{
>-	struct iommu_dma_notifier_data *master, *tmp;
>-
>-	if (action != BUS_NOTIFY_BIND_DRIVER)
>-		return 0;
>-
>-	mutex_lock(&iommu_dma_notifier_lock);
>-	list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
>-		if (data == master->dev && do_iommu_attach(master->dev,
>-				master->ops, master->dma_base, master->size)) {
>-			list_del(&master->list);
>-			kfree(master);
>-			break;
>-		}
>-	}
>-	mutex_unlock(&iommu_dma_notifier_lock);
>-	return 0;
>-}
>-
>-static int __init register_iommu_dma_ops_notifier(struct bus_type *bus)
>-{
>-	struct notifier_block *nb = kzalloc(sizeof(*nb), GFP_KERNEL);
>-	int ret;
>-
>-	if (!nb)
>-		return -ENOMEM;
>-
>-	nb->notifier_call = __iommu_attach_notifier;
>-
>-	ret = bus_register_notifier(bus, nb);
>-	if (ret) {
>-		pr_warn("Failed to register DMA domain notifier; IOMMU DMA ops unavailable on bus '%s'\n",
>-			bus->name);
>-		kfree(nb);
>-	}
>-	return ret;
>-}
>-
> static int __init __iommu_dma_init(void)
> {
>-	int ret;
>-
>-	ret = iommu_dma_init();
>-	if (!ret)
>-		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
>-	if (!ret)
>-		ret = register_iommu_dma_ops_notifier(&amba_bustype);
>-#ifdef CONFIG_PCI
>-	if (!ret)
>-		ret = register_iommu_dma_ops_notifier(&pci_bus_type);
>-#endif
>-	return ret;
>+	return iommu_dma_init();
> }
> arch_initcall(__iommu_dma_init);
>
>@@ -920,18 +832,12 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>
> 	if (!ops)
> 		return;
>-	/*
>-	 * TODO: As a concession to the future, we're ready to handle being
>-	 * called both early and late (i.e. after bus_add_device). Once all
>-	 * the platform bus code is reworked to call us late and the notifier
>-	 * junk above goes away, move the body of do_iommu_attach here.
>-	 */
>+
> 	group = iommu_group_get(dev);
>+
> 	if (group) {
> 		do_iommu_attach(dev, ops, dma_base, size);
> 		iommu_group_put(group);
>-	} else {
>-		queue_iommu_attach(dev, ops, dma_base, size);
> 	}
> }
>
I should have has this as well for being removed,

From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Date: Fri, 7 Oct 2016 19:20:21 +0530
Subject: [PATCH] iommu:/arm-smmu: Avoid early iommu device registration

of_platform_device_create was called early in the init
to have the smmu probed before the master. But now with
the probe deferral, this is not needed.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c841eb7..083489e4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2066,9 +2066,6 @@ static int __init arm_smmu_of_init(struct device_node *np)
 	if (ret)
 		return ret;
 
-	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
-		return -ENODEV;
-
 	return 0;
 }
 IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", arm_smmu_of_init);
-- 
1.8.2.1

Regards,
 Sricharan
