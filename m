From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
Date: Mon, 10 Sep 2018 11:55:47 +0530
Message-ID: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com, robin.murphy@arm.com, bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
Cc: david.brown@linaro.org, tfiga@chromium.org, swboyd@chromium.org, linux-kernel@vger.kernel.org, robdclark@gmail.com, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Qcom's implementation of arm,mmu-500 on sdm845 has a functional/performance
errata [1] because of which the TCU cache look ups are stalled during
invalidation cycle. This is mitigated by serializing all the invalidation
requests coming to the smmu.

This patch series addresses this errata by adding new tlb_ops for
qcom,sdm845-smmu-500 [2]. These ops take context bank locks for all the
tlb_ops that queue and sync the TLB invalidation requests.

Besides adding locks, there's a way to expadite these TLB invalidations
for display and camera devices by turning off the 'wait-for-safe' logic
in hardware that holds the tlb invalidations until a safe level.
This 'wait-for-safe' logic is controlled by toggling a chicken bit
through a secure register. This secure register is accessed by making an
explicit SCM call into the EL3 firmware.
There are two ways of handling this logic -
 * Firmware, such as tz present on sdm845-mtp devices has a handler to do
   all the register access and bit set/clear. So is the handling in
   downstream arm-smmu driver [3].
 * Other firmwares can have handlers to just read/write this secure
   register. In such cases the kernel make io_read/writel scm calls to
   modify the register.
This patch series adds APIs in qcom-scm driver to handle both of these
cases.

Lastly, since these TLB invalidations can happen in atomic contexts
there's a need to add atomic versions of qcom_scm_io_readl/writel() and
qcom_scm_call() APIs. The traditional scm calls take mutex and we therefore
can't use these calls in atomic contexts.

This patch series is adapted version of how the errata is handled in
downstream [1].

Changes since v1:
 * Addressed Will and Robin's comments:
    - Dropped the patch[4] that forked out __arm_smmu_tlb_inv_range_nosync(),
      and __arm_smmu_tlb_sync().
    - Cleaned up the errata patch further to use downstream polling mechanism
      for tlb sync.
 * No change in SCM call patches - patches 1 to 3.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4842
[2] https://lore.kernel.org/patchwork/patch/974114/
[3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4864
[4] https://patchwork.kernel.org/patch/10565349/

Vivek Gautam (4):
  firmware: qcom_scm-64: Add atomic version of qcom_scm_call
  firmware/qcom_scm: Add atomic version of io read/write APIs
  firmware/qcom_scm: Add scm call to handle smmu errata
  iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata

 drivers/firmware/qcom_scm-32.c |  17 ++++
 drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
 drivers/firmware/qcom_scm.c    |  18 ++++
 drivers/firmware/qcom_scm.h    |   9 ++
 drivers/iommu/arm-smmu-regs.h  |   2 +
 drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
 include/linux/qcom_scm.h       |   6 ++
 7 files changed, 320 insertions(+), 46 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
