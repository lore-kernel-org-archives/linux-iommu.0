From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH 5/8] dt-bindings: iommu/ipmmu-vmsa: Add R-Car M3-N (R8A77965)
Date: Mon, 26 Feb 2018 18:57:13 +0100
Message-ID: <1519667836-31330-6-git-send-email-jacopo+renesas@jmondi.org>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: geert@linux-m68k.org, horms@verge.net.au, sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Add Renesas R-Car M3-N (R8A77965) compat string to IPMMU DT bindings
documentation.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
index 1fd5d69..0143fd4 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
@@ -17,6 +17,7 @@ Required Properties:
     - "renesas,ipmmu-r8a7794" for the R8A7794 (R-Car E2) IPMMU.
     - "renesas,ipmmu-r8a7795" for the R8A7795 (R-Car H3) IPMMU.
     - "renesas,ipmmu-r8a7796" for the R8A7796 (R-Car M3-W) IPMMU.
+    - "renesas,ipmmu-r8a77965" for the R8A77965 (R-Car M3-N) IPMMU.
     - "renesas,ipmmu-r8a77970" for the R8A77970 (R-Car V3M) IPMMU.
     - "renesas,ipmmu-r8a77995" for the R8A77995 (R-Car D3) IPMMU.
     - "renesas,ipmmu-vmsa" for generic R-Car Gen2 VMSA-compatible IPMMU.
-- 
2.7.4
