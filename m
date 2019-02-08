From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v1 1/7] iommu: Use dev_printk() when possible
Date: Fri, 08 Feb 2019 16:05:45 -0600
Message-ID: <154966354568.132359.3728108083634257425.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use dev_printk() when possible so the IOMMU messages are more consistent
with other messages related to the device.

E.g., I think these messages related to surprise hotplug:

  pciehp 0000:80:10.0:pcie004: Slot(36): Link Down
  iommu: Removing device 0000:87:00.0 from group 12
  pciehp 0000:80:10.0:pcie004: Slot(36): Card present
  pcieport 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec

would be easier to read as these (also requires some PCI changes not
included here):

  pci 0000:80:10.0: Slot(36): Link Down
  pci 0000:87:00.0: Removing from iommu group 12
  pci 0000:80:10.0: Slot(36): Card present
  pci 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/iommu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3ed4db334341..54c9d18fe31d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -668,7 +668,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	trace_add_device_to_group(group->id, dev);
 
-	pr_info("Adding device %s to group %d\n", dev_name(dev), group->id);
+	dev_info(dev, "Adding to iommu group %d\n", group->id);
 
 	return 0;
 
@@ -684,7 +684,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 err_free_device:
 	kfree(device);
-	pr_err("Failed to add device %s to group %d: %d\n", dev_name(dev), group->id, ret);
+	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
@@ -701,7 +701,7 @@ void iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *tmp_device, *device = NULL;
 
-	pr_info("Removing device %s from group %d\n", dev_name(dev), group->id);
+	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
 	/* Pre-notify listeners that a device is being removed. */
 	blocking_notifier_call_chain(&group->notifier,
@@ -1951,7 +1951,7 @@ int iommu_request_dm_for_dev(struct device *dev)
 		iommu_domain_free(group->default_domain);
 	group->default_domain = dm_domain;
 
-	pr_info("Using direct mapping for device %s\n", dev_name(dev));
+	dev_info(dev, "Using iommu direct mapping\n");
 
 	ret = 0;
 out:
