Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3E1E9074
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068274; cv=none; b=o8Oaza2zBz0xZPvcNU/9Xyxk7IuGa/FDPNW6qIHX4pOyA2Ss+MK3cX8Ur9VwkpJ0ppCflVx5O3a0QC94UvdOpYfhCk8pGGGVm+v0puwIJzPV5kuv/2zFoF+hm+c9yXRLMGb/XJDJxm8A1RG0zJjdcUioMphlf1l3wKxPFXfeduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068274; c=relaxed/simple;
	bh=eg6PD3CuAltZOvrslb8O1BllOcumlzSeflErh+2dj4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKr2yb8urAqzG1E1oW1qAXu0ciqw5dRAuaSO1yk9ePcAsz02zeTacaQGk5/vqNKs1CLNxYyxZetJJWU+Uq32yakWh5QkRVaWUyqRXrV1SJURST/VKg6+/eI6/tWVAoRu9y5t8pZTKUwyCQDqVAQ/57NRjo/EWqmrmGj3Wawjl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irUaPNfM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irUaPNfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731068273; x=1762604273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eg6PD3CuAltZOvrslb8O1BllOcumlzSeflErh+2dj4U=;
  b=irUaPNfM0Nzyzrx19dFiNoTHn0poc5Hx0KSBoBhtV5VM9UbZRBW9oeni
   MVr9lbGoNW5zAnZyceYRCKkIPl61YsaR8QY67l3YLkI9+WltoFC0T3Hkl
   fygJz3dTn8BtcNnvXB5XX7q+2sRmo1tnJy4quXpYFRDKS1F0wfcmApAxp
   crhn7PJpOWbRJBVeuLkaXBrUUEKIo98AeNJYkOFfqX+jiss+vzt8Ahsue
   wzLRtWsbl283RtIdmu7pRkAUjdKeB69W10/ZPliI5LodJLBaLvgWCNWYJ
   8m1f/SqCUfnkZlJtL+bqTgzMVdiBPhIbpTqKkGbTJpKrAoFIUUfBJJnVQ
   w==;
X-CSE-ConnectionGUID: qUU25l/2RIisjK1qg1ejcw==
X-CSE-MsgGUID: hWI2R+DUT1CfQd2Sa0ojuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41560842"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="41560842"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:17:50 -0800
X-CSE-ConnectionGUID: UOskUehgQ7ShGTgC2rwYQg==
X-CSE-MsgGUID: su3n60svQCWS/BodfBcoVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85865460"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 08 Nov 2024 04:17:49 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: joro@8bytes.org,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v5 5/5] iommufd: Extend IOMMU_GET_HW_INFO to report PASID capability
Date: Fri,  8 Nov 2024 04:17:42 -0800
Message-Id: <20241108121742.18889-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108121742.18889-1-yi.l.liu@intel.com>
References: <20241108121742.18889-1-yi.l.liu@intel.com>
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
index cc1b94f43538..e5709502d8e4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -547,9 +547,17 @@ enum iommu_hw_info_type {
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
@@ -565,6 +573,9 @@ enum iommufd_hw_capabilities {
  *                 iommu_hw_info_type.
  * @out_capabilities: Output the generic iommu capability info type as defined
  *                    in the enum iommu_hw_capabilities.
+ * @out_max_pasid_log2: Output the width of PASIDs. 0 means no PASID support.
+ *                      PCI devices turn to out_capabilities to check if the
+ *                      specific capabilities is supported or not.
  * @__reserved: Must be 0
  *
  * Query an iommu type specific hardware information data from an iommu behind
@@ -588,7 +599,8 @@ struct iommu_hw_info {
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

