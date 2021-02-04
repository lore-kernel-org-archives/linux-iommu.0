Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C1CC433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 07:14:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CF364E27
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 07:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CF364E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB60186ACD;
	Thu,  4 Feb 2021 07:14:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dugNcfiGtm7C; Thu,  4 Feb 2021 07:14:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D228186ABD;
	Thu,  4 Feb 2021 07:14:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB2E1C08A1;
	Thu,  4 Feb 2021 07:14:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1703CC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 07:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 12659871D6
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 07:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OeZrsReawtjY for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 07:14:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7C56A871D5
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 07:14:49 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id o63so1485301pgo.6
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 23:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gMwV/7nsE5roUUmtI+CoFEwIDleSZQrd14tE0FVtMOE=;
 b=odzWHrloN/wRcxyb6aZFAHYcjyBk86MMT4vqy7adE/iKLC8rd9L+1d4xEbgGjQibk7
 t7gJtQpeiPluDu+WEGMn9iJjuc0zhQolSOGHM24pthstaEUhL5Mo3wERUOyAP9xXmoBl
 1nJ/uDh5uChzixEIAh0aglELcqdZIVTin+YswwF+fLO/ktGqI8XvrX/MT0qLzTMpgRRh
 KqSkkGINw6nkoqPplq9SakPBYqgdHqjnt33/xE8ow3wMO8EK6R0FaV4UOavtjozVVWBY
 WAULuMPQ/ACbvdoEMsO5ATCj5YOfM/5j+YKXLYB9YvZGBO3BRbqpeg2pIVb+VxLEcbXs
 qULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gMwV/7nsE5roUUmtI+CoFEwIDleSZQrd14tE0FVtMOE=;
 b=cAXTcIG92o8p9BoJRQrer9QyPCxXyC60C0U+hGn8v4bJN8itynbmWGDr99SB0rXApi
 G6iWG6E8FQm/yP4+L3yxrRj8Nk1yjgmdo2fBKeUxGve9a5Ztp7J5xspN0l+TExzO9G4O
 TjTefP/XYeEvqID9AbFfZRFQZ3jJjSZGuO5QF6y1v5BMN/rfxQ/GU7yQlDafU9z3pFIu
 0lX7sTSPcQlD9kcqEfYuL93fWp7nbt2nimq8PHRlOBIbfWplrnneLQQCL2C8EDIHCwcC
 54p+Y3rNFSEzblkCfb5W4EriPUX3XT9d3vcK/ygGODkWOXw364gusUcwvVCtJgOoh4pw
 gMKw==
X-Gm-Message-State: AOAM533pHIVGIxuVEd9ophLvILD+p9G5WDmEgmKyEh3/6RHCOHYg8zGi
 Mydz7n0Iyc8yWleFEVTc7j8=
X-Google-Smtp-Source: ABdhPJyF3ezlJ8DKqXaY1mRWSpJAVhGIF9ojWcGQXuHC9TuruhLI48LoIzbQM/G3Nvdt0M6l4rjp5Q==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr7484668pgv.241.1612422889076; 
 Wed, 03 Feb 2021 23:14:49 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id h4sm4578855pfo.187.2021.02.03.23.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 23:14:48 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: iommu: add bindings for sprd IOMMU
Date: Thu,  4 Feb 2021 15:14:03 +0800
Message-Id: <20210204071404.891098-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204071404.891098-1-zhang.lyra@gmail.com>
References: <20210204071404.891098-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>
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

This IOMMU module can be used by Unisoc's multimedia devices, such as
display, Image codec(jpeg) and a few signal processors, including
VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..36abd2187a19
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
+      register range used by IOMMU and multimedia device, the cell
+      defines the offset for IOMMU registers. Since IOMMU module shares
+      the same register range with the multimedia device which uses it.
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
