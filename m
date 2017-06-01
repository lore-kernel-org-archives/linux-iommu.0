From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 0/4] iommu: add qcom_iommu for early "B" family devices
Date: Thu,  1 Jun 2017 09:58:45 -0400
Message-ID: <20170601135849.14978-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sricharan <sricharan@codeaurora.org>, Archit Taneja <architt@codeaurora.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

An iommu driver for Qualcomm "B" family devices which do not implement
the ARM SMMU spec in a way that is compatible with the arm-smmu driver.

Since last version, a few updates to 3/4 based on Robin's suggestions.

Rob Clark (3):
  Docs: dt: document qcom iommu bindings
  iommu: arm-smmu: split out register defines
  iommu: add qcom_iommu

Stanimir Varbanov (1):
  iommu: qcom: initialize secure page table

 .../devicetree/bindings/iommu/qcom,iommu.txt       | 121 +++
 drivers/iommu/Kconfig                              |  10 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/arm-smmu-regs.h                      | 227 +++++
 drivers/iommu/arm-smmu.c                           | 203 +----
 drivers/iommu/qcom_iommu.c                         | 965 +++++++++++++++++++++
 6 files changed, 1325 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
 create mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/qcom_iommu.c

-- 
2.9.4
