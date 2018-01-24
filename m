From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH  1/3] dt-bindings: iommu: ipmmu-vmsa: Add device tree support for r8a774[35]
Date: Wed, 24 Jan 2018 15:42:00 +0000
Message-ID: <1516808522-17348-2-git-send-email-biju.das@bp.renesas.com>
References: <1516808522-17348-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1516808522-17348-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>
List-Id: iommu@lists.linux-foundation.org

Document r8a774[35] specific compatible strings. The Renesas RZ/G1[ME]
(r8a774[35]) IPMMU are identical to the R-Car Gen2 family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
index 857df92..7d300af 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
@@ -11,12 +11,15 @@ Required Properties:
     the device is compatible with the R-Car Gen2 VMSA-compatible IPMMU.
 
     - "renesas,ipmmu-r8a73a4" for the R8A73A4 (R-Mobile APE6) IPMMU.
+    - "renesas,ipmmu-r8a7743" for the R8A7743 (RZ/G1M) IPMMU.
+    - "renesas,ipmmu-r8a7745" for the R8A7745 (RZ/G1E) IPMMU.
     - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
     - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
     - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
     - "renesas,ipmmu-r8a7794" for the R8A7794 (R-Car E2) IPMMU.
     - "renesas,ipmmu-r8a7795" for the R8A7795 (R-Car H3) IPMMU.
-    - "renesas,ipmmu-vmsa" for generic R-Car Gen2 VMSA-compatible IPMMU.
+    - "renesas,ipmmu-vmsa" for generic R-Car Gen2 or RZ/G1 VMSA-compatible
+			   IPMMU.
 
   - reg: Base address and size of the IPMMU registers.
   - interrupts: Specifiers for the MMU fault interrupts. For instances that
-- 
2.7.4
