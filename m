Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437EF4E1B3
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910084; cv=none; b=cw/3somMT/Exb0LAFG/5Ng7Nju6jskxP5Mtg+QntTfJxs+TNBEQLiuNnk8Dfv4kXcA9/iYq93Jfug/b0ApRKJfvdzJScsnnTVRxf7GFcqleSU1rGWLIKphtlqTSUtLW9v5qEPWq11SxwAPA+eL/zh+WIIMjfZn3774uHHOB21pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910084; c=relaxed/simple;
	bh=Q3tE0NbRiOJnGc3zFk/jp6N7QgVRnZMdGUP7mCxbEfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oL4JSBunXXtebAKjVOQATB7e7ydqjTzGODS1dHlx5CaUfJ0EgiNewPzL+ic8TlI+1yH/bqbFSS9xWQwZVdrlulf5Bf6hXwTQpAqK/VeYTtf5WKr/ZyDvlqNLh4yitkaO2e6+tlJKi7MjCgZkUPtT98NbOX5SDAK/kjJfmmlPj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AW5LUr1H; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AW5LUr1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712910083; x=1744446083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q3tE0NbRiOJnGc3zFk/jp6N7QgVRnZMdGUP7mCxbEfY=;
  b=AW5LUr1HdmGxY/KRtJZzb6CKCSrYMNsBd3/qcAZBxqrdnQE5vrtYxpX9
   OJfjZDSRBcMYt947662p8uUhFRp0G8n2MDO0iAj47ecgFjokqApKFzDxr
   Isc62jhF/GrL2677ep9LEozRNrAVOt/H8JgFGJOzXgKBWV4agJ1S51xcJ
   p24Bd2pH8z2UUWu9bD/KewNpF2Heuc5JpWXgliBpMEyHlKK9QmtBb0Jqt
   eApxtm0Jcg1Lw68hHwYAqdakZYCuqXduT2ju02gDT4e/dfUixDkcmiuqJ
   ywERpgu38CjmEAiTUza0WLaL5t/kELmcQtAwo4dwN+uP4W1wC4LbbBGwe
   g==;
X-CSE-ConnectionGUID: YliguYFjTyCYJSxvvqeVMg==
X-CSE-MsgGUID: b0vQOqUITcObls0+uFxBAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19069396"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="19069396"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:21:23 -0700
X-CSE-ConnectionGUID: 63F6Lt/HTV6D7YDiozmJsg==
X-CSE-MsgGUID: hIJO9pd8ReOCVvbd+8fq8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25836239"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 12 Apr 2024 01:21:23 -0700
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
Subject: [PATCH v2 0/4] vfio-pci support pasid attach/detach
Date: Fri, 12 Apr 2024 01:21:17 -0700
Message-Id: <20240412082121.33382-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the pasid attach/detach uAPIs for userspace to attach/detach
a PASID of a device to/from a given ioas/hwpt. Only vfio-pci driver is
enabled in this series. After this series, PASID-capable devices bound
with vfio-pci can report PASID capability to userspace and VM to enable
PASID usages like Shared Virtual Addressing (SVA).

This series first adds the helpers for pasid attach in vfio core and then
adds the device cdev ioctls for pasid attach/detach, finally exposing the
device PASID capability to the user. It depends on the iommufd pasid
attach/detach series [1].

A userspace VMM is supposed to get the details of the device's PASID capability
and assemble a virtual PASID capability in a proper offset in the virtual PCI
configuration space. While it is still an open on how to get the available
offsets. Devices may have hidden bits that are not in the PCI cap chain. For
now, there are two options to get the available offsets.[2]

- Report the available offsets via ioctl. This requires device-specific logic
  to provide available offsets. e.g., vfio-pci variant driver. Or may the device
  provide the available offset by DVSEC.
- Store the available offsets in a static table in userspace VMM. VMM gets the
  empty offsets from this table.

Since there was no clear answer to it, I have not made much change on this in
this version. Wish we could have more discussions on this.

The completed code can be found at [3], tested with a hacky Qemu branch [4].

[1] https://lore.kernel.org/linux-iommu/20240412081516.31168-1-yi.l.liu@intel.com/
[2] https://lore.kernel.org/kvm/b3e07591-8ebc-4924-85fe-29a46fc73d78@intel.com/
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid
[4] https://github.com/yiliu1765/qemu/tree/wip/zhenzhong/iommufd_nesting_rfcv2-test-pasid

Change log:

v2:
 - Use IDA to track if PASID is attached or not in VFIO. (Jason)
 - Fix the issue of calling pasid_at[de]tach_ioas callback unconditionally (Alex)
 - Fix the wrong data copy in vfio_df_ioctl_pasid_detach_pt() (Zhenzhong)
 - Minor tweaks in comments (Kevin)

v1: https://lore.kernel.org/kvm/20231127063909.129153-1-yi.l.liu@intel.com/
 - Report PASID capability via VFIO_DEVICE_FEATURE (Alex)

rfc: https://lore.kernel.org/linux-iommu/20230926093121.18676-1-yi.l.liu@intel.com/

Regards,
        Yi Liu

Yi Liu (4):
  ida: Add ida_get_lowest()
  vfio-iommufd: Support pasid [at|de]tach for physical VFIO devices
  vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
  vfio: Report PASID capability via VFIO_DEVICE_FEATURE ioctl

 drivers/vfio/device_cdev.c       | 51 +++++++++++++++++++++++
 drivers/vfio/iommufd.c           | 60 +++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c      |  2 +
 drivers/vfio/pci/vfio_pci_core.c | 50 +++++++++++++++++++++++
 drivers/vfio/vfio.h              |  4 ++
 drivers/vfio/vfio_main.c         |  8 ++++
 include/linux/idr.h              |  1 +
 include/linux/vfio.h             | 11 +++++
 include/uapi/linux/vfio.h        | 69 ++++++++++++++++++++++++++++++++
 lib/idr.c                        | 67 +++++++++++++++++++++++++++++++
 10 files changed, 323 insertions(+)

-- 
2.34.1

