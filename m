Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA808CCA47F
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 14:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 573FF40002;
	Wed,  8 Jun 2022 14:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UslI9R8UoG0W; Wed,  8 Jun 2022 14:26:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 12108408C4;
	Wed,  8 Jun 2022 14:26:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2337C0039;
	Wed,  8 Jun 2022 14:26:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D4EEC002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 14:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ACC360D68
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 14:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LBT8Kg-SsaQd for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:25:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBABD60B1D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 14:25:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9DEC1424;
 Wed,  8 Jun 2022 07:25:56 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4AD03F73B;
 Wed,  8 Jun 2022 07:25:55 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: alex.williamson@redhat.com,
	cohuck@redhat.com
Subject: [PATCH 1/2] vfio/type1: Simplify bus_type determination
Date: Wed,  8 Jun 2022 15:25:49 +0100
Message-Id: <07c69a27fa5bf9724ea8c9fcfe3ff2e8b68f6bf0.1654697988.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, jgg@nvidia.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Since IOMMU groups are mandatory for drivers to support, it stands to
reason that any device which has been successfully be added to a group
must be on a bus supported by that IOMMU driver, and therefore a domain
viable for any device in the group must be viable for all devices in
the group. This already has to be the case for the IOMMU API's internal
default domain, for instance. Thus even if the group contains devices
on different buses, that can only mean that the IOMMU driver actually
supports such an odd topology, and so without loss of generality we can
expect the bus type of any arbitrary device in a group to be suitable
for IOMMU API calls.

Replace vfio_bus_type() with a trivial callback that simply returns any
device from which to then derive a usable bus type. This is also a step
towards removing the vague bus-based interfaces from the IOMMU API.

Furthermore, scrutiny reveals a lack of protection for the bus and/or
device being removed while .attach_group is inspecting them; the
reference we hold on the iommu_group ensures that data remains valid,
but does not prevent the group's membership changing underfoot. Holding
the vfio_goup's device_lock should be sufficient to block any relevant
device's VFIO driver from unregistering, and thus block unbinding and
any further stages of removal for the duration of the attach operation.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

With vfio_group_viable() now gone and no longer taking the vfio_group
device_lock inside the iommu_group mutex, this seems workable, and at
least lockdep is happy.

 drivers/vfio/vfio.c             |  6 ++++++
 drivers/vfio/vfio_iommu_type1.c | 32 ++++++++++++++------------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 61e71c1154be..0b71f3d12e5f 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -760,8 +760,11 @@ static int __vfio_container_attach_groups(struct vfio_container *container,
 	int ret = -ENODEV;
 
 	list_for_each_entry(group, &container->group_list, container_next) {
+		/* Prevent devices unregistering during attach */
+		mutex_lock(&group->device_lock);
 		ret = driver->ops->attach_group(data, group->iommu_group,
 						group->type);
+		mutex_unlock(&group->device_lock);
 		if (ret)
 			goto unwind;
 	}
@@ -1017,9 +1020,12 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 
 	driver = container->iommu_driver;
 	if (driver) {
+		/* Prevent devices unregistering during attach */
+		mutex_lock(&group->device_lock);
 		ret = driver->ops->attach_group(container->iommu_data,
 						group->iommu_group,
 						group->type);
+		mutex_unlock(&group->device_lock);
 		if (ret) {
 			if (group->type == VFIO_IOMMU)
 				iommu_group_release_dma_owner(
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c13b9290e357..5c19faef90ae 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1679,18 +1679,6 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 	return ret;
 }
 
-static int vfio_bus_type(struct device *dev, void *data)
-{
-	struct bus_type **bus = data;
-
-	if (*bus && *bus != dev->bus)
-		return -EINVAL;
-
-	*bus = dev->bus;
-
-	return 0;
-}
-
 static int vfio_iommu_replay(struct vfio_iommu *iommu,
 			     struct vfio_domain *domain)
 {
@@ -2153,13 +2141,20 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
 	list_splice_tail(iova_copy, iova);
 }
 
+static int vfio_first_dev(struct device *dev, void *data)
+{
+	/* Just grab the first device and return nonzero to stop iterating */
+	*(struct device **)data = dev;
+	return 1;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 		struct iommu_group *iommu_group, enum vfio_group_type type)
 {
 	struct vfio_iommu *iommu = iommu_data;
 	struct vfio_iommu_group *group;
 	struct vfio_domain *domain, *d;
-	struct bus_type *bus = NULL;
+	struct device *iommu_api_dev = NULL;
 	bool resv_msi, msi_remap;
 	phys_addr_t resv_msi_base = 0;
 	struct iommu_domain_geometry *geo;
@@ -2192,9 +2187,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_unlock;
 	}
 
-	/* Determine bus_type in order to allocate a domain */
-	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
-	if (ret)
+	/* Resolve the group back to a device for IOMMU API ops */
+	ret = -ENODEV;
+	iommu_group_for_each_dev(iommu_group, &iommu_api_dev, vfio_first_dev);
+	if (!iommu_api_dev)
 		goto out_free_group;
 
 	ret = -ENOMEM;
@@ -2203,7 +2199,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_free_group;
 
 	ret = -EIO;
-	domain->domain = iommu_domain_alloc(bus);
+	domain->domain = iommu_domain_alloc(iommu_api_dev->bus);
 	if (!domain->domain)
 		goto out_free_domain;
 
@@ -2258,7 +2254,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	list_add(&group->next, &domain->group_list);
 
 	msi_remap = irq_domain_check_msi_remap() ||
-		    iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
+		    iommu_capable(iommu_api_dev->bus, IOMMU_CAP_INTR_REMAP);
 
 	if (!allow_unsafe_interrupts && !msi_remap) {
 		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
-- 
2.36.1.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
