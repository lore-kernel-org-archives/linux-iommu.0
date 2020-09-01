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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAC2C28E83
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0157207D3
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9J0siRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0157207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9E1032040E;
	Tue,  1 Sep 2020 16:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0AEhrwys9MR; Tue,  1 Sep 2020 16:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A5DA620495;
	Tue,  1 Sep 2020 16:47:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 930EEC0052;
	Tue,  1 Sep 2020 16:47:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3988BC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 28C7A870E5
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yQflT7aOzFkX for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 16:47:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9CEFA870E1
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:43 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id o20so1107614pfp.11
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eTzVI35DRVJv330Nqj3ET+6aUZCHukORN2vVqCI+diU=;
 b=Q9J0siRiCBTUvlTt1kvK7tVe6kE41TN+kIDNXErBGCMEu1mS9WGl+7HnaY7AizAAhM
 MGgJn5r7Rof/eu1Uou0PMSTw5hFRpugiRYy1Zicok/Tfuyw1H3V1tq3kahNYERz3c8YT
 bXHl75p+tvjsOILMrKaZDr3cZEd5sXyOpNnNhuqDgkx3L6L6Kb3YuoljJJBZkNLHwbFo
 soPQIChGhslKZccNHRLkXXS2dp3278kCoXtym2UYyH9+JavhTLC8/CcPIIx8CECq/6fQ
 wY6/1CctuejLklrAEC2Nb6tplD1fgnMzEIXMROD7R3A/ASkM5gP75Pv1ZPmEFTZQnh5W
 DuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eTzVI35DRVJv330Nqj3ET+6aUZCHukORN2vVqCI+diU=;
 b=D1P2l7f783z9Mzlw+pfiamscuuUmKx6hmLHVhpLE8q4PnCI2MPGsWF/o8qL9hNyP5f
 HdjpkEv9479nxxGvfl3yuAEUX+GfYiNO5sQoazxbBHN1zRObsMT5iVGDiAhOn0qrFqK6
 +bnn8W9OwDR2N9BlQEauCSfAYVZC/B16Irbgt24vahOV1WCmGovmEzqvSodmsniQGcek
 cbrvsrO01T5pGfQK7fV78JUmL58D9ltftECN4ro6XhiQXEm5+ICa6QnrBEbyCyoAF4/4
 a5jMnnN3hsxWRJHAKXdzf97MkZ04YDG1+tQhGZ8X40sv1EonFHbCHOZQsbxb5D+OAMCo
 LZEQ==
X-Gm-Message-State: AOAM5307xcW8C36pnmErYXhaRrlCfQKxgvDmck6QC94xpfkG6FkW5ffh
 lsx9wTWVH6RcsvQKRyE8+cg=
X-Google-Smtp-Source: ABdhPJy7payz3Vghp5VrIVR/57rRNtRm4gc2iwL+b/6W66VztvW4dVIOty7fJYRx21hhgXmVGY0cFg==
X-Received: by 2002:a62:928d:: with SMTP id o135mr2763620pfd.22.1598978863218; 
 Tue, 01 Sep 2020 09:47:43 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id w66sm2622381pfb.126.2020.09.01.09.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:47:41 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v16 20/20] arm: dts: qcom: sc7180: Set the compatible string
 for the GPU SMMU
Date: Tue,  1 Sep 2020 09:46:37 -0700
Message-Id: <20200901164707.2645413-21-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901164707.2645413-1-robdclark@gmail.com>
References: <20200901164707.2645413-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>
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
