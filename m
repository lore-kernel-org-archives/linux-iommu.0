Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DB7C4332F
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161AC61A50
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 161AC61A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC4624029B;
	Fri,  1 Oct 2021 14:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YpWo5Kw-2psb; Fri,  1 Oct 2021 14:20:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4DE7A400D0;
	Fri,  1 Oct 2021 14:20:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9D7C000D;
	Fri,  1 Oct 2021 14:20:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ECF1C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 13:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11D8183542
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 13:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N1g-VOp2XJ2t for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 13:49:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6059A8239A
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 13:49:57 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 q127-20020a1ca785000000b0030cb71ea4d1so6812669wme.1
 for <iommu@lists.linux-foundation.org>; Fri, 01 Oct 2021 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WcobWQEpWw130naSD1qRlgqF9tLl50nKK3Jb8AKHqY0=;
 b=drKM7fR+bkOqM1CnvRn3B7zQHy2cElx4kLBMtgyBvwUjg6tbdbgQfLdHUMLDvui/UR
 mqY8QRxauUHd+LxbNpoZsMq31xzVoS97UIbs9279YQeXjPayhm8lNJJLp0vJGdFMSSXw
 DzUczyq0swBzmOE+vBWtIfkLhSSxBKEDkKjQEVk9R+Dfb3nuJ9znOJ2chsaJF2Hphgrb
 FatNVY6nkmiWeKGai4Od/Zdd4CEFDazcaWQA/ShiUxjwS1RRBQfzZ2wLp6acsX+QqnpG
 Ht3lU5hbW6GPFCbzHRvFF77PdjumyCGMUXvfy4T5sh/+2J49vBklzLF3z/v4EIM4U3Co
 XqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WcobWQEpWw130naSD1qRlgqF9tLl50nKK3Jb8AKHqY0=;
 b=eGyrxMvmTDgMGEHtf3BXnJFFE/CCBgQJ29+43Jewq3QPUdCGvzUMTWRsa8kejYXUDi
 +wxmDwwjblORIux62epTXQUELO4KmoC+kQMknfXWiIQAKTEC+a5dPiLnyvVDZ31tHiLT
 m+QQakMxsdiGYLZyV9sUkyXuKQ8uNzYPQoDUc7PGQL2BoiF6avaq5MGAuiRMZiQYVEQP
 8hGsHL+ipIVlF0kuQGwzCA7QRnfxORsnsBmw3VDzqO0nX9hcTus3XQX1yBuv2tl5YfIQ
 n5dPMKsxd6znAKKnvhEsIhEJ0AGsXqD/mUhF3nufloGX+7NBQd/PdoVlF6YcEPvPNfn+
 u2sA==
X-Gm-Message-State: AOAM532LDSATueQHHYR2Btn/MYr/iFrEXBkAuSnkmWb89VVqT4T6J55L
 deVFT5wRftXPzgwacslM6zJmsA==
X-Google-Smtp-Source: ABdhPJx5H32EiW6wymhJBhzRrbFyAIP2CyBgLVm92yZyD3woYizkxL86BsGpqCkq13ic2tRj2yYhEw==
X-Received: by 2002:a1c:457:: with SMTP id 84mr1087408wme.161.1633096195384;
 Fri, 01 Oct 2021 06:49:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:426:4b95:c465:7a47])
 by smtp.gmail.com with ESMTPSA id l11sm7471658wms.45.2021.10.01.06.49.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Oct 2021 06:49:55 -0700 (PDT)
From: Loic Poulain <loic.poulain@linaro.org>
To: will@kernel.org,
	robh+dt@kernel.org,
	joro@8bytes.org
Subject: [PATCH 2/2] dt-bindings: arm-smmu: Add qcm2290 compatible strings
Date: Fri,  1 Oct 2021 16:00:32 +0200
Message-Id: <1633096832-7762-2-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633096832-7762-1-git-send-email-loic.poulain@linaro.org>
References: <1633096832-7762-1-git-send-email-loic.poulain@linaro.org>
X-Mailman-Approved-At: Fri, 01 Oct 2021 14:20:38 +0000
Cc: devicetree@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
 iommu@lists.linux-foundation.org, shawn.guo@linaro.org, robin.murphy@arm.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add compatible strings for qcm2290 iommu to documentation.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 03f2b2d..e66f20d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -40,6 +40,7 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
+              - qcom,qcm2290-smmu-500
           - const: arm,mmu-500
       - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
         items:
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
