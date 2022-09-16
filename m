Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE933C1;
	Fri, 16 Sep 2022 09:42:01 +0000 (UTC)
Received: from robin.home.jannau.net (unknown [91.200.110.112])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 1642C26F073;
	Fri, 16 Sep 2022 11:41:54 +0200 (CEST)
From: Janne Grunau <j@jannau.net>
To: iommu@lists.linux.dev
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
	asahi@lists.linux.dev,
	Sven Peter <sven@svenpeter.dev>,
	Rob Herring <robh@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Hector Martin <marcan@marcan.st>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Kettenis <mark.kettenis@xs4all.nl>,
	Rob Herring <robh+dt@kernel.org>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: iommu: dart: add t6000 compatible
Date: Fri, 16 Sep 2022 11:41:48 +0200
Message-Id: <20220916094152.87137-2-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916094152.87137-1-j@jannau.net>
References: <20220916094152.87137-1-j@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Peter <sven@svenpeter.dev>

The M1 Max/Pro SoCs come with a new DART variant that is incompatible with
the previous one. Add a new compatible for those.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Acked-by: Rob Herring <robh@kernel.org>

Signed-off-by: Janne Grunau <j@jannau.net>
---

(no changes since v2)

Changes in v2:
- added Rob's Acked-by:

 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 82ad669feef7..06af2bacbe97 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -22,7 +22,9 @@ description: |+
 
 properties:
   compatible:
-    const: apple,t8103-dart
+    enum:
+      - apple,t8103-dart
+      - apple,t6000-dart
 
   reg:
     maxItems: 1
-- 
2.35.1

