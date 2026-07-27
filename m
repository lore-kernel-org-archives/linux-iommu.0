Received: from out16-185.antispamcloud.com (out16-185.antispamcloud.com [185.201.18.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080A42DA53;
	Mon, 27 Jul 2026 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785188901; cv=none; b=fDpPt6BLUYlWZRrX2hqORfh7401SznOdG4GTey3s2y/fpjCxzCujMqHaEeAO7YXdNg98/snRBtAAvgs4F1MAtnrw7AhKFdssK2EqLOsydx7PBW+h7d5j1ckqrvXvXgaVDoEWkfEtiuSAPF2NYdjTFd0zTM92tUBu6bq4r+vkCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785188901; c=relaxed/simple;
	bh=s86Iz80t+COKGIAgQpMtPdQg69zp16F61aHcV5ft4qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCFwoqxnLF71sA/KxYUnvMFikKfvI2Ec4J8GLDLoNxKZ2EltHOd9jDQ3yhVU7kzxXwpOH5OQXv2MT/oU2CG8Qx4sBuX8gDmHwVOJAvoAYrhmzFymUQ34/yoCtffkLf9/HgNuBjVx7G/z9A9HE2uYXqhf+HNxdbfOZDt2eD4rxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=ToJkmVUG; arc=none smtp.client-ip=185.201.18.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="ToJkmVUG"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx198.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1woSC2-00FE1H-89; Mon, 27 Jul 2026 22:45:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6kb7OSZLeatZJg4qKTXz/3tlja7deBGMwFWUzjzH7tQ=; b=ToJkmVUGB2fPKqtK6AEzo4XCgi
	oxL4tnTpkckgPCyp7FPv0jup4Zuy97gi0jFSqaBpVO2bmmkD1DluQ4YJQt9PRtUhvxGAhRAQ4IqtJ
	+j/yhF33037iBxn8Bw907b4v52XSFJSVdVMUVjyMNHmUUTFk8D6NCQv0sUzygssXIi3WUHCInH6Zi
	bcnpFh1uwQj0jk1edlKYz4hXMQBPZMv8yYX3d/kYSjVYMrNz3IxQKzl1sfibuBO7xyxHCMGzMrgqC
	7vLor5d5Yw0CRLCIUAL+U19T3be0CKAa1p72gplj/blTqAo22Jx92AUiGlRjpnBJk5Jlkfdi6bVFl
	aHRMtCXg==;
Received: from [188.251.249.2] (port=52006 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <dan@reactivated.net>)
	id 1woSC0-0000000AlhO-1NID;
	Mon, 27 Jul 2026 20:44:56 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Mon, 27 Jul 2026 21:43:57 +0100
Subject: [PATCH v2 2/5] dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-bcm2712-iommu-submit-v2-2-0247b5c03de8@reactivated.net>
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
In-Reply-To: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
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
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00675305950777)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXz4UJeeABNWpW4GmXZonq67PwMvKALXrlW
 plrcUrm++iu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVINRCX/Ri5AcP+9Th+oaBXuDGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWAIN4GsiK0O3K+JEByc7IobeB7itP8hgjDRserKv4bhb/pXHHNX+LCF5x5jewa7FkNWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyO3cajqKP
 N2TQucmsPqkADN9YaMSDrgb8f3EnZj8JSSVcMQtcPaBj0oM3kYoQzFFh/1fSrLRlrfqhJUG8z4R9
 /uECIyfb59UKcPyKB7/seAhbEXLAIlQO41grCDpV7x4SG0sbLPkEPwaTR9JCgIIwUaKDJQlUrg+c
 sO2wlDq1j4FhXBjpwUH3T5DwogMcW3n9eq+zqef+wJHXDp70tdmxlpLzlnjbD/7Y4GiVM0Vs+iZc
 VYJfyg12CBbscT1cNN1Jsfa3HCw6gGU1+SdwTBKf9HkMLWk/C0vLNlLzxrmqyasitZFgJIlVn1LH
 h1zXo+HQWBsS3EZt9a+xyS/dOq7TUqYyGJZd46kBXaReSYigCAhlVRgJDS0AzAOltsq3PRbZ63Kg
 QzPNdZuTKxU6aj16VjYz3CPunnl+LI7l5fzInLuGrwLN0VeqvzLlcRxwGgEvNMtirEVgSD8PZy6W
 zRj7WHIZl76lsW55eQV2n2lY9hpC2YtTBQO/Nu6TVwO6CV7e9KZY7AUftyem5JXm2HSubn2WKeN5
 PBvIRkiU4E8H4e7X9sw5VBsaDF9CxNBjABkH3hTMjGc3lQAtuckU+MNQlLpWhjjykqbde3UjWoF9
 cBo9q3T2iWmfFRW/Psbz8QFVy0V5rN3M2TZ9grsaBV7hOgCSkfEzb1aIdlnbLZp4DCYOuNFQ+5eG
 III/qgXB3gv2NI/ukWuQBNrXV+EmIqM8SxKOhcObZXWnkEw+6F9CGyYC9AhR1ZLKC40YaZQ+trtn
 c3HOUHNRces2OQfEVEXjAs8s5hViH5FzumxHh1EFHPyizxFc684o/A69h/CvHI/GeXW8oEyu47TQ
 DqTi6GKwcIp24VOsP5eu885wo+t+ynT3Y80OmAux3oN13+ztUzneZGHdcUfaxYq0ZH+Cc9iqnocR
 WxNUEo38DE53aa5lZFsy2onypIM6qetbKE/25wcBEyyBLXoMm5I9GX4+l7O/frx6h4LvvXllTrDW
 JQYgIwBr3Z1SFe+4OrB9Rro7EpOy1Um2iVRPSUxhtw3wz3yqYcOpyKA69LF1Ge2GaGfxmfp09oMS
 l8c4ShQ//ve+MHzjs9MOb3HXByN6cty/LT6lgOv2AzRyYGlsi3xQeIJ6TM5o5F89lTjPCn99uwfA
 g5wm8t3Xj/LzZ5s/OJg1L2asZ/4te3BTDYEBZZ1yPQnIH5IVn/pKnch3lmmwSrgldH+Ps9MOb3HX
 ByN6cty/LT6lgO+c9AHZZ12442bv/l3jZJg=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

Add bindings for the Broadcom BCM2712 IOMMUs and their shared TLB cache.

Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 .../bindings/iommu/brcm,bcm2712-iommu.yaml         | 48 ++++++++++++++++++++++
 .../bindings/iommu/brcm,bcm2712-iommuc.yaml        | 35 ++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
new file mode 100644
index 000000000000..af4d8bac10e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
@@ -0,0 +1,48 @@
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
+description:
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
+    description:
+      Phandle to the shared IOMMU cache. The IOMMUC is a shared hardware block
+      that provides centralized Translation Lookaside Buffer (TLB) caching and
+      invalidation.
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

