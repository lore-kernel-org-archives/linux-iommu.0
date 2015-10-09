From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Fri, 09 Oct 2015 12:41:10 -0600
Message-ID: <20151009184110.14752.53531.stgit@gimli.home>
References: <20151009182228.14752.99700.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151009182228.14752.99700.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, avi-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bruce.richardson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gleb-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org, vladz-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

There is really no way to safely give a user full access to a PCI
without an IOMMU to protect the host from errant DMA.  There is also
no way to provide DMA translation, for use cases such as devices
assignment to virtual machines.  However, there are still those users
that want userspace drivers under those conditions.  The UIO driver
exists for this use case, but does not provide the degree of device
access and programming that VFIO has.  In an effort to avoid code
duplication, this introduces a No-IOMMU mode for VFIO.

This mode requires enabling CONFIG_VFIO_NOIOMMU and loading the vfio
module with the option "enable_unsafe_pci_noiommu_mode".  This should
make it very clear that this mode is not safe.  In this mode, there is
no support for unprivileged users, CAP_SYS_ADMIN is required for
access to the necessary dev files.  Mixing no-iommu and secure VFIO is
also unsupported, as are any VFIO IOMMU backends other than the
vfio-noiommu backend.  Furthermore, unsafe group files are relocated
to /dev/vfio-noiommu/.  Upon successful loading in this mode, the
kernel is tainted due to the dummy IOMMU put in place.  Unloading of
the module in this mode is also unsupported and will BUG due to the
lack of support for unregistering an IOMMU for a bus type.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/vfio/Kconfig        |   15 +++
 drivers/vfio/Makefile       |    3 +
 drivers/vfio/vfio_core.c    |   40 +++++++++
 drivers/vfio/vfio_noiommu.c |  185 +++++++++++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_private.h |   31 +++++++
 include/uapi/linux/vfio.h   |    2 
 6 files changed, 276 insertions(+)
 create mode 100644 drivers/vfio/vfio_noiommu.c
 create mode 100644 drivers/vfio/vfio_private.h

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index 4540179..929de0d 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -31,5 +31,20 @@ menuconfig VFIO
 
 	  If you don't know what to do here, say N.
 
+menuconfig VFIO_NOIOMMU
+	bool "VFIO No IOMMU support"
+	depends on VFIO
+	help
+	  VFIO is built on the ability to isolate devices using the IOMMU.
+	  Only with an IOMMU can userspace access to DMA capable devices be
+	  considered secure.  VFIO No IOMMU support enables a dummy IOMMU
+	  for the purpose of re-using the VFIO infrastructure in a non-secure
+	  mode.  Use of this mode will result in an unsupportable kernel and
+	  will therefore taint the kernel.  Device assignment to virtual
+	  machines is also not possible with this mode since the dummy IOMMU
+	  cannot provide DMA translation.
+
+	  If you don't know what to do here, say N.
+
 source "drivers/vfio/pci/Kconfig"
 source "drivers/vfio/platform/Kconfig"
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index e8fa248..9736449 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -1,5 +1,8 @@
 vfio_virqfd-y := virqfd.o
 vfio-y := vfio_core.o
+ifdef CONFIG_VFIO_NOIOMMU
+vfio-y += vfio_noiommu.o
+endif
 
 obj-$(CONFIG_VFIO) += vfio.o
 obj-$(CONFIG_VFIO_VIRQFD) += vfio_virqfd.o
diff --git a/drivers/vfio/vfio_core.c b/drivers/vfio/vfio_core.c
index 563c510..495a490 100644
--- a/drivers/vfio/vfio_core.c
+++ b/drivers/vfio/vfio_core.c
@@ -34,10 +34,18 @@
 #include <linux/vfio.h>
 #include <linux/wait.h>
 
+#include "vfio_private.h"
+
 #define DRIVER_VERSION	"0.3"
 #define DRIVER_AUTHOR	"Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
 #define DRIVER_DESC	"VFIO - User Level meta-driver"
 
