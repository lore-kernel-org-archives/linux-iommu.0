From: jglisse@redhat.com
Subject: [RFC PATCH 2/5] drivers/base: add a function to test peer to peer capability
Date: Tue, 29 Jan 2019 12:47:25 -0500
Message-ID: <20190129174728.6430-3-jglisse@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129174728.6430-1-jglisse@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Logan Gunthorpe <logang@deltatee.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Jérôme Glisse <jglisse@redhat.com>

device_test_p2p() return true if two devices can peer to peer to
each other. We add a generic function as different inter-connect
can support peer to peer and we want to genericaly test this no
matter what the inter-connect might be. However this version only
support PCIE for now.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org
---
 drivers/base/core.c    | 20 ++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0073b09bb99f..56023b00e108 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -26,6 +26,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/sysfs.h>
+#include <linux/pci-p2pdma.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -3167,3 +3168,22 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 	dev->of_node_reused = true;
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
+
+/**
+ * device_test_p2p - test if two device can peer to peer to each other
+ * @devA: device A
+ * @devB: device B
+ * Returns: true if device can peer to peer to each other, false otherwise
+ */
+bool device_test_p2p(struct device *devA, struct device *devB)
+{
+	/*
+	 * For now we only support PCIE peer to peer but other inter-connect
+	 * can be added.
+	 */
+	if (pci_test_p2p(devA, devB))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(device_test_p2p);
diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..0d532d7f0779 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1250,6 +1250,7 @@ extern int device_online(struct device *dev);
 extern void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 extern void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
+bool device_test_p2p(struct device *devA, struct device *devB);
 
 static inline int dev_num_vf(struct device *dev)
 {
-- 
2.17.2
