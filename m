From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v6 08/20] driver core: platform: add device binding path
	'driver_override'
Date: Thu,  5 Jun 2014 19:03:16 +0200
Message-ID: <1401987808-23596-9-git-send-email-a.motakis@virtualopensystems.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1401987808-23596-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DOCUMENTATION" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

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

Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Reviewed-by: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
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
+Contact:	Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
1.8.3.2
