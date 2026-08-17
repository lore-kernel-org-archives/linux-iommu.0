Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F242901B
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980128; cv=none; b=qCnlXtbaryIeVXMSp1Qt9iW/74jGrE41iRVbVQ9TAlnLaVkt9TX29ATus6c80kCnTKheEtNK+rYAJLT1FriedVQN57lUOt7ArcFxpmjn6gNibohifosdXHLckpKnHp87w1mUozC69/t8KfNxC0SENPfJmB4i8M84CjzP8oqsq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980128; c=relaxed/simple;
	bh=W6voWMSIXcTOLlQL1vvfDmAX05fiYTOatnOT2wU7duA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UbSMS4w/Z+uLNcFIFtQwxrxfuwibb+deIuwaZ22BWocUi9pOShjVBu/nWg8wTbblL1J1fmoY9U1sKB/22LJLhUIApnncQTOO10Ez9NfjPeOcQrTl1+E2Y02uOS8KLTuGSO2N8+qr7FBq0c5e6H6wOiOi2CE5FynYoh9VHE9xKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5001013bc7be0d60b86.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1013:bc7b:e0d6:b86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3159E206667;
	Mon, 17 Aug 2026 17:22:04 +0200 (CEST)
Date: Mon, 17 Aug 2026 17:22:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v7.3
Message-ID: <aoMm4FPj8xVb-oK2@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.3

for you to fetch changes up to 3c6a2bac15247bc4f28125247ff89165324612fe:

  Merge branches 'arm/smmu/updates', 'arm/smmu/bindings', 'mediatek', 'qualcomm/msm', 'rockchip', 'ti/omap', 'riscv', 'intel/vt-d', 'amd/amd-vi', 'core' and 'typos' into next (2026-08-11 09:12:19 +0200)

----------------------------------------------------------------
IOMMU updates for Linux v7.3:

- ARM SMMUv2:
  - Device-tree binding updates for Qualcomm Eliza, Maili, Shikra and
    IPQ9650 SoCs.
  - Add support for Qualcomm SM8450.
  - Numerous fixes for lifetime and ordering issues found by Sashiko in
    the Qualcomm driver.

- ARM SMMUv3:
  - Fix interrupt type in device-tree binding example for NVIDIA CMDQV.
  - Numerous fixes for issues identified by Sashiko in the NVIDIA CMDQV
    driver.
  - Work around TLB erratum T264-SMMU-3 on Tegra264 by repeating the
    invalidation sequence.
  - Add support for HAFT (hardware access flag in table entries) when
    using SVA.
  - Probe for 52-bit addressing with a page size smaller than 64k ('DS')
    but don't do anything with it for now.
  - Minor driver improvements (remove sort_nonatomic(), use
    readl_relaxed_poll_timeout_atomic(), fix IOPF teardown ordering).

- Intel VT-d:
  - Consolidation of complex enablement logic into a clean, priority-based
    state machine.
  - Support for the DMA_REMAP_OPT_OUT flag from the VT-d v5.2
    specification.
  - An update to cache_tag_flush_devtlb_psi() to use full-range constants
    instead of modifying shared variables for CACHE_TAG_NESTING_DEVTLB.
  - A fix for the UCTP context-table slot when copying root entries.
  - Fixes for several pre-existing issues reported by Sashiko.
  - General code cleanup and refinement.

- AMD IOMMU:
  - Add SNP page-mode-0 support, enabling passthrough, v2 DMA page
    tables and host SVA on supporting systems.
  - Fix invalid PPR handling, COMPLETE_PPR responses and guest-mode
    reporting.
  - Improve Southbridge IOAPIC validation and remove the dependency on
    hard-coded device IDs.
  - Fix PCI-device lifetime, debugfs and diagnostic issues.

- IOMMU core and IOMMUFD:
  - Restore serialization of the shared MSI-page list.
  - Fix SVA-handle publication and several IOMMUFD reference and error
    path leaks.
  - Return the expected zero result for invalid generic page-table
    translations.
  - Allocate per-CPU IOVA magazines lazily to reduce memory use on
    large systems.

- PCI ATS:
  - Make VF support checks account for the associated PF and validate
    that VF and PF Smallest Translation Unit settings agree.

- Platform drivers:
  - Fix Qualcomm runtime-PM, probe unwind, fault reporting and page
    table initialization races.
  - Rework Rockchip state handling and fix clock, probe and stale-fault
    handling.
  - Fix smaller issues in the MSM and MediaTek drivers.

- Device-tree bindings:
  - Add new Qualcomm SMMU compatibles, convert the OMAP IOMMU binding
    to YAML, and fix the Tegra264 CMDQV interrupt example.

- Various smaller cleanups, documentation fixes and a Rust IOMMU
  safety/readability improvement.

----------------------------------------------------------------
Akari Tsuyukusa (1):
      iommu/mediatek-v1: Fix off-by-one in MT2701_LARB_NR_MAX

Akhil P Oommen (1):
      dt-bindings: arm-smmu: Document GPU SMMU for Eliza SoC

