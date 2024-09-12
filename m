Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8819F42D
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146274; cv=none; b=OkpBibXB6na29pzWfCZEyEWu2LCOaOaq/3vG2uZMU+KG8+JlrnVuJDqmhjz99C8Cee4uHgJYz9rru75TzbzCb6sU+nVZvWI7dg2G7HHFlN2bZAcDvBWzL/DoeF5JHjQXf7zylblXI2RPEApkBebJNXbe8WYPepEEL6Qznl0EW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146274; c=relaxed/simple;
	bh=XyNHvyNEye0jcSAzV3V+fEuJzblC0RvSU4nG6g4cpY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nok2D5K1zxDKsvydZlucosqqc786DltB6UKUa+ldIC0jmeAO2dyCWhbip8YPT8jhYE14TYBaZuIY+B7huhUrclK08b4upArnhAujJ3OCAF+O0YbGwax6TUm5G7lUBacMJv8Yd1zZPce5TWvFGfIAGMZQJNCcbW3unQXN+J40pn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcOULRWD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcOULRWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146273; x=1757682273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XyNHvyNEye0jcSAzV3V+fEuJzblC0RvSU4nG6g4cpY0=;
  b=lcOULRWD+/mkRIf7k4WpZKUYghNWgK4KUkJP7CUsKT6Lmiy1KyD2D28O
   zP3USEYxc6fzgxOExjusUuL9dx1O+53o+9aTC7jhAvDB26wR+VSxTL3xa
   rXTSw8AKZcvMY/UJhgm/HzX1Tz2HikVxgO1jMNXlqahRp74l/k5VchNbm
   /cb7cehjgeHyWA/htZ5VrCp/I4Eyr5ogUbbvdyHBzuaoHhEjbRO+uYwS8
   Vsd+YAK6yyJr2Iwpk/2APHI/KPIuFPIbu3kovGuEllavecrlJFIH+6PSg
   4OZNtYwhNkdaYAiJObd1OoMmrMNmX84xoyRYDz90g/jJFb6l8L1WSmf2t
   g==;
X-CSE-ConnectionGUID: N9IPbdugQjCWQ2poA0r+Fg==
X-CSE-MsgGUID: OeXGXAQIQMmVnmfaGXxEQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36380517"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36380517"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:04:32 -0700
X-CSE-ConnectionGUID: SWjfLq4JRIWOtYaaYs5rwQ==
X-CSE-MsgGUID: QOefvboDRO2u9VLPjThPsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72509901"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 12 Sep 2024 06:04:32 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v2 0/6] Make set_dev_pasid op supporting domain replacement
Date: Thu, 12 Sep 2024 06:04:21 -0700
Message-Id: <20240912130427.10119-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This splits the preparation works of the iommu and the Intel iommu driver
out from the iommufd pasid attach/replace series. [1]

To support domain replacement, the definition of the set_dev_pasid op
needs to be enhanced. Meanwhile, the existing set_dev_pasid callbacks
should be extended as well to suit the new definition.

This series first prepares the Intel iommu set_dev_pasid op for the new
definition, adds the missing set_dev_pasid support for nested domain, makes
ARM SMMUv3 set_dev_pasid op to suit the new definition, and in the end
enhances the definition of set_dev_pasid op. The AMD set_dev_pasid callback
is extended to fail if the caller tries to do domain replacement to meet the
new definition of set_dev_pasid op. AMD iommu driver would support it later
per Vasant [2].

[1] https://lore.kernel.org/linux-iommu/20240412081516.31168-1-yi.l.liu@intel.com/
[2] https://lore.kernel.org/linux-iommu/fa9c4fc3-9365-465e-8926-b4d2d6361b9c@amd.com/

v2:
 - Make ARM SMMUv3 set_dev_pasid op support domain replacement (Jason)
 - Drop patch 03 of v1 (Kevin)
 - Multiple tweaks in VT-d driver (Kevin)

v1: https://lore.kernel.org/linux-iommu/20240628085538.47049-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Make smmuv3 set_dev_pasid() op support replace

Lu Baolu (1):
  iommu/vt-d: Add set_dev_pasid callback for nested domain

Yi Liu (4):
  iommu: Pass old domain to set_dev_pasid op
  iommu/vt-d: Move intel_drain_pasid_prq() into
    intel_pasid_tear_down_entry()
  iommu/vt-d: Make intel_iommu_set_dev_pasid() to handle domain
    replacement
  iommu: Make set_dev_pasid op support domain replacement

 drivers/iommu/amd/amd_iommu.h                 |   3 +-
 drivers/iommu/amd/pasid.c                     |   6 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   8 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +-
 drivers/iommu/intel/iommu.c                   | 122 ++++++++++++------
 drivers/iommu/intel/iommu.h                   |   3 +
 drivers/iommu/intel/nested.c                  |   1 +
 drivers/iommu/intel/pasid.c                   |  13 +-
 drivers/iommu/intel/pasid.h                   |   8 +-
 drivers/iommu/intel/svm.c                     |   6 +-
 drivers/iommu/iommu.c                         |   3 +-
 include/linux/iommu.h                         |   5 +-
 13 files changed, 129 insertions(+), 56 deletions(-)

-- 
2.34.1

