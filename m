Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0A139D04
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726859; cv=none; b=jfMn0fyoWQ6Pxqvp7y+2D8UseHwcDLlm9hY4M3Q7tktTLmAK6bRfepcPGvDYlbGKS8ASbE/NfoNKER7wZxSPpIhcIKveNVQcJaPWFgSeAxSl7ZZZgrXQSDts9ukR5IYuhe/LXgvUugPOIHSD3w6/nCBhgc9ltZMOg8V0pDWDM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726859; c=relaxed/simple;
	bh=5sQSfXmZiJzGPYHCOBr/AtFGlcHA+RdB5BcuVX2z7KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHyS5J74I2hgIqrxh5epCtakpqqjLRjJumZQKQQbTQVMUDNwNKMhLUy8LbLHilxAKPt6XwXiOR8Ykp+1E0GWZK2VmCLAH1wTlJKCwZpXJHGX42eg4IiA+nIG0MrKMKtjen72q4NiSveyBAYSyvvzDiqBxb4Citd8fw9lLVjlcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+JmmU5N; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+JmmU5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726858; x=1762262858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5sQSfXmZiJzGPYHCOBr/AtFGlcHA+RdB5BcuVX2z7KU=;
  b=X+JmmU5Nvbg0WicHPF3Y4EFIqJKkXAACXjc9QF357C+nk6sBi2wCLIyS
   OGFh4vae16/uzkQbf2EXA9d3vuhH6qwDTTIxgvzZJP9/6Y8yAM4OtdyQa
   jnR4Z0AmOPXOfH3S2WE20XFFLM1m8RDaXosrualMbO1Fbcjo5P4NRR2O+
   wa7jEE8Vi1tDIK3BUrZBuOylwq6ED+T5D6g/kFDfxXrREV6B0NloPBIfo
   2763+Y5DBnz/M9CyuSOZIdxSdr1zPGl4e58bunEJS06jaxF1+pFLksBT3
   0Cmakmzu8PjsHcCsP4t4s41GG8MbhXF93uITWNnCWFKiDsGCGvVFag97C
   A==;
X-CSE-ConnectionGUID: 68ptpI60RXioZKe01kikWQ==
X-CSE-MsgGUID: ySifl5C6Rh+EAsAmup6A5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47884595"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47884595"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:27:37 -0800
X-CSE-ConnectionGUID: l7fhb2hMRia4jeI5i1mx3g==
X-CSE-MsgGUID: ojLwnFhxSp+RK4k32hDoHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84100917"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 05:27:37 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com
Cc: joro@8bytes.org,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	willy@infradead.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 4/4] iommufd: Extend IOMMU_GET_HW_INFO to report PASID capability
Date: Mon,  4 Nov 2024 05:27:32 -0800
Message-Id: <20241104132732.16759-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104132732.16759-1-yi.l.liu@intel.com>
References: <20241104132732.16759-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PASID usage requires PASID support in both device and IOMMU. Since the
iommu drivers always enable the PASID capability for the device if it
is supported, so it is reasonable to extend the IOMMU_GET_HW_INFO to
report the PASID capability to userspace.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org> #aarch64 platform
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 24 +++++++++++++++++++++++-
 drivers/pci/ats.c              | 33 +++++++++++++++++++++++++++++++++
 include/linux/pci-ats.h        |  3 +++
 include/uapi/linux/iommufd.h   | 14 +++++++++++++-
 4 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a52937fba366..3620a039d3fa 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -3,6 +3,8 @@
  */
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/slab.h>
 #include <uapi/linux/iommufd.h>
 
@@ -1248,7 +1250,8 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	void *data;
 	int rc;
 
