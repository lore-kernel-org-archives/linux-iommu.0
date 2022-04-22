Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5919C433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 19:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8292A8416E;
	Fri, 22 Apr 2022 19:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rXksUv__F7A7; Fri, 22 Apr 2022 19:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 877CE840B6;
	Fri, 22 Apr 2022 19:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FCDDC0032;
	Fri, 22 Apr 2022 19:21:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0F5EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 19:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEF0D840CC
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 19:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zEmylFtWbAZM for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 19:21:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48D3A840B6
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 19:21:19 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-e68392d626so4539142fac.4
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 12:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0gc9s0Nu7Dy/f5W0uxa+JhgkFQnmycRULJWoNHmae7s=;
 b=Cb+qEp9ovKBP9EsaCaJmv91y1g/E89rv4klY1MosKC04OPuyUtPU30N6gN5i15tInO
 K4Wf608CxqjeA0fi7nwCLFW4G2cBNfejap3caWxEYyiW5FpnCfgetJx0rdeoAicuD42a
 bTlYQQnBO5Tv996B28vMrIwvmaKBno5yy4VtC98AUpL358Bh1Q9kPVIwdrhsIqscVOEo
 k9cysAQwhI+O4UX1xkvdaL9ZHY2akPJklaEpURKJGs0zyL7+H/Vsq+VN6+oTzjJDSQaB
 80XxTnMiBlVoIZLlSQ7KfCXuoj06jnQ1D+krxP+LSjnk3mlF8/4CuAD8XkUUb4DaB31q
 AgMA==
X-Gm-Message-State: AOAM531gcLdy3vIk+qQgsG1VI4AOMVxw2LFwJTl1uZFEFYlH9/rp3BRh
 iV3mCoIQov7tg5bGI420lA==
X-Google-Smtp-Source: ABdhPJy1+14fIkK9Z0u5jvsEPpFvTFjZbVR5xwcjkuW3Qq+dGls5tB9qudMev6OqfOIz/ed6iA+g2g==
X-Received: by 2002:a05:6870:6196:b0:e1:e1a2:5c65 with SMTP id
 a22-20020a056870619600b000e1e1a25c65mr2782990oah.190.1650655278243; 
 Fri, 22 Apr 2022 12:21:18 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
 by smtp.googlemail.com with ESMTPSA id
 bd32-20020a056870d7a000b000d43d4d2de1sm937317oab.5.2022.04.22.12.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Apr 2022 12:21:17 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] dt-bindings: iommu: Drop client node in examples
Date: Fri, 22 Apr 2022 14:21:03 -0500
Message-Id: <20220422192104.2591462-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
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

There's no need to show consumer side in provider examples. The ones
used here are undocumented or undocumented in schemas which results in
warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.yaml      | 10 ----------
 .../devicetree/bindings/iommu/samsung,sysmmu.yaml      | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 97e8c471a5e8..e0389539194f 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -173,13 +173,3 @@ examples:
                              <&larb3>, <&larb4>, <&larb5>;
             #iommu-cells = <1>;
     };
-
-  - |
-    #include <dt-bindings/memory/mt8173-larb-port.h>
-
-    /* Example for a client device */
-    display {
-           compatible = "mediatek,mt8173-disp";
-           iommus = <&iommu M4U_PORT_DISP_OVL0>,
-                    <&iommu M4U_PORT_DISP_RDMA0>;
-     };
diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
index 783c6b37c9f0..672a0beea600 100644
--- a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
@@ -86,16 +86,6 @@ examples:
   - |
     #include <dt-bindings/clock/exynos5250.h>
 
-    gsc_0: scaler@13e00000 {
-      compatible = "samsung,exynos5-gsc";
-      reg = <0x13e00000 0x1000>;
-      interrupts = <0 85 0>;
-      power-domains = <&pd_gsc>;
-      clocks = <&clock CLK_GSCL0>;
-      clock-names = "gscl";
-      iommus = <&sysmmu_gsc0>;
-    };
-
     sysmmu_gsc0: iommu@13e80000 {
       compatible = "samsung,exynos-sysmmu";
       reg = <0x13E80000 0x1000>;
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
