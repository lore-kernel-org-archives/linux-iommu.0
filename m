From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 6/9] iommu/vt-d: Check whether device requires bounce buffer
Date: Tue, 12 Mar 2019 14:00:02 +0800
Message-ID: <20190312060005.12189-7-baolu.lu@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds a helper to check whether a device needs to
use bounce buffer. It also provides a boot time option
to disable the bounce buffer. Users can use this to
prevent the iommu driver from using the bounce buffer
for performance gain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/iommu/intel-iommu.c                     | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..86880eb3fc73 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1726,6 +1726,11 @@
 			Note that using this option lowers the security
 			provided by tboot because it makes the system
 			vulnerable to DMA attacks.
+		nobounce [Default off]
+			Do not use the bounce buffer for untrusted devices like
+			the Thunderbolt devices. This will treat the untrusted
+			devices as the trusted ones, hence might expose security
+			risks of DMA attacks.
 
 	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
 			0	disables intel_idle and fall back on acpi_idle.
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 305731ec142e..cc7609a17d6a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -366,6 +366,7 @@ static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
 static int intel_iommu_sm;
 static int iommu_identity_mapping;
+static int intel_no_bounce;
 
 #define IDENTMAP_ALL		1
 #define IDENTMAP_GFX		2
@@ -382,6 +383,19 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
+static inline bool device_needs_bounce(struct device *dev)
+{
+	struct pci_dev *pdev = NULL;
+
+	if (intel_no_bounce)
+		return false;
+
+	if (dev_is_pci(dev))
+		pdev = to_pci_dev(dev);
+
+	return pdev ? pdev->untrusted : false;
+}
+
 /*
  * Iterate over elements in device_domain_list and call the specified
  * callback @fn against each element.
@@ -464,6 +478,9 @@ static int __init intel_iommu_setup(char *str)
 			printk(KERN_INFO
 				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
 			intel_iommu_tboot_noforce = 1;
+		} else if (!strncmp(str, "nobounce", 8)) {
+			pr_info("Intel-IOMMU: No bounce buffer. This could expose security risks of DMA attacks\n");
+			intel_no_bounce = 1;
 		}
 
 		str += strcspn(str, ",");
-- 
2.17.1
