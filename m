Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463EEC433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 08:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 097F660D73;
	Fri, 29 Apr 2022 08:23:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1z460vxykanS; Fri, 29 Apr 2022 08:22:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CCA4C60EE4;
	Fri, 29 Apr 2022 08:22:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A42C4C0039;
	Fri, 29 Apr 2022 08:22:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1114C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEC9B8291A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iWQep4TH0yQX for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 08:22:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E07483300
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:55 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id t25so12721507lfg.7
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oMI7QqZGI0vddFgsm9lt9vX32EVJjnSzVDzCY5m9AWw=;
 b=A+MZEIPz8f8ZVktBwhejBMEn6pzxhtXTC4xQVz8q12o9QJLmNmtexynvWUrVfIa+Ae
 6maTnwa27kI+xhAXIBGtAXjVHK7OGM1kx3PkAyO1LHyQpy7V4Zbr4LBWK2DnNg5xfU31
 o/YCThPeqJSDMynOYaIVENS+YcOQV9KrhfGlA2t/h0nwecrVjINLXEHjSqLLDCi3YgGi
 dHNbsLaDuEnWQYS3Hjn99lwnOfDdmAXQQo88TH0DPRgx1FPIO/rhzW9EnivfjyxWeWTe
 uEfb1tML0BB76+flF+4+aDM9lTjTNlwoTuDlfW5skzC2KfUcYHWvHsrF7HsOUW99vdOq
 qkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oMI7QqZGI0vddFgsm9lt9vX32EVJjnSzVDzCY5m9AWw=;
 b=ANKatSeEbdFH8VkxQBNrny3lVJStIDzbv39tZtzFd/B/aAkGg+Hy8jmtGWsYf/Q9IA
 kpdK4sOXUixD2JNxkUq19jTq1pT25xZrMw1Oy2O4LiS7AbpBHmRImBs9J/1DrsZ2PqUn
 v8cEhkgBcaEheaOzpIeaGfub2J93ZdWFxmMOhNJaPDldkRJGDi7jUrvDgsdYBTYZLDMC
 wx2lZVZkEJyIK493ZkZ7OUlB/yD7yApfRS2niOVSgv1mNtsJ1HCNigHF4zaIDC3UEeKI
 Y+T2shBMD3WlsTxNqoT9twajVyP1/2aMV+jegjpg5MZfD2mgKhSwPXeQfMrirfINvHOt
 MUOg==
X-Gm-Message-State: AOAM5328FaR1rRInfgmHQ9K/UOc3RWc/hP2hyQC4KyFmMktojfAgf37r
 iLgB8Low1LUU6nW6LH3321M=
X-Google-Smtp-Source: ABdhPJznRjWCO7GO08thPSho9osAYFp9jDBFLMKt6fOX5IuiDEYe27Bgr+pjGNRAHJ3ZKvw5r/QthA==
X-Received: by 2002:a05:6512:3d1c:b0:472:3444:df98 with SMTP id
 d28-20020a0565123d1c00b004723444df98mr6310755lfv.366.1651220573131; 
 Fri, 29 Apr 2022 01:22:53 -0700 (PDT)
Received: from localhost ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 t19-20020a19dc13000000b0044b022fd9f1sm179229lfg.160.2022.04.29.01.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 01:22:52 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 2/3] dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
Date: Fri, 29 Apr 2022 10:22:42 +0200
Message-Id: <20220429082243.496000-3-thierry.reding@gmail.com>
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

The NVIDIA Tegra234 SoC comes with one single-instance ARM SMMU used by
isochronous memory clients and two dual-instance ARM SMMUs used by non-
isochronous memory clients.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 44606ad5aa39..590cc8dc8323 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -62,8 +62,9 @@ properties:
           for improved performance.
         items:
           - enum:
-              - nvidia,tegra194-smmu
               - nvidia,tegra186-smmu
+              - nvidia,tegra194-smmu
+              - nvidia,tegra234-smmu
           - const: nvidia,smmu-500
       - items:
           - const: arm,mmu-500
@@ -183,8 +184,9 @@ allOf:
         compatible:
           contains:
             enum:
-              - nvidia,tegra194-smmu
               - nvidia,tegra186-smmu
+              - nvidia,tegra194-smmu
+              - nvidia,tegra234-smmu
     then:
       properties:
         reg:
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
