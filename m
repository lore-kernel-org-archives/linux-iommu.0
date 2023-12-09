Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76BF7F
	for <iommu@lists.linux.dev>; Sat,  9 Dec 2023 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YHbdN3p4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hDOWo
	ySA4CZNBE7lDkM9JvLOpbEJ+zrh02ycvkDH8j8=; b=YHbdN3p44zuvEHiPDNNxd
	8rnOhUySjsWhqV8PWkh60ad0I5el+QC0jzmNBF3uLH56/c70hO+SqEqwQTX+kwAU
	llELJdBt+tD5AqILXfcJi9cIgyj5BaF5/+WUukv+fybAxchFu9WvbYul7F0VOM3U
	uzW+4nk+u3EvACfxwOP+YI=
Received: from ProDesk.. (unknown [58.22.7.114])
	by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wBXn4Dwx3NlPIyWFA--.59698S2;
	Sat, 09 Dec 2023 09:50:43 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: conor+dt@kernel.org,
	heiko@sntech.de,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	robin.murphy@arm.com,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iommu: rockchip: Add Rockchip RK3588
Date: Sat,  9 Dec 2023 09:50:38 +0800
Message-Id: <20231209015038.1457967-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXn4Dwx3NlPIyWFA--.59698S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF17JF4DJF4rurW7KFWrAFb_yoWkKFX_C3
	WxXw15XF48tFWFv3WDA3yxGryDGw12krn5XF9YkF1kCw1qvry8J393Jw15Aw18Wr47uFyS
	93WxWry2gF9xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8GYLDUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBdBXmVOA2VgAwAAsO

From: Andy Yan <andy.yan@rock-chips.com>

Add a Rockchip RK3588 compatible

I split it from the vop2 patch series as suggested by Heiko[0]

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[0]https://patchwork.kernel.org/project/dri-devel/patch/20231207080235.652719-1-andyshrk@163.com/

---

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

