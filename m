Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474E566C4D;
	Wed, 23 Sep 2026 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190952; cv=none; b=Nm1K392L6m9cRc7MaHH2m5yFz6M0XuHBlWp7ympUu69vGXNkGy+f7Zu/IF0564RjXPJwMWol1zBztFjMJMrKQzLf3zcUNhXL0FoBpm0L6HmJ061SDagJphQR1Q1oPqb/+JXX+avbDkQRIk/PjJu/gvmbs2LAytBECGIbrb+3M18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190952; c=relaxed/simple;
	bh=OBnd6YqYitom54GDZWn8IQVu6ccwaiE/uJZXojlQ3QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGpEeaAb927wSzoTDwYC1G7HscW6xKMXWE7EFAIgsrtqKJ24i6+QllomtJk2ZVitje/p4+ddFEqUMA9iMcfEfa8+ht9r3NAeztaj3cyIilHOcUqun9IJ7MYJEPa7sIojx9ZO1wppDb8ZGggligWCpw1cG2CSS40q7F2LZ3ZDedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVP6HfkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVP6HfkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263A31F000FF;
	Wed, 23 Sep 2026 19:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790190951;
	bh=LfzNAPun3QfgyrfQ0AalSAcIX1q+GxGMokSjC8c+Aro=;
	h=From:To:Cc:Subject:Date;
	b=fVP6HfkLAXWcUzphziNJN7eEDSmmN69m2vrUKsHXa4E+6z+rHChjym6bn4gNl7D1/
	 ThA2pXoKKCFYGWh+DsbbkuvhqG9CYGRLI6qE5xWT/iHb8KXGo9MdvX/o3bxXEj064P
	 zOP8qBxiE6aNIcPi5/nhASftTMm1aCUGu/AXujrrvysdbvuTzF12X8OHdViIlwWitl
	 luwRBeaOlFdtQ/lO7kiMqNYG7NrvEXlf6nJtsUN2FZekVdBeB0n8dUUWgYOX3QxQx+
	 061xOF2nqX3gjGrtgcXC/beEQRpIAIMEu9Ve3DHPeRkimnp+uNVBUicEJhf6YjDp7J
	 C9Wt1+34wfC5g==
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
Subject: [PATCH v2] dt-bindings: iommu: Describe MT8195 infra IRQs
Date: Wed, 23 Sep 2026 14:15:45 -0500
Message-ID: <20260923191546.2209201-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8195 infra IOMMU has one fault interrupt per IOMMU bank with 5 banks.
Keep other MediaTek IOMMUs limited to one unnamed interrupt.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Drop unnecessary 'interrupt-names' addition
---
 .../bindings/iommu/mediatek,iommu.yaml         | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 79c573c47b08..cbda221a4fc5 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -100,7 +100,10 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 5
+    description:
+      A single interrupt or one interrupt per bank.
 
   clocks:
     items:
@@ -155,6 +158,19 @@ required:
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
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
   - if:
       properties:
         compatible:
-- 
2.53.0

