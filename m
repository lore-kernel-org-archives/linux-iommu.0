Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ACDA41
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032100; cv=none; b=EGipDF9zlr0idEjqMgihVDd2eYu+f9MX2sebvWZQKPHifzA21QkYcKr+sZ8c9rz3WeCDWJPtRGXJMxN1VoggUcZEx2L768lt+OW7jEReioWO3YHbV46QETHB5Xc7RKoLx4rc0qTy3swMJ+AWWRNPKE1w0qwCLTand4DTBFkU610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032100; c=relaxed/simple;
	bh=/RwNtUIK5qsH2x/pT+BCqwmWHh7ol3Wb5glueJeUYm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePxrKqEM3s/mpXMxHuSEEnfpcbbZ4QTqH3V/Sftm+y3qhQtbL6HBNEdW8svCq0npyR2U6TEmg8dhAD2bUAWAZF3qSEnZ3+CMA4y1RI6LyMr66ej4KEsORi5bdUMpFIeIjG22X3Q6YVF9wcilxDcoRlCO9knRpxvNJoJ4pqphru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7LoaBmP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7LoaBmP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032099; x=1762568099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/RwNtUIK5qsH2x/pT+BCqwmWHh7ol3Wb5glueJeUYm0=;
  b=c7LoaBmPPkAlUZGzGn1wNqhx1t0y7Rq3gksYzPUso19cK+HceLBsgovx
   YG1lJvGzLJuvHuDGCktKhbk9gCFBBpYkl2WFcDiJOkmkqzYeqPzStwD8G
   c4p/xAqyDd1qBrgE+gA/QvJubeQZaE9Gkq7KpyOE+0ezJRmZLZ5z9dx1K
   rmy+nsdLC49nmK8HtHUj+S2ikbxZMOQJg8m87Ylkm8J1Gvi/kPpb0dL7L
   5vFzuHw6ZFVtCj9Cmg1DvDv2undSg+jcNw3LFvi6WRO7vlV7MllmYpfR4
   bKO5Jjnh83R0AAZU7xZ47pA7hNt5Ig9lZ8bz3pXoti+MhM/tF1daGPIoa
   g==;
X-CSE-ConnectionGUID: 2M7s4a7qRUuTdJuJszbmhw==
X-CSE-MsgGUID: dd+6mCSqSredmuiFpt7Pvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007722"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007722"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:14:58 -0800
X-CSE-ConnectionGUID: 2by48bBrR+GilLxmiYHRhg==
X-CSE-MsgGUID: r/RQRxgLTCeNkkIGyA9EKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213709"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:14:56 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] [PULL REQUEST] Intel IOMMU updates for v6.13 (2nd
Date: Fri,  8 Nov 2024 10:13:51 +0800
Message-ID: <20241108021406.173972-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

I apologize, I should have put all patches in a single pull request.
However, the feature introduced in this pull request needed extra rounds
of review and is now ready for merge.  I'm trying to merge this series
in this merge window because it's self-contained and other series, for
vfio and iommufd, depend on it. Merging this series in time will
simplify the upstream process for those series.

With above explained, the following changes have been queued for
v6.13-rc1, including:

 - Add domain replacement support for pasid

These patches are based on the vtd branch of the iommu tree. The complete
patches are also available at:

https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.13

Please consider them for iommu next.

Best regards,
baolu

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Make set_dev_pasid() op support replace

Yi Liu (12):
  iommu: Pass old domain to set_dev_pasid op
  iommu/vt-d: Add a helper to flush cache for updating present pasid
    entry
  iommu/vt-d: Refactor the pasid setup helpers
  iommu/vt-d: Add pasid replace helpers
  iommu/vt-d: Consolidate the struct dev_pasid_info add/remove
  iommu/vt-d: Add iommu_domain_did() to get did
  iommu/vt-d: Make intel_iommu_set_dev_pasid() to handle domain
    replacement
  iommu/vt-d: Limit intel_iommu_set_dev_pasid() for paging domain
  iommu/vt-d: Make intel_svm_set_dev_pasid() support domain replacement
  iommu/vt-d: Make identity_domain_set_dev_pasid() to handle domain
    replacement
  iommu/vt-d: Add set_dev_pasid callback for nested domain
  iommu: Make set_dev_pasid op support domain replacement

 drivers/iommu/amd/amd_iommu.h                 |   3 +-
 drivers/iommu/amd/pasid.c                     |   6 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  12 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +-
 drivers/iommu/intel/iommu.c                   | 176 ++++--
 drivers/iommu/intel/iommu.h                   |  34 ++
 drivers/iommu/intel/nested.c                  |  50 ++
 drivers/iommu/intel/pasid.c                   | 553 +++++++++++++-----
 drivers/iommu/intel/pasid.h                   |  22 +-
 drivers/iommu/intel/svm.c                     |  36 +-
 drivers/iommu/iommu.c                         |   3 +-
 include/linux/iommu.h                         |   5 +-
 13 files changed, 657 insertions(+), 250 deletions(-)

-- 
2.43.0

