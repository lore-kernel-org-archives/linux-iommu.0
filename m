From: Simon Xue <xxm@rock-chips.com>
Subject: [PATCH V2 1/3] Docs: dt: rockchip: add rk-iommu,disable-reset-quirk property
Date: Fri, 21 Jul 2017 14:27:08 +0800
Message-ID: <1500618430-114821-1-git-send-email-xxm@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Simon <xxm@rock-chips.com>
List-Id: iommu@lists.linux-foundation.org

From: Simon <xxm@rock-chips.com>

Add rk-iommu,disable-reset-quirk property to ignore the isp mmu
reset operation

Signed-off-by: Simon <xxm@rock-chips.com>
---
changes since V1:
 - new added file

 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
index 9a55ac3..aa2136c 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
@@ -15,6 +15,11 @@ Required properties:
                     to associate with its master device.  See:
                     Documentation/devicetree/bindings/iommu/iommu.txt
 
+Optional properties:
+- rk-iommu,disable-reset-quirk : This ignore the isp mmu reset operation.
+				 It can't get the expected result when isp mmu
+				 reset, but the reset function work normally
+
 Example:
 
 	vopl_mmu: iommu@ff940300 {
-- 
1.9.1
