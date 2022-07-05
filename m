Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E683FC433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 13:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8108F40A49;
	Tue,  5 Jul 2022 13:07:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8108F40A49
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=lm8H8F5n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cFs3SBF5verF; Tue,  5 Jul 2022 13:07:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2F4C140141;
	Tue,  5 Jul 2022 13:07:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F4C140141
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 079A0C0032;
	Tue,  5 Jul 2022 13:07:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE599C002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 13:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B3DE82716
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 13:06:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B3DE82716
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=lm8H8F5n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UhYURw7T2I1x for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 13:06:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8794182404
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8794182404
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 13:06:57 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id pk21so21578221ejb.2
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E5lZCn36K7elVbgWUPtU4nIkD2xVpncEAsbxyPDLzyQ=;
 b=lm8H8F5nhMgMkfJktmNYWnUwAHoU2kzLD1lTjvkXjHVFIckKFJIfzndHBmtswfGRg/
 MXRKwWqk9GdDKkkUqoELU2G0JpTQkS+85q5nInih4KHrdwlCb32ArHDlZxJXLb14yZ2w
 +l97eRTC0Rv6D+/OJhsjiyFiepR7ozNkzifW+JtqVkW88Hmw1G+yqTqvB+NTaPXM9WNH
 edYyvQDB+kYK94PH8/ZDymKjKKoIAPrxwfLE5D+AGN3jfz0NNxFdNDR7eibxSRGx574F
 7II+SvPVgYI9g9ZmxZYYaN8b0zAdF+EOcBR05XoLHJcl8DPdXwsm9HsEhM3ikdSOVCIO
 JIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E5lZCn36K7elVbgWUPtU4nIkD2xVpncEAsbxyPDLzyQ=;
 b=DGOVFchc6HgLVsrdpusD/1HnQkPmKw45fUESY9buLAhpunxsO3XxOIk+H6gnD7tC1O
 +zPEg/1GcArZquRj1JOPchGB7OBIKnGYYaQbYY7rLPLBzzALRgsd5yxCvWCwECZ3+SJ4
 zDqqD/zKQ7PAqGLkxtrSKVgyQ37eZUYrzDgR8uEnSwa2+PtUwBxWi33xfXhpkN9okb+D
 Rz3j8t0FQZAh/1dmno5/9QF1ca1Vp2MlWeWbzcdaX8TiraGD7ylIG6oM5VcGEOq0wK94
 dWFE0s1I+hfPRs5zD4j184cGjBdsaGT5H7nlbXpV9ko9J2iLllN5uEmn/ehpTRhPU0U5
 j2jQ==
X-Gm-Message-State: AJIora8UhvOz0+RjlsDercdvrKhmf2vRa/OL8tV4bDWjoZoGuf2Hj11F
 KIepilywrkwLykP5o6KIxQ4=
X-Google-Smtp-Source: AGRyM1vD8mMwCrBI8neyCmTlP1RSBwb6Rp+y6x2OGJiIuDCQ/Ljz4kwRfPcQ5Ky4BFx6E/eSBIIMrw==
X-Received: by 2002:a17:907:1dc6:b0:72a:5e9a:91be with SMTP id
 og6-20020a1709071dc600b0072a5e9a91bemr28945775ejc.730.1657026415675; 
 Tue, 05 Jul 2022 06:06:55 -0700 (PDT)
Received: from localhost
 (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a056402000800b0043a71c376a2sm2744485edu.33.2022.07.05.06.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 06:06:53 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v7] dt-bindings: reserved-memory: Document iommu-addresses
Date: Tue,  5 Jul 2022 15:06:52 +0200
Message-Id: <20220705130652.433496-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705125834.431711-2-thierry.reding@gmail.com>
References: <20220705125834.431711-2-thierry.reding@gmail.com>
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
Changes in v7:
- keep reserved-memory.txt to avoid broken references

Changes in v6:
- add device phandle to iommu-addresses property in examples
- remove now unused dt-bindings/reserved-memory.h header
---
 .../reserved-memory/reserved-memory.yaml      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

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
