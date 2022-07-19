Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3075393
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 20:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AE1C341C6;
	Tue, 19 Jul 2022 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658261409;
	bh=MphE1A0MBNfqUHD/G9dXrMp5nuRDZG0BZwbqaZHaQ0o=;
	h=Date:From:To:Cc:Subject:From;
	b=J/4WHpjr+uWqXVMuZGUZSvM9kkV7fLEuwipJv2oKyOCQb79xSgtIGA5an2ldHH6Io
	 JU9BxsFmHbC3bgiwsWs0x1h9qV/rgIN+Blceg02VDfU2zwUkOYTRjd+KCEbozQ+uzi
	 cw772Xt/UkqwoZZ41MQVwhLAQbk5tTUTPfiOCTQ24W8X18Ayei6P/dZ2mnv5s/RSkf
	 Gr4TjgfvdUqKYcMU8fB4UtPXaNlAl0K0LZ3jgMKWFzwoAmXxWDYFuI2Vj87D2J29Ug
	 Yq4XsUeelBIgpTdnnZJO7Udu6tbxsIxbnEBruoiZ3kGSEimraRhYrklYp0pwPNUsxk
	 SJfsGGWJ3acVA==
Date: Tue, 19 Jul 2022 21:10:04 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.20
Message-ID: <20220719201004.GA15241@willie-the-truck>
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

Please pull these Arm SMMU updates for 5.20. There's not a lot here and it's
actually all related to the Qualcomm hardware implementations. Summary in
the tag.

Cheers,

Will

--->8

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to a91eb6803c1c715738682fece095145cbd68fe0b:

  iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of loop (2022-07-19 18:30:32 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.20

- Add even more Qualcomm device-tree compatible strings

- Support dumping of IMP DEF Qualcomm registers on TLB sync timeout

- Fix reference count leak on device tree node in Qualcomm driver

----------------------------------------------------------------
Emma Anholt (1):
      iommu: arm-smmu-impl: Add 8250 display compatible to the client list.

Konrad Dybcio (2):
      dt-bindings: arm-smmu: Add compatible for Qualcomm SM6375
      iommu/arm-smmu-qcom: Add SM6375 SMMU compatible

Liang He (1):
      iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of loop

Sai Prakash Ranjan (1):
      iommu/arm-smmu-qcom: Add debug support for TLB sync timeouts

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 drivers/iommu/Kconfig                              |  10 ++
 drivers/iommu/arm/arm-smmu/Makefile                |   1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   | 142 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  34 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |  28 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   7 +-
 9 files changed, 219 insertions(+), 11 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
