Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8B1531E2
	for <iommu@lists.linux.dev>; Sat, 28 Dec 2024 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735388563; cv=none; b=EnLPnR7CKClw6RXHXhHLBmP2Vf+E1hHAK08Ne4qjic8xraRw9Cit+mUtBM+vCy7uDV8mHdVtAqottKj2OQ0//J0RWkoj3NOKsyqsqPG5aJ1XKN1cOGrFKzZIYdxXgZQql83CwYDRDylWMQXwRW7DVlwFxKaLtGseDEJhfVZbJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735388563; c=relaxed/simple;
	bh=xhub9P2Y22bbUbBA4IWRKm3O+OVfZvd1qAAu7iE/jFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEcUi6BJUITAMKcsgfiFSS5+ufUd2R1jA7EgTfJoLdrIkSmzZD89TAOFKj4g6Pmzu4KarfbfqkfenW2QUogqbMqycMK+hofc62NplaJO+AwLytUKFFPlMGDDbQPmltE/Mw8jWKsbbWXLvT0rrqnh/j4jeXevWuHskTpPFxcAMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ojB/XMx0; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ojB/XMx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=UZ56D
	317gEmcn9NpcsH9EbXwzgNo8eOGXcdkL4nJ2YA=; b=ojB/XMx0+bKzV/c64b3+T
	CyfZGunaKKS6U8Tr//Nx0ZdSWISmPE76P1OFQNW9q5/YhyHmPPwYI8lf5+Cv51Zk
	lRHcbMDVSzPZZXF8n4Q7z/8wHzvIQw/mgZyXoR4/mG8ioL/D3X/TIY2YwH2STzYm
	hlZy1zmQ6lZ8xf0mY2Ui7Q=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3t0tl7W9nUxdCCQ--.1009S4;
	Sat, 28 Dec 2024 20:22:04 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de,
	krzk+dt@kernel.org,
	joro@8bytes.org
Cc: cl@rock-chips.com,
	robh@kernel.org,
	hjc@rock-chips.com,
	vkoul@kernel.org,
	devicetree@vger.kernel.org,
	detlev.casanova@collabora.com,
	cristian.ciocaltea@collabora.com,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 2/8] dt-bindings: phy: Add rk3576 hdptx phy
Date: Sat, 28 Dec 2024 20:21:45 +0800
Message-ID: <20241228122155.646957-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228122155.646957-1-andyshrk@163.com>
References: <20241228122155.646957-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t0tl7W9nUxdCCQ--.1009S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF48Cw1xXF45tFW3ZryrWFg_yoW5Jr17pa
	nxCFykJF1xJw13ZayDtwn5CF93trsayr4ayrnagr13Kws3trW3trWa9F15Z34Yvr40qay5
	Krsrury3ZF4avrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j39N3UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRPDXmdv5wS0uAABsB

From: Andy Yan <andy.yan@rock-chips.com>

Add compatible for the HDPTX PHY on rk3576, which is compatible with
rk3588, but without rst_phy/rst_ropll/rst_lcpll.

In fact, these three reset lines are also optional on the rk3588,
they just used for debug, then they were removed on the rk3576 IC
design.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- Wrap commit message according to Linux coding style
- Make "rockchip,rk3588-hdptx-phy" const for "rockchip,rk3576-hdptx-phy"
- Make declare phy/ropll/lcpll reset line are not exit on rk3576

 .../phy/rockchip,rk3588-hdptx-phy.yaml        | 62 +++++++++++++------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
index 84fe59dbcf48..7a307f45cdec 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
@@ -11,8 +11,13 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - rockchip,rk3588-hdptx-phy
+    oneOf:
+      - enum:
+          - rockchip,rk3588-hdptx-phy
+      - items:
+          - enum:
+              - rockchip,rk3576-hdptx-phy
+          - const: rockchip,rk3588-hdptx-phy
 
   reg:
     maxItems: 1
@@ -34,24 +39,12 @@ properties:
     const: 0
 
   resets:
-    items:
-      - description: PHY reset line
-      - description: APB reset line
-      - description: INIT reset line
-      - description: CMN reset line
-      - description: LANE reset line
-      - description: ROPLL reset line
-      - description: LCPLL reset line
+    minItems: 4
+    maxItems: 7
 
   reset-names:
-    items:
-      - const: phy
-      - const: apb
-      - const: init
-      - const: cmn
-      - const: lane
-      - const: ropll
-      - const: lcpll
+    minItems: 4
+    maxItems: 7
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -67,6 +60,39 @@ required:
   - reset-names
   - rockchip,grf
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-hdptx-phy
+    then:
+      properties:
+        resets:
+          minItems: 4
+          maxItems: 4
+        reset-names:
+          items:
+            - const: apb
+            - const: init
+            - const: cmn
+            - const: lane
+    else:
+      properties:
+        resets:
+          minItems: 7
+          maxItems: 7
+        reset-names:
+          items:
+            - const: phy
+            - const: apb
+            - const: init
+            - const: cmn
+            - const: lane
+            - const: ropll
+            - const: lcpll
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

