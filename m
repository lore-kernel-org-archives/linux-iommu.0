Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B8EC433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 00:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B578784060;
	Fri, 18 Feb 2022 00:58:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l_RUrrW2muY1; Fri, 18 Feb 2022 00:58:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E5528405C;
	Fri, 18 Feb 2022 00:58:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F240C002D;
	Fri, 18 Feb 2022 00:58:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB2BCC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC46084060
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iFYjBtbDBjHL for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 00:58:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3DD68405E
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645145886; x=1676681886;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oUncDBL+5vMy4n8DugjyhG+MWYfr+VE0+QodZOTRghw=;
 b=VUX59LDUxfOI5ezVNe2lZUTbOJ4MBRrDZKBAyR5MpqoJ78VRpMc1Czeu
 QLI8bUNSfuVYZcb2gglC/hW6iTTRFlLNGTsDmOBd7QOqXbdQVpqnWsujD
 XrWEbk0x+6bJkXeGqBQT+0LtL6MV/ctk+YGeCiAKoDpFPEetUCj0iymzu
 1ZjU+a5Okdp1q4nuebQpUW63yTiHDryEYvRby0MWc/LEwDP+egO1FAKLg
 6/n7ZdvhWu+7Alt32LpmrgE2KJMTZKUEL5gkj4qv4Hi9SA0MFvSQny1+z
 VewHw5WcJ/WN7yNbsWQ9tgKf3pCrmR3vSvJcylbDIuNTiXRQwnof48uU5 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248612840"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="248612840"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 16:57:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="637490930"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 16:57:16 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v6 04/11] bus: platform, amba, fsl-mc,
 PCI: Add device DMA ownership management
Date: Fri, 18 Feb 2022 08:55:14 +0800
Message-Id: <20220218005521.172832-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218005521.172832-1-baolu.lu@linux.intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

The devices on platform/amba/fsl-mc/PCI buses could be bound to drivers
with the device DMA managed by kernel drivers or user-space applications.
Unfortunately, multiple devices may be placed in the same IOMMU group
because they cannot be isolated from each other. The DMA on these devices
must either be entirely under kernel control or userspace control, never
a mixture. Otherwise the driver integrity is not guaranteed because they
could access each other through the peer-to-peer accesses which by-pass
the IOMMU protection.

This checks and sets the default DMA mode during driver binding, and
cleanups during driver unbinding. In the default mode, the device DMA is
managed by the device driver which handles DMA operations through the
kernel DMA APIs (see Documentation/core-api/dma-api.rst).

For cases where the devices are assigned for userspace control through the
userspace driver framework(i.e. VFIO), the drivers(for example, vfio_pci/
vfio_platfrom etc.) may set a new flag (driver_managed_dma) to skip this
default setting in the assumption that the drivers know what they are
doing with the device DMA.

