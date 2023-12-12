Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2A0639
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FStsEO0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ALA6E
	1kxgqoyYdK+X/tV01Cv4nS2fQCV1ZSR7WI680E=; b=FStsEO0uHLWJqwximzbpg
	kRqRlujuNe6619REWsYePZpQ1B5Cv+psr0Gtv2/FKSQhuAcWEE1hFCb3RFGdHhY+
	fhCFztfy8uxsMWM9uogzwTROQidBzm2wdG9MYizO+tABPLpRfzdsc0UCLzwpAezZ
	ZqijZ/n1qZRMdLtZpr1DDs=
Received: from ProDesk.. (unknown [58.22.7.114])
	by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wDnLx3nr3dlgINjCQ--.23988S2;
	Tue, 12 Dec 2023 08:57:15 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: iommu@lists.linux.dev
Cc: heiko@sntech.de,
	conor+dt@kernel.org,
	joro@8bytes.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	robin.murphy@arm.com,
	will@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: iommu: rockchip: Add Rockchip RK3588
Date: Tue, 12 Dec 2023 08:57:10 +0800
Message-Id: <20231212005710.1837066-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnLx3nr3dlgINjCQ--.23988S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7JF15GFyxXF45Jr1DGF43GFg_yoW8JF45pF
	srCryDXFyxGw1fWa9rtFn3Cr45tr4DAa1jgryaga17WFn8ta45GrnY9rn8ZF1DWFW8AFW7
	ua9rurW5A3yavrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrcTPUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBBEXmVOA5nBygAAsY

From: Andy Yan <andy.yan@rock-chips.com>

Add a Rockchip RK3588 compatible

I split it from the vop2 patch series as suggested by Heiko[0]

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[0]https://patchwork.kernel.org/project/dri-devel/patch/20231207080235.652719-1-andyshrk@163.com/

---

Changes in v2:
- Add maintainers for the iommu subsystem to cc list

 .../devicetree/bindings/iommu/rockchip,iommu.yaml     | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index ba9124f721f1..621dde0e45d8 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -19,9 +19,14 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - rockchip,iommu
-      - rockchip,rk3568-iommu
+    oneOf:
+      - enum:
+          - rockchip,iommu
+          - rockchip,rk3568-iommu
+      - items:
+          - enum:
+              - rockchip,rk3588-iommu
+          - const: rockchip,rk3568-iommu
 
   reg:
     items:
-- 
2.34.1

