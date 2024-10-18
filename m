Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02B185B6F
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231110; cv=none; b=dAknsBH9kwYb1iypyv+aReDB/8eRsw4DO8XLj548/xDB9RvbCYR+og6sjJuvBWMvMRVZ3wKjYe3jMjv2ZAxdTOssnhipi77Q3ACIJAJRCYy60FBXlzIWHsaK70cCks0Jggv+4OECP1m8ibPgluape+tlAmCqi0ROMAfLW9zmEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231110; c=relaxed/simple;
	bh=anh/7ifcMitvfZ8PgN/A+zUPUjBS0XS75RBtInw9vVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bUJJbbMGKqZOv38GLR9O6N6mgfUT/BVwf4xpHB4duYJxOu6f4wE9QcTViL6rStx4yt4b/PrHOkojw2hLBqGORLRTO995ORyERyoWvSsbDgy/SdgZ2Vp50fmqS8yBL82/cecdV06jQhWZ4er4mHz8hd6pwW3sYqJDpbW+dTArS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8Ww//CL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8Ww//CL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729231108; x=1760767108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=anh/7ifcMitvfZ8PgN/A+zUPUjBS0XS75RBtInw9vVU=;
  b=J8Ww//CLrSy8SU/uVaxkOX9aZ8ueHScrV6QLElgF/IDoDw6Ihjn61INs
   OhKykYzUMAoX9NeKQYWryzKmGfnF1g2a9abvFVTay411rWXvjZV97laQ1
   L2PT7M01SCuBzW+8JtOY8/G1jLhj+hNcKKW8Fq4ulM3ONHmfgseYcuX8T
   cHiM8lrfmqwtndi+QtLX6yb/7Ome/mZ/zcrDQeNLQeIw8/6DX0JhZIGnD
   PVmVp4M0gQiIr7oDg3Jo4hYY4Gfbe/4KodBJuxfrv08WHKFuMofWsoPPz
   Jz31pkAtUMbbwDiJRy0GrEpZr5Tcaweus10OH7mKJppuvtXDtsLnto0ZH
   g==;
X-CSE-ConnectionGUID: WXpdcDAjTmm403vH7Zvc9Q==
X-CSE-MsgGUID: QVYz1BkxTGKXXJGIrnaIgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39879115"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39879115"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:58:26 -0700
X-CSE-ConnectionGUID: 6mJ9z1/kTJ2/jOAHTNUAuw==
X-CSE-MsgGUID: VqAYaTPIT3qEVZSbSqDydA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78675715"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 17 Oct 2024 22:58:25 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	will@kernel.org
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com
Subject: [PATCH v2 0/3] Support attaching PASID to the blocked_domain
Date: Thu, 17 Oct 2024 22:58:21 -0700
Message-Id: <20241018055824.24880-1-yi.l.liu@intel.com>
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

This series makes the Intel iommu driver and ARM SMMUv3 driver support
attaching PASID to the blocked domain. While the AMD iommu driver does
not have the blocked domain yet, so still uses the remove_dev_pasid() op.

[1] https://lore.kernel.org/linux-iommu/20240816130202.GB2032816@nvidia.com/
[2] https://lore.kernel.org/linux-iommu/20241018055402.23277-2-yi.l.liu@intel.com/

v2:
 - Add Kevin's r-b
 - Adjust the order of patch 03 of v1, it should be the first patch (Baolu)

v1: https://lore.kernel.org/linux-iommu/20240912130653.11028-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Make the blocked domain support PASID

Yi Liu (2):
  iommu: Add a wrapper for remove_dev_pasid
  iommu/vt-d: Make the blocked domain support PASID

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++-----
 drivers/iommu/intel/iommu.c                 | 19 ++++++++-----
 drivers/iommu/intel/pasid.c                 |  3 ++-
 drivers/iommu/iommu.c                       | 30 ++++++++++++++++-----
 4 files changed, 45 insertions(+), 19 deletions(-)

-- 
2.34.1

