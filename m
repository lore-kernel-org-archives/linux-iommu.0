Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDC8C0D
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 14:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C303C4339B;
	Tue, 11 Apr 2023 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681223166;
	bh=YuM2O01SoB7qsK2kdvinWtyQVTT9oJLIx/qQD2GkO1M=;
	h=Date:From:To:Cc:Subject:From;
	b=EIwfJvtoPlvUVU0TLboD/60OZsbhgjSA5OeUZdIWdJ7W64LvJvsOE6rDk/ZDmG24y
	 YaR3j8h+CS/5VK4UhNZhXx9TXWS1MC14Auh5DdVb6LYSHNKiwxVjLNkjPNfgbdwYk8
	 6eo5/1zoPhTf6R8fpXNEzI4PaP0HCG7iVsT489khzUZ7U6oafTo73Ns3XSECpqngtu
	 wFlyEO5q7WPGT01Qk19UNmVgoPoj80fvTDQKuCtVE4YHciql/O3TsHSJcHNy8sMF1Q
	 XmhafdxeXQlzX+u5lRa9nXMU1yBeySYbFc/2uojBkUkZS387jzDoSI1WDBdveNDh8j
	 /RWz3kolNlcJw==
Date: Tue, 11 Apr 2023 15:26:01 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.4
Message-ID: <20230411142600.GA22971@willie-the-truck>
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

Please pull these Arm SMMU updates for 6.4. It's mostly the usual minor
DT binding updates, but there are also a couple of functional changes
relating to quirk detection and queue overflow.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to ca08b2a65b5cf2814e4db40bfa5a240600e88cee:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2023-04-11 14:05:06 +0100)

----------------------------------------------------------------
Arm SMMU updates for 6.4

- Device-tree binding updates:
  * Allow Qualcomm GPU SMMUs to accept relevant clock properties
  * Document Qualcomm 8550 SoC as implementing an MMU-500
  * Favour new "qcom,smmu-500" binding for Adreno SMMUs

- Fix S2CR quirk detection on non-architectural Qualcomm SMMU
  implementations

- Acknowledge SMMUv3 PRI queue overflow when consuming events

- Document (in a comment) why ATS is disabled for bypass streams

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: arm-smmu: Add compatible for SM8550 SoC

Jean-Philippe Brucker (1):
      iommu/arm-smmu-v3: Explain why ATS stays disabled with bypass

Konrad Dybcio (3):
      dt-bindings: arm-smmu: Use qcom,smmu compatible for MMU500 adreno SMMUs
      dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
      dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU

Manivannan Sadhasivam (1):
      iommu/arm-smmu-qcom: Limit the SMR groups to 128

Tomas Krcka (1):
      iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 45 ++++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 26 ++++++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         | 16 +++++++-
 3 files changed, 77 insertions(+), 10 deletions(-)
