Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FEAC433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 07:34:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1231064DDD
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 07:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1231064DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BBD0D86D37;
	Tue,  2 Feb 2021 07:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GCaFIXtj+Hkz; Tue,  2 Feb 2021 07:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2DE04861A2;
	Tue,  2 Feb 2021 07:34:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 251AAC0174;
	Tue,  2 Feb 2021 07:34:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A305C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 07:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 843822047D
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 07:34:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AipfHcOW+9zN for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 07:34:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by silver.osuosl.org (Postfix) with ESMTPS id 54D5520020
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 07:34:50 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id j2so12684390pgl.0
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 23:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MBNJGJWi6eP7GdgbQTp5RCUskWudTGe2wTYTqTKx4V0=;
 b=pmpSCGCBGyZpwijywa887RwHyaZATOvgE1aNeznea8FbSQtpW7aU8gy5w1kW2zQN6/
 zV4D32ThIZX4TlupUN5CXFNfCB3zZkyp/57OWUbC0mtw++MY2kkUPe/B6lIRju2RaimH
 hiYzTMNoaECstCkIPxq3D8mOlffKQB7uZFhdWOA3ad2iN/Cy5Nf9lh3c/hRg7JYGZyLm
 EQxQt0vkLCOVaeVBxXPHSngvm5c457y6BJfANjxDj5acCJtyW6usDY91OZlsDzJCL6yk
 nwfRWfzgge7vML98i7rNTTIhcF/xejh6EV3t7/lF5mESq+WLwP/Ymgd08hXUxzRK1nqU
 A2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MBNJGJWi6eP7GdgbQTp5RCUskWudTGe2wTYTqTKx4V0=;
 b=KQt42cKsuNft4ZYV8EWlVcYM9qWuKaslsRYf8wksGYYJXEFypQMPHXTvlk2eRo/Itx
 E16RckpxkQCpxATC6lPe3iibKf14mm64DupF+vBR6baWbQeA6366Iob7ZcuGTIHPxX6J
 /BP4AtQAeo0tOkVUfREGoTFN4PkLAg7UJQuZM4jMqHr44FSGZCJ8a23/qdevtUR5aHZO
 KmymvUFyG5hQWWBD190G794l6GmQlJt6qBzy6oY7zr8WFI6TkoGE4r1LxxCLIpDb5s5d
 3qow34P1YbRgsrkMfZi4r6r4J0dlLtuyxx76h4oZSzD6ampiaoUlR+4vRpEDN+gfjdeE
 /9gg==
X-Gm-Message-State: AOAM531ECFsttNmwRi51crtTcoF7fsJC7uLfX2zo4g8qqZR80CtXA2nL
 nK73TqRX5kt/acLRAWbSd54=
X-Google-Smtp-Source: ABdhPJwVwMqBTa3MvSnsnMCZEEm0OukPovehjbfJCq5GTvXGDy6tkb8htyb1+2SgjEufZ4hI5DIlDg==
X-Received: by 2002:a63:63c3:: with SMTP id x186mr20368910pgb.54.1612251289802; 
 Mon, 01 Feb 2021 23:34:49 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id o4sm1752029pjs.57.2021.02.01.23.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 23:34:49 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/2] dt-bindings: iommu: add bindings for sprd iommu
Date: Tue,  2 Feb 2021 15:32:57 +0800
Message-Id: <20210202073258.559443-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202073258.559443-1-zhang.lyra@gmail.com>
References: <20210202073258.559443-1-zhang.lyra@gmail.com>
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
