Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB2208A7
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726438; cv=none; b=iSm+SKuFghPK+gzTsXTfoFg2FtNvlRcOYgq0Lu+Cmf2aWwjUOR3XkL3//edkR42q8f++ny+IdtxM+SAFUUqYEywHw0QU3vcCnub1TOMZHFPiPslSyXAVWM7steBepJw6J1bAj0PtFYhMnXUhaKLAKd5MDTLQe/NFvJL7TCG8EVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726438; c=relaxed/simple;
	bh=A2IuYzkoJgmiWWlDW7wZHf6bWUe+DxehJQp/4ahD86g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VAPWHZorf7WNe4vPA+cYMFhbxYcZPTtf9heRZrrbL3aiF4OoaPCDW1Z64s6m2MtNCZxV/67DexKrNQr/P9F34MLld9yGi6sIgqCCmDxaX+i7RphXZSCphRXOvZYile4csRjXWE+ccL39b/JtSbsYh53xhhN2K+l9gmwvR3ueXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfMsuubG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfMsuubG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726437; x=1762262437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A2IuYzkoJgmiWWlDW7wZHf6bWUe+DxehJQp/4ahD86g=;
  b=IfMsuubGkMC1NcLsekPH7J7ufJkrWzx+h38+oFozyalaz9aus7awSXtQ
   N3m43VPNob+D/EtIx+toRge1zPcx6ERTLTD0BeAFg3VHGEPvwG9AABSEn
   zW20Y46up4QY+fgZpeDXLOuuQeHZf2o5uXklSFMdifTgJvF3ko/NbpxDT
   zmvrpP5TJijW9oMwey6frLRDjHN+QvtGmqUxTYOBjUggHtPKU3+gS7d++
   pc7Bz2KLXD/PcR8sQdqDR4U1AeS7fnLQ8CDfqEkUm905SjnZIoczYUGNG
   5QfIjL/ckOdBtPaK5dbrRWp+lIf23b4yBhLUbu0VDxhNNr5zET66aNlQg
   g==;
X-CSE-ConnectionGUID: ahBIBbVyRzafcTFr0y0qng==
X-CSE-MsgGUID: ETTmeTkFRc6+0WhViDrW+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47883253"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47883253"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:20:36 -0800
X-CSE-ConnectionGUID: ZDilgAoBT4qMBP0ecyNMBw==
X-CSE-MsgGUID: qC+N2/17SBqtce6qghSmwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84099706"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 05:20:36 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v3 0/7] Support attaching PASID to the blocked_domain
Date: Mon,  4 Nov 2024 05:20:26 -0800
Message-Id: <20241104132033.14027-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the review of iommufd pasid series, Kevin and Jason suggested
attaching PASID to the blocked domain hence replacing the usage of
remove_dev_pasid() op [1]. This makes sense as it makes the PASID path
aligned with the RID path which attaches the RID to the blocked_domain
when it is to be blocked. To do it, it requires passing the old domain
to the iommu driver. This has been done in [2].

This series makes the Intel iommu driver, ARM SMMUv3 driver and AMD iommu
driver support attaching PASID to the blocked domain. And in the end remove
the remove_dev_pasid op from iommu_ops.

[1] https://lore.kernel.org/linux-iommu/20240816130202.GB2032816@nvidia.com/
[2] https://lore.kernel.org/linux-iommu/20241104131842.13303-1-yi.l.liu@intel.com/

v3:
 - Add a patch to check remove_dev_pasid() in iommu_attach_device_pasid()
 - Split patch 01 of v2 into two patches, drop the r-b of this patch due the
   split.
 - Add AMD iommu blocked domain pasid support (Jason)
 - Remove the remove_dev_pasid op as all the iommu drivers that support pasid
   attach have supported attaching pasid to blocked domain.

v2: https://lore.kernel.org/linux-iommu/20241018055824.24880-1-yi.l.liu@intel.com/#t
 - Add Kevin's r-b
 - Adjust the order of patch 03 of v1, it should be the first patch (Baolu)

v1: https://lore.kernel.org/linux-iommu/20240912130653.11028-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Make the blocked domain support PASID

Yi Liu (6):
  iommu: Prevent pasid attach if no ops->remove_dev_pasid
  iommu: Consolidate the ops->remove_dev_pasid usage into a helper
  iommu: Detaching pasid by attaching to the blocked_domain
  iommu/vt-d: Make the blocked domain support PASID
  iommu/amd: Make the blocked domain support PASID
  iommu: Remove the remove_dev_pasid op

 drivers/iommu/amd/iommu.c                   | 10 ++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++------
 drivers/iommu/intel/iommu.c                 | 15 ++++++++++----
 drivers/iommu/iommu.c                       | 23 ++++++++++++++-------
 include/linux/iommu.h                       |  5 -----
 5 files changed, 42 insertions(+), 23 deletions(-)

-- 
2.34.1

