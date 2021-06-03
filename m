Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD078C47097
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D446613F1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D446613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73CC48425B;
	Thu,  3 Jun 2021 16:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G3jGSFvOp7IM; Thu,  3 Jun 2021 16:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9030A84233;
	Thu,  3 Jun 2021 16:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89A2AC000D;
	Thu,  3 Jun 2021 16:45:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8565AC0024
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5848E84236
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id epcZEMWHeu01 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 16:45:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46B7B83F0D
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:05 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id dg27so7868692edb.12
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1qAlE0u1BDdmT3kxaqiAfVPWOKqwZQKr5SI3k0RTYWA=;
 b=CAhaaFczzsR+qo5Hqs0zvKaqIcB44uJx5EPBVT/eOlIiBQO8Kxrfy9kyLfEQx2VOs7
 3galmUc2FmgWxY4s+wTVSbEWuWpE7chcjjWgW7G3usHcX9445FW8a+FI4SxKccny40G9
 q/fTNdBmQFuwoYx+jvtIZ0PiOX9ccEFghofCJ1A553lvVsVk4E/pCiBpbCdtAfC7/WoJ
 PScqrLCNOHamT8W0H4MR6uoyvJZWtOb0emaiPPYkvaFflu3e5ny9JLMn5eTYgKLpGg/z
 oxtFgJ2a8IIGrnBOadoSNgfXvSCGi40elWZeTES0IHeWvNw4kZLIqFPAvo+O7Dm5wUqx
 02fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1qAlE0u1BDdmT3kxaqiAfVPWOKqwZQKr5SI3k0RTYWA=;
 b=ccfc5E9ikFHShW116Wuk4Isc8lzgKLBOoRGosz1RXN0y3amxQktfwoXWJV0Xj2qSFv
 C/K0oepZGmhG1aA16aelbYM8hFnc3YZrt6OYx9dFQks9hiaR92f4fyBVHXtwF4oNiQfQ
 KrY6Krq0dqvaYpAicF7Ud17Q6CE8movzxg0UC4LRRUQwYm8G9okeF2ZA3EHtMsQJXwyG
 JW4/vyfKk8mQ+eGEtUkZ7fSDlwvP8o982+JOpfq4SlrbRTODuZnHnJywovL+7uB/mtPE
 h7Nic1DDCrd5MmddNraAJ4KG+VTx/zyb3JZw35/5XTB4HDfm6XU1Kumgn79AE7n4SsmP
 vNTg==
X-Gm-Message-State: AOAM532nznPGBRyTo2zO33jHqHa5CgWeDp6JvCxsUFOq8jqoLhyRmgC9
 nyvyyBnCcB5tafRIa94Z3wY=
X-Google-Smtp-Source: ABdhPJxWxKKXdiAhQmYMpJQg1u2BfcQfDwX6ekk/hR6cNHnyigeCY0LGOj7xl3o81sGLEp2hfKPUoQ==
X-Received: by 2002:a05:6402:4390:: with SMTP id
 o16mr390957edc.79.1622738703488; 
 Thu, 03 Jun 2021 09:45:03 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id zb19sm1720622ejb.120.2021.06.03.09.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 09:45:02 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 2/9] dt-bindings: arm-smmu: Add Tegra186 compatible string
Date: Thu,  3 Jun 2021 18:46:25 +0200
Message-Id: <20210603164632.1000458-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603164632.1000458-1-thierry.reding@gmail.com>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
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
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