-	if (cmd->flags || cmd->__reserved)
+	if (cmd->flags || cmd->__reserved[0] || cmd->__reserved[1] ||
+	    cmd->__reserved[2])
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
@@ -1305,6 +1308,25 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	if (device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
 		cmd->out_capabilities |= IOMMU_HW_CAP_DIRTY_TRACKING;
 
+	cmd->out_max_pasid_log2 = 0;
+
+	if (dev_is_pci(idev->dev)) {
+		struct pci_dev *pdev = to_pci_dev(idev->dev);
+		int ctrl;
+
+		ctrl = pci_pasid_ctrl_status(pdev);
+		if (ctrl >= 0 && (ctrl & PCI_PASID_CTRL_ENABLE)) {
+			cmd->out_max_pasid_log2 =
+					ilog2(idev->dev->iommu->max_pasids);
+			if (ctrl & PCI_PASID_CTRL_EXEC)
+				cmd->out_capabilities |=
+						IOMMU_HW_CAP_PCI_PASID_EXEC;
+			if (ctrl & PCI_PASID_CTRL_PRIV)
+				cmd->out_capabilities |=
+						IOMMU_HW_CAP_PCI_PASID_PRIV;
+		}
+	}
+
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 out_free:
 	kfree(data);
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 6afff1f1b143..c35465120329 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -538,4 +538,37 @@ int pci_max_pasids(struct pci_dev *pdev)
 	return (1 << FIELD_GET(PCI_PASID_CAP_WIDTH, supported));
 }
 EXPORT_SYMBOL_GPL(pci_max_pasids);
+
+/**
+ * pci_pasid_ctrl_status - Check the PASID status
+ * @pdev: PCI device structure
+ *
+ * Returns a negative value when no PASID capability is present.
+ * Otherwise the value of the control register is returned.
+ * Status reported are:
+ *
+ * PCI_PASID_CTRL_ENABLE - PASID enabled
+ * PCI_PASID_CTRL_EXEC - Execute permission enabled
+ * PCI_PASID_CTRL_PRIV - Privileged mode enabled
+ */
+int pci_pasid_ctrl_status(struct pci_dev *pdev)
+{
+	int pasid;
+	u16 ctrl;
+
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
+	pasid = pdev->pasid_cap;
+	if (!pasid)
+		return -EINVAL;
+
+	pci_read_config_word(pdev, pasid + PCI_PASID_CTRL, &ctrl);
+
+	ctrl &= PCI_PASID_CTRL_ENABLE | PCI_PASID_CTRL_EXEC |
+		PCI_PASID_CTRL_PRIV;
+
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(pci_pasid_ctrl_status);
 #endif /* CONFIG_PCI_PASID */
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 0e8b74e63767..f4e1d2010287 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -42,6 +42,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features);
 void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
+int pci_pasid_ctrl_status(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
 static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
 { return -EINVAL; }
@@ -50,6 +51,8 @@ static inline int pci_pasid_features(struct pci_dev *pdev)
 { return -EINVAL; }
 static inline int pci_max_pasids(struct pci_dev *pdev)
 { return -EINVAL; }
+static inline int pci_pasid_ctrl_status(struct pci_dev *pdev)
+{ return -EINVAL; }
 #endif /* CONFIG_PCI_PASID */
 
 #endif /* LINUX_PCI_ATS_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0c0ed28ee113..8dd6412ab74a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -512,9 +512,17 @@ enum iommu_hw_info_type {
  *                                   IOMMU_HWPT_GET_DIRTY_BITMAP
  *                                   IOMMU_HWPT_SET_DIRTY_TRACKING
  *
+ * @IOMMU_HW_CAP_PASID_EXEC: Execute Permission Supported, user ignores it
+ *                           when the struct iommu_hw_info::out_max_pasid_log2
+ *                           is zero.
+ * @IOMMU_HW_CAP_PASID_PRIV: Privileged Mode Supported, user ignores it
+ *                           when the struct iommu_hw_info::out_max_pasid_log2
+ *                           is zero.
  */
 enum iommufd_hw_capabilities {
 	IOMMU_HW_CAP_DIRTY_TRACKING = 1 << 0,
+	IOMMU_HW_CAP_PCI_PASID_EXEC = 1 << 1,
+	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
 };
 
 /**
@@ -530,6 +538,9 @@ enum iommufd_hw_capabilities {
  *                 iommu_hw_info_type.
  * @out_capabilities: Output the generic iommu capability info type as defined
  *                    in the enum iommu_hw_capabilities.
+ * @out_max_pasid_log2: Output the width of PASIDs. 0 means no PASID support.
+ *                      PCI devices turn to out_capabilities to check if the
+ *                      specific capabilities is supported or not.
  * @__reserved: Must be 0
  *
  * Query an iommu type specific hardware information data from an iommu behind
@@ -553,7 +564,8 @@ struct iommu_hw_info {
 	__u32 data_len;
 	__aligned_u64 data_uptr;
 	__u32 out_data_type;
-	__u32 __reserved;
+	__u8 out_max_pasid_log2;
+	__u8 __reserved[3];
 	__aligned_u64 out_capabilities;
 };
 #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
-- 
2.34.1

