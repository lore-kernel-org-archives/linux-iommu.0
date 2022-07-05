Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1146C43334
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 12:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40C0B61063;
	Tue,  5 Jul 2022 12:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40C0B61063
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Py0vxhDT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O3Yx2qX285lX; Tue,  5 Jul 2022 12:58:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EEBF76063B;
	Tue,  5 Jul 2022 12:58:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEBF76063B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFACEC0032;
	Tue,  5 Jul 2022 12:58:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D97C2C002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 12:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4EDB40869
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 12:58:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4EDB40869
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Py0vxhDT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v0RW_L2DC1ZL for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 12:58:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54E2C40873
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54E2C40873
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 12:58:43 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id eq6so15152388edb.6
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/KFZ7cMq9JU+ArgnFFOioWDlil9QesIzP5/MdIscAXo=;
 b=Py0vxhDTdUr4+MxP647OOnJwClrnNnu90Pd79Y02NW8ZHIZiTv7rHNn/Z+ThujmZW9
 g0WYwIiwfE+htVnBa/fyVdL587u9cXDLC0vIUNRJSth5U5nuPNnqvsPV8owIWnI4UypF
 vvcaZnMdZh+S17Gti6kcnvj4wynbzZ9gpjflsHdGCqR08vruWJp3Mzc5J69KrxShmamh
 07pVeQOtmLgrdKFUbvlXSsHSolLtmw9r84deR3Du0qinOJvQTpqFR/AY3lWsvPSQ7mR5
 4CEQ3Gq3Gqv01hiNcC18jkVqqIripnnkK2Y9NMEG1WjISnoLS07MYL49fI7WhWKUrlnk
 eqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/KFZ7cMq9JU+ArgnFFOioWDlil9QesIzP5/MdIscAXo=;
 b=qH/50232vD5VQhqcQPv6O0V+4/0ktZqwSeCcsIQFkd3M/12rxIq6Zf99RQxnQ30V7o
 fy/8IS/LWYsiN/fiNkdzq6IdZjto5oy5NOy7qFyWEX/a0RvQlfwIwaXe3pOjmloo/kSc
 9GWgoreLtIooqttphSXUMdzMUOZutCG7rm79687S6lrMLckfdM4rhq4Suq1VTJ3vLC7M
 YZN6EWlU19PuctX2YN85Q6AOBdB0Y/cB+N0XnQ/yOKYOlcF5I1nGGAe2waANsNRjbfQM
 PF45zSvf/YyUMiiIFJohkpImM6ttEltYR/0DLKFcru1HwehBH3aC4+S7f+aoEn4tDTjo
 A1Hg==
X-Gm-Message-State: AJIora+MGVpRYHYnTnx5Nl1HFqXcEWAPzzdLPv5OmMKmhDHdUvoyx3+D
 v5xFAEP0kqnBHSPEXaOxhmU=
X-Google-Smtp-Source: AGRyM1tL7dLUK0tNEdwSBHVbXevA1qu+6i9xsWr/SUwd7OcqQyEtiWItJWgq2Lpy3YPrD0xM44NgDQ==
X-Received: by 2002:a05:6402:149:b0:431:7dde:9b59 with SMTP id
 s9-20020a056402014900b004317dde9b59mr46118082edu.339.1657025921510; 
 Tue, 05 Jul 2022 05:58:41 -0700 (PDT)
Received: from localhost
 (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 b9-20020aa7dc09000000b00437938c731fsm17191040edu.97.2022.07.05.05.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 05:58:40 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v6 1/5] dt-bindings: reserved-memory: Document iommu-addresses
Date: Tue,  5 Jul 2022 14:58:30 +0200
Message-Id: <20220705125834.431711-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705125834.431711-1-thierry.reding@gmail.com>
References: <20220705125834.431711-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Sameer Pujar <spujar@nvidia.com>, iommu@lists.linux-foundation.org,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Janne Grunau <j@jannau.net>, Robin Murphy <robin.murphy@arm.com>,
 asahi@lists.linux.dev
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Thierry Reding <treding@nvidia.com>

This adds the "iommu-addresses" property to reserved-memory nodes, which
allow describing the interaction of memory regions with IOMMUs. Two use-
cases are supported:

  1. Static mappings can be described by pairing the "iommu-addresses"
     property with a "reg" property. This is mostly useful for adopting
     firmware-allocated buffers via identity mappings. One common use-
     case where this is required is if early firmware or bootloaders
     have set up a bootsplash framebuffer that a display controller is
     actively scanning out from during the operating system boot
     process.

  2. If an "iommu-addresses" property exists without a "reg" property,
     the reserved-memory node describes an IOVA reservation. Such memory
     regions are excluded from the IOVA space available to operating
     system drivers and can be used for regions that must not be used to
     map arbitrary buffers.

Each mapping or reservation is tied to a specific device via a phandle
to the device's device tree node. This allows a reserved-memory region
to be reused across multiple devices.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v6:
- add device phandle to iommu-addresses property in examples
- remove now unused dt-bindings/reserved-memory.h header

 .../reserved-memory/reserved-memory.txt       |  1 -
 .../reserved-memory/reserved-memory.yaml      | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
deleted file mode 100644
index 1810701a8509..000000000000
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has been moved to reserved-memory.yaml.
diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
index 7a0744052ff6..8b885ee82ff4 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
@@ -52,6 +52,30 @@ properties:
       Address and Length pairs. Specifies regions of memory that are
       acceptable to allocate from.
 
+  iommu-addresses:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: >
+      A list of phandle and specifier pairs that describe static IO virtual
+      address space mappings and carveouts associated with a given reserved
+      memory region. The phandle in the first cell refers to the device for
+      which the mapping or carveout is to be created.
+
+      The specifier consists of an address/size pair and denotes the IO
+      virtual address range of the region for the given device. The exact
+      format depends on the values of the "#address-cells" and "#size-cells"
+      properties of the device referenced via the phandle.
+
+      When used in combination with a "reg" property, an IOVA mapping is to
+      be established for this memory region. One example where this can be
+      useful is to create an identity mapping for physical memory that the
+      firmware has configured some hardware to access (such as a bootsplash
+      framebuffer).
+
+      If no "reg" property is specified, the "iommu-addresses" property
+      defines carveout regions in the IOVA space for the given device. This
+      can be useful if a certain memory region should not be mapped through
+      the IOMMU.
+
   no-map:
     type: boolean
     description: >
@@ -97,4 +121,42 @@ oneOf:
 
 additionalProperties: true
 
+examples:
+  - |
+    / {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      reserved-memory {
+        ranges;
+
+        adsp_resv: reservation-adsp {
+          /*
+           * Restrict IOVA mappings for ADSP buffers to the 512 MiB region
+           * from 0x40000000 - 0x5fffffff. Anything outside is reserved by
+           * the ADSP for I/O memory and private memory allocations.
+           */
+          iommu-addresses = <&adsp 0x0 0x00000000 0x00 0x40000000>,
+                            <&adsp 0x0 0x60000000 0xff 0xa0000000>;
+        };
+
+        fb: framebuffer@90000000 {
+          reg = <0x0 0x90000000 0x0 0x00800000>;
+          iommu-addresses = <&dc0 0x0 0x90000000 0x0 0x00800000>;
+        };
+      };
+
+      bus@0 {
+        adsp: adsp@2990000 {
+          reg = <0x0 0x2990000 0x0 0x2000>;
+          memory-region = <&adsp_resv>;
+        };
+
+        dc0: display@15200000 {
+          reg = <0x0 0x15200000 0x0 0x10000>;
+          memory-region = <&fb>;
+        };
+      };
+    };
+
 ...
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
