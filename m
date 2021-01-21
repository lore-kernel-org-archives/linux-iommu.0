Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64E4C433E0
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 11:24:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3166B238E3
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 11:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3166B238E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7D376871C0;
	Thu, 21 Jan 2021 11:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hbbpfhwxy1Iv; Thu, 21 Jan 2021 11:24:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7636C87047;
	Thu, 21 Jan 2021 11:24:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BD0BC088B;
	Thu, 21 Jan 2021 11:24:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ADF0C013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 11:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 84252871BE
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 11:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eO7kqY9XydSB for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 11:24:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4AA0C87047
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 11:24:02 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id y12so1464714pji.1
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 03:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lslmnlQrtpTIRDu3hWAi8sXwnSjS9donHChZd58khQg=;
 b=UXQlAdc3hwbMzWm7xePYi4qK9KThp0aPF+Fo8eaQ1m454i2Id/Fg4/2lnzVZNTBgSE
 FZWOCaKhIZ/w/ivuLaSJ2B1OBAtTUEy9gkaKWYiRQ631x4j4pJWFj7xbmWPflAoho9nx
 5TqVyroutmHFUHB3pls8vsLs3fXIoJ2ZtRZAJaKus50gRaXz5TP52PHIYHudHBo2KmHG
 d+wMkNBWjxiMYQD5ck/jol9G1dyhM3Ai4rZa8pdVwNDxsrUkX7iVLPJzc/Hd+9sbPMgD
 NRqXfPjni1Qj/64G4G1gha7qiLB0sgr0aWfZF2C/TG2c5iOX0QsU488ufpKl/6YGiDHA
 2ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lslmnlQrtpTIRDu3hWAi8sXwnSjS9donHChZd58khQg=;
 b=f2ecwKv8GSOBBtdeLpx6T2ggM7tSQj9XENQS6fEZXvJpjQ58RkYEfwAboUW4oOpFVB
 T/JMFkmCAfA0MjZO49P8IYIjsBAC3pViOvTbtc0uhMv7MYChNUVbbeI3DZs0BNtdKWa1
 1k6KzLVnuttHFivgW9EKAmA50Isd5U7VY9jAiYlnp3FuoB4wj/DerhwbL5r8TzTbZeJA
 6gQic9mSnwHASimDkJGJKH9qQkn+YppqbOcM2C5Ht857td+yO56f9g14ryfvmbNo+212
 o3Ym+jX16fwpQOKbbVx1lI8bLgZWc/0KseH4ducizeXUmbiWDyHQfuWA5AKGJ9CcFjpg
 ZAng==
X-Gm-Message-State: AOAM531vufiEKV1Am4HaVeWgf4NlYRPTZAOQDrYaGBC2vh7I10ctX/K9
 LQ/omEUG3KKO0iD8XotsMqg=
X-Google-Smtp-Source: ABdhPJxR2pyo41CIdOAqik7/AVjtgJxP91xCIN/od+oVRsP+mpgZY+ChDoR6zqNG4YsSW2ZmSO108w==
X-Received: by 2002:a17:902:e5cc:b029:df:bc77:3aba with SMTP id
 u12-20020a170902e5ccb02900dfbc773abamr9115606plf.72.1611228241858; 
 Thu, 21 Jan 2021 03:24:01 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id me5sm5404797pjb.19.2021.01.21.03.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 03:24:01 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v1 1/2] dt-bindings: iommu: add bindings for sprd iommu
Date: Thu, 21 Jan 2021 19:23:48 +0800
Message-Id: <20210121112349.421464-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121112349.421464-1-zhang.lyra@gmail.com>
References: <20210121112349.421464-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 Sheng Xu <sheng.xu@unisoc.com>, iommu@lists.linux-foundation.org,
 Kevin Tang <kevin.tang@unisoc.com>, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>
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

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch adds bindings to support display and Image codec(jpeg) iommu
instance.

The iommu support for others would be added once finished tests with those
devices, such as a few signal processors, including VSP(video),
GSP(graphic), ISP(image), and camera CPP, etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..4b912857c112
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2020 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc IOMMU and Multi-media MMU
+
+maintainers:
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,iommu-v1-disp
+      - sprd,iommu-v1-jpg
+
+  reg:
+    maxItems: 1
+
+  "#iommu-cells":
+    const: 0
+    description:
+      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
+      additional information needs to associate with its master device.
+      Please refer to the generic bindings document for more details,
+      Documentation/devicetree/bindings/iommu/iommu.txt
+
+required:
+  - compatible
+  - reg
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu_disp: iommu@63000000 {
+      compatible = "sprd,iommu-v1-disp";
+      reg = <0x63000000 0x880>;
+      #iommu-cells = <0>;
+    };
+
+...
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
