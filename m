Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B311A42DA;
	Thu, 12 Sep 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145980; cv=none; b=mLUCE3ihy2WahpJxHYa2WBKDOKkQGJTPm+vEzEmjolthXHU420BxAaxG056cbGtYDYzmBerx/8m5/802jqM0VNaaYSu8pXwMqHwNlFcqDu77EuqBnzt9IAFD9x4V4H5lv5PWshmTm7VzqhituhqWtujKOsI0uQ65RQ0PL/GXBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145980; c=relaxed/simple;
	bh=AvtzSC3Csk3z8NPXkiPtAx9GovjKGdqPfKXOIZCX9io=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CRO2H4A5wAJRVkkDmZ12jV//Vqh7dkk6cVWNrf205/xv8UaneguhyM6r4EbylLI+vJCfUoiBC8JNnx8mrXdvr8EVZ5LSoayqIJcCUjyvKCttZESaBppoNsRCA7hCcPynO9gPUDCZ5O0SEfWymUAuG4O7FE4DluZeOd2v9eAFGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNnBqrhY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNnBqrhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95040C4CEC3;
	Thu, 12 Sep 2024 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726145979;
	bh=AvtzSC3Csk3z8NPXkiPtAx9GovjKGdqPfKXOIZCX9io=;
	h=Date:From:To:Cc:Subject:From;
	b=MNnBqrhYNKwn+5KcG4nGejpUPJa5NNohyz7PxGVEtxVTB7JAHO5VN14tbtFOHKuFA
	 oxuIUJsn1DhWFko6lPDOsdR9DxjPSHxKlOmxcIo94Lrc0wjKFJN4/AwOj24SdPh7Cr
	 I+5yAMOEwV8sn73fIuDNnQhbKec22uRfmYt5eM0TXPrioe15hHwKx9untYP4ym2Fir
	 LltFOvZkoYxxznr5Yvr1aovGjty6gNyiNmuvQBqWabzhqeb1ttr4pYCz+DHpH3fr11
	 FkYHBknjL6NSMv7Q1/7v12K6pt9m+4IzyQMvu0xLQN+lA/RlKYu1SRgoREiq4eiFus
	 MtIlU7h5H7oTg==
Date: Thu, 12 Sep 2024 13:59:35 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.12
Message-ID: <20240912125934.GA23244@willie-the-truck>
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

Please pull these Arm SMMU updates for v6.12. The big new feature is
support for NVIDIA's virtual command queue implementation for SMMUv3,
but everything is summarised in the tag.

** Please note **: I've already pushed this to the arm/smmu branch for
-next coverage, but I thought sending a pull request was still useful
for the records and the signed tag. If you want to recreate the branch,
please feel free.

See you at LPC!

Cheers,

Will

--->8

The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to f1c6cf8e7ab9d7498ee70c69d5093165952d3595:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2024-09-12 12:54:14 +0100)

----------------------------------------------------------------
Arm SMMU updates for 6.12

- SMMUv2:
  * Devicetree binding updates for Qualcomm MMU-500 implementations.
  * Extend workarounds for broken Qualcomm hypervisor to avoid touching
    features that are not available (e.g. 16KiB page support, reserved
    context banks).

- SMMUv3:
  * Support for NVIDIA's custom virtual command queue hardware.
  * Fix Stage-2 stall configuration and extend tests to cover this area.
  * A bunch of driver cleanups, including simplification of the master
    rbtree code.

- Plus minor cleanups and fixes across both drivers.

----------------------------------------------------------------
Dan Carpenter (2):
      iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
      iommu/tegra241-cmdqv: Fix ioremap() error handling in probe()

Dmitry Baryshkov (1):
      iommu/arm-smmu-qcom: apply num_context_bank fixes for SDM630 / SDM660

Jason Gunthorpe (10):
      iommu/arm-smmu-v3: Add struct arm_smmu_impl_ops
      iommu/arm-smmu-v3: Use the new rb tree helpers
      iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()
      iommu/arm-smmu-v3: Add types for each level of the 2 level stream table
      iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg
      iommu/arm-smmu-v3: Remove strtab_base/cfg
      iommu/arm-smmu-v3: Do not use devm for the cd table allocations
      iommu/arm-smmu-v3: Shrink the cdtab l1_desc array
      iommu/arm-smmu-v3: Add types for each level of the CD table
      iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg

Konrad Dybcio (1):
      iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/ 16K pages

Marc Gonzalez (1):
      iommu/arm-smmu-qcom: hide last LPASS SMMU context bank from linux

Mostafa Saleh (2):
      iommu/arm-smmu-v3: Match Stall behaviour for S2
      iommu/arm-smmu-v3-test: Test masters with stall enabled

Nate Watterson (1):
      iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV

Nicolin Chen (11):
      iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
      iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_build_sync_cmd
      iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
      iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
      iommu/arm-smmu-v3: Add ARM_SMMU_OPT_TEGRA241_CMDQV
      iommu/arm-smmu-v3: Add acpi_smmu_iort_probe_model for impl
      iommu/arm-smmu-v3: Start a new batch if new command is not supported
      iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a guest owned VINTF
      iommu/tegra241-cmdqv: Fix -Wformat-truncation warnings in lvcmdq_error_header
      iommu/tegra241-cmdqv: Drop static at local variable
      iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent

Nikunj Kela (1):
      dt-bindings: arm-smmu: document the support on SA8255p

Rob Clark (1):
      iommu/arm-smmu: Un-demote unhandled-fault msg

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

Zhang Zekun (1):
      iommu/arm-smmu-v3: Remove the unused empty definition

Zhenhua Huang (1):
      dt-bindings: arm-smmu: Add compatible for QCS8300 SoC

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   5 +
 MAINTAINERS                                        |   1 +
 drivers/iommu/Kconfig                              |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile             |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   |  83 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 576 +++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        | 137 +++-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     | 909 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  28 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   2 +-
 10 files changed, 1463 insertions(+), 290 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
