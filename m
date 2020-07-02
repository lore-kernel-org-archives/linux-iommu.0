Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE2FC433E0
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:24:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADEEB20760
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="k0iCN5ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEEB20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8386288D30;
	Thu,  2 Jul 2020 20:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yfHXyujQvLqG; Thu,  2 Jul 2020 20:24:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 11D3188D2B;
	Thu,  2 Jul 2020 20:24:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF062C0890;
	Thu,  2 Jul 2020 20:24:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A7E5C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E68EF20012
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:24:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7FUBMQPbq389 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 20:24:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 8ED5D204C2
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:24:06 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id d16so18673266edz.12
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jul 2020 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9CjV5IRbtLXef4ZCaeYQurLNNMYOTEz6UYo91B3a5us=;
 b=k0iCN5ihLSHYr/tu3lX8IHxHRFnBO0uko2hOdV4yefDcfwPQNH0zao1tLfjU7VdtDp
 yzwD13qE4V91Qdu1YysJEf4ruLqoH+zF7N2yhUcqHPuGZtHvijipXrXSor25eaBQRXxf
 4WRPpyYpOACNSVtDpQgLWzOhjBj/WJMkNzUyE8OeeG/PENbRDXcJ1tK9Gl6aMe6EjGcg
 O8BYLzwF9uBTPabqhpVVkeTZ2V7RnNpCI1ZGvgAN9J/9sxPulR8jZlF+woDcaWTtjcmv
 5sITNIpuzVE3tV1Mv3K6AyD6plDTzYeP342sKCeOSA18wsHZ0Xcaup89hlzLtP3zFw/y
 BT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9CjV5IRbtLXef4ZCaeYQurLNNMYOTEz6UYo91B3a5us=;
 b=t8UFlD/otrZVmXyyW49vdtAevafcOcSj+ssMvbttOU/C/y5sucV8MyaNFxJZJzy4TR
 p5sVhjQjRuLtk+q3LUjpSwSHa+pRv/P4a2y9BYv6cINB05lrzMhX1hv/FwRulWFMSxtN
 vt4FoJOlHDMIdqjPr5O2ldLov7d1d+H/7X84s1L8vJ0YsHmSWmHOfmalBJzBVqrVsp7T
 7kNGv/Nw2kas18+yNwrBjxIAqasWHBSqVNUBDANoAYqctUi3iSwemEveX5nXnLUoCBFp
 z1pfRU0cvxdMxLCTqtbbDOATOQWsMUZb1NHakd5vWGOEV190dmfcT38xHHUSku9biMvp
 YBHQ==
X-Gm-Message-State: AOAM531ts2ZKNQDSHjqsGKqLDeNbCD+WawWh8qAVG1coHKE+TMYDb6P+
 T5ik1ExtqUI+XGRGvUeVVdRJaIA8bJQ=
X-Google-Smtp-Source: ABdhPJxTvF+/sQ/1u1yKMPhEvQ5mwhQosMRjvbLgIX8F/hyPFunxwmUI84tWTJ/RmeamcAMTQWMgCQ==
X-Received: by 2002:a05:6512:20f:: with SMTP id
 a15mr19339346lfo.118.1593721022420; 
 Thu, 02 Jul 2020 13:17:02 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id y2sm3320372lji.8.2020.07.02.13.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 13:17:01 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH v3 3/4] dt-bindings: arm-smmu: add compatible string for
 Marvell Armada-AP806 SMMU-500
Date: Thu,  2 Jul 2020 22:16:32 +0200
Message-Id: <20200702201633.22693-4-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702201633.22693-1-tn@semihalf.com>
References: <20200702201633.22693-1-tn@semihalf.com>
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

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index d7ceb4c34423..7beca9c00b12 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -38,6 +38,11 @@ properties:
               - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
           - const: arm,mmu-500
+      - description: Marvell SoCs implementing "arm,mmu-500"
+        items:
+          - enum:
+              - marvell,ap806-smmu-500
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
