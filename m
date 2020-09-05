Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32225C2BBD0
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:05:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1FA20DD4
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcwVx61P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1FA20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3ACB85F81;
	Sat,  5 Sep 2020 20:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9xNrph8dHQcK; Sat,  5 Sep 2020 20:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4573885F75;
	Sat,  5 Sep 2020 20:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FD62C07FF;
	Sat,  5 Sep 2020 20:05:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5646C0051
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A4E41875F0
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xh2PdwWtBTJR for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 20:05:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 36FD087595
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:05:11 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id m15so1567495pls.8
 for <iommu@lists.linux-foundation.org>; Sat, 05 Sep 2020 13:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RI73hAm8taFHglKyL+fRjHiZ9E+te2SePrFdWbpImkA=;
 b=vcwVx61Pt9UhOQmiYEavtCbKoTKImHwiu+5jNHRaBSnjLI1sdwRkCWJV7Ec4krDahz
 lc+nmsDR6BxsvxOcXYoa1f00LwwOFO8ueOqgYAWv9LYJ6smg5RbifVEIzOgln8l3P/l1
 kxjB3AO/QbVXPZ4QDZ/L9rWZYPKkOqi94fVEADu5b5L08A3T75RNv0g8OHkw6+OVZXQn
 FZYfZfboXk3lS0zsdJbCw4Bb/18UXsxjbCWTj5LgU6LVp65iJ8gZvtPHviCUsWPFJstF
 dLaCPjABpEIDLYyxFhuGouemYzSkTEMaicAUMUcUcFsAakPRpDHPxT1f20D+zjUnlnNP
 jLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RI73hAm8taFHglKyL+fRjHiZ9E+te2SePrFdWbpImkA=;
 b=JbOb2Y/+fQlChfAHFRexJWdpxhxsPGNzn/ulaFVmA4LzzfxQJ6dV7reivhBaHjWExS
 gK5UoAwRrR8OWL+XOwlwM3KJ0bcPFt9RlGw8xs44BnvnkrVRIYklekdeB54WZOxI7Hj0
 IrOHllIO8KV7fkwZmKI0FKflvx4ZO3u5KiceASQ4twFD2I29428CKLxovcT5WAFpEs/c
 WLU4zRxpSOeEwcUV2bsdhWF4NEgt4OEA6dxV41OWTUHezRmxffFnozi6BCSIydhpd1LH
 +QN4487kfuCl53ud+Vps315TfoS3uCJ1Q3eh0mij44NL4XSBbJdibJ2rnooFB8+5f2RE
 okSg==
X-Gm-Message-State: AOAM533j8J2jYjB7MFbBIitH7dSuoP1fuv0IUZMpRE824zNpREAbNI2W
 Bp+mQM7btEdO8vZh7GC2lGjT6Z7s2htdwoOHoRQ=
X-Google-Smtp-Source: ABdhPJzMiqoqztwMnULjxDUjTNS0z8BEMDOuI3DDlzgg2GpvsRIBIOXD8OIwXo/hNDfPqheUam39uw==
X-Received: by 2002:a17:902:b092:b029:d0:89f1:9e2c with SMTP id
 p18-20020a170902b092b02900d089f19e2cmr12189283plr.8.1599336310134; 
 Sat, 05 Sep 2020 13:05:10 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 x3sm10486542pfo.95.2020.09.05.13.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 13:05:08 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v17 18/20] dt-bindings: arm-smmu: Add compatible string for
 Adreno GPU SMMU
Date: Sat,  5 Sep 2020 13:04:24 -0700
Message-Id: <20200905200454.240929-19-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905200454.240929-1-robdclark@gmail.com>
References: <20200905200454.240929-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Rob Herring <robh@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, freedreno@lists.freedesktop.org,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

From: Jordan Crouse <jcrouse@codeaurora.org>

Every Qcom Adreno GPU has an embedded SMMU for its own use. These
devices depend on unique features such as split pagetables,
different stall/halt requirements and other settings. Identify them
with a compatible string so that they can be identified in the
arm-smmu implementation specific code.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 503160a7b9a0..3b63f2ae24db 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -28,8 +28,6 @@ properties:
           - enum:
               - qcom,msm8996-smmu-v2
               - qcom,msm8998-smmu-v2
-              - qcom,sc7180-smmu-v2
-              - qcom,sdm845-smmu-v2
           - const: qcom,smmu-v2
 
       - description: Qcom SoCs implementing "arm,mmu-500"
@@ -40,6 +38,13 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
           - const: arm,mmu-500
+      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
+        items:
+          - enum:
+              - qcom,sc7180-smmu-v2
+              - qcom,sdm845-smmu-v2
+          - const: qcom,adreno-smmu
+          - const: qcom,smmu-v2
       - description: Marvell SoCs implementing "arm,mmu-500"
         items:
           - const: marvell,ap806-smmu-500
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
