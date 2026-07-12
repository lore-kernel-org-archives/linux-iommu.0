Received: from out13-173.antispamcloud.com (out13-173.antispamcloud.com [185.201.17.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5F35E930;
	Sun, 12 Jul 2026 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.17.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891165; cv=none; b=NiUkDQpoTltfXjl7dcHienAcwDrKzX4dqK1skgO/V9DRh0YHddDgXN5tnE8d1ncBQfb9aog1Cw6BgyS2dnUijvW1xV/KD5uBzXVEA07t3Y3Ex6/mlD5Eqml+CLbNUURFeCtme5my73x7jtZGKypfds4o8CDlFN0XVVTS7pvbBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891165; c=relaxed/simple;
	bh=QJ/vzn1Oja8eZ3GalWvgiUTZ4cPgSoO2DB6bv+DpObI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2uvUyI6ZTGT9verEc4BjAgWmT+ZRjAWEVhMZo/aDkQE7O4OaataGbTabOoQArdXZVugAXJzIU83qi8QjPiSmQaDzvUNqn0xX9aV6GK90buqme2MXqsM+IdIsw305QaQvOJpaqpt3X9GWmfTStv8QyhzqppJSaFpwrHPX5kvpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=DV7yCnlp; arc=none smtp.client-ip=185.201.17.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="DV7yCnlp"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx195.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1wj1Zx-00GoSN-M0; Sun, 12 Jul 2026 23:19:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1Mj67QcVmqs6wmRW2naVhRw1o1ZfYr/QnTH9zrVrifs=; b=DV7yCnlpn/0mTP4kaVCvoX0bvK
	q/StrZFkYRAG4qJwh9bb1GtCjQBZPH1lpeSDiIIr74szX6BiaxY89rWXF7avxAT6PyNaTkwqwHUox
	5slzsAghwP5/WClbQTpTFH6fZJOGaHiy5Oj0S2i1OyoI25sE/qVm+VxzA0owKOi58QzbBIGhLObl9
	+lWxXtFm040f19qrc4RAjCC8cIDwRgL/ZYUrcIsNTva+WX+th2eg2u0nMufoZ48JzlaQK8KYUS4TE
	a/HU8U+QAidog5jlAyDbrfn0L1MLYmW8VpwSQy58yMAupBtF+46FaW5QQRJoEjhV7wBCPr1WiFNpR
	TD123p2Q==;
Received: from [188.251.249.2] (port=43526 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <dan@reactivated.net>)
	id 1wj1Zu-0000000D6jk-38Hd;
	Sun, 12 Jul 2026 21:19:11 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Sun, 12 Jul 2026 22:18:53 +0100
Subject: [PATCH 3/6] dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-bcm2712-iommu-submit-v1-3-80e10cdde2ea@reactivated.net>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
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
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00198314465392)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVII5Q6oPCuB9qu4EA3zhr96uX8i5dKehwf
 KC2SaWwUYSu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIPXALmPA8d+BGIw6ynmMqunGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCulNo0fvnzmZPW3MC2/ZtQeB7itP8hgjDRserKv4bhb3RyZlCL9i3kc+ehInPHgYZWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyPIv7c2tg
 uiTnO7hoWdxS2Euf+eM3l5KPnbp/eQthjVPLCh11+xKgET3fXj754wkhoRweeXUyelEFumxqJC98
 W2Chcvueb7X9IVOP0nXi5ScUGZbDvQNAWVsKTgEVkGFZkrTBb08hz2+hQWIE/jMJBRjlXAPIIi6r
 dxgy5Mnu2cDsZps7XJtkUNhIi117bsGJ7ren9RtRNyYim5e3GD8LGd17Yt5uvWRLqYZ7YcWBwuaj
 bB9FLgbTIobDkucCu6K1Qts6ESwZ+TRkjY5CmPXd4fzFwV5PA+Zo1HkEWshOrnfOczv/Rq1TfV/y
 9sPCUZ0yjBqTnQMt5W0GKvZ5TPS+0sUsSnvAz6a57TzpYAKZxAOMmYkwXP3g8rtJn6lRuSHjV8Jw
 2Fxq1Vd7xIu/TP3zxxtadaYgn3OIzsUC2wDRiPKWwieZyauFYqHkIbFa+ipFHuOywN1cBSoAw5Iq
 u8uD6H9vRamlPbOxG7rXq5Czwgf6xGEuqjPYHqCiHsRpKiyawVZCoGB4EfDx2fRuW8Y0o7OCze69
 5wqpq4Ow1lDfcfvX9sw5VBsaDF9CxNBjABkH3hTMjGc3lQAtuckU+MNQlLpWhjjykqbde3UjWoF9
 cBo9q3T2iWmfFRW/Psbz8QFVy0V5rN3M2TZ9grsaBV7hOgCSkfEzb1aIdlnbLZp4DCYOuNFQ+5eG
 III/qgXB3gv2NI/ukWuQBNrXV+EmIqM8SxKOhcObZXWnkEw+6F9CGyYC9AhR1ZLKC40YaZQ+trtn
 Eh9wUysc4uCrhmcWLql8TBcwc7MLvLLf36yri656/naizxFc684o/A69h/CvHI/GeXW8oEyu47TQ
 DqTi6GKwcIp24VOsP5eu885wo+t+ynT3Y80OmAux3oN13+ztUzneZGHdcUfaxYq0ZH+Cc9iqnocR
 WxNUEo38DE53aa5lZFsy2onypIM6qetbKE/25wcBE3dCizsqYfBnHUM3oFa+qdoVIihnVzbm4Qzx
 fUxUyvhr3Z1SFe+4OrB9Rro7EpOy1Um2iVRPSUxhtw3wz3yqYcOpyKA69LF1Ge2GaGfxmfp09oMS
 l8c4ShQ//ve+MHzjs9MOb3HXByN6cty/LT6lgOv2AzRyYGlsi3xQeIJ6TM5o5F89lTjPCn99uwfA
 g5wm8t3Xj/LzZ5s/OJg1L2asZ/4te3BTDYEBZZ1yPQnIH5IVn/pKnch3lmmwSrgldH+Ps9MOb3HX
 ByN6cty/LT6lgO+c9AHZZ12442bv/l3jZJg=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

Add bindings for the Broadcom BCM2712 IOMMU and its shared TLB cache.

Include compatibility with the cache phandle used in existing firmware
shipped on Raspberry Pi 5, and also allow the iova-window to be omitted,
which similarly will maintain compatibility with existing RPi5 firmware.

Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 .../bindings/iommu/brcm,bcm2712-iommu.yaml         | 65 ++++++++++++++++++++++
 .../bindings/iommu/brcm,bcm2712-iommuc.yaml        | 35 ++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
new file mode 100644
index 000000000000..0d91c513afc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
@@ -0,0 +1,65 @@
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
+
+description: |
+  The BCM2712 IOMMU provides address translation for various hardware blocks
+  on the BCM2712 SoC, such as the VC6 display pipeline.
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
+    description: Phandle to the shared IOMMU cache (IOMMUC).
+
+  cache:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Deprecated. Use brcm,iommu-cache instead.
+    deprecated: true
+
+  brcm,iova-window:
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    description: |
+      An array of two 64-bit integers specifying the IOVA aperture start
+      address and the aperture size. IOMMU mappings will be created inside
+      this aperture. All preceding address space is in identity/bypass mode.
+      The aperture start address must be 4GB-aligned.
+      Should be considered a required property, but it is technically optional
+      in order to maintain compatibility with historical firmware versions.
+      If absent, defaults to a 4GB window at 40GiB (0xa00000000).
+    items:
+      - description: IOVA window start address
+      - description: IOVA window size
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
+        brcm,iova-window = /bits/ 64 <0xa00000000 0x100000000>;
+    };
diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml
new file mode 100644
index 000000000000..f22e9be2c473
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml
@@ -0,0 +1,35 @@
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
+
+description: |
+  The BCM2712 IOMMU Cache (IOMMUC) provides a shared Translation Lookaside
+  Buffer (TLB) cache used by the primary BCM2712 IOMMUs to speed up address
+  translations.
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
+    iommuc: iommu-cache@1001000 {
+        compatible = "brcm,bcm2712-iommuc";
+        reg = <0x1001000 0x100>;
+    };

-- 
2.55.0

