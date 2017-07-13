From: Rob Clark <robdclark@gmail.com>
Subject: [RESEND PATCH 0/4] iommu: add qcom_iommu for early "B" family devices
Date: Thu, 13 Jul 2017 08:07:43 -0400
Message-ID: <20170713120747.20490-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Archit Taneja <architt@codeaurora.org>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

An iommu driver for Qualcomm "B" family devices which do implement the
ARM SMMU spec, but not in a way that arm-smmu can support.

(I initially added support to arm-smmu, but it was decided that approach
was too intrusive and it would be cleaner to have a separate driver.)

I should note that all the dependencies for this driver have been merged
since 4.12, and it is the last thing needed for having another fully-
enabled (gpu/display/video codec/etc) ARM device that is fully upstream.

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
 drivers/iommu/qcom_iommu.c                         | 932 +++++++++++++++++++++
 6 files changed, 1292 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
 create mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/qcom_iommu.c

-- 
2.13.0
