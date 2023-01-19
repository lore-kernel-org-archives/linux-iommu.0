Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D47471
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 13:40:27 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.97,229,1669042800"; 
   d="scan'208";a="149953118"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jan 2023 22:35:19 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9042C42704B3;
	Thu, 19 Jan 2023 22:35:19 +0900 (JST)
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
Subject: [PATCH resend] dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779g0 support
Date: Thu, 19 Jan 2023 22:35:14 +0900
Message-Id: <20230119133514.1008925-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible values for the IPMMU-VMSA blocks in
the Renesas R-Car V4H (R8A779G0) SoC.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index 26d0a5121f02..72308a4c14e7 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -49,6 +49,7 @@ properties:
           - enum:
               - renesas,ipmmu-r8a779a0           # R-Car V3U
               - renesas,ipmmu-r8a779f0           # R-Car S4-8
+              - renesas,ipmmu-r8a779g0           # R-Car V4H
           - const: renesas,rcar-gen4-ipmmu-vmsa  # R-Car Gen4
 
   reg:
-- 
2.25.1

