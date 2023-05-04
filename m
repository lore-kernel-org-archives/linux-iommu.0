Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08B7156FC
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 21:11:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC7F61FB;
	Thu,  4 May 2023 14:11:44 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B81253F67D;
	Thu,  4 May 2023 14:10:59 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	jgg@nvidia.com
Cc: will@kernel.org,
	schnelle@linux.ibm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommu: Make flush queues a proper capability
Date: Thu,  4 May 2023 22:10:54 +0100
Message-Id: <cover.1683233867.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Since it came up in discussion on the default domain series, it seemed
pertinent to dig this idea up, whcih I started a while ago, and finish
it off.

Cheers,
Robin.


Robin Murphy (2):
  iommu: Add a capability for flush queue support
  iommu: Use flush queue capability

 drivers/iommu/amd/iommu.c                   | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 4 ++--
 drivers/iommu/dma-iommu.c                   | 3 ++-
 drivers/iommu/intel/iommu.c                 | 2 +-
 drivers/iommu/iommu.c                       | 3 ++-
 include/linux/iommu.h                       | 6 ++++++
 7 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

