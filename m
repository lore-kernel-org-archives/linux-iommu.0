Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA101FA8
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 07:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676275094; x=1707811094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bVUDxCsJ0qh4wSYknVng2u8pwgP80u8CrU610g0J+tg=;
  b=mX7tc/YAUJJfME6wczSY7eDcP1E235dwjRz6WtN7zHHhDtlb9ajrbxug
   BR4uRBKQPJerQYhGP+zn6dDcTj62tGEwZ5v2fAUVznlnsXE9mSjtrLCGL
   kpnnAQxZ/8hd8mQDHpiCWYHzBY22KI1TvDTqvekNFQClz/zTe/J7FWlAq
   ghfLJWVQ9sek+615LfVJS2Y8launI1q4eD89kwkYU87kBfkzPreyYGHYr
   nVAjF716yT5okXACMirX0jusMzaoB/QNDApHoJ5zrudRa8/J2dNElK78M
   1814oh3w9IS0ll76iOaihZsDxtLTqWbwlOY19RgIOCeMGxM5EHkrVkfmb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="417058740"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="417058740"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 23:58:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842684799"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="842684799"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2023 23:58:11 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/4] iommu: Extend changing default domain to normal group
Date: Mon, 13 Feb 2023 15:49:37 +0800
Message-Id: <20230213074941.919324-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU group sysfs interface allows users to change the default
domain of a group. The current implementation uses device_lock() to make
sure that the devices in the group are not bound to any driver and won't
be bound during the process of changing the default domain. In order to
avoid a possible deadlock caused by lock order of device_lock and
group->mutex, it limits the functionality to singleton groups only.

The recently implemented DMA ownership framework can be applied here to
replace device_lock(). In addition, add an rw lock to ensure that the
iommu ops of the devices is always valid during the process of changing
default domain.

With above replacement and enhancement, the device_lock() could be
removed and the singleton-group-only limitation could be removed.

The whole series is also available on github:

https://github.com/LuBaolu/intel-iommu/commits/iommu-sysfs-default-domain-extension-v1

Please help to review and suggest.

Lu Baolu (4):
  iommu: Add dev_iommu->ops_rwsem
  iommu: Use group ownership to avoid driver attachment
  iommu: Remove unnecessary device_lock()
  iommu: Cleanup iommu_change_dev_def_domain()

 include/linux/iommu.h |   3 +
 drivers/iommu/iommu.c | 187 +++++++++++++++++-------------------------
 2 files changed, 78 insertions(+), 112 deletions(-)

-- 
2.34.1

