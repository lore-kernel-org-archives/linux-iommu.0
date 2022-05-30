Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1EFC433EF
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 21:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C8FD40C96;
	Mon, 30 May 2022 21:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-MmtHIqnwdG; Mon, 30 May 2022 21:00:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4ABC140949;
	Mon, 30 May 2022 21:00:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 093B1C0032;
	Mon, 30 May 2022 21:00:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA579C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 21:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA72B417BB
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 21:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gh2wFUqOkh8C for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 21:00:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D80A417A6
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 21:00:33 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id q1so12744165ljb.5
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+FJSf1vwMYB6K1+IygWHYLgdHKsQ/Ri86qwFQ7er7r4=;
 b=qQaEnEqIn8+KVCu3pPRo+BDQrdzTpsLMqbypvWjSdP/zBsAUHoF+Gerr5XT7DNRZW1
 0bpkwfkPu1hMKNckTJkbfqyHKTvvxPuLi2IZmXv8DMFMNKXEOakkweh7lNNBTtPOBInP
 RK0XWq87slLWTrLyJGGcQJqd8OW+B3LmN9XSCB6PL+8FmxkWI4gWNWUhuz5hn/0OLywc
 FmS2FjqsGyViA9Q3hUbKnJx84AOsuqZKFmqJuUPb+jKs+WQqtD/joiFjLBoJ8UGFL5xq
 t9Y57ac2D/yaMy2ErqyyoxRbxwDkBaU13uHKzvKFZmAcaFPptLb+oQOVf2CD+OnQqqDE
 qNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+FJSf1vwMYB6K1+IygWHYLgdHKsQ/Ri86qwFQ7er7r4=;
 b=Jt9W80fyfFA7toqMBFK5Z0ZrKfaE7wri+w6K/KtcUCDPRa+3Oi/vJFf2cG2uxZ06dp
 +uedD7m65NqLyFNNQTYnz/Escqx5oTmKIASaYqOV7I5yjaA/cri3x+B7XZ97Tra5YAJv
 gKYQB0SaEC/XyQGBNI5OwDyC4ygzl3CSBW18sQet5Y7yUbgA5kD4fNtOSqWdi+YHr4Rw
 V6zvxWg6lCGzltIxaeEW1x+zySWjOov99MBRR8DOVj9KgJ5l75c4puR2AulFBn0Njc8P
 KO2ozTBfCGfeZuXeysxxi2rzzqGC6bhSwGM6dyKqrAZ+xc2Ko7tFCg9JftNW129qcu14
 nGNg==
X-Gm-Message-State: AOAM5313GMSHle0CBdQadYxIrWNRJ5IznWkLc8I+6tlTZU5lJx2PaBKP
 DFbt4F2OccFeNSkCCXW7yYI=
X-Google-Smtp-Source: ABdhPJy1j0CZ8u38C6o5Ly2O9aBU8Z/J0PR4IPWipSyv2hmVKkIJPggqQZ4sM6kw/XDqJU3SD8VYcQ==
X-Received: by 2002:a2e:a36f:0:b0:253:d948:731c with SMTP id
 i15-20020a2ea36f000000b00253d948731cmr32005387ljn.159.1653944431239; 
 Mon, 30 May 2022 14:00:31 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
 by smtp.gmail.com with ESMTPSA id
 k21-20020a2ea275000000b0025550e2693asm581541ljm.38.2022.05.30.14.00.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 May 2022 14:00:30 -0700 (PDT)
From: Oleksandr Tyshchenko <olekstysh@gmail.com>
To: xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH V3 5/8] dt-bindings: Add xen,
 grant-dma IOMMU description for xen-grant DMA ops
Date: Tue, 31 May 2022 00:00:14 +0300
Message-Id: <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

The main purpose of this binding is to communicate Xen specific
information using generic IOMMU device tree bindings (which is
a good fit here) rather than introducing a custom property.

Introduce Xen specific IOMMU for the virtualized device (e.g. virtio)
to be used by Xen grant DMA-mapping layer in the subsequent commit.

The reference to Xen specific IOMMU node using "iommus" property
indicates that Xen grant mappings need to be enabled for the device,
and it specifies the ID of the domain where the corresponding backend
resides. The domid (domain ID) is used as an argument to the Xen grant
mapping APIs.

This is needed for the option to restrict memory access using Xen grant
mappings to work which primary goal is to enable using virtio devices
in Xen guests.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V1:
   - update commit subject/description and text in description
   - move to devicetree/bindings/arm/

Changes V1 -> V2:
   - update text in description
   - change the maintainer of the binding
   - fix validation issue
   - reference xen,dev-domid.yaml schema from virtio/mmio.yaml

Change V2 -> V3:
   - Stefano already gave his Reviewed-by, I dropped it due to the changes (significant)
   - use generic IOMMU device tree bindings instead of custom property
     "xen,dev-domid"
   - change commit subject and description, was
     "dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops"
---
 .../devicetree/bindings/iommu/xen,grant-dma.yaml   | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml

diff --git a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
new file mode 100644
index 00000000..ab5765c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/xen,grant-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xen specific IOMMU for virtualized devices (e.g. virtio)
+
+maintainers:
+  - Stefano Stabellini <sstabellini@kernel.org>
+
+description:
+  The reference to Xen specific IOMMU node using "iommus" property indicates
+  that Xen grant mappings need to be enabled for the device, and it specifies
+  the ID of the domain where the corresponding backend resides.
+  The binding is required to restrict memory access using Xen grant mappings.
+
+properties:
+  compatible:
+    const: xen,grant-dma
+
+  '#iommu-cells':
+    const: 1
+    description:
+      Xen specific IOMMU is multiple-master IOMMU device.
+      The single cell describes the domid (domain ID) of the domain where
+      the backend is running.
+
+required:
+  - compatible
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    xen_iommu {
+        compatible = "xen,grant-dma";
+        #iommu-cells = <1>;
+    };
+
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        /* The backend is located in Xen domain with ID 1 */
+        iommus = <&xen_iommu 1>;
+    };
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
