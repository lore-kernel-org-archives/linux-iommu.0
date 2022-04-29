Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14130C433FE
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 08:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE55E83F32;
	Fri, 29 Apr 2022 08:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K74GJEg7620w; Fri, 29 Apr 2022 08:22:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 94E858291A;
	Fri, 29 Apr 2022 08:22:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C55BC0039;
	Fri, 29 Apr 2022 08:22:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B503AC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91F4740A9C
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k53BL2sZ65UR for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 08:22:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DCCD4091A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:52 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id bn33so9633562ljb.6
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BqXPunmGph8XZto24fUj0G8vrN134xfSDWAMlJF8WBA=;
 b=fucmz1GgWONzX38ItL0J0SdsV2RbDADjwMXY00Ep8ru2rz9kJYrICku40mpA+OhHkN
 Tt11jjM6p6pRkj68T/yBFKeQMEwpcIIE+k/Rl8DQcP8PLkG+lU6MgkdtomQaZP9TFndG
 ea1mFyzDGYy8Z0ZxcIn5nGhY6MqSz6ZT8rHHChdlsR4c4fGvZa9k2F4UMsxSF3pCbi/u
 2Ng4dB6T0PTVwsRb/SSi+2MPjpt8XNAG8gX1DFZwQl0ZNuFhJ+GalaFGQw5L0dHAXUZy
 Pf5aEyoanA40m2laUFNC6upPjs8h+wJdnkMSk7IJoOH+zr2nvhSiyw57MDN5C6mKULKE
 GP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BqXPunmGph8XZto24fUj0G8vrN134xfSDWAMlJF8WBA=;
 b=scfxsVMA5oo0LZGg+K25HtLj+GD+HcEf9pFTRLWZN9K0ZxMnrIc5NrF8MKSAAG8yIG
 KCqIvfY0mgvA9gU5p7zfJKLVaB1rgE9dx9OZnQe/lnLbTVgdHIe3/bV+IrTQ4iLv73PT
 Ju7kMmSC1/KzbByFKBDjRHpHZlEaHgO8JuSxpqKAr5J+IZ39W+phyu7Yw/0dnRwPNVgw
 zp2ikt3D7L0c1Shb6h2R3IdCoFes60wxioUl0BoI/yXI96Cx9E/NcFQLjzHPf2L8kpHM
 80n9Mg/tbueaoYiINNzUCYdmo0vok6GKIzY93Qar3x9TE7/YjAU7pLzr7eeVMmgAur9U
 ndYQ==
X-Gm-Message-State: AOAM533acUsXFoknYodDScmf06czTNk9VQlyDYsIMH4h5N4p2piwKOFg
 GwopQizEPU4+dh/hnI7Tgms=
X-Google-Smtp-Source: ABdhPJxjBeKz+bjnoFzef0XBxYP3wxVL83OPI0s4GLwL1Z/ru492IPCB0tHy6nvnA/phj8VTYPSAZg==
X-Received: by 2002:a2e:82c5:0:b0:247:e81f:8b02 with SMTP id
 n5-20020a2e82c5000000b00247e81f8b02mr24196768ljh.90.1651220570942; 
 Fri, 29 Apr 2022 01:22:50 -0700 (PDT)
Received: from localhost ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 q3-20020a2e8743000000b0024f3d1daee6sm209010ljj.110.2022.04.29.01.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 01:22:50 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 1/3] dt-bindings: arm-smmu: Document nvidia,
 memory-controller property
Date: Fri, 29 Apr 2022 10:22:41 +0200
Message-Id: <20220429082243.496000-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429082243.496000-1-thierry.reding@gmail.com>
References: <20220429082243.496000-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On NVIDIA SoC's the ARM SMMU needs to interact with the memory
controller in order to map memory clients to the corresponding stream
IDs. Document how the nvidia,memory-controller property can be used to
achieve this.

Note that this is a backwards-incompatible change that is, however,
necessary to ensure correctness. Without the new property, most of the
devices would still work but it is not guaranteed that all will.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- clarify why the new nvidia,memory-controller property is required

 .../devicetree/bindings/iommu/arm,smmu.yaml     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index da5381c8ee11..44606ad5aa39 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -157,6 +157,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  nvidia,memory-controller:
+    description: |
+      A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
+      The memory controller needs to be programmed with a mapping of memory
+      client IDs to ARM SMMU stream IDs.
+
+      If this property is absent, the mapping programmed by early firmware
+      will be used and it is not guaranteed that IOMMU translations will be
+      enabled for any given device.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
   - reg
@@ -179,6 +190,12 @@ allOf:
         reg:
           minItems: 1
           maxItems: 2
+
+      # The reference to the memory controller is required to ensure that the
+      # memory client to stream ID mapping can be done synchronously with the
+      # IOMMU attachment.
+      required:
+        - nvidia,memory-controller
     else:
       properties:
         reg:
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
