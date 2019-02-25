From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Check identity map for hot-added devices
Date: Mon, 25 Feb 2019 10:46:36 +0800
Message-ID: <20190225024636.32418-1-baolu.lu@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: joro@8bytes.org, dwmw2@infradead.org
Cc: ashok.raj@intel.com, jacob.jun.pan@linux.intel.com, jisben@google.com, xmdong@google.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The Intel IOMMU driver will put devices into a static identity
mapped domain during boot if the kernel parameter "iommu=pt" is
used. That means the IOMMU hardware will translate a DMA address
into the same memory address.

Unfortunately, hot-added devices are not subject to this. That
results in some devices not working properly after hot added. A
quick way to reproduce this issue is to boot a system with

    iommu=pt

and, remove then readd the pci device with

    echo 1 > /sys/bus/pci/devices/[pci_source_id]/remove
    echo 1 > /sys/bus/pci/rescan

You will find the identity mapped domain was replaced with a
normal domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: stable@vger.kernel.org
Reported-by: Jis Ben <jisben@google.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: James Dong <xmdong@google.com>
---
 drivers/iommu/intel-iommu.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index af23cfc2a05e..4f77657a9c25 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4564,16 +4564,19 @@ static int device_notifier(struct notifier_block *nb,
 	if (iommu_dummy(dev))
 		return 0;
 
-	if (action != BUS_NOTIFY_REMOVED_DEVICE)
-		return 0;
-
-	domain = find_domain(dev);
-	if (!domain)
-		return 0;
+	if (action == BUS_NOTIFY_REMOVED_DEVICE) {
+		domain = find_domain(dev);
+		if (!domain)
+			return 0;
 
-	dmar_remove_one_dev_info(dev);
-	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
-		domain_exit(domain);
+		dmar_remove_one_dev_info(dev);
+		if (!domain_type_is_vm_or_si(domain) &&
+		    list_empty(&domain->devices))
+			domain_exit(domain);
+	} else if (action == BUS_NOTIFY_ADD_DEVICE) {
+		if (iommu_should_identity_map(dev, 1))
+			domain_add_dev_info(si_domain, dev);
+	}
 
 	return 0;
 }
-- 
2.17.1
