Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD3137A
	for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673513666; x=1705049666;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sbZLbVJ1FtTUzxWrLWMc69Y2p0n8V6X7/TxYZupX72g=;
  b=BhN8Sp9nrpzSbpKkNDWPWKj4pmdmJpadEs4x5n5/GIgdq6zK4iv4ZHAr
   lELbZ7kfUAkq46J5riFEy2MwIpTU5KU+EPBvxGRn3Sd1kRTe9lwDEZrKE
   qDEkcgsFw+O+rnIj79nbBB1yaztq71W1LSvBGX+ejStR/ZuIBV7ENmmyH
   Q8y+r9HD2M6TSVsV4hDk7QziaZPzDhHEgHgRjTdy0TJiCMUBQgtokNc9u
   zgFKGW1dCluDTE1idzQf2UZ385OmAyV4hh/9lYQEncQZOCpQoEMIVu+12
   VxRQEX/0tEaeYQbsTXsSY1EFtAJuwVYJBMkZa15MCYTpxgZAZl0M8v+iN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303349662"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="303349662"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="765526296"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="765526296"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2023 00:54:22 -0800
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
Subject: [PATCH 1/1] PCI: Add translated request only opt-in for pci_enable_pasid()
Date: Thu, 12 Jan 2023 16:46:29 +0800
Message-Id: <20230112084629.737653-1-baolu.lu@linux.intel.com>
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

This adds an extra parameter in the pci_enable_pasid() helper, with which
the device driver could opt-in the fact that device always sets the
translated bit for PASID.

It also applies this opt-in for AMD graphic devices. Without this change,
kernel boots to black screen on a system with below AMD graphic device:

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
        [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
        (prog-if 00 [VGA controller])
	DeviceName: ATI EG BROADWAY
	Subsystem: Hewlett-Packard Company Device 8332

Refer to kernel bugzilla through below link for more details.

Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on upstream path")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/pci-ats.h                     | 5 +++--
 drivers/iommu/amd/iommu.c                   | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/intel/iommu.c                 | 3 ++-
 drivers/pci/ats.c                           | 7 +++++--
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index df54cd5b15db..78a37821fff4 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -35,12 +35,13 @@ static inline bool pci_pri_supported(struct pci_dev *pdev)
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-int pci_enable_pasid(struct pci_dev *pdev, int features);
+int pci_enable_pasid(struct pci_dev *pdev, int features, bool transled_only);
 void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
-static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
+static inline int pci_enable_pasid(struct pci_dev *pdev, int features,
+				   bool transled_only)
 { return -EINVAL; }
 static inline void pci_disable_pasid(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..a89734b30947 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1700,7 +1700,7 @@ static int pdev_pri_ats_enable(struct pci_dev *pdev)
 	int ret;
 
 	/* Only allow access to user-accessible pages */
-	ret = pci_enable_pasid(pdev, 0);
+	ret = pci_enable_pasid(pdev, 0, true);
 	if (ret)
 		goto out_err;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab160198edd6..f5f224f023ba 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2350,7 +2350,7 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
 	if (num_pasids <= 0)
 		return num_pasids;
 
-	ret = pci_enable_pasid(pdev, features);
+	ret = pci_enable_pasid(pdev, features, false);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable PASID\n");
 		return ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 317af67b6098..2dd7773ce5c0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1424,7 +1424,8 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	   undefined. So always enable PASID support on devices which
 	   have it, even if we can't yet know if we're ever going to
 	   use it. */
-	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
+	if (info->pasid_supported &&
+	    !pci_enable_pasid(pdev, info->pasid_supported & ~1, false))
 		info->pasid_enabled = 1;
 
 	if (info->pri_supported &&
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..eb14ca8ec4e6 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -353,12 +353,14 @@ void pci_pasid_init(struct pci_dev *pdev)
  * pci_enable_pasid - Enable the PASID capability
  * @pdev: PCI device structure
  * @features: Features to enable
+ * @transled_only: True if the device issues MemRd/Wr TLPs with a PASID TLP
+ *                 prefix only when the AT field is set to translated.
  *
  * Returns 0 on success, negative value on error. This function checks
  * whether the features are actually supported by the device and returns
  * an error if not.
  */
-int pci_enable_pasid(struct pci_dev *pdev, int features)
+int pci_enable_pasid(struct pci_dev *pdev, int features, bool transled_only)
 {
 	u16 control, supported;
 	int pasid = pdev->pasid_cap;
@@ -382,7 +384,8 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
-	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
+	if (!transled_only &&
+	    !pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
 		return -EINVAL;
 
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
-- 
2.34.1

