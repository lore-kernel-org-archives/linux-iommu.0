From: thor.thayer@linux.intel.com
Subject: [PATCH 0/2] iommu/arm-smmu: Add Stratix10 SMMU Support
Date: Wed, 25 Jul 2018 13:24:35 -0500
Message-ID: <1532543077-8933-1-git-send-email-thor.thayer@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org, will.deacon@arm.com, robin.murphy@arm.com
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thor Thayer <thor.thayer@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add SMMU support for the Stratix10 SOCFPGA. This patch requires
clock enables for the master TBUs and therefore has a dependency
on patches currently being reviewed.

This patchset is dependent on the patch series
"iommu/arm-smmu: Add runtime pm/sleep support"
(https://patchwork.ozlabs.org/cover/946160/)

Thor Thayer (2):
  arm64: dts: stratix10: Add Stratix10 SMMU support
  iommu/arm-smmu: Add support for Stratix10 smmu-v2 variant

 .../devicetree/bindings/iommu/arm,smmu.txt         | 25 ++++++++++++++++++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 30 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           | 12 +++++++++
 3 files changed, 67 insertions(+)

-- 
2.7.4
