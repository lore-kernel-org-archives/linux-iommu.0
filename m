From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v2 1/3] dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
Date: Tue, 14 Aug 2018 15:57:38 +0530
Message-ID: <20180814102740.30222-2-vivek.gautam@codeaurora.org>
References: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org, will.deacon@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Qcom's implementation of arm,mmu-500 works well with current
arm-smmu driver implementation. Adding a soc specific compatible
along with arm,mmu-500 makes the bindings future safe.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 7c71a6ed465a..7d73b2a259fc 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -18,6 +18,7 @@ conditions.
                         "arm,mmu-500"
                         "cavium,smmu-v2"
                         "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
+                        "qcom,<soc>-smmu-500", "arm,mmu-500"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
@@ -30,6 +31,10 @@ conditions.
                   An example string would be -
                   "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
 
+		  "qcom,<soc>-smmu-500" compatible string represents qcom's soc
+		  specific implementation of arm,mmu-500, and should be present
+		  along with "arm,mmu-500".
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
