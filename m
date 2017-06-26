From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 0/4] iommu: add qcom_iommu for early "B" family devices
Date: Mon, 26 Jun 2017 08:43:48 -0400
Message-ID: <20170626124352.21726-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Archit Taneja <architt@codeaurora.org>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

An iommu driver for Qualcomm "B" family devices which do not implement
the ARM SMMU spec in a way that is compatible with the arm-smmu driver.

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
 drivers/iommu/qcom_iommu.c                         | 921 +++++++++++++++++++++
 6 files changed, 1281 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
 create mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/qcom_iommu.c

-- 
2.9.4
