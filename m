Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD1290D
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 14:04:56 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.97,251,1669042800"; 
   d="scan'208";a="150775484"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Jan 2023 23:04:50 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 124B4432BC63;
	Fri, 27 Jan 2023 23:04:50 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] dt-bindings: iommu: renesas,ipmmu-vmsa: Update for R-Car Gen4
Date: Fri, 27 Jan 2023 23:04:46 +0900
Message-Id: <20230127140446.1728102-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, update
the renesas,ipmmu-main property which allows to only set the first
argument for R-Car Gen4.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
Changes from v1:
https://lore.kernel.org/all/20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com/
 - Change number of argument for R-Car Gen4 instead of "module id".
   On the discussion, using 'minItems' is a solution. But, it causes
   "too short" errors on dtbs_check. So, using "oneOf" instead.

 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index 72308a4c14e7..8e8f79f612e5 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -73,12 +73,16 @@ properties:
 
   renesas,ipmmu-main:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
+    oneOf:
+      - items:
+          - items:
+              - description: phandle to main IPMMU
+              - description: the interrupt bit number associated with the particular
+                  cache IPMMU device. The interrupt bit number needs to match the main
+                  IPMMU IMSSTR register. Only used by cache IPMMU instances.
       - items:
-          - description: phandle to main IPMMU
-          - description: the interrupt bit number associated with the particular
-              cache IPMMU device. The interrupt bit number needs to match the main
-              IPMMU IMSSTR register. Only used by cache IPMMU instances.
+          - items:
+              - description: phandle to main IPMMU
     description:
       Reference to the main IPMMU phandle plus 1 cell. The cell is
       the interrupt bit number associated with the particular cache IPMMU
-- 
2.25.1

