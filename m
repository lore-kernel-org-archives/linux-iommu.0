Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0C7C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 13:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10000C43470;
	Thu,  8 Sep 2022 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662643544;
	bh=vKmdZnSEqQsgGYqX0IyUeu5ecemFZS/PREfqX8Z3614=;
	h=From:To:Cc:Subject:Date:From;
	b=QCBpWX3Yd+k88zciOQ5QXOLEW9QXWpWmKrfzwp+BYl1BmLURpPXKrBbUGuxum5r/u
	 NmXJ/oBKrOy864Aj0w4szD96VRM82oc6fGsmNeaOL/qY57Rl+zNldk85SvsFKnqxkY
	 QSLaBRdaBlfMGPTBJrcMZTGoB9/SBrR1B6a5nKQEx9YZ1zj+nLXxuZRDnGA9hdgh1V
	 S5g/fRHMEorYRXxx4Sd5bnxorRW0o7wNDjJ3jfWc+71Z+oWYNZUcuSprSWsd8QeRRR
	 D4WLSTXtkVyE52HU8DLgIkylxcX2lplcdWryOJj0tMpY+m3ZguGlnqnCPWojBKNRBe
	 zcA5kvua4pqLg==
From: matthias.bgg@kernel.org
To: Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: devicetree@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	iommu@lists.linux.dev,
	Rob Herring <robh+dt@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v1] dt-bindings: iommu: mediatek: mt8195: Fix max interrupts
Date: Thu,  8 Sep 2022 15:25:35 +0200
Message-Id: <20220908132535.9350-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthias Brugger <mbrugger@suse.com>

The mt8195-iommu-infra has five banks and one interrupt for each.
Reflect that in the binding.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

 .../bindings/iommu/mediatek,iommu.yaml        | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index fee0241b50988..621aca2adfb7f 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -91,7 +91,7 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    description: each bank has one dedicated interrupt
 
   clocks:
     items:
@@ -183,6 +183,19 @@ allOf:
       required:
         - mediatek,infracfg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8195-iommu-infra
+
+    then:
+      properties:
+        interrupts:
+          maxItems: 5
+      required:
+        - interrupts
+
   - if: # The IOMMUs don't have larbs.
       not:
         properties:
@@ -191,8 +204,12 @@ allOf:
               const: mediatek,mt8195-iommu-infra
 
     then:
+      properties:
+        interrupts:
+          maxItems: 1
       required:
         - mediatek,larbs
+        - interrupts
 
 additionalProperties: false
 
-- 
2.37.3

