Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD05020F3
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 09:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198E1C433EF;
	Fri,  9 Jun 2023 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686302081;
	bh=DptfuerpQuvFEU37yMHYofydyO+X8X2wLrda5zzTN3E=;
	h=Date:From:To:Cc:Subject:From;
	b=kT2Bc7HfIMxiczzL5A7WZygdjhNamVOeYcA1fEHADYX2Xm5T07GmBgpAiZVkpnYXu
	 B9OIPkM8ZFQSyNSke5uHzBPo4k2BNqvg7r5jS2wlULuqvbFrpGwnVuD+5jBm/CTpzJ
	 HZnt749JivaPLQAglV6/7mVDleseVNKy986P9/9MGJCRAkp1Ilvmj/Do0s4fclYc7N
	 nuurhr/TbU4ep1OenWlCZjjSiomBFHWsnS2RSF8VdtOqnukmA95kWVBtqihznz9Kw6
	 GuJqft7Y8d/vu5WFrmZVTgJ75g+phWeonqqoaaTKh9iPY9FUmhcj3WBYB2oicIwDtB
	 ZFrzMmmz/X6eA==
Date: Fri, 9 Jun 2023 10:14:36 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.5
Message-ID: <20230609091435.GA3741@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Joerg,

Please pull these Arm SMMU updates for 6.5. There's the usual summary
in the tag, but the most important thing is a crop of errata workarounds
from Robin for Arm's MMU-700 SMMUv3 implementation.

Cheers,

Will

--->8

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to c5fb66a17a4362a8990e0d3d050c1c5a415dfc7e:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2023-06-08 22:27:26 +0100)

----------------------------------------------------------------
Arm SMMU updates for 6.5

- Device-tree binding updates:
  * Add missing clocks for SC8280XP and SA8775 Adreno SMMUs
  * Add two new Qualcomm SMMUs in SDX75 and SM6375

- Workarounds for Arm MMU-700 errata:
  * 1076982: Avoid use of SEV-based cmdq wakeup
  * 2812531: Terminate command batches with a CMD_SYNC
  * Enforce single-stage translation to avoid nesting-related errata

- Set the correct level hint for range TLB invalidation on teardown

----------------------------------------------------------------
Bartosz Golaszewski (1):
      dt-bindings: iommu: arm,smmu: enable clocks for sa8775p Adreno SMMU

Bjorn Andersson (1):
      dt-bindings: arm-smmu: Fix SC8280XP Adreno binding

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Add SM6375 GPU SMMU

Robin Murphy (5):
      iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
      iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
      iommu/arm-smmu-v3: Add explicit feature for nesting
      iommu/arm-smmu-v3: Document nesting-related errata
      iommu/arm-smmu-v3: Set TTL invalidation hint better

Rohit Agarwal (1):
      dt-bindings: arm-smmu: Add SDX75 SMMU compatible

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 Documentation/arm64/silicon-errata.rst             |  4 ++
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 12 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 59 +++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  8 +++
 4 files changed, 78 insertions(+), 5 deletions(-)
