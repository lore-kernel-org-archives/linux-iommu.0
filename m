Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2724FC433E3
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:03:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BD3207D3
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL8fnDvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BD3207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 99D0A878BB;
	Mon, 17 Aug 2020 22:03:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CUnix55q3-mH; Mon, 17 Aug 2020 22:03:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B863C87917;
	Mon, 17 Aug 2020 22:03:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5A46C088B;
	Mon, 17 Aug 2020 22:03:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94A47C088B
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7C9EA86B7B
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:03:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AleOw2EYFgmJ for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 22:03:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EDB2586B50
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:03:29 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id f5so8220033plr.9
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/RMbEO1wS6ve28JkP/1VJiMbFcTiFM9NBrI4zgQscQM=;
 b=ZL8fnDvw2JO35q5KslLETY9tBaGJ6NBbXqEA7vYHRSLYx4P/opOuvZH6Mnw0NP08bX
 jPvTBwPIAKH37k3g7Jk9u+swo58YqYz/aTtg2qzWBIQjlE6Fz0nWrJY1Wi62AIZ/XAL8
 zTxxQ80xVY123z92lHmO3OtQdR7PSR1OQH/2EA0pKUfmIGOKDseiT7j1cYQ1f8KLr54W
 fzAWM+IXCZnD0oxyv6NO8WxdmW4/BW5sOKEYN+WiTR+vb9FME4m2K4+CI3flRms6Txvx
 p4YWE7fWjSidNKQe/De9YjSdtotAtG49tOwbIXVLbZb9eTY9k54o8InXzXnQUVIeMja3
 GtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/RMbEO1wS6ve28JkP/1VJiMbFcTiFM9NBrI4zgQscQM=;
 b=s7do70c81H6EMlHYxIfuE59fmJ2SjO1CTqjMVepEN1sVk/7GRb6k15lOXaeNtakQXw
 f8UcmjP2JZ1Iatlhi7lPMQiFoyYa9iRAu9/yB778nFZFAYYCRECY33R4y0gojjZqHqoZ
 4h4aCq76+U/WpQFDsA1Wd4Ev48vhwY4DZMwin949rUpbiqF4Yolt8K7SefjU29itTDlt
 nunT2xIj5q3E4PrV19cl88fBBtjVbrK8nP5euTCq5a2UiTTszqC+ATi0riY5KcFJ5I+X
 9tMTI1B8MLtA8cg1rgNLbjlGYLZHGsjvrxa506DNq7pKnu0AqUqNiOy9FwZgAnJLorn9
 4c2w==
X-Gm-Message-State: AOAM533YHwXUFleCudEwUkSbidlY996AI7cY8ZE2G/mXKtu4du3C93Mk
 cKt9JgrEESNEnLpmuLA0kRM=
X-Google-Smtp-Source: ABdhPJzcpHZhmDBtp9AUC/rTQdXs//5Wga3CPsk+w6f9oGQlu4dMZIhJfEHvZb6UuQImgc1is5O1JQ==
X-Received: by 2002:a17:902:8546:: with SMTP id
 d6mr12962504plo.218.1597701809511; 
 Mon, 17 Aug 2020 15:03:29 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 f6sm20966585pfa.23.2020.08.17.15.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 15:03:28 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 17/20] arm: dts: qcom: sm845: Set the compatible string for
 the GPU SMMU
Date: Mon, 17 Aug 2020 15:01:42 -0700
Message-Id: <20200817220238.603465-18-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817220238.603465-1-robdclark@gmail.com>
References: <20200817220238.603465-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 freedreno@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>
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

Set the qcom,adreno-smmu compatible string for the GPU SMMU to enable
split pagetables and per-instance pagetables for drm/msm.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2884577dcb77..6a9adaa401a9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4058,7 +4058,7 @@ opp-257000000 {
 		};
 
 		adreno_smmu: iommu@5040000 {
-			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+			compatible = "qcom,adreno-smmu", "qcom,smmu-v2";
 			reg = <0 0x5040000 0 0x10000>;
 			#iommu-cells = <1>;
 			#global-interrupts = <2>;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
