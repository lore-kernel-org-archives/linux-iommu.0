From: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v9 5/7] vfio/type1: also check IRQ remapping capability at
	msi domain
Date: Thu, 5 May 2016 19:23:55 +0000
Message-ID: <FFD9D7C5-B6EF-4E16-A209-BED31DAB26AA@caviumnetworks.com>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
	<1462362858-2925-6-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1462362858-2925-6-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Content-ID: <EB805B7A5BA43A46B721DEF2F230AA75-Tk6F3M/euE6cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "eric.auger-qxv4g6HH51o@public.gmane.org" <eric.auger-qxv4g6HH51o@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org" <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: "yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org" <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "julien.grall-5wv7dgnIgG8@public.gmane.org" <julien.grall-5wv7dgnIgG8@public.gmane.org>, "pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org






On 5/4/16, 4:54 AM, "linux-arm-kernel on behalf of Eric Auger" <linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org on behalf of eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

>On x86 IRQ remapping is abstracted by the IOMMU. On ARM this is abstracted
>by the msi controller. vfio_safe_irq_domain allows to check whether
>interrupts are "safe" for a given device. They are if the device does
>not use MSI or if the device uses MSI and the msi-parent controller
>supports IRQ remapping.
>
>Then we check at group level if all devices have safe interrupts: if not,
>we only allow the group to be attached if allow_unsafe_interrupts is set.
>
>At this point ARM sMMU still advertises IOMMU_CAP_INTR_REMAP. This is
>changed in next patch.

Will this work in systems with multiple ITS?
>
>Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
>---
>v3 -> v4:
>- rename vfio_msi_parent_irq_remapping_capable into vfio_safe_irq_domain
>  and irq_remapping into safe_irq_domains
>
>v2 -> v3:
>- protect vfio_msi_parent_irq_remapping_capable with
>  CONFIG_GENERIC_MSI_IRQ_DOMAIN
>---
> drivers/vfio/vfio_iommu_type1.c | 44 +++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 42 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>index 4d3a6f1..2fc8197 100644
>--- a/drivers/vfio/vfio_iommu_type1.c
>+++ b/drivers/vfio/vfio_iommu_type1.c
>@@ -37,6 +37,8 @@
> #include <linux/vfio.h>
> #include <linux/workqueue.h>
> #include <linux/msi-iommu.h>
>+#include <linux/irqdomain.h>
>+#include <linux/msi.h>
> 
> #define DRIVER_VERSION  "0.2"
> #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
>@@ -777,6 +779,33 @@ static int vfio_bus_type(struct device *dev, void *data)
> 	return 0;
> }
> 
>+/**
>+ * vfio_safe_irq_domain: returns whether the irq domain
>+ * the device is attached to is safe with respect to MSI isolation.
>+ * If the irq domain is not an MSI domain, we return it is safe.
>+ *
>+ * @dev: device handle
>+ * @data: unused
>+ * returns 0 if the irq domain is safe, -1 if not.
>+ */
>+static int vfio_safe_irq_domain(struct device *dev, void *data)
>+{
>+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>+	struct irq_domain *domain;
>+	struct msi_domain_info *info;
>+
>+	domain = dev_get_msi_domain(dev);
>+	if (!domain)
>+		return 0;
>+
>+	info = msi_get_domain_info(domain);
>+
>+	if (!(info->flags & MSI_FLAG_IRQ_REMAPPING))
>+		return -1;
>+#endif
>+	return 0;
>+}
>+
> static int vfio_iommu_replay(struct vfio_iommu *iommu,
> 			     struct vfio_domain *domain)
> {
>@@ -870,7 +899,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> 	struct vfio_group *group, *g;
> 	struct vfio_domain *domain, *d;
> 	struct bus_type *bus = NULL;
>-	int ret;
>+	int ret, safe_irq_domains;
> 
> 	mutex_lock(&iommu->lock);
> 
>@@ -893,6 +922,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> 
> 	group->iommu_group = iommu_group;
> 
>+	/*
>+	 * Determine if all the devices of the group have a safe irq domain
>+	 * with respect to MSI isolation
>+	 */
>+	safe_irq_domains = !iommu_group_for_each_dev(iommu_group, &bus,
>+				       vfio_safe_irq_domain);
>+
> 	/* Determine bus_type in order to allocate a domain */
> 	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
> 	if (ret)
>@@ -920,8 +956,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> 	INIT_LIST_HEAD(&domain->group_list);
> 	list_add(&group->next, &domain->group_list);
> 
>+	/*
>+	 * to advertise safe interrupts either the IOMMU or the MSI controllers
>+	 * must support IRQ remapping/interrupt translation
>+	 */
> 	if (!allow_unsafe_interrupts &&
>-	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
>+	    (!iommu_capable(bus, IOMMU_CAP_INTR_REMAP) && !safe_irq_domains)) {
> 		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
> 		       __func__);
> 		ret = -EPERM;
>-- 
>1.9.1
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
