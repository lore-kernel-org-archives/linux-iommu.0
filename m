Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71655624
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 01:29:54 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.97,238,1669042800"; 
   d="scan'208";a="150243657"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jan 2023 10:29:47 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E8F654126E2B;
	Mon, 23 Jan 2023 10:29:46 +0900 (JST)
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
Subject: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Update descriptions for R-Car Gen4
Date: Mon, 23 Jan 2023 10:29:40 +0900
Message-Id: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, but
each cache IPMMU has own module id. So, update descriptions of
renesas,ipmmu-main property for R-Car Gen4.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 The old R-Car S4-8 datasheet had described IPMMU IMSSTR register, but
 the latest datasheet undocumented the register. So, update the propeties
 description. Note that the second argument is not used on the driver.
 So no behavior change.

 .../bindings/iommu/renesas,ipmmu-vmsa.yaml          | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index 72308a4c14e7..7f63ecb467e6 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -76,14 +76,15 @@ properties:
     items:
       - items:
           - description: phandle to main IPMMU
-          - description: the interrupt bit number associated with the particular
-              cache IPMMU device. The interrupt bit number needs to match the main
-              IPMMU IMSSTR register. Only used by cache IPMMU instances.
+          - description: The interrupt bit number or module id associated with
+              the particular cache IPMMU device. The interrupt bit number needs
+              to match the main IPMMU IMSSTR register. Only used by cache IPMMU
+              instances.
     description:
       Reference to the main IPMMU phandle plus 1 cell. The cell is
-      the interrupt bit number associated with the particular cache IPMMU
-      device. The interrupt bit number needs to match the main IPMMU IMSSTR
-      register. Only used by cache IPMMU instances.
+      the interrupt bit number or module id associated with the particular
+      cache IPMMU device. The interrupt bit number needs to match the main
+      IPMMU IMSSTR register. Only used by cache IPMMU instances.
 
 required:
   - compatible
-- 
2.25.1