Andrew Jones (1):
      iommu/dma: Restore locking around msi_page_list

Ashish Mhetre (4):
      dt-bindings: iommu: Fix interrupt type in example
      iommu/arm-smmu-v3: Add CFGI/TLBI-repeat workaround
      iommu/arm-smmu-v3-iommufd: Report CFGI/TLBI-repeat erratum
      iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat workaround on Tegra264

Bhargav Joshi (1):
      dt-bindings: iommu: ti,omap-iommu: Convert to DT schema

Bibek Kumar Patro (1):
      dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC

Desnes Nunes (1):
      iommu/vt-d: Fix UCTP context table slot when copying root entries

Dmitry Antipov (1):
      iommu/vt-d: Use kstrtoint_from_user() in dmar_perf_latency_write()

Esteban Urrutia (1):
      iommu/arm-smmu-qcom: Add SM8450 MDSS compatible

Guanghui Feng (1):
      iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared variables in flush loop

Haoxiang Li (1):
      iommu/qcom: Remove sysfs device on probe failure path

Jiaxing Hu (2):
      iommu/rockchip: Take all DT clocks
      iommu/rockchip: Clear stale page faults before enabling stall

Jingyi Wang (1):
      dt-bindings: arm-smmu: qcom: Add compatible for Maili SoC

Joerg Roedel (1):
      Merge branches 'arm/smmu/updates', 'arm/smmu/bindings', 'mediatek', 'qualcomm/msm', 'rockchip', 'ti/omap', 'riscv', 'intel/vt-d', 'amd/amd-vi', 'core' and 'typos' into next

Kathiravan Thirumoorthy (1):
      dt-bindings: arm-smmu: qcom: add compatible for IPQ9650 SoC

Kevin Tian (9):
      iommu/vt-d: Fix no_iommu to disable platform opt-in
      iommu/vt-d: Force requesting ACS when tboot is enabled
      iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
      iommu/vt-d: Consolidate dmar policy management and force_on logic
      iommu/vt-d: Use dmar_can_force_on() for platform opt-in
      iommu/vt-d: Call dmar_can_force_on() for tboot opt-in
      iommu/vt-d: Remove the 'force_on' variable
      iommu/vt-d: Remove dmar_disabled
      iommu/vt-d: Support the new DMA_REMAP_OPT_OUT flag bit

Kuan-Wei Chiu (1):
      iommu/arm-smmu-v3: Replace sort_nonatomic() with sort()

Li RongQing (2):
      iommu/amd: Fix undefined behavior in devid_write debugfs function
      iommu/vt-d: Use logical OR operator for privilege mode check

Logan Odell (1):
      iommu/iova: Move CPU magazine init to first insert

Lu Baolu (5):
      iommu/vt-d: Cache max domain ID to avoid redundant calculation
      iommu/vt-d: Clear Present bit before tearing down copied context entry
      iommu/vt-d: Fix iopf_refcount leak on RID domain replacement
      iommu/vt-d: Tear down scalable-mode context on probe failure
      iommu/vt-d: Flush context cache with correct SID when tearing down aliases

Mukesh Ojha (6):
      iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
      iommu/qcom: Use devm_pm_runtime_enable() in qcom_iommu_device_probe()
      iommu/qcom: Check pm_runtime_resume_and_get() return in probe
      iommu/qcom: Fix pgtbl_ops leak in qcom_iommu_init_domain() error path
      iommu/qcom: Publish pgtbl_ops before releasing init_mutex
      iommu/qcom: Enable clocks before hardware access in qcom_iommu_ctx_probe()

Nicolin Chen (13):
      iommu/arm-smmu-v3: Declare eats_s1chk and eats_trans as host-endian u64
      iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
      iommu/tegra241-cmdqv: Publish an LVCMDQ only after it is fully initialized
      iommu/tegra241-cmdqv: Synchronize the error ISR against VINTF (de)init
      iommu/tegra241-cmdqv: Harden error-map index handling in the error ISR
      iommu/tegra241-cmdqv: Don't run the error ISR before probe sets up vintfs
      iommu/tegra241-cmdqv: Don't fall back to a freed smmu after devm_krealloc()
      iommu/tegra241-cmdqv: Free the error IRQ before tearing down VINTFs
      iommu/tegra241-cmdqv: Reject a vSID wider than the SID_MATCH field
      iommu/tegra241-cmdqv: Require exactly one Stream ID for a vSID
      iommu/tegra241-cmdqv: Fix VINTF0 leak on the init-failure path
      iommu/tegra241-cmdqv: Rate-limit the error ISR's log message
      iommu/arm-smmu-v3: Support IDR5.DS and widen the TLBI SCALE field

Nicolás Antinori (1):
      rust: iommu: replace core::mem::zeroed with Zeroable::zeroed

Pan Chuang (1):
      iommu: arm: Remove redundant dev_err()/dev_err_probe()

Pengpeng Hou (1):
      iommu/msm: Limit the per-master Machine ID list

