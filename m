Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548649F107;
	Mon, 21 Sep 2026 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033261; cv=none; b=O+C+jBtqOgdrQpp8ZsU59pU/vNmes1S3rVyaUIOR/NyXoqABslLVDVTeLLiKFYNT5tGwvMgH+o8gIffEvWaXeNsytsKUMNWLTmjmB23KK/uewYmiCfdQnUwQ2DQ1aWN8taIzymEchfwO/i41wpDKqktNRBW6VfTUJE1sgT0ROgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033261; c=relaxed/simple;
	bh=hBgkM4mPbl4sx8EbrjrqBX4IS0l78CxmStXBBIRyEL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWwuVVoyTlAQKI9VhgOAJjHj4c+EYYeZFKYoAq0WcVtl4JIBu52mcuh/fg8sL2zrag4/1Bv/7XhJucBLJg3XfC5W3ewyGs4Wdy0LLeon0v4s3E4KSgYS0YlHLXPkVTOQtHojR/gSdEnyKTmu1X2X83YyH0+1SJ1oh0aJBYvBLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXcAx7dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXcAx7dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161AF1F000FF;
	Mon, 21 Sep 2026 23:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033248;
	bh=Z4j95iorbULZW94KfX9vH9S7sD5hTc6RHIL3XgcCWVU=;
	h=From:To:Cc:Subject:Date;
	b=LXcAx7dk9Cvfcmws4NMjLKDSkYUgwfCaLkhBMMPXb2fgDdLs1WjcJXvmmTkd4TlDr
	 +jiXPfKkSL8P7ZnXZoXuqkRlysBOGRbAylJS/0jqRL9L5E2HyWz38k73nf3jdOFxrT
	 FPxeeXd1rdv/QPDf14WiwPbQ/elhYZE3XzJ6sxzLi3Q0S6rt162Zwm2LpV4b8PnmvG
	 Js6ejO/r5xOMdgqqlEaxyBRsr18Izr2qnlN4o6/pLFkBmr5f6FH6hVaGXfItrkxSu9
	 /o/f2aUB6/1Pzy86sXPO+lWGOmJH9ne1fmiTEhLlgC7gN6XPXHFqTeER73epYSNGgq
	 iCQCmJS4raLOA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: iommu: Describe MT8195 infra IRQs
Date: Mon, 21 Sep 2026 18:27:15 -0500
Message-ID: <20260921232716.3134140-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8195 infra IOMMU has one fault interrupt per IOMMU bank. Require
the five bank interrupts, named bank0 through bank4, for this
compatible. Keep other MediaTek IOMMUs limited to one unnamed interrupt.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/iommu/mediatek,iommu.yaml        | 30 ++++++++++++++++++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  2 ++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 79c573c47b08..4dc5621c17e1 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -100,7 +100,11 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 5
+
+  interrupt-names:
+    description: Names of IOMMU banks providing fault interrupts.
 
   clocks:
     items:
@@ -155,6 +159,30 @@ required:
   - '#iommu-cells'
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8195-iommu-infra
+    then:
+      properties:
+        interrupts:
+          minItems: 5
+        interrupt-names:
+          items:
+            - const: bank0
+            - const: bank1
+            - const: bank2
+            - const: bank3
+            - const: bank4
+      required:
+        - interrupt-names
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names: false
+
   - if:
       properties:
         compatible:
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 9aaf8b6edcb5..3e46ffaa44c6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -937,6 +937,8 @@ iommu_infra: infra-iommu@10315000 {
 				     <GIC_SPI 797 IRQ_TYPE_LEVEL_HIGH 0>,
 				     <GIC_SPI 798 IRQ_TYPE_LEVEL_HIGH 0>,
 				     <GIC_SPI 799 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "bank0", "bank1", "bank2", "bank3",
+					  "bank4";
 			#iommu-cells = <1>;
 		};
 
-- 
2.53.0

