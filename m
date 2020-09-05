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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FCBC2D0A7
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:05:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB6F2074D
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pns3oHCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB6F2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0752B21505;
	Sat,  5 Sep 2020 20:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nflqO+FbLHMX; Sat,  5 Sep 2020 20:05:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CC3F1203F7;
	Sat,  5 Sep 2020 20:05:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2E31C07FF;
	Sat,  5 Sep 2020 20:05:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D77FC0051
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 198F78626D
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QhKopNcwPrDc for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 20:05:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9618685F8B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:05:16 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id c142so6478923pfb.7
 for <iommu@lists.linux-foundation.org>; Sat, 05 Sep 2020 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lMN6Aad98rZkq5O2asxI/gYil5amAFJMEDxEz6HXvq8=;
 b=Pns3oHCbWFzzejByOVGuRtp6qKL3sl4mj7AykBUBeMIX6DG8SR1IsoN6Ja6JU7Mmo7
 89KRmzbpwRMJZgVFooJIgnPncIpgSt+0EQvYxbEtZvr/exYq5DPPfS7S+ncnjbEhencR
 RH5YuTk5AGbsVWb0tGdT7dOwa0QwL6iFKmCTJEejA59iNmhNep/3QwIBxY7vvSa5bfZl
 928en8I2HTpfpoKWubThI/PwTsU8ldfmeANtINBPqLG2F2UTWsghPvDW3iuMWy0jWS7r
 KftJtF16JX0Ubuj9I3CFNVPkiwX+Irnt9JioDg924zLZRFRuzWi8RIzaliNNfS10b6oh
 2IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lMN6Aad98rZkq5O2asxI/gYil5amAFJMEDxEz6HXvq8=;
 b=mXXHtUwHVuDBcix+XNamTNqpSZWuuwHclUJ5RXe248jLfePTd8FFRTL+fyd4NjRZgf
 jtY2H65KVOj7oXXsum73ojSdNWr5LpQg8nG44E7LNL27MMpzp2FwpgFMP6PQIsTgoi0x
 nhxlfv9ymMXxx7XawqqQu/By0xYmpWkQPRUeMtv0MO1XB8PcjkTOs4MUb5vGxhctRHIF
 rzeoo56GAOswVHMRPEeu1lsyGh5NbTvEnwV3a3/fER3iwbwNdkgc7yETDEJkNt/p1QeL
 /DFKdVWflKRsMyLgNyw4AvCYESxIg7VQgHCZjOywhUb46W52ZXDY0RwXnEU+oFJdCFe+
 iz5Q==
X-Gm-Message-State: AOAM5330nYEAFORPGXJevuXCpLqCpFhlafHfIGJbKUAkHV2g+RTpqWov
 iTLBDI9lXhgQW6AY8941TKmoVFXGy3rNhDQ/cns=
X-Google-Smtp-Source: ABdhPJxtD01crAlFjZ6W6bU8A0+Jv4zKtX9LztW24Q4Cb6srFiKHgkdX/x8tPcvikAdykSvAmRGnSg==
X-Received: by 2002:a63:fa10:: with SMTP id y16mr5293364pgh.304.1599336314974; 
 Sat, 05 Sep 2020 13:05:14 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 e18sm8722752pgr.53.2020.09.05.13.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 13:05:13 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v17 20/20] arm: dts: qcom: sc7180: Set the compatible string
 for the GPU SMMU
Date: Sat,  5 Sep 2020 13:04:26 -0700
Message-Id: <20200905200454.240929-21-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905200454.240929-1-robdclark@gmail.com>
References: <20200905200454.240929-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
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

From: Rob Clark <robdclark@chromium.org>

Set the qcom,adreno-smmu compatible string for the GPU SMMU to enable
split pagetables and per-instance pagetables for drm/msm.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index d46b3833e52f..f3bef1cad889 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1937,7 +1937,7 @@ opp-180000000 {
 		};
 
 		adreno_smmu: iommu@5040000 {
-			compatible = "qcom,sc7180-smmu-v2", "qcom,smmu-v2";
+			compatible = "qcom,sc7180-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
 			reg = <0 0x05040000 0 0x10000>;
 			#iommu-cells = <1>;
 			#global-interrupts = <2>;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
