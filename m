Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE0CC433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585D5613C2
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585D5613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36152405AF;
	Tue, 20 Apr 2021 17:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qoBY28X7E4hW; Tue, 20 Apr 2021 17:25:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC53E405CC;
	Tue, 20 Apr 2021 17:25:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFB65C000E;
	Tue, 20 Apr 2021 17:25:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA141C0021
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC72683C27
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o0o_BKDnT9Rt for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F3CF83C23
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:42 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id z5so9545002edr.11
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rplQXUmZ3dZaacFdD2/srDfpf5ly21wkPzV828fQxU0=;
 b=WGtiLxPL+ZMD/2cJcTdb6TNrVJ7kpsc/TKm+6Yn5hLZagZgNELwTGSFe2OB7JgOH2f
 lNFTEJF96qxnqFGwExDRuH2mi/nSk6rgnz34yO89rQixQ3DB95+l3FnxHk3Y2aqBiP1I
 yKo06USh0xCCuc6A4bqB/4uiJkqjVFzfUxmFW0+BqYgCqCpJrGsZR3vAhn0qGWuT6Kuu
 GrEFILmMbP8utFC6ypWzvQGNR+HYUYlNtEU99G839CR1KPROi7S/H47eyKoSdKIB1t/a
 ZEkUHGVMSYj21ReVIMjvZS9nCUqfb58gXoaVqwDudmAgBnUvAu7VjVhAjSzwSDVTj9QP
 wHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rplQXUmZ3dZaacFdD2/srDfpf5ly21wkPzV828fQxU0=;
 b=CF7XloecVidbP6L3CFvZeRNPtaQz8M5l/b0wtB4WILwN1TMXeH49bgR9k/kp18PNxD
 9xohdHRzrhK857IZdc170ooXk3TW7VXisLSPsKyNurTJ4xcOa0NdtdqKaSIB32sgRd55
 Zh9xw1vuCTVysgIrU0at9XxmZk65V71kfF6xzX517HnT68TufFnwNLfdrmrsnJqgkI1Y
 Q33W19jgLF3/0uJBZ40uhYc5pfMZKJsEmtZ1vyIaKTexaRbMR7GLxC6v4yGFe0OiQKOy
 sVpqDzIdAjKLj6xq3ll4OE8dlZ+D6BlI67aVKOT1uQ7nHTDyFDJGsBuPaYw8qHv3RK10
 1m1g==
X-Gm-Message-State: AOAM533JjIaGJN1MKr5xndGDjaX9bKAAqycj3OMFCEul06jm9hfXdmcC
 5vZ/5IP7kBacPvrUzJcCc90=
X-Google-Smtp-Source: ABdhPJy2hEVDGdB7GOaFHXjCKKKVhYmH5kmX29KofoItNeRF5QX6huP1VBvPg6OO52HQJ3zXXgYoeA==
X-Received: by 2002:a05:6402:27ce:: with SMTP id
 c14mr33381218ede.263.1618939540856; 
 Tue, 20 Apr 2021 10:25:40 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id m14sm7179088edr.45.2021.04.20.10.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:39 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 02/10] dt-bindings: arm-smmu: Add Tegra186 compatible string
Date: Tue, 20 Apr 2021 19:26:11 +0200
Message-Id: <20210420172619.3782831-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

The ARM SMMU instantiations found on Tegra186 and later need inter-
operation with the memory controller in order to correctly program
stream ID overrides.

Furthermore, on Tegra194 multiple instances of the SMMU can gang up
to achieve higher throughput. In order to do this, they have to be
programmed identically so that the memory controller can interleave
memory accesses between them.

Add the Tegra186 compatible string to make sure the interoperation
with the memory controller can be enabled on that SoC generation.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9d27aa5111d4..1181b590db71 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -54,8 +54,14 @@ properties:
           - const: arm,mmu-500
       - description: NVIDIA SoCs that program two ARM MMU-500s identically
         items:
+      - description: NVIDIA SoCs that require memory controller interaction
+          and may program multiple ARM MMU-500s identically with the memory
+          controller interleaving translations between multiple instances
+          for improved performance.
+        items:
           - enum:
-              - nvidia,tegra194-smmu
+              - const: nvidia,tegra194-smmu
+              - const: nvidia,tegra186-smmu
           - const: nvidia,smmu-500
       - items:
           - const: arm,mmu-500
@@ -165,10 +171,11 @@ allOf:
           contains:
             enum:
               - nvidia,tegra194-smmu
+              - nvidia,tegra186-smmu
     then:
       properties:
         reg:
-          minItems: 2
+          minItems: 1
           maxItems: 2
     else:
       properties:
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
