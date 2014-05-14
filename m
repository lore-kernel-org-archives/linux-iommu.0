From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Subject: [PATCH] documentation/iommu: Add note on existing DT binding status
Date: Wed, 14 May 2014 11:23:33 +0530
Message-ID: <1400046813-15248-1-git-send-email-shaik.ameer@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, arnd@arndb.de, t.figa@samsung.com, pullip.cho@samsung.com, shaik.samsung@gmail.com, Shaik Ameer Basha <shaik.ameer@samsung.com>
List-Id: iommu@lists.linux-foundation.org

The current dt binding for Exynos System MMU can be changed, if found
incompatible with the support for "Generic IOMMU Binding".
This patch adds a note to the binding documentation stating the same.

Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
index 15b2a2b..6fa4c73 100644
--- a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
@@ -27,6 +27,11 @@ The drivers must consider how to handle those System MMUs. One of the idea is
 to implement child devices or sub-devices which are the client devices of the
 System MMU.
 
+Note:
+The current DT binding for the Exynos System MMU is incomplete.
+The following properties can be removed or changed, if found incompatible with
+the "Generic IOMMU Binding" support for attaching devices to the IOMMU.
+
 Required properties:
 - compatible: Should be "samsung,exynos-sysmmu"
 - reg: A tuple of base address and size of System MMU registers.
-- 
1.7.9.5
