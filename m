Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7D0C433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 09:33:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2EA64FE2
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 09:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2EA64FE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 818EB84521;
	Fri,  5 Mar 2021 09:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Rt79URcrH0b; Fri,  5 Mar 2021 09:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60F6E8452A;
	Fri,  5 Mar 2021 09:33:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32EDEC000B;
	Fri,  5 Mar 2021 09:33:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E15DAC000A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 09:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDC58431E8
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 09:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qoE1Urjcq953 for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:33:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1439043150
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 09:33:07 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id ch11so1613600pjb.4
 for <iommu@lists.linux-foundation.org>; Fri, 05 Mar 2021 01:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HlqmHeevMmSuyU9myU0zzVc8UAGUmKSe//SxTGaHqG8=;
 b=piYgtv3h6moY2iLUdfh0qaV9PvnwRZSusUIde5rh04gNmgqdmhRtuhaP69HuYFDpqh
 Ibm2vmfmRTfDnw9pWKTtXrdRjgUboi6Z89GPH5gjit4nT5ldPxCANoL/+oTQ/3s9iqPJ
 JTVONZDVRObObRBMrBEcF0HylLy3XAquOahU8CYO1ClZZqIXDJFKRT87bW3U5cj0+5bD
 R1ApQMUUVmADSga1FcnG1dFObub9bnRUy9JHb0VnmUYboUNJzNki3j86AqSYv+2wgCin
 6kabTpw8+nbY6DByc1WhbYfV9D1rm6Na+HkFGcFlMVMpDN1ol2B6klTDMrtb+AlEoNpc
 ZF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HlqmHeevMmSuyU9myU0zzVc8UAGUmKSe//SxTGaHqG8=;
 b=VnU5LxXwvf8me+m4/tjx5n4tFbxYYRqdvPbWBgaS3GMm3RhUG+qvdcnuc7q6KCLoLc
 DZNvU1CSolEhgqyo7fIMF43drVreMy8WL3WbQS5SyoNhvAafGlaHUPM/dR/Pnfj9st75
 LBOLi+pEzoACi2Yn34uKUD3QZGg8QrJgcJ2XXB30y1kFoG+oHg5x1WHvWiWG82jHBvXu
 yxEIET2fT+uJ/TiYb6kh5K1HxsUI1AYQQYnPcd13AtUa5Id3KXZ4+EOq8DlcOnRP+Rd9
 9FSzyBQnxeVAThfRJuQdICq7qONQou3uek9QGCXFZhnMlhOz1IEZJHW1I2wNOKCBEGaN
 sMMQ==
X-Gm-Message-State: AOAM532kqzPMlut5e3FML8g0Pc9ujVFfePk3fb+o31poQJ9tjBqttHO+
 roQlQvuKlPR5LUE5pchvhV8=
X-Google-Smtp-Source: ABdhPJzH/dGqeZ1ZHVVmsHM3zWtRrVX9cheaLLPZERpuKhfsIz8C7bi/VpWE7GhAa1FHEmYR2KlfKA==
X-Received: by 2002:a17:90b:947:: with SMTP id
 dw7mr9451009pjb.178.1614936787556; 
 Fri, 05 Mar 2021 01:33:07 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id f3sm1873967pfe.25.2021.03.05.01.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 01:33:07 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: iommu: add bindings for sprd IOMMU
Date: Fri,  5 Mar 2021 17:32:15 +0800
Message-Id: <20210305093216.201897-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305093216.201897-1-zhang.lyra@gmail.com>
References: <20210305093216.201897-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Kevin Tang <kevin.tang@unisoc.com>,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..7003e12f55f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
@@ -0,0 +1,57 @@
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
+
+  clocks:
+    description:
+      Reference to a gate clock phandle, since access to some of IOMMUs are
+      controlled by gate clock, but this is not required.
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
+    iommu_disp: iommu@63000800 {
+      compatible = "sprd,iommu-v1";
+      reg = <0x63000800 0x80>;
+      #iommu-cells = <0>;
+    };
+
+  - |
+    iommu_jpg: iommu@62300300 {
+      compatible = "sprd,iommu-v1";
+      reg = <0x62300300 0x80>;
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
