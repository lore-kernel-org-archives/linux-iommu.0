From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: iommu: ipmmu-vmsa: Use generic node name
Date: Wed,  4 Oct 2017 14:33:08 +0200
Message-ID: <1507120388-14179-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

Use the preferred generic node name in the example.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
index 3ed027cfca95cc98..857df929a6542157 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
@@ -53,7 +53,7 @@ Example: R8A7791 IPMMU-MX and VSP1-D0 bus master
 		#iommu-cells = <1>;
 	};
 
-	vsp1@fe928000 {
+	vsp@fe928000 {
 		...
 		iommus = <&ipmmu_mx 13>;
 		...
-- 
2.7.4