With the IOMMU layer knowing DMA ownership of each device, above problem
can be solved.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/amba/bus.h        |  8 ++++++++
 include/linux/fsl/mc.h          |  8 ++++++++
 include/linux/pci.h             |  8 ++++++++
 include/linux/platform_device.h |  8 ++++++++
 drivers/amba/bus.c              | 20 ++++++++++++++++++++
 drivers/base/platform.c         | 20 ++++++++++++++++++++
 drivers/bus/fsl-mc/fsl-mc-bus.c | 26 ++++++++++++++++++++++++--
 drivers/pci/pci-driver.c        | 21 +++++++++++++++++++++
 8 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 6c7f47846971..e9cd981be94e 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -79,6 +79,14 @@ struct amba_driver {
 	void			(*remove)(struct amba_device *);
 	void			(*shutdown)(struct amba_device *);
 	const struct amba_id	*id_table;
+	/*
+	 * For most device drivers, no need to care about this flag as long as
+	 * all DMAs are handled through the kernel DMA API. For some special
+	 * ones, for example VFIO drivers, they know how to manage the DMA
+	 * themselves and set this flag so that the IOMMU layer will allow them
+	 * to setup and manage their own I/O address space.
+	 */
+	bool driver_managed_dma;
 };
 
 /*
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 7b6c42bfb660..27efef8affb1 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -32,6 +32,13 @@ struct fsl_mc_io;
  * @shutdown: Function called at shutdown time to quiesce the device
  * @suspend: Function called when a device is stopped
  * @resume: Function called when a device is resumed
+ * @driver_managed_dma: Device driver doesn't use kernel DMA API for DMA.
+ *		For most device drivers, no need to care about this flag
+ *		as long as all DMAs are handled through the kernel DMA API.
+ *		For some special ones, for example VFIO drivers, they know
+ *		how to manage the DMA themselves and set this flag so that
+ *		the IOMMU layer will allow them to setup and manage their
+ *		own I/O address space.
  *
  * Generic DPAA device driver object for device drivers that are registered
  * with a DPRC bus. This structure is to be embedded in each device-specific
@@ -45,6 +52,7 @@ struct fsl_mc_driver {
 	void (*shutdown)(struct fsl_mc_device *dev);
 	int (*suspend)(struct fsl_mc_device *dev, pm_message_t state);
 	int (*resume)(struct fsl_mc_device *dev);
+	bool driver_managed_dma;
 };
 
 #define to_fsl_mc_driver(_drv) \
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8253a5413d7c..b94bce839b83 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -894,6 +894,13 @@ struct module;
  *              created once it is bound to the driver.
  * @driver:	Driver model structure.
  * @dynids:	List of dynamically added device IDs.
+ * @driver_managed_dma: Device driver doesn't use kernel DMA API for DMA.
+ *		For most device drivers, no need to care about this flag
+ *		as long as all DMAs are handled through the kernel DMA API.
+ *		For some special ones, for example VFIO drivers, they know
+ *		how to manage the DMA themselves and set this flag so that
+ *		the IOMMU layer will allow them to setup and manage their
+ *		own I/O address space.
  */
 struct pci_driver {
 	struct list_head	node;
@@ -912,6 +919,7 @@ struct pci_driver {
 	const struct attribute_group **dev_groups;
 	struct device_driver	driver;
 	struct pci_dynids	dynids;
+	bool driver_managed_dma;
 };
 
 static inline struct pci_driver *to_pci_driver(struct device_driver *drv)
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 17fde717df68..b3d9c744f1e5 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -210,6 +210,14 @@ struct platform_driver {
 	struct device_driver driver;
 	const struct platform_device_id *id_table;
 	bool prevent_deferred_probe;
+	/*
+	 * For most device drivers, no need to care about this flag as long as
+	 * all DMAs are handled through the kernel DMA API. For some special
+	 * ones, for example VFIO drivers, they know how to manage the DMA
+	 * themselves and set this flag so that the IOMMU layer will allow them
+	 * to setup and manage their own I/O address space.
+	 */
+	bool driver_managed_dma;
 };
 
 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 8392f4aa251b..cebf03522524 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -22,6 +22,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/iommu.h>
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
@@ -277,9 +278,16 @@ static void amba_shutdown(struct device *dev)
 
 static int amba_dma_configure(struct device *dev)
 {
+	struct amba_driver *drv = to_amba_driver(dev->driver);
 	enum dev_dma_attr attr;
 	int ret = 0;
 
+	if (!drv->driver_managed_dma) {
+		ret = iommu_device_use_default_domain(dev);
+		if (ret)
+			return ret;
+	}
+
 	if (dev->of_node) {
 		ret = of_dma_configure(dev, dev->of_node, true);
 	} else if (has_acpi_companion(dev)) {
@@ -287,9 +295,20 @@ static int amba_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, attr);
 	}
 
+	if (ret && !drv->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
+
 	return ret;
 }
 
+static void amba_dma_cleanup(struct device *dev)
+{
+	struct amba_driver *drv = to_amba_driver(dev->driver);
+
+	if (!drv->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
+}
+
 #ifdef CONFIG_PM
 /*
  * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
@@ -359,6 +378,7 @@ struct bus_type amba_bustype = {
 	.remove		= amba_remove,
 	.shutdown	= amba_shutdown,
 	.dma_configure	= amba_dma_configure,
+	.dma_cleanup	= amba_dma_cleanup,
 	.pm		= &amba_pm,
 };
 EXPORT_SYMBOL_GPL(amba_bustype);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index acbc6eae37b8..ad8ea9453cdb 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -30,6 +30,7 @@
 #include <linux/property.h>
 #include <linux/kmemleak.h>
 #include <linux/types.h>
+#include <linux/iommu.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -1456,9 +1457,16 @@ static void platform_shutdown(struct device *_dev)
 
 static int platform_dma_configure(struct device *dev)
 {
+	struct platform_driver *drv = to_platform_driver(dev->driver);
 	enum dev_dma_attr attr;
 	int ret = 0;
 
+	if (!drv->driver_managed_dma) {
+		ret = iommu_device_use_default_domain(dev);
+		if (ret)
+			return ret;
+	}
+
 	if (dev->of_node) {
 		ret = of_dma_configure(dev, dev->of_node, true);
 	} else if (has_acpi_companion(dev)) {
@@ -1466,9 +1474,20 @@ static int platform_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, attr);
 	}
 
+	if (ret && !drv->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
+
 	return ret;
 }
 
+static void platform_dma_cleanup(struct device *dev)
+{
+	struct platform_driver *drv = to_platform_driver(dev->driver);
+
+	if (!drv->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
+}
+
 static const struct dev_pm_ops platform_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend, pm_generic_runtime_resume, NULL)
 	USE_PLATFORM_PM_SLEEP_OPS
@@ -1483,6 +1502,7 @@ struct bus_type platform_bus_type = {
 	.remove		= platform_remove,
 	.shutdown	= platform_shutdown,
 	.dma_configure	= platform_dma_configure,
+	.dma_cleanup	= platform_dma_cleanup,
 	.pm		= &platform_dev_pm_ops,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..eca3406a14ce 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -140,15 +140,36 @@ static int fsl_mc_dma_configure(struct device *dev)
 {
 	struct device *dma_dev = dev;
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(dev->driver);
 	u32 input_id = mc_dev->icid;
+	int ret;
+
+	if (!mc_drv->driver_managed_dma) {
+		ret = iommu_device_use_default_domain(dev);
+		if (ret)
+			return ret;
+	}
 
 	while (dev_is_fsl_mc(dma_dev))
 		dma_dev = dma_dev->parent;
 
 	if (dev_of_node(dma_dev))
-		return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
+		ret = of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
+	else
+		ret = acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
+
+	if (ret && !mc_drv->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
+
+	return ret;
+}
+
+static void fsl_mc_dma_cleanup(struct device *dev)
+{
+	struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(dev->driver);
 
-	return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
+	if (!mc_drv->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
 }
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
@@ -312,6 +333,7 @@ struct bus_type fsl_mc_bus_type = {
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
 	.dma_configure  = fsl_mc_dma_configure,
+	.dma_cleanup = fsl_mc_dma_cleanup,
 	.dev_groups = fsl_mc_dev_groups,
 	.bus_groups = fsl_mc_bus_groups,
 };
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 588588cfda48..893a8707c179 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
+#include <linux/iommu.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -1590,9 +1591,16 @@ static int pci_bus_num_vf(struct device *dev)
  */
 static int pci_dma_configure(struct device *dev)
 {
+	struct pci_driver *driver = to_pci_driver(dev->driver);
 	struct device *bridge;
 	int ret = 0;
 
+	if (!driver->driver_managed_dma) {
+		ret = iommu_device_use_default_domain(dev);
+		if (ret)
+			return ret;
+	}
+
 	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
@@ -1605,9 +1613,21 @@ static int pci_dma_configure(struct device *dev)
 	}
 
 	pci_put_host_bridge_device(bridge);
+
+	if (ret && !driver->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
+
 	return ret;
 }
 
+static void pci_dma_cleanup(struct device *dev)
+{
+	struct pci_driver *driver = to_pci_driver(dev->driver);
+
+	if (!driver->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
+}
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
@@ -1621,6 +1641,7 @@ struct bus_type pci_bus_type = {
 	.pm		= PCI_PM_OPS_PTR,
 	.num_vf		= pci_bus_num_vf,
 	.dma_configure	= pci_dma_configure,
+	.dma_cleanup	= pci_dma_cleanup,
 };
 EXPORT_SYMBOL(pci_bus_type);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
