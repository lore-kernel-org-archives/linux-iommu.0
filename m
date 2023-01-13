Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937736C
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 01:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673574729; x=1705110729;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fB0iGXDWuyL8rchNy46SKRF6kk1f2kOIhvmNTUPvuVY=;
  b=LSpjmETh8uC7tkcA5Wf2dpJ0PxwD6dcVKbv6Jabr/s7sSvstIbT3ApQj
   CGTd7jUpesKOkD7GQcB2iGfn6Khz0x8pedqOS2pbTebmOVer1iVK390kg
   2YwR95kGE7EAFKY1w0rt+b4mQBRsACRO4zDdvkT3eSca/mayE+HJ8zddK
   ZBDzXPORktxUV7B5P6AYa0IjnjYDPnZocvVJq7VAJRpB7KHCcl8AREIwp
   QHSW1OspL4zPB3tSfFrZ1o19xBFQ3BV+eiMU0syqCbz7nIv4iMo4FoGEE
   PitkLvEFGTnjMZ3FIOSyW+yLlZ2FVSz9gDPQOK8GdLsB2clnVGsU7c0GD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="311742623"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="311742623"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 17:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="658060007"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="658060007"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2023 17:52:05 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Joerg Roedel <jroedel@suse.de>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Tony Zhu <tony.zhu@intel.com>,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Matt Fagnani <matt.fagnani@bell.net>
Subject: [PATCH v2 1/1] PCI: Add translated request only flag for pci_enable_pasid()
Date: Fri, 13 Jan 2023 09:44:09 +0800
Message-Id: <20230113014409.752405-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The PCIe fabric routes Memory Requests based on the TLP address, ignoring
the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
Enable PASID only when ACS RR & UF enabled on upstream path") requires
some ACS features being supported on device's upstream path when enabling
PCI/PASID.

One alternative is ATS which lets the device resolve the PASID+addr pair
before a memory request is made into a routeable TLB address through the
TA. Those resolved addresses are then cached on the device instead of
in the IOMMU TLB and the device always sets the translated bit for PASID.
One example of those devices are AMD graphic devices that always have ACS
or ATS enabled together with PASID.

This adds a flag parameter in the pci_enable_pasid() helper, with which
the device driver could opt-in the fact that device always sets the
translated bit for PASID.

It also applies this opt-in for AMD graphic devices. Without this change,
kernel boots to black screen on a system with below AMD graphic device:

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
        [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
        (prog-if 00 [VGA controller])
	DeviceName: ATI EG BROADWAY
	Subsystem: Hewlett-Packard Company Device 8332

At present, it is a common practice to enable/disable PCI PASID in the
iommu drivers. Considering that the device driver knows more about the
specific device, we will follow up by moving pci_enable_pasid() into
the specific device drivers.

Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on upstream path")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/pci-ats.h                     | 6 ++++--
 drivers/iommu/amd/iommu.c                   | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/intel/iommu.c                 | 3 ++-
 drivers/pci/ats.c                           | 8 ++++++--
 5 files changed, 14 insertions(+), 7 deletions(-)

Change log:
v2:
 - Convert the bool to a named flag;
 - Convert TRANSLED to XLATED.

v1:
 - https://lore.kernel.org/linux-iommu/20230112084629.737653-1-baolu.lu@linux.intel.com/

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index df54cd5b15db..750fca736ef4 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -4,6 +4,8 @@
 
 #include <linux/pci.h>
 
+#define PCI_PASID_XLATED_REQ_ONLY	BIT(0)
+
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 bool pci_ats_supported(struct pci_dev *dev);
@@ -35,12 +37,12 @@ static inline bool pci_pri_supported(struct pci_dev *pdev)
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-int pci_enable_pasid(struct pci_dev *pdev, int features);
+int pci_enable_pasid(struct pci_dev *pdev, int features, int flags);
 void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
-static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
+static inline int pci_enable_pasid(struct pci_dev *pdev, int features, int flags)
 { return -EINVAL; }
 static inline void pci_disable_pasid(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..64a8c03d7dfa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1700,7 +1700,7 @@ static int pdev_pri_ats_enable(struct pci_dev *pdev)
 	int ret;
 
 	/* Only allow access to user-accessible pages */
-	ret = pci_enable_pasid(pdev, 0);
+	ret = pci_enable_pasid(pdev, 0, PCI_PASID_XLATED_REQ_ONLY);
 	if (ret)
 		goto out_err;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab160198edd6..891bf53c45dc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2350,7 +2350,7 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
 	if (num_pasids <= 0)
 		return num_pasids;
 
-	ret = pci_enable_pasid(pdev, features);
+	ret = pci_enable_pasid(pdev, features, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable PASID\n");
 		return ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..5cc13f02a5ac 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1425,7 +1425,8 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	   undefined. So always enable PASID support on devices which
 	   have it, even if we can't yet know if we're ever going to
 	   use it. */
-	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
+	if (info->pasid_supported &&
+	    !pci_enable_pasid(pdev, info->pasid_supported & ~1, 0))
 		info->pasid_enabled = 1;
 
 	if (info->pri_supported &&
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..3a2d9e0ba1d8 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -353,12 +353,15 @@ void pci_pasid_init(struct pci_dev *pdev)
  * pci_enable_pasid - Enable the PASID capability
  * @pdev: PCI device structure
  * @features: Features to enable
+ * @flags: device-specific flags
+ *   - PCI_PASID_XLATED_REQ_ONLY: The PCI device only issues PASID
+ *                                memory requests of translated type.
  *
  * Returns 0 on success, negative value on error. This function checks
  * whether the features are actually supported by the device and returns
  * an error if not.
  */
-int pci_enable_pasid(struct pci_dev *pdev, int features)
+int pci_enable_pasid(struct pci_dev *pdev, int features, int flags)
 {
 	u16 control, supported;
 	int pasid = pdev->pasid_cap;
@@ -382,7 +385,8 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
-	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
+	if (!(flags & PCI_PASID_XLATED_REQ_ONLY) &&
+	    !pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
 		return -EINVAL;
 
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
-- 
2.34.1

