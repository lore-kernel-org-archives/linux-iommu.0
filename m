Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A4C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 09:08:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFB964E36
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 09:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFB964E36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6397C86730;
	Wed,  3 Feb 2021 09:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8uvz30k89DiV; Wed,  3 Feb 2021 09:08:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1BB238650D;
	Wed,  3 Feb 2021 09:08:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08AECC0174;
	Wed,  3 Feb 2021 09:08:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBB5FC013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D1004870BD
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLQYZOPaKCZn for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 09:08:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DDC48870B2
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:08:02 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id q20so16235242pfu.8
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 01:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MBNJGJWi6eP7GdgbQTp5RCUskWudTGe2wTYTqTKx4V0=;
 b=KMPbBYyLh4qQHs05QbeBHjZsRM8xJCZqoLV4jmxvxGh9VSJYY3tqs3KSgOuS/vkZPa
 /VF6M0NN3pl7lNwnoxe55k0Fq2BMz+FEAC0yZR5Xh1q5rqvlfMqu8BQct6pplCDxvN/X
 VtUMl3rUhzIhsK+0N5Sd19LyDexd/4jgZUTex/AjvORZ4PU98zqOL0H+uKHW55UeM4j4
 GVAgryL62ak360L4TrJizJLWdmJq6ioYMtowxDs9dXYAYouEh969NSRSHXOi6tzRC7ZG
 dRv9oEHlOzuEEWwWu19nbcj9nFfZTYxH4DXC8dbw2GqDly0W7nmJAucGWmWsdn+Umr/2
 72sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MBNJGJWi6eP7GdgbQTp5RCUskWudTGe2wTYTqTKx4V0=;
 b=lRxujbyTxOMdSQ6ZkSuBHCCQRjsBMj/5Mof2ELjhC7Pa/csT4Lq1M3EW2OlUq9+IDc
 D8cHcu2mU5rNl5xsK/IqOS7KyZ+2XRgIOk2hxHD3JdFnfOlTs8xUkr8+MIxaga/DnrZ4
 8aBNOfZbPEvoeWtW2mXrPa3NRNGy9h9fnIPGOBzNog3+t+T2IcENYx2ieL58WWXLvTGA
 +lXevHOvOGSthBR/tbmPb2COTxoz8a3y86IC4T5I87Mq3ZJlxnDgIie+BD+AZTX0KSFA
 zR2QWlmMTTcH2i6qhVtavcoZpjjCYvN2nQxKQz5vdq1LRMGAwt3t6PKy47gn0k51OKWo
 l2ag==
X-Gm-Message-State: AOAM532/bjiI+6Zj86mfTW8zXMkJTLhPOvSiJifrb1EA2kQuuXF9ulBe
 xdCd8jyau3zHzwVrkxnc+UQ=
X-Google-Smtp-Source: ABdhPJyon0Q21+AWXR2McqbrrUaVGjOGMgM5ykj/OuwX2mo8spdaqpXn5ey5eVy3BBFR//zq36f7dg==
X-Received: by 2002:a63:d601:: with SMTP id q1mr2555343pgg.417.1612343282495; 
 Wed, 03 Feb 2021 01:08:02 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id y12sm1586403pfp.166.2021.02.03.01.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 01:08:01 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
Date: Wed,  3 Feb 2021 17:07:26 +0800
Message-Id: <20210203090727.789939-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203090727.789939-1-zhang.lyra@gmail.com>
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 Sheng Xu <sheng.xu@unisoc.com>, iommu@lists.linux-foundation.org,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
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

This iommu module can be used by Unisoc's multimedia devices, such as
display, Image codec(jpeg) and a few signal processors, including
VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..4fc99e81fa66
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
@@ -0,0 +1,72 @@
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
+      - sprd,iommu-v1
+
+  "#iommu-cells":
+    const: 0
+    description:
+      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
+      additional information needs to associate with its master device.
+      Please refer to the generic bindings document for more details,
+      Documentation/devicetree/bindings/iommu/iommu.txt
+
+  reg:
+    maxItems: 1
+    description:
+      Not required if 'sprd,iommu-regs' is defined.
+
+  clocks:
+    description:
+      Reference to a gate clock phandle, since access to some of IOMMUs are
+      controlled by gate clock, but this is not required.
+
+  sprd,iommu-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Reference to a syscon phandle plus 1 cell, the syscon defines the
+      register range used by the iommu and the media device, the cell
+      defines the offset for iommu registers. Since iommu module shares
+      the same register range with the media device which uses it.
+
+required:
+  - compatible
+  - "#iommu-cells"
+
+oneOf:
+  - required:
+      - reg
+  - required:
+      - sprd,iommu-regs
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu_disp: iommu-disp {
+      compatible = "sprd,iommu-v1";
+      sprd,iommu-regs = <&dpu_regs 0x800>;
+      #iommu-cells = <0>;
+    };
+
+  - |
+    iommu_jpg: iommu-jpg {
+      compatible = "sprd,iommu-v1";
+      sprd,iommu-regs = <&jpg_regs 0x300>;
+      #iommu-cells = <0>;
+      clocks = <&mm_gate 1>;
+    };
+
+...
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
