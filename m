Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49419CCA479
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 18:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D01C060FDA;
	Mon, 20 Jun 2022 18:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D01C060FDA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anholt-net.20210112.gappssmtp.com header.i=@anholt-net.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=j27uV95Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OXNSHJYNG4zb; Mon, 20 Jun 2022 18:36:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B529E6059F;
	Mon, 20 Jun 2022 18:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B529E6059F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C8DBC0032;
	Mon, 20 Jun 2022 18:36:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10E17C002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 18:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7E5D83E17
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 18:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7E5D83E17
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=anholt-net.20210112.gappssmtp.com
 header.i=@anholt-net.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=j27uV95Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNu5laQSQrOh for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 18:36:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FFD0832BF
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FFD0832BF
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 18:36:46 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id i15so10477429plr.1
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anholt-net.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dYnEPoGZqfZYJAuPegqx++UzPWjcPYHxQtwczgOEqOY=;
 b=j27uV95QDHmh28z29YzfPn3mYVjgQeD4AjLpoagSqW19OAWVkRFOHjYUOCslMxwhqS
 8lw/4ul9kFOZw8r+4NfjnLyke4Ov1rf8JPUzzFfx2oPJU1GcZHlLopjosMj5XGo3nvUu
 ep4bc9OllPhyOPJ/95NZh5DTjYq3MXOjlURHmycUaCYajuixGmRxiCia5GFA3yo3JMuk
 3WFrf8GZ2yGDYglM9CNwrlf0gkpbcAVQ/hlVXD7L0hBLUFBsrDcrbDz+wnEK/0ixHu8L
 h2pPMd3Jhe4fy/M+xWzMzstO7ugktrNpSJCtX9eZUIdySavMl3jHcZy7PJt+Mgcqu5ec
 Efgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dYnEPoGZqfZYJAuPegqx++UzPWjcPYHxQtwczgOEqOY=;
 b=PXnHf4s5ZiJZWcf4q4rxk1RyKeZtJVUfq4erxHd7eyLnBbWvqqllRK+Zo7I/cbiWvL
 +c2K+RT2WhHLxmh9kxAT51jgE797kLZouAdnr/z8Pr7kOAmOlu/lnoOvGxJsTzX3EXiu
 HWrC5xgKVZDLW7Ml1sv65FjopNXyUkZieSfbkts6AmqgBd74j81H9NOiGB+lpfWpch92
 ZCChsGXev3mVFGudvGkn1v/F4rcXJ129JWS6GwfQYboWolA2AzG8C9va2aloYuBxkHKa
 vXFX6Bo1+zwLgIhAqM61MHLL2Q6Y5OYG5RHFs/pXRgLCfme0lMn36wcknP/RQ9gxn27X
 uLlw==
X-Gm-Message-State: AJIora/tH/8WB7xZWUfcPhxgcIiAB6HgwU1FRxLostCzYoQgHLApBo0B
 Vj+FgYkBcDzn8Md52YCdIWGAUg==
X-Google-Smtp-Source: AGRyM1uz/6Ko3AqqWsTQqB/KJYqsG9FJzSMzyl3BFf9B5wef0b4KsUd6G43yzj9L9DvutkGyCDta0A==
X-Received: by 2002:a17:90b:3b8a:b0:1e2:ee1e:6340 with SMTP id
 pc10-20020a17090b3b8a00b001e2ee1e6340mr28501640pjb.38.1655750205525; 
 Mon, 20 Jun 2022 11:36:45 -0700 (PDT)
Received: from wildbow.anholt.net ([97.115.187.17])
 by smtp.gmail.com with ESMTPSA id
 ds12-20020a17090b08cc00b001e0c1044ceasm8500041pjb.43.2022.06.20.11.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 11:36:44 -0700 (PDT)
From: Emma Anholt <emma@anholt.net>
To: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/2] iommu: arm-smmu-impl: Add 8250 display compatible to
 the client list.
Date: Mon, 20 Jun 2022 11:36:32 -0700
Message-Id: <20220620183633.1131760-2-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620183633.1131760-1-emma@anholt.net>
References: <20220620183633.1131760-1-emma@anholt.net>
MIME-Version: 1.0
Cc: Emma Anholt <emma@anholt.net>, Konrad Dybcio <konrad.dybcio@somainline.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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

Required for turning on per-process page tables for the GPU.

Signed-off-by: Emma Anholt <emma@anholt.net>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d8e1ef83c01b..bb9220937068 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -233,6 +233,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mdss" },
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
+	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
 	{ }
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
