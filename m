Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D31322309
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241863; cv=none; b=LOh1FTo39JRV6LoOCXoJ6d7UDdzd+XFm8uYrhU2rUYGRa5CgedKK1mjxTg6Em35lwOSEq+EpWfQqTQ36TZkesr86PiyDr8BBKQnkML3PALlO3JJWwS8H/pHFApqDHkOaiOZFKmtoLvUpFHl0+L2rFgApXDfCFvTyxxr13QfOru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241863; c=relaxed/simple;
	bh=aBpacNPMohRcwSsOR11sSC5U39gBhwta0pqjN6fSZyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UStXsSN1mSCc0nnjml3pqInmY3fzsazS9EJ3NIj5VkQbmeLA02voLTWU9ySWqpvqRSA0DDRUehMPIlA454423rnMJ4xMnYiJ5ai7ViLoaeYlrwMmj6UZSEsbVgm6iIInIDJeSyEk+EaaP6wNn1atvvl31xvRorTkFDIjQ1tjt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuiVNt4X; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuiVNt4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725241861; x=1756777861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aBpacNPMohRcwSsOR11sSC5U39gBhwta0pqjN6fSZyw=;
  b=HuiVNt4XI3pIRjopYRZXBDQF2uros7rjjM57nddaG9BQC+hfGD4UsfLf
   iDyTNkup2ee5t+ddRRSZVXMkUisZjnQn3fNB2ooUp/k1W9QN8jDPa5ie6
   hvof8ux07ESuU0KPMMeYnQ1ehb2FCjexWRbKwHKsxsgV/euUe2DsKpddO
   JBUHllZBTNVzmzWiKVl40Xk0B425lbJ+FBBG2QDxF8CEz9ikGu1MKUflt
   gck6uPyjq9JRANsN8iSrX1FJRj+BiWKVRt1gzq8lRFFDnGwClNrxFT4GS
   1T26KoAmnxdGoVj1Lm7sieg3lhH6u7ILDKhcEpy+J8Q70/09t/MpVjXKz
   g==;
X-CSE-ConnectionGUID: ShxUFgMMQVevMZ+EBBacLw==
X-CSE-MsgGUID: 4ke43anSTeWJ8oXWIRivAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41307653"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="41307653"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 18:51:01 -0700
X-CSE-ConnectionGUID: IRhh+f7nQQCcc3lrV/qkew==
X-CSE-MsgGUID: V2HiG/ObQqC4xEN2WrNWAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="64817612"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2024 18:50:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/3] drm: Use iommu_paging_domain_alloc()
Date: Mon,  2 Sep 2024 09:46:57 +0800
Message-Id: <20240902014700.66095-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <17de3f5fdd35> ("iommu: Retire bus ops") removes iommu ops from
the bus structure. The iommu subsystem no longer relies on bus for
operations. So iommu_domain_alloc() interface is no longer relevant.

A new helper named iommu_paging_domain_alloc() was introduced in the
iommu subsystem as a replacement of iommu_domain_alloc(). This helper
relies on the device for IOMMU API use instead of the bus.

The replacement work started from this series:

https://lore.kernel.org/linux-iommu/20240610085555.88197-1-baolu.lu@linux.intel.com/

Several patches have already been merged into the mainline kernel, but
we've decided to route all remaining ones through the subsystem tree.

Change log:
v2:
 - Patch 3/3: use dev->dev.parent as the input for
   iommu_paging_domain_alloc(), suggested by Thierry Reding.
   https://lore.kernel.org/linux-iommu/qyvyd2ftebjlgmzyayfvxsqa64c4wgx7keix3a6eexdspbvawy@a5ffnm5h5tgp/

v1:
 - https://lore.kernel.org/linux-iommu/20240812071034.9443-1-baolu.lu@linux.intel.com/

Lu Baolu (3):
  drm/nouveau/tegra: Use iommu_paging_domain_alloc()
  drm/rockchip: Use iommu_paging_domain_alloc()
  drm/tegra: Use iommu_paging_domain_alloc()

 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |  4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 10 +++++++---
 drivers/gpu/drm/tegra/drm.c                        |  5 +++--
 3 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.34.1

