Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70905C28E83
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310C72067C
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK/gWhvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310C72067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EB4A420495;
	Tue,  1 Sep 2020 16:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tpUQLwcQWDyZ; Tue,  1 Sep 2020 16:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 57AD62040E;
	Tue,  1 Sep 2020 16:47:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43F69C0052;
	Tue,  1 Sep 2020 16:47:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22DC4C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1B03D2040E
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i6X6bB8-mTXs for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 16:47:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 2C2A42152E
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:38 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id o68so1127402pfg.2
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RI73hAm8taFHglKyL+fRjHiZ9E+te2SePrFdWbpImkA=;
 b=iK/gWhvX43nTVceqadIhYvSqK91IRCJCr5an4KZFK1DTvINxVcTZMuQyegyN/355Bw
 JZQ7Y2NxnEyNgHakr4ZD9u87n6KRWb0TKstSl2SZ3PzPV7YLJVSPcDu6euUaGOQkNRud
 h/4COkh5TdixQZkT8bM/oxcl04nzVQ3WdlDCo9PGw+fVjnSiUbbujl8LFIUnDWnDJ2Xd
 Kxrsomm8Prr7eCxcP7aZHzasUFTLyJ4ODxcdLAuEMq9dv/FyYghppWV3sNUAyRmMhpzB
 UUeqqU/WJ87+Ydrrx0WdNSh8807h1sbE0add+3495kD6sIYWodJy28OaQcodE2eH8PRw
 XMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RI73hAm8taFHglKyL+fRjHiZ9E+te2SePrFdWbpImkA=;
 b=Gcd1D/nWtiMrDrWTnf8umcpN426EIzfOVyxPCUBCf737lE98QroLQcXS3NYFC2PL4F
 kBEVSSu2C0DKC6mzg646bqNnRpns3QR5xblo0MLxjPM0EdhJSXyM//XvrqxHC5NFLxcU
 OTdVztXMonCYWUUmFEgUFuXgxFDpFNpUs5fCfqYQwBOAdwPqtP2FK1Kj/WBkorgQQTCm
 +KfV4HS65RP8gKy6we/RBNGE6/ebESzBQamjBdqg7yH85GK9c/UGHdR9RdvDbSfbXKaN
 /AzVUoRXLXp6HOLVVqw49L0lWcpdURSvsmMu/mSzQ1EguPV2qBkD4kQlButo74JuDoO/
 A5Jw==
X-Gm-Message-State: AOAM5324aUhBnsbOEhQLotO/YmF3MuHwodqrjAIU0JDQPMaLCH4m2HxT
 wJ3FrWzLX7IFc5tkuj4XhBU=
X-Google-Smtp-Source: ABdhPJxqESFlReg5RGOlUO1KFXl0W8xH0asJAzoRAGy9j2bDD2ncGLx0thhLxLusFeJPcxyqh3MDbA==
X-Received: by 2002:a63:6d4c:: with SMTP id i73mr2312150pgc.63.1598978857690; 
 Tue, 01 Sep 2020 09:47:37 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id i1sm2497656pfo.212.2020.09.01.09.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:47:36 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v16 18/20] dt-bindings: arm-smmu: Add compatible string for
 Adreno GPU SMMU
Date: Tue,  1 Sep 2020 09:46:35 -0700
Message-Id: <20200901164707.2645413-19-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901164707.2645413-1-robdclark@gmail.com>
References: <20200901164707.2645413-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
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
