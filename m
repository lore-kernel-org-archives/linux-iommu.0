Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC60CC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 19:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89B68401C3;
	Thu, 12 May 2022 19:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XHxdbz7y_9XU; Thu, 12 May 2022 19:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F2E484016E;
	Thu, 12 May 2022 19:01:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4572C0032;
	Thu, 12 May 2022 19:01:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2385EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F167B409ED
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 68yhPHZxwYC3 for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 19:01:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8225B401B9
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:03 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id p26so10692273lfh.10
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zObGKOaJqI+lQlWn/A2V2vyoJI6RyKFT4z4IHmuyIik=;
 b=feex53gwAWPfxdOhgRR95JhgIvWQTMfp6AMZf8ZC6V1/1zgbKvx7ZkfTb3JUtn2/1m
 zvNvIyypfMSuOyQChmxyWeKn1DLIfWBVxOH5N1AKTujmIaajZk4WSlSl3dsu36T/spl7
 QS4AunHAdGvq2kw987GUMoOjaoIfQ2ocFZnbnhMa1EEXwHovABQPJQp1v7I+ziKyI23f
 bvTHJVqTpOANZLMsCwMuCiOtAZHjv5fl/3L89dNAVzzfcg+uQjEAMecKAeRpbHGTpdvy
 h4rnchINjMIjTD6XBX1FYl3LchHo6dEqYcs4uNXLWxtWwbijJE49lvidgTWqqjZbOdPd
 bQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zObGKOaJqI+lQlWn/A2V2vyoJI6RyKFT4z4IHmuyIik=;
 b=V/MX11wRPQPPeDRB4K2ItIJ6QhkjsTfL+UGSN9+tmo+dzmxce/jnvwV7JYVDamYvFA
 EyVEMPM1cTjDqy5sUU3HFfw120sHWlKTNDBsycnUQYRYZx521cJ7NjwG1kls62ZeEmyW
 AAO8BApT5So+ekQPcebwJ+cnHnM2QuSnTiF52J1ADMC/i4WNmeIe48gt9dv5aYlCnBnI
 dSaK3OhbYXtpM3EmbFfAKb5VEjT7of7fj8oZqcq4G4pTZwAlxcSeauuSk8g58BgiyOad
 q2eF2ZAZxlj8P/2rdA3wV8vhTPD6OdhnBMICftfUFuBC35x9FxybDQjYZHvZj5Sb9CZi
 A6MA==
X-Gm-Message-State: AOAM533QQPtVsIznzpRepeee9c7PlLxQ3R8Y/x0yMKyBqR8BrhpyJTaP
 vDe1g6FiFmLTTsCsz6yQl3U=
X-Google-Smtp-Source: ABdhPJyTmd5nsLTmRqk/CLqOwQdO0d9t4A6MVZuzTPU6DSpoKmI0wKtbuxTMdPvFwRHBLXtKLktysQ==
X-Received: by 2002:ac2:4e86:0:b0:474:879:97e9 with SMTP id
 o6-20020ac24e86000000b00474087997e9mr833553lfr.558.1652382061258; 
 Thu, 12 May 2022 12:01:01 -0700 (PDT)
Received: from localhost ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 n27-20020a05651203fb00b0047255d2115bsm55030lfq.138.2022.05.12.12.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 12:01:00 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 1/5] dt-bindings: reserved-memory: Document iommu-addresses
Date: Thu, 12 May 2022 21:00:48 +0200
Message-Id: <20220512190052.1152377-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512190052.1152377-1-thierry.reding@gmail.com>
References: <20220512190052.1152377-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Sameer Pujar <spujar@nvidia.com>, iommu@lists.linux-foundation.org,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Janne Grunau <j@jannau.net>, Robin Murphy <robin.murphy@arm.com>
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
 .../reserved-memory/reserved-memory.txt       |  1 -
 .../reserved-memory/reserved-memory.yaml      | 62 +++++++++++++++++++
 include/dt-bindings/reserved-memory.h         |  8 +++
 3 files changed, 70 insertions(+), 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
 create mode 100644 include/dt-bindings/reserved-memory.h

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
deleted file mode 100644
index 1810701a8509..000000000000
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has been moved to reserved-memory.yaml.
diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
index 7a0744052ff6..3a769aa66e1c 100644
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
+    reserved-memory {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      ranges;
+
+      adsp: reservation-adsp {
+        /*
+         * Restrict IOVA mappings for ADSP buffers to the 512 MiB region
+         * from 0x40000000 - 0x5fffffff. Anything outside is reserved by
+         * the ADSP for I/O memory and private memory allocations.
+         */
+        iommu-addresses = <0x0 0x00000000 0x00 0x40000000>,
+                          <0x0 0x60000000 0xff 0xa0000000>;
+      };
+
+      fb: framebuffer@90000000 {
+        reg = <0x0 0x90000000 0x0 0x00800000>;
+        iommu-addresses = <&dc0 0x0 0x90000000 0x0 0x00800000>;
+      };
+    };
+
+    bus@0 {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      adsp@2990000 {
+        reg = <0x0 0x2990000 0x0 0x2000>;
+        memory-region = <&adsp>;
+      };
+
+      display@15200000 {
+        reg = <0x0 0x15200000 0x0 0x10000>;
+        memory-region = <&fb>;
+      };
+    };
+
 ...
diff --git a/include/dt-bindings/reserved-memory.h b/include/dt-bindings/reserved-memory.h
new file mode 100644
index 000000000000..174ca3448342
--- /dev/null
+++ b/include/dt-bindings/reserved-memory.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+
+#ifndef _DT_BINDINGS_RESERVED_MEMORY_H
+#define _DT_BINDINGS_RESERVED_MEMORY_H
+
+#define MEMORY_REGION_IDENTITY_MAPPING 0x1
+
+#endif
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
