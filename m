Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7350C433E6
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 14:18:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4755E23331
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 14:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4755E23331
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 00E8285BFB;
	Wed, 23 Dec 2020 14:18:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpNuN2yhIxl5; Wed, 23 Dec 2020 14:17:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E47D85BD0;
	Wed, 23 Dec 2020 14:17:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45B0FC1787;
	Wed, 23 Dec 2020 14:17:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0623CC0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 11:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EE5E085D4B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 11:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CFgXjW_n9LPZ for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 11:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DA6D885A78
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 11:16:47 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id c22so10404881pgg.13
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 03:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i8cSGTFdV6NDouRQh8ewWda9XJF0YqAiRaVhtmmVYqs=;
 b=FdVyJfiMZLgccBvmk28x2IxrfNCBbrDkEui8a2XFvqwT8XMQnbnq2eUij1zz6Z9FZ/
 Ac6DIc9SYTKcn7Fkf5L8DNH6xKPaahH8DctB5c6O/X8H3PZg3CsjLLsgeVhPqJW1AT8e
 QHtnlOxWWeCU7VeRwRE59prGitlRMHyQazqW19YCf1stXTjhu4+pQ2gVrKphwbUyZERH
 3zVAECN9nAcRlbrK0WEJ7eX+5JjUOkhMVqQ36KFKiATHTxPailU9agD0m2Mz5DDqMQsy
 PIswlgqE3Edb+PDN6kXRqfH6z1P5lutf+WC+15NxoBfyeRUu53lVu5sfBH5M7hEv+Xav
 1f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i8cSGTFdV6NDouRQh8ewWda9XJF0YqAiRaVhtmmVYqs=;
 b=Y170SUl2jG+UWaYcLBCYIoxYuXiG1/QxEaG7dtYEawAuSg9AY8V9H8i/TnQNGnIlAm
 huH7xGzu+k5+mLS6W1vfcBZVCvFDTnHTMDY+sq+UIVs10NY4DM2e/ObdJ/z2LUmk1Bwa
 BXtTx0vvCCTfVo0/yXE1uY/K8w4dEqX5Z/tKcmX0FiIgDYj2aW+oksmPvAOiIc388Xty
 hANzaJ1ZPSFBdqOCy4a9afyLzMVSlwNvOA4bQDVJqIrPBv/KllkHgb3QKoVcjw3Kcc1u
 A4tbLb9p837RsOF14l+lQI1SNhr9iGUxzBlCDDsOk5JPYbsKj668uNiPtbowOe1krhH/
 RzCg==
X-Gm-Message-State: AOAM531bm9/4TTw/2DnjpaUOhx2kZSw8ViLoB3S4UfZcfOqGJ1wag2Ir
 ixCSuwXB6l84pgx4rxpDdOA=
X-Google-Smtp-Source: ABdhPJz8Q7qY4aMwzKG1OtlSYN46oJ8PbdL1vUkKfcU+6WDsOFNd/Q3biq6nIjtENA6Lt5NzGH6rSg==
X-Received: by 2002:a63:65c5:: with SMTP id
 z188mr23820319pgb.332.1608722207535; 
 Wed, 23 Dec 2020 03:16:47 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id ga12sm21771023pjb.48.2020.12.23.03.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 03:16:46 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
Date: Wed, 23 Dec 2020 19:16:32 +0800
Message-Id: <20201223111633.1711477-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 23 Dec 2020 14:17:58 +0000
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Kevin Tang <kevin.tang@unisoc.com>,
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

This patch only adds bindings to support display iommu, support for others
would be added once finished tests with those devices, such as Image
codec(jpeg) processor, a few signal processors, including VSP(video),
GSP(graphic), ISP(image), and camera CPP, etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..4d9a578a7cc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
@@ -0,0 +1,44 @@
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
+      - sprd,iommu-disp
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
+      compatible = "sprd,iommu-disp";
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
