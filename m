Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBC50241
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910087; cv=none; b=YssYIbbKqO3W7IdmTj6fqpSCV9VEMwI/BH087vQzP6a/w4UDBpM3MSHX8xHd1u3f+SRhuvtDNlgYo/KS1rXWYxUKBdhB8i7kEm6IBBZzQvDZl3dVC/x9HTciORsreUvo4vRVBkAGax3T83NS1bYoprw4Jhn5EB1nqrkmILRm82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910087; c=relaxed/simple;
	bh=jLjMOyugTL5/+7lybaOBxd433Z4MIv3gSjYWbqITPXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtKG5XtjVeKyi2Han8cU1QdZ0gmHXGJquSGT6V6+n2MNbIL/fHtEm0bEmOlceDRMMrl80dhgDZXVXUIESQX1YR7h7IAMPk+fNNLefRbMyQfnwERxRIq1Q3lvgw/Yb1WnCARfrjmYnrVy6/e+o/h8bHkg1KwEMYdP6lBQl0IMEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxhp+nWa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxhp+nWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712910086; x=1744446086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jLjMOyugTL5/+7lybaOBxd433Z4MIv3gSjYWbqITPXc=;
  b=hxhp+nWazzNQWQW0102UsBrHVEYg5g2VJLCKUssjYLzdOrC1OldJVICp
   R84A8PTB4+JzH/qwpIuaT+zu0ApgjDSLVjCiPD0gAxjwiP81KUqz2W55O
   wtHr1WlAksCWz/7LxxRwF7dND60ocJnqJ75NV86BNNK5C45su3AJZRUE2
   +iCNO4pNOBc8MP8/Hr2ByrPNBW5DtoKJukmdvuQ4WfW/6N3FnS12vTFrq
   LtD8QcMDJMmV4mYecIEwVCHsOOE2idZ/cLpwXREM7jVLe0GF0xP0SBFgH
   VrDdppOV2OsaJN5/VEZQyLy+x0suTZhFxaKwukaJitxXMnb5isvmFGOit
   Q==;
X-CSE-ConnectionGUID: rut4FaryQFa3TUSIiObYbA==
X-CSE-MsgGUID: xEp2037fTyaP3hFBXawVZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19069429"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="19069429"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:21:26 -0700
X-CSE-ConnectionGUID: yqcSNUxURnmmSB3/gIz9Rg==
X-CSE-MsgGUID: eVhiK1TzQdakbtwlDeQTSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25836280"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 12 Apr 2024 01:21:26 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com
Cc: joro@8bytes.org,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	jacob.jun.pan@intel.com
Subject: [PATCH v2 4/4] vfio: Report PASID capability via VFIO_DEVICE_FEATURE ioctl
Date: Fri, 12 Apr 2024 01:21:21 -0700
Message-Id: <20240412082121.33382-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412082121.33382-1-yi.l.liu@intel.com>
References: <20240412082121.33382-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today, vfio-pci hides the PASID capability of devices from userspace. Unlike
other PCI capabilities, PASID capability is going to be reported to user by
VFIO_DEVICE_FEATURE. Hence userspace could probe PASID capability by it.
This is a bit different from the other capabilities which are reported to
userspace when the user reads the device's PCI configuration space. There
are two reasons for this.

 - First, userspace like Qemu by default exposes all the available PCI
   capabilities in vfio-pci config space to the guest as read-only, so
   adding PASID capability in the vfio-pci config space will make it
   exposed to the guest automatically while an old Qemu doesn't really
   support it.

 - Second, the PASID capability does not exist on VFs (instead shares the
   cap of the PF). Creating a virtual PASID capability in vfio-pci config
   space needs to find a hole to place it, but doing so may require device
   specific knowledge to avoid potential conflict with device specific
   registers like hidden bits in VF's config space. It's simpler to move
   this burden to the VMM instead of maintaining a quirk system in the kernel.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 50 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 14 +++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d94d61b92c1a..ca64e461d435 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1495,6 +1495,54 @@ static int vfio_pci_core_feature_token(struct vfio_device *device, u32 flags,
 	return 0;
 }
 
+static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32 flags,
+				       struct vfio_device_feature_pasid __user *arg,
+				       size_t argsz)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(device, struct vfio_pci_core_device, vdev);
+	struct vfio_device_feature_pasid pasid = { 0 };
+	struct pci_dev *pdev = vdev->pdev;
+	u32 capabilities = 0;
+	u16 ctrl = 0;
+	int ret;
+
+	/*
+	 * Due to no PASID capability per VF, to be consistent, we do not
+	 * support SET of the PASID capability for both PF and VF.
+	 */
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
+				 sizeof(pasid));
+	if (ret != 1)
+		return ret;
+
+	/* VF shares the PASID capability of its PF */
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
+	if (!pdev->pasid_enabled)
+		goto out;
+
+#ifdef CONFIG_PCI_PASID
+	pci_read_config_dword(pdev, pdev->pasid_cap + PCI_PASID_CAP,
+			      &capabilities);
+	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL,
+			     &ctrl);
+#endif
+
+	pasid.width = (capabilities >> 8) & 0x1f;
+
+	if (ctrl & PCI_PASID_CTRL_EXEC)
+		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_EXEC;
+	if (ctrl & PCI_PASID_CTRL_PRIV)
+		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_PRIV;
+
+out:
+	if (copy_to_user(arg, &pasid, sizeof(pasid)))
+		return -EFAULT;
+	return 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1508,6 +1556,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
 		return vfio_pci_core_feature_token(device, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_PASID:
+		return vfio_pci_core_feature_pasid(device, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 9591dc24b75c..e50e55c67ab4 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1513,6 +1513,20 @@ struct vfio_device_feature_bus_master {
 };
 #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_GET, return the PASID capability for the device.
+ * Zero width means no support for PASID.
+ */
+struct vfio_device_feature_pasid {
+	__u16 capabilities;
+#define VFIO_DEVICE_PASID_CAP_EXEC	(1 << 0)
+#define VFIO_DEVICE_PASID_CAP_PRIV	(1 << 1)
+	__u8 width;
+	__u8 __reserved;
+};
+
+#define VFIO_DEVICE_FEATURE_PASID 11
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.34.1