+static bool pci_noiommu __read_mostly;
+#ifdef CONFIG_VFIO_NOIOMMU
+module_param_named(enable_unsafe_pci_noiommu_mode, pci_noiommu, bool, S_IRUGO);
+MODULE_PARM_DESC(enable_unsafe_pci_noiommu_mode, "Enable UNSAFE, no-IOMMU mode for PCI.  This mode provides no device isolation, no DMA translation, no host kernel protection, cannot be used for device assignment to virtual machines, requires root permissions, and will taint the kernel.  If you do not know what this is for, step away. (default: false)");
+#endif
+
 static struct vfio {
 	struct class			*class;
 	struct list_head		iommu_drivers_list;
@@ -101,6 +109,9 @@ int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops)
 {
 	struct vfio_iommu_driver *driver, *tmp;
 
+	if (pci_noiommu && strcmp(ops->name, "vfio-noiommu"))
+		return -EPERM;
+
 	driver = kzalloc(sizeof(*driver), GFP_KERNEL);
 	if (!driver)
 		return -ENOMEM;
@@ -998,6 +1009,9 @@ static int vfio_fops_open(struct inode *inode, struct file *filep)
 {
 	struct vfio_container *container;
 
+	if (pci_noiommu && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	container = kzalloc(sizeof(*container), GFP_KERNEL);
 	if (!container)
 		return -ENOMEM;
@@ -1221,6 +1235,9 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
 	    !group->container->iommu_driver || !vfio_group_viable(group))
 		return -EINVAL;
 
+	if (pci_noiommu && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	device = vfio_device_get_from_name(group, buf);
 	if (!device)
 		return -ENODEV;
@@ -1347,6 +1364,9 @@ static int vfio_group_fops_open(struct inode *inode, struct file *filep)
 	struct vfio_group *group;
 	int opened;
 
+	if (pci_noiommu && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	group = vfio_group_get_from_minor(iminor(inode));
 	if (!group)
 		return -ENODEV;
@@ -1507,6 +1527,9 @@ struct vfio_group *vfio_group_get_external_user(struct file *filep)
 {
 	struct vfio_group *group = filep->private_data;
 
+	if (pci_noiommu)
+		return ERR_PTR(-EPERM);
+
 	if (filep->f_op != &vfio_group_fops)
 		return ERR_PTR(-EINVAL);
 
@@ -1549,6 +1572,9 @@ EXPORT_SYMBOL_GPL(vfio_external_check_extension);
  */
 static char *vfio_devnode(struct device *dev, umode_t *mode)
 {
+	if (pci_noiommu)
+		return kasprintf(GFP_KERNEL, "vfio-noiommu/%s", dev_name(dev));
+
 	return kasprintf(GFP_KERNEL, "vfio/%s", dev_name(dev));
 }
 
@@ -1564,6 +1590,12 @@ static int __init vfio_init(void)
 {
 	int ret;
 
+	if (pci_noiommu) {
+		ret = vfio_noiommu_iommu_init(&pci_bus_type);
+		if (ret)
+			return ret;
+	}
+
 	idr_init(&vfio.group_idr);
 	mutex_init(&vfio.group_lock);
 	mutex_init(&vfio.iommu_drivers_lock);
@@ -1605,6 +1637,9 @@ static int __init vfio_init(void)
 	request_module_nowait("vfio_iommu_type1");
 	request_module_nowait("vfio_iommu_spapr_tce");
 
+	if (pci_noiommu)
+		vfio_noiommu_init();
+
 	return 0;
 
 err_cdev_add:
@@ -1621,6 +1656,11 @@ static void __exit vfio_cleanup(void)
 {
 	WARN_ON(!list_empty(&vfio.group_list));
 
+	if (pci_noiommu) {
+		vfio_noiommu_cleanup();
+		vfio_noiommu_iommu_cleanup(&pci_bus_type);
+	}
+
 	idr_destroy(&vfio.group_idr);
 	cdev_del(&vfio.group_cdev);
 	unregister_chrdev_region(vfio.group_devt, MINORMASK);
diff --git a/drivers/vfio/vfio_noiommu.c b/drivers/vfio/vfio_noiommu.c
new file mode 100644
index 0000000..b12bb290
--- /dev/null
+++ b/drivers/vfio/vfio_noiommu.c
@@ -0,0 +1,185 @@
+/*
+ * VFIO - No IOMMU support
+ *
+ * Copyright (C) 2015 Red Hat, Inc.  All rights reserved.
+ *     Author: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/vfio.h>
+
+/*
+ * VFIO is fundamentally built on IOMMU groups but we have a lot of
+ * infrastructure for exposing devices to userspace.  There is no way to
+ * make userspace device access safe without IOMMU protection, but some
+ * users want to do it anyway.  Allow, but make it very, very clear that
+ * there's nothing safe about this.
+ */
+
+struct vfio_noiommu_domain {
+	struct iommu_domain domain;
+	/* mutex to avoid attach/detach race? */
+	struct device *dev;
+};
+
+static struct iommu_domain *vfio_noiommu_domain_alloc(unsigned type)
+{
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	return kzalloc(sizeof(struct vfio_noiommu_domain), GFP_KERNEL);
+}
+
+static void vfio_noiommu_domain_free(struct iommu_domain *domain)
+{
+	kfree(domain);
+}
+
+static int vfio_noiommu_attach_dev(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct vfio_noiommu_domain *vdomain;
+
+	vdomain = container_of(domain, struct vfio_noiommu_domain, domain);
+
+	if (vdomain->dev)
+		return -EBUSY;
+
+	vdomain->dev = dev;
+	return 0;
+}
+
+static void vfio_noiommu_detach_dev(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	struct vfio_noiommu_domain *vdomain;
+
+	vdomain = container_of(domain, struct vfio_noiommu_domain, domain);
+
+	vdomain->dev = NULL;
+}
+
+static int vfio_noiommu_add_device(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_alloc();
+	int ret;
+
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	ret = iommu_group_add_device(group, dev);
+	iommu_group_put(group);
+	return ret;
+}
+
+static void vfio_noiommu_remove_device(struct device *dev)
+{
+	iommu_group_remove_device(dev);
+}
+
+static struct iommu_ops vfio_noiommu = {
+	.domain_alloc = vfio_noiommu_domain_alloc,
+	.domain_free = vfio_noiommu_domain_free,
+	.attach_dev = vfio_noiommu_attach_dev,
+	.detach_dev = vfio_noiommu_detach_dev,
+	.add_device = vfio_noiommu_add_device,
+	.remove_device = vfio_noiommu_remove_device,
+};
+
+int vfio_noiommu_iommu_init(struct bus_type *bus)
+{
+	int ret;
+
+	if (iommu_present(bus)) {
+		pr_warn("IOMMU present on bus %s, "
+			"cannot register vfio-noiommu\n", bus->name);
+		return -EBUSY;
+	}
+
+	ret = bus_set_iommu(bus, &vfio_noiommu);
+	if (!ret) {
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+		pr_warn("vfio-noiommu IOMMU driver registered on bus %s, "
+			"kernel tainted\n", bus->name);
+	}
+
+	return ret;
+}
+
+void vfio_noiommu_iommu_cleanup(struct bus_type *bus)
+{
+	BUG(); /* Unsetting an IOMMU from a bus is not supported */
+}
+
+static void *vfio_noiommu_open(unsigned long arg)
+{
+	if (arg != VFIO_NOIOMMU_IOMMU)
+		return ERR_PTR(-EINVAL);
+	if (!capable(CAP_SYS_ADMIN))
+		return ERR_PTR(-EPERM);
+
+	/* TODO: Should probably at least track pinnings */
+
+	return NULL;
+}
+
+static void vfio_noiommu_release(void *iommu_data)
+{
+	/* TODO: Track stuff an unpin */
+}
+
+static int vfio_noiommu_attach_group(void *iommu_data,
+				     struct iommu_group *iommu_group)
+{
+	return 0;
+}
+
+static void vfio_noiommu_detach_group(void *iommu_data,
+				      struct iommu_group *iommu_group)
+{
+}
+
+static long vfio_noiommu_ioctl(void *iommu_data,
+			       unsigned int cmd, unsigned long arg)
+{
+	if (cmd == VFIO_CHECK_EXTENSION) {
+		switch (arg) {
+		case VFIO_NOIOMMU_IOMMU:
+			return 1;
+		default:
+			return 0;
+		}
+	}
+
+	return -ENOTTY;
+}
+
+static struct vfio_iommu_driver_ops vfio_noiommu_ops = {
+	.name = "vfio-noiommu",
+	.owner = THIS_MODULE,
+	.open = vfio_noiommu_open,
+	.release = vfio_noiommu_release,
+	.ioctl = vfio_noiommu_ioctl,
+	.attach_group = vfio_noiommu_attach_group,
+	.detach_group = vfio_noiommu_detach_group,
+};
+
+int vfio_noiommu_init(void)
+{
+	return vfio_register_iommu_driver(&vfio_noiommu_ops);
+}
+
+void vfio_noiommu_cleanup(void)
+{
+	vfio_unregister_iommu_driver(&vfio_noiommu_ops);
+}
diff --git a/drivers/vfio/vfio_private.h b/drivers/vfio/vfio_private.h
new file mode 100644
index 0000000..6fe073d
--- /dev/null
+++ b/drivers/vfio/vfio_private.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2015 Red Hat, Inc.  All rights reserved
+ * Author: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef VFIO_PRIVATE_H
+#define VFIO_PRIVATE_H
+
+#ifdef CONFIG_VFIO_NOIOMMU
+int vfio_noiommu_iommu_init(struct bus_type *bus);
+void vfio_noiommu_iommu_cleanup(struct bus_type *bus);
+int vfio_noiommu_init(void);
+void vfio_noiommu_cleanup(void);
+#else
+static inline int vfio_noiommu_iommu_init(struct bus_type *bus)
+{
+	return -ENODEV;
+}
+static inline void vfio_noiommu_iommu_cleanup(struct bus_type *bus) { }
+static inline int vfio_noiommu_init(void)
+{
+	return -ENODEV;
+}
+static inline void vfio_noiommu_cleanup(void) { }
+#endif
+#endif /* VFIO_PRIVATE_H */
+
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 9fd7b5d..c221614 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -38,6 +38,8 @@
 
 #define VFIO_SPAPR_TCE_v2_IOMMU		7
 
+#define VFIO_NOIOMMU_IOMMU		8
+
 /*
  * The IOCTL interface is designed for extensibility by embedding the
  * structure length (argsz) and flags into structures passed between
