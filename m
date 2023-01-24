Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728037E4
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 14:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D8CC433D2;
	Tue, 24 Jan 2023 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674570604;
	bh=PHhA2thK99LDK7KgFn8m6wG4a/0PBj3xWHjyopgvXng=;
	h=Date:From:To:Cc:Subject:From;
	b=pF1DuxX/DyIX/oQWzTMDkA1U5+mrtHEhsjFiHgeClJt4FB+w+aAlRQsEStR27GSfe
	 2vgIqWZyBMU5QhhGYHAdWlK03K82YapJ+zjw2UXMsaXoIVFZLHhjbNc1+7Vqrp/PAB
	 9kmVfx4Vs5RJs01Q0ylD5W9cDv1Yfroqxdk3G2CBolLtgDNLRUnsURqWE/zJ0WMoSE
	 M4FduDVA0dTcuzKTizntStT4UbqmbZnPDteeLs+FAAGXK/ap9m7dskCtbJhltafaJx
	 AJ6+RR0gTSK3s3+rmigSv1N0qDC0fOThiHqh9zDpZ6ZGOVxzHpmSNKm5KHvkshx/kA
	 Nf8XH+1mH94SQ==
Date: Tue, 24 Jan 2023 14:29:59 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL v2] iommu/arm-smmu: Updates for 6.3
Message-ID: <20230124142957.GA26873@willie-the-truck>
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

This is an updated version of the pull request I previously sent here:

https://lore.kernel.org/r/20230120161527.GA22266@willie-the-truck

The branch is now based on your iommu/fixes branch rather than the
arm-smmu-fixes tag. I've also picked up an additional DT bindings patch
which came in since last time.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 142e821f68cf5da79ce722cb9c1323afae30e185:

  iommu/mediatek-v1: Fix an error handling path in mtk_iommu_v1_probe() (2023-01-13 13:46:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 8a24401701aa67c3bf8daa56c54d7bd1d6e69c23:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2023-01-24 11:45:41 +0000)

----------------------------------------------------------------
Arm SMMU updates for 6.3

- Device-tree binding updates:
  * Cater for three power domains on SM6375
  * Document existing compatible strings for Qualcomm SoCs
  * Tighten up clocks description for platform-specific compatible strings

- Enable Qualcomm workarounds for some additional platforms that need them

----------------------------------------------------------------
Bartosz Golaszewski (1):
      dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P

Bjorn Andersson (1):
      iommu/arm-smmu-qcom: Select identity domain for sc8280xp MDSS

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Allow 3 power domains on SM6375 MMU500

Krzysztof Kozlowski (1):
      dt-bindings: arm-smmu: disallow clocks when not used

Luca Weiss (1):
      dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible

Manivannan Sadhasivam (1):
      dt-bindings: arm-smmu: Fix binding for SDX55 and SDX65

Marijn Suijten (2):
      dt-bindings: arm-smmu: Add sm8150-smmu-500 to the list of Adreno smmus
      iommu/arm-smmu-qcom: Add SM8150 DPU compatible

Martin Botka (1):
      dt-bindings: arm-smmu: Document smmu-500 binding for SM6125

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 66 +++++++++++++++++++---
 .../devicetree/bindings/iommu/qcom,iommu.txt       |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  2 +
 3 files changed, 60 insertions(+), 9 deletions(-)
