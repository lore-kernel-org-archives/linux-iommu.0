From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Subject: [RFC PATCH 10/20] VFIO: notify vIOMMU emulator when device is assigned
Date: Wed, 26 Apr 2017 18:06:40 +0800
Message-ID: <1493201210-14357-11-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

With vIOMMU exposed to guest, notify vIOMMU emulator to record information
of this assigned device. This patch adds iommu_ops->record_device to record
the host bus/slot/function for this device. In future, it can be extended to
other info which is needed.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9e13472..a1e6942 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2881,6 +2881,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                                    subregion,
                                    0,
                                    &n1);
+
+            memory_region_notify_device_record(subregion,
+                                               &vdev->host);
+
         }
     }
 
-- 
1.9.1
