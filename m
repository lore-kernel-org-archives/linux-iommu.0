Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B7154A9
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 15:39:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B55081063;
	Wed, 10 May 2023 08:39:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CBC63F67D;
	Wed, 10 May 2023 08:38:53 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	nicolinc@nvidia.com,
	jean-philippe@linaro.org
Subject: [PATCH 0/4] iommu/arm-smmu-v3: Arm SMMU errata bits
Date: Wed, 10 May 2023 16:38:42 +0100
Message-Id: <cover.1683731256.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Further to the discussion on the nesting series a while back, here's a
mini-series to help us start taking more of an interest in SMMU errata.
Patch #1 is more about the infrastucture than that erratum itself, but
since I *had* already written it up (5 years ago!) I figured why not
just build on it as-is. The rest is effectively just documentation at
this point, but getting us ready for all the hitherto unmet conditions
that IOMMUFD nesting is going to open up.

Thanks,
Robin.


Robin Murphy (4):
  iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
  iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
  iommu/arm-smmu-v3: Add explicit feature for nesting
  iommu/arm-smmu-v3: Document nesting-related errata

 Documentation/arm64/silicon-errata.rst      |  4 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
 3 files changed, 62 insertions(+)

-- 
2.39.2.101.g768bb238c484.dirty

