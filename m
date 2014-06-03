From: Kim Phillips <kim.phillips@freescale.com>
Subject: [PATCH] driver core: platform: add device binding path
 'driver_override'
Date: Mon, 2 Jun 2014 19:42:58 -0500
Message-ID: <20140602194258.5135925bf3c71b9c010fb409@freescale.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
	<1398700371-20096-2-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1398700371-20096-2-git-send-email-a.motakis@virtualopensystems.com>
Sender: linux-doc-owner@vger.kernel.org
To: a.motakis@virtualopensystems.com
Cc: alex.williamson@redhat.com, kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, jhovold@gmail.com, will.deacon@arm.com, a.rigo@virtualopensystems.com, rob.herring@calxeda.com, stuart.yoder@freescale.com, rob@landley.net, grant.likely@linaro.org, tech@virtualopensystems.com, clbchenlibo.chen@huawei.com, christoffer.dall@linaro.org, eric.auger@linaro.org, Julien Grall <julien.grall@linaro.org>, Ian Campbell <ian.campbell@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Alexander Graf <agraf@suse.de>
List-Id: iommu@lists.linux-foundation.org

Needed by platform device drivers, such as the upcoming
vfio-platform driver, in order to bypass the existing OF, ACPI,
id_table and name string matches, and successfully be able to be
bound to any device, like so:

echo vfio-platform > /sys/bus/platform/devices/fff51000.ethernet/driver_override
echo fff51000.ethernet > /sys/bus/platform/devices/fff51000.ethernet/driver/unbind
echo fff51000.ethernet > /sys/bus/platform/drivers_probe

This mimics "PCI: Introduce new device binding path using
pci_dev.driver_override", which is an interface enhancement
for more deterministic PCI device binding, e.g., when in the
presence of hotplug.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Stuart Yoder <stuart.yoder@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
Greg,

This is largely identical to the PCI version of the same that has
been accepted for v3.16 and ack'd by you:

https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009674.html

and applied to Bjorn Helgaas' PCI tree:

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=782a985d7af26db39e86070d28f987cad21313c0

You are the platform driver core maintainer: can you apply this to
your driver-core tree now?

Thanks,

Kim

changes since previous version (v2 of the v5 vfio-platform driver
series):
- commit text: replaced vfio platform driver reference with
  'upcoming', and removed the PCI version mailing list reference
  since it has now been accepted.
- added Alex W., Alex G., and Stuart's Reviewed-by's.

changes in v2 patch of v5 of this patchseries:
- rebased onto today's Linus' ToT
- added kfree to match PCI counterpart fix, as Alex Williamson
  just posted a v3 of the patch (thanks Christoffer for the
  notification)
- in the commit text, replaced vfio platform driver reference with
  'later in series', and updated the PCI version mailing list reference
  to the v3 version.

 Documentation/ABI/testing/sysfs-bus-platform | 20 ++++++++++++
 drivers/base/platform.c                      | 47 ++++++++++++++++++++++++++++
 include/linux/platform_device.h              |  1 +
 3 files changed, 68 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform

diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI/testing/sysfs-bus-platform
new file mode 100644
index 0000000..5172a61
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-platform
@@ -0,0 +1,20 @@
+What:		/sys/bus/platform/devices/.../driver_override
+Date:		April 2014
+Contact:	Kim Phillips <kim.phillips@freescale.com>
+Description:
+		This file allows the driver for a device to be specified which
+		will override standard OF, ACPI, ID table, and name matching.
+		When specified, only a driver with a name matching the value
+		written to driver_override will have an opportunity to bind
+		to the device.  The override is specified by writing a string
+		to the driver_override file (echo vfio-platform > \
+		driver_override) and may be cleared with an empty string
+		(echo > driver_override).  This returns the device to standard
+		matching rules binding.  Writing to driver_override does not
+		automatically unbind the device from its current driver or make
+		any attempt to automatically load the specified driver.  If no
+		driver with a matching name is currently loaded in the kernel,
+		the device will not bind to any driver.  This also allows
+		devices to opt-out of driver binding using a driver_override
+		name such as "none".  Only a single driver may be specified in
+		the override, there is no support for parsing delimiters.
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 5b47210..4f47563 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -23,6 +23,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/idr.h>
 #include <linux/acpi.h>
+#include <linux/limits.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -188,6 +189,7 @@ static void platform_device_release(struct device *dev)
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
+	kfree(pa->pdev.driver_override);
 	kfree(pa);
 }
 
@@ -695,8 +697,49 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 }
 static DEVICE_ATTR_RO(modalias);
 
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	char *driver_override, *old = pdev->driver_override, *cp;
+
+	if (count > PATH_MAX)
+		return -EINVAL;
+
+	driver_override = kstrndup(buf, count, GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	if (strlen(driver_override)) {
+		pdev->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		pdev->driver_override = NULL;
+	}
+
+	kfree(old);
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return sprintf(buf, "%s\n", pdev->driver_override);
+}
+static DEVICE_ATTR_RW(driver_override);
+
+
 static struct attribute *platform_dev_attrs[] = {
 	&dev_attr_modalias.attr,
+	&dev_attr_driver_override.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(platform_dev);
@@ -752,6 +795,10 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct platform_driver *pdrv = to_platform_driver(drv);
 
+	/* When driver_override is set, only bind to the matching driver */
+	if (pdev->driver_override)
+		return !strcmp(pdev->driver_override, drv->name);
+
 	/* Attempt an OF style match first */
 	if (of_driver_match_device(dev, drv))
 		return 1;
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 16f6654..153d303 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -28,6 +28,7 @@ struct platform_device {
 	struct resource	*resource;
 
 	const struct platform_device_id	*id_entry;
+	char *driver_override; /* Driver name to force a match */
 
 	/* MFD cell pointer */
 	struct mfd_cell *mfd_cell;
-- 
1.9.3

