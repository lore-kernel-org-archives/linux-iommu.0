Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6824DC433E8
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB682065E
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="aZI38iW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB682065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C97EF88D0C;
	Wed, 15 Jul 2020 07:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mgJ7TW6fHXwD; Wed, 15 Jul 2020 07:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 992BB88D11;
	Wed, 15 Jul 2020 07:07:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85296C07FF;
	Wed, 15 Jul 2020 07:07:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3BB3C0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C3B798A868
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9BuVsgNvJdJO for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 07:07:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F1B8E8AC25
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:05 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id b25so1374456ljp.6
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 00:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AN6q6cpkTRxXQWeyGXCEz+5PNSY4fUKCWqUMoq2I19U=;
 b=aZI38iW+N0p3zR3+9g94ZzT2QSUYjfLbOoKQH33KYYGZ49ABOvH3cOqHSUnLzI/Evi
 zUcxdYazJI8D/ZT1inTTCw0evilhYmHEN4B9syQCe4F3E+RVsDJFnUq9PanfLe33vDC7
 6mQiKU+ReumQ7VdYGC6R4yUmVdA4cpOnOWqwUn6cH32i4HEWXyVOBfjwWUN2k+YPvrvc
 ps2gcDe3uq84j7bnC0r2fJ8t3D2H9aJ7zRaqNTTevpifETcg19ApyEL7Gw/trUsRXT2f
 mZGiBd1RLGJHA3vk8jsOH6EnGAw2Cp90AHomKWgZ4QaDG5zTqUF31ifFxk4bNkzbG762
 hb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AN6q6cpkTRxXQWeyGXCEz+5PNSY4fUKCWqUMoq2I19U=;
 b=jMPpivkkdiew5Z4T/MbHQp6qx68frkIHVhKBSupCCA8O/WgtT9+1j9qMGVEWF0quq6
 vLiVGlMvPkSbEyx8u34DUbC2WHEWfolQbDrsbY9gESGWePISw7N/YN/YlpLhG2CiDuNz
 l0glfGvSme6F/uZvPqcw8GOmeXD0kCIFxZO8op0Areqt2ciYvmpGv5JASSuh3SN/lKYH
 kIlmxmsYQbpIPhOkXdvZeFco08xNeQYY9tOjWHd+StZuMmQuLZ8Hb1onSL4Cxj02+CDt
 L1GpSmBMQKqQAZka1QJ/C35lP6u3VXHqg3M8agzy35O+HAJ5BS5nwd0HitaeTrDwCsNE
 5jBA==
X-Gm-Message-State: AOAM530FkZzm6t+4s9u8JhGRZrix+VrRpeh4lKnGTJxAtitgdQ12sJsH
 pijAj/H3V0vOSiaWp38qMAnbPA==
X-Google-Smtp-Source: ABdhPJw8wXKSMLWdz7iN/fEgokVzEzLgEAN75R0DOvwEGBnD1GhqcFfMd0XYyzHDbz0qTTPoOhMbJg==
X-Received: by 2002:a05:651c:3d1:: with SMTP id
 f17mr3951936ljp.203.1594796824219; 
 Wed, 15 Jul 2020 00:07:04 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id 83sm276040ljj.51.2020.07.15.00.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 00:07:03 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH v4 3/4] dt-bindings: arm-smmu: add compatible string for
 Marvell Armada-AP806 SMMU-500
Date: Wed, 15 Jul 2020 09:06:48 +0200
Message-Id: <20200715070649.18733-4-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715070649.18733-1-tn@semihalf.com>
References: <20200715070649.18733-1-tn@semihalf.com>
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add specific compatible string for Marvell usage due to errata of
accessing 64bits registers of ARM SMMU, in AP806.

AP806 SoC uses the generic ARM-MMU500, and there's no specific
implementation of Marvell, this compatible is used for errata only.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index d7ceb4c34423..156b38924a00 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -38,6 +38,10 @@ properties:
               - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
           - const: arm,mmu-500
+      - description: Marvell SoCs implementing "arm,mmu-500"
+        items:
+          - const: marvell,ap806-smmu-500
+          - const: arm,mmu-500
       - items:
           - const: arm,mmu-500
           - const: arm,smmu-v2
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
