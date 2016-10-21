From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH 0/4] iommu/arm-smmu: Add runtime pm/sleep support
Date: Fri, 21 Oct 2016 22:44:22 +0530
Message-ID: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: m.szyprowski@samsung.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

This series provides the support for turning on the arm-smmu's
clocks/powerdomains using runtime pm. This is done using the
recently introduced device links patches, which lets the symmu's
runtime to follow the master's runtime pm, so the smmu remains
powered only when the masters use it.

Also added a patch to do the context/save restore during suspend.
But a way to find if the context is really lost during suspend
has to be added in some way.

This is based on the device_link series [1].

Took some reference from the exynos runtime patches in post [2].

Tested this on a platform where context is not really lost,
but atleast the sequence to restore the context is verified.

[1] http://lkml.iu.edu/hypermail/linux/kernel/1609.3/02637.html
[2] https://lkml.org/lkml/2016/10/20/70

Sricharan R (4):
  Docs: dt: document ARM SMMU clocks/powerdomains bindings
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Add context save restore support
  iommu/arm-smmu: Add the device_link between masters and smmu

 .../devicetree/bindings/iommu/arm,smmu.txt         |  12 ++
 drivers/iommu/arm-smmu.c                           | 168 ++++++++++++++++++++-
 2 files changed, 179 insertions(+), 1 deletion(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