Pranjal Shrivastava (5):
      PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
      PCI/ATS: Validate STU for VFs in pci_prepare_ats()
      iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
      iommu/vt-d: Fail probe on ATS configuration failure
      iommu/arm-smmu-v3: Convert to use atomic poll timeout

Robin Murphy (2):
      arm64: Add override for MMFR1.HAFDBS
      iommu/arm-smmu-v3: Add HAFT support for SVA

Shameer Kolothum (2):
      iommu/arm-smmu-v3: Manage teardown with devm
      iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown

Shuai Xue (5):
      iommu/amd: Put PCI device after handling PPR faults
      iommu/sva: Set handle->dev before the SVA handle is visible
      iommufd: Avoid locking internal accesses during unmap
      iommufd: Release current IOAS on xa_store() failure
      iommupt: Return zero for invalid iova_to_phys() ranges

Simon Xue (1):
      iommu/rockchip: Drop global rk_ops in favor of per-device ops

Uwe Kleine-König (The Capable Hub) (1):
      iommu/riscv: Drop superfluous zeros in pci_device_id array

Vasant Hegde (6):
      iommu/amd: Fix incorrect device ID in invalid PASID error message
      iommu/amd: Introduce PPR_TAG_LAST_PAGE() macro
      iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests
      iommu/amd: Rate limit INVALID_PPR_REQUEST error logging
      iommu/amd: Fix GN bit setting in COMPLETE_PPR_REQUEST command
      iommu/amd: Add SNP page mode 0 support

Vladimir Zapolskiy (1):
      iommu/msm: Return -ENOMEM on memory allocation failure in probe

Wei Wang (3):
      iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
      iommu/amd: Fix false positive in SB IOAPIC IVRS validation
      iommu/amd: Dynamically verify Southbridge IOAPIC via PCI config space

Weimin Xiong (1):
      iommu/msm: Unwind probe state on registration failure

ZhaoJinming (2):
      iommu/rockchip: Fix silent probe success when all MMU resources fail
      iommu/vt-d: Fix copied_tables bitmap leak on error in copy_translation_tables

xiongweimin (6):
      iommu/vt-d: Fix spelling of "guarantees" in comment
      iommu: Fix possessive "its" in group remove kdoc
      iova: Fix spelling of "reserved" in comment
      iommu/arm-smmu-v3: Fix grammar in comment
      iommu/mtk: Fix spelling of correspondence in comment
      iommu/amd: Fix grammar and typos in comments

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/arch/arm64/silicon-errata.rst        |   2 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   8 +
 .../bindings/iommu/nvidia,tegra264-cmdqv.yaml      |   2 +-
 .../devicetree/bindings/iommu/ti,omap-iommu.txt    |  59 ------
 .../devicetree/bindings/iommu/ti,omap-iommu.yaml   | 114 +++++++++++
 arch/arm64/kernel/pi/idreg-override.c              |   2 +
 drivers/iommu/amd/amd_iommu_types.h                |   9 +-
 drivers/iommu/amd/debugfs.c                        |  12 +-
 drivers/iommu/amd/init.c                           |  99 ++++++---
 drivers/iommu/amd/iommu.c                          |  75 +++++--
 drivers/iommu/amd/ppr.c                            |  12 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   7 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  24 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 188 +++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  13 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     | 226 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   9 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  39 ++--
 drivers/iommu/dma-iommu.c                          |  13 ++
 drivers/iommu/generic_pt/iommu_pt.h                |   2 +-
 drivers/iommu/intel/cache.c                        |   5 +-
 drivers/iommu/intel/debugfs.c                      |  16 +-
 drivers/iommu/intel/dmar.c                         |  98 ++++++++-
 drivers/iommu/intel/iommu.c                        | 154 ++++++++------
 drivers/iommu/intel/iommu.h                        |  67 ++++--
 drivers/iommu/intel/pasid.c                        |   9 +-
 drivers/iommu/intel/prq.c                          |   2 +-
 drivers/iommu/intel/svm.c                          |   2 +-
 drivers/iommu/iommu-sva.c                          |   2 +-
 drivers/iommu/iommu.c                              |   4 +-
 drivers/iommu/iommufd/device.c                     |   4 +-
 drivers/iommu/iommufd/ioas.c                       |   2 +
 drivers/iommu/iova.c                               |  31 +--
 drivers/iommu/msm_iommu.c                          |  15 +-
 drivers/iommu/mtk_iommu.c                          |   2 +-
 drivers/iommu/mtk_iommu_v1.c                       |   2 +-
 drivers/iommu/riscv/iommu-pci.c                    |   6 +-
 drivers/iommu/rockchip-iommu.c                     | 117 +++++------
 drivers/pci/ats.c                                  |  13 +-
 include/linux/dmar.h                               |   1 +
 include/uapi/linux/iommufd.h                       |  17 +-
 rust/kernel/iommu/pgtable.rs                       |   3 +-
 44 files changed, 1027 insertions(+), 464 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/ti,omap-iommu.yaml

Please pull.

Thanks,

	Joerg
