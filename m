Received: from out13-75.antispamcloud.com (out13-75.antispamcloud.com [185.201.17.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDB3E5A0F;
	Wed,  9 Sep 2026 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.17.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984549; cv=none; b=t59vnqKozNcsA+HabIYZyDVUGbQuN0Xv/FwnfA5UPgVG8/AVx51k31j+WDK4+FB3B2AVmx1LZr4wWUfjMm1QviZzvXTScX+OvBsMvIxXS+C8FBkCu9ej5wSIEFF0YR05272IYSCXIGSSSCYnAKhj6e/e8pn5qRpYqcS3uW5wj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984549; c=relaxed/simple;
	bh=u7rJyBVNS3KWB72oeww+xedcyOSO1pu/9F/9FnMv+ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxNK4/W70pG9+G33w0dP+xG0PT/PnSCdT58fQSg3WF1LLIzAJParkgwaGTXQ7ZB/XHKK5MXNW1GrJ5PdAQpGKdCqe/LHuqO3p4TkwX64JvwttHe+lU4H0Q1ysQZeRM77N2bneTJ1ILHWFSGyyEhdYZO5TWhJeYg1UPUetSmzfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=yIgzJ5Lx; arc=none smtp.client-ip=185.201.17.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="yIgzJ5Lx"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx321.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1x4ObF-003TNT-0l; Wed, 09 Sep 2026 22:08:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P67qbos3D+tWJec3niEbndAJClHMkcSjY99grIP5ELc=; b=yIgzJ5Lx5YfACdaj/G0IrNlFZU
	TEN8H8eoo41uDwyUbXg27nG8hMDIFBlAOtLTdYeZ+Yk/bnGHRPBPckFju6G4Jv/4k4BlBuaI1/oba
	dsb+q51BABP8TqRq8NxCLETeXvtF7iwTSrH8DzqK3PkB9/TGOqY+Pvi3VhPZUoyOKLIbtic4Yl+Sh
	23c/5Ssb0HiuPrA/TfMBFn6wHQDJXDYBRkSKaD6LG+scYYYh1pEg9Ck4eRDWOuA1FjpgqVXnmpjDv
	a1YBGrdUCWzh9FbFgBpChBg/Gdwx2sZw3hRqwbwa2EmTaVufeO8T7OQNbP1ChemE4shOExXpksu0V
	bPezqXxA==;
Received: from [188.251.249.2] (port=52430 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <dan@reactivated.net>)
	id 1x4ObD-0000000DWp8-47g0;
	Wed, 09 Sep 2026 20:08:50 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Wed, 09 Sep 2026 21:08:08 +0100
Subject: [PATCH v5 2/5] dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-bcm2712-iommu-submit-v5-2-2539c52b249e@reactivated.net>
References: <20260909-bcm2712-iommu-submit-v5-0-2539c52b249e@reactivated.net>
In-Reply-To: <20260909-bcm2712-iommu-submit-v5-0-2539c52b249e@reactivated.net>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Daniel Drake <dan@reactivated.net>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00433844911397)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuWEzRp917teJpwtmUPNDZBo0usM7jSAXZPF
 HlQWJujTSCu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIOYn9vhoNExpT0rpjg2lHVHGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWBp35AJbRNknLgMOj3O/cqXeB7itP8hgjDRserKv4bhb7ubyJcscJCC/8jhyq4eIIJWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5Ay6i8PhAwy
 ohd+GCGjMSaCo2g+pLXSstFFr2Pmsof7eeRHKvLDzn+sBlvbv5VnduIaCC8T432LXhcN9iDypd/G
 jBIJaw3nA0JWQqC5+Jig4CpfjrlgQefNeWcxSH+UCzbtFoUUErjvkjClnO+z3Y8BCB4GKZ8tHsR5
 A+L9kzDG/K63IFf1tTl6XjJBLr8hyqcPiIfzvuBQjcdRxCwh8eiHlonTJYQp6P0LGGk5YcssJBnE
 oCFelNEuPkquluSoEnYwJqEylk1bBhjIWUVQpiEaCXgutbnJ8XLRZlxuyGE4ZkJ+Ct1rytEV3nXE
 30Z2uRLE/8mc4sO+W8vok4IjJdnmU8DTX941WdbezDc4vvZrV3V8zxJiAh4HD0pbHodESl7kaNlb
 x8xIGSNGie95MFeWVyO9Qfhfm+3ZVXwsV2bUYWW4ep6BcO097ndMLXudKQNeFU4oFhi1MNpONIVI
 cKQLYpRI/YdWVB4RLR9xg0malhL/zrerFdzyp80QodgbrP5s8nByAM67kkfx5CxJZu8aTgJ5f3aq
 udJOEH3RuyZ+8leu7vxlwaJe4HXvh1KDzbyuhe3rKagUdobsFC0Ri8UJKkNYEwQtgFkgklp04bUn
 b1qdOer54gFeYIyf/VI1wUg/RktiFekFeW+7U10rT7jLCnLvR/Y0+hqFCvJ5ztihCGpdCKDGFJnk
 5eJFcFklVb9231/E3ahF5MMcDI7KdpjQKdEz/+/QkUVhwSqO+QS+xjCZ3JKVmi72ocgY5kMQSjs7
 CnU3Vkswnvz2sY575f5VZdC7A9EkfupFeybqiokSL/UoBa9Z74L1QD5u7fk/CB2ffOy/knOaqu9M
 jU02vQscbFXfLr4QfL2DDLcpCTGg9PS1ky5OPdlHgN5e9b5Lw3uYQPd20BP0KnfPWQcPrGKRVBY+
 C3NKVBiu9E09fH2QcWWDSTfRyaGsL+KZNwpYGCN6yCqJqJMY7uMzxq3+Ecx6Ww+vAj0HbLbveTIz
 fDDueIdjUxTaa0dmGx2m78JeU6J5dQk8TiQJh7U9utxWE7LPnybsgEYdqBiEd1NUIwnN5yy6OdCX
 ruFiDfpPjR+W8zc/PAlbDjazCbhs7qBpykynMlI8ehauFjA7dVMOTKcW5c6UnY64mAykh3LBvXwi
 LIjlrjIuKSKddsFYTaIZy4Zvun7pGU7uz9Qh2BYl/pOFic8JjqapLpwrwdUQz9MPWEmV3jR5NeVa
 JQBh0uawl0Cg8hPs+cRD5TJxNzOPadp3mtqXN3cCIyIm263/n4zqghav48Y+3YiJRbPwEKhVXmMF
 SH7pGU7uz9Qh2BYl/pOFic/qXKRF3uOx1VRdI9vLlOBy9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

Add bindings for the Broadcom BCM2712 IOMMUs and their shared TLB cache.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 .../bindings/iommu/brcm,bcm2712-iommu.yaml         | 54 ++++++++++++++++++++++
 .../bindings/iommu/brcm,bcm2712-iommuc.yaml        | 40 ++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
new file mode 100644
index 000000000000..5ca8ce469ec3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/brcm,bcm2712-iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2712 IOMMU
+
+maintainers:
+  - Daniel Drake <dan@reactivated.net>
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+  - Jim Quinlan <james.quinlan@broadcom.com>
+
+description:
+  The BCM2712 SoC features multiple independent IOMMU instances providing
+  address translation for multimedia hardware blocks, such as the VC6 display
+  pipeline, camera receivers, and ISP. Each IOMMU has its own page tables,
+  control registers, and local TLB, and is additionally linked to a centralized
+  L2 TLB (IOMMUC).
+
+properties:
+  compatible:
+    const: brcm,bcm2712-iommu
+
+  reg:
+    maxItems: 1
+
+  '#iommu-cells':
+    const: 0
+
+  brcm,iommu-cache:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the shared IOMMU cache (IOMMUC). Each IOMMU instance caches
+      translated descriptors in this centralized L2 TLB cache block and must
+      trigger cache invalidation commands on it when updating or unmapping page
+      table entries.
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+  - brcm,iommu-cache
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu@5200 {
+        compatible = "brcm,bcm2712-iommu";
+        reg = <0x5200 0x80>;
+        brcm,iommu-cache = <&iommuc>;
+        #iommu-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml
new file mode 100644
index 000000000000..47c584ad667a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/brcm,bcm2712-iommuc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2712 Shared IOMMU Cache (IOMMUC)
+
+maintainers:
+  - Daniel Drake <dan@reactivated.net>
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+  - Jim Quinlan <james.quinlan@broadcom.com>
+
+description:
+  The BCM2712 IOMMUC is a centralized Translation Lookaside Buffer (TLB) cache
+  which accelerates address translation across the SoC's IOMMU devices. If an
+  address mapping is not found in the IOMMU's local TLB cache, then this
+  IOMMUC is consulted as a L2 TLB. The SoC includes a single IOMMUC which is
+  shared between all IOMMUs, and it must be explicitly invalidated when
+  modifying or unmapping IOMMU page tables.
+
+properties:
+  compatible:
+    const: brcm,bcm2712-iommuc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    iommuc@5b00 {
+        compatible = "brcm,bcm2712-iommuc";
+        reg = <0x5b00 0x80>;
+    };

-- 
2.55.0

