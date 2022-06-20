Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B4CCCA482
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 18:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CFC383E2D;
	Mon, 20 Jun 2022 18:36:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CFC383E2D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anholt-net.20210112.gappssmtp.com header.i=@anholt-net.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=HcNySfWk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3nzgaSKSq5fb; Mon, 20 Jun 2022 18:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D232F83E17;
	Mon, 20 Jun 2022 18:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D232F83E17
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAC48C0032;
	Mon, 20 Jun 2022 18:36:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EEBDC002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 18:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25627404F8
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 18:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25627404F8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=anholt-net.20210112.gappssmtp.com
 header.i=@anholt-net.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=HcNySfWk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jJ0Tfxo_KxOG for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 18:36:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57E4D404CF
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57E4D404CF
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 18:36:47 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id k127so5753397pfd.10
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anholt-net.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cuXafal7oQMsPKjaUnSX0izJjoMCagq43H5IBdJoY/0=;
 b=HcNySfWkztX+IpyLdapmB5uQv+0HIWkTNMKKAUBo24pLvsbYdt0MhDUZ8AamP/aZZs
 2GiClOnQwtLaUHbNNgwZvIlNV1NxAv09YX1qM+M8ZsC+t+woA8HTL0xrUUVHTaXgQtFA
 8FBuTsB4XH9nq191ZTS4LYUooQk7H8oCGm9lmcuJSIiPLFVJ0s8wxOaDHR7c3PAHwUYk
 kkRkFNINd50B/k8Y+kWGdSjF7SLflNWx8DLSASQPsU02g3sr+8mEyVN+hHwDVzV9fGJ+
 iLaRwn7xGaqfvxbirLEalktbZwqgl36/g2RknT6Z1hinMikKYh5wNN89zPcWPQ4H9C2P
 uU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cuXafal7oQMsPKjaUnSX0izJjoMCagq43H5IBdJoY/0=;
 b=goWslOLAbkV/5GL2Ig0MuX3WJF0c2KqKfQPCZJ8/zTB9ycOpem4jn6GjKRlU71RymR
 Y/nGQfe08XwpA4qqwzNn4OVaBEza4l0uta0WHfK6fy7fkog6hyPZZPEKAzJbgn/eMmNZ
 7lRpFDf5kFQ2HchnjvycOtLut6X/1IVjZDuRIWXQ6xQ/wBSRknRlLhiggKE0CVWkDw6h
 JT2AuVm2q1EjnQPhyB+k/JtF7PZBs2tpOPquBD1Z4YVU7eNSBmrKlRCtU0w1LOleg6MX
 46NPrjh4fqkuisqmktnCXcZZ8MeLG8zSje2LAGhKwa6xJ+oxzD6Tcbr2fzUsamtsl3Zw
 Cwgg==
X-Gm-Message-State: AJIora9glf+SYoqblcBi4+mv7CHGyKJOs6+qPVmSfRnO5a1/HdQHwXTW
 UH68FUrW0mFfcyqV0jGc1YiOYQ==
X-Google-Smtp-Source: AGRyM1uaVMxPdAdbEkr6R5BXQkH4b9IPtINsC+QUA2arv2IQf8W7zqXF2oWl6/UIv0I4Iw1fk1cI2w==
X-Received: by 2002:a65:404c:0:b0:3c6:4018:ffbf with SMTP id
 h12-20020a65404c000000b003c64018ffbfmr23272611pgp.408.1655750206723; 
 Mon, 20 Jun 2022 11:36:46 -0700 (PDT)
Received: from wildbow.anholt.net ([97.115.187.17])
 by smtp.gmail.com with ESMTPSA id
 ds12-20020a17090b08cc00b001e0c1044ceasm8500041pjb.43.2022.06.20.11.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 11:36:46 -0700 (PDT)
From: Emma Anholt <emma@anholt.net>
To: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm8250: Enable per-process page
 tables.
Date: Mon, 20 Jun 2022 11:36:33 -0700
Message-Id: <20220620183633.1131760-3-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620183633.1131760-1-emma@anholt.net>
References: <20220620183633.1131760-1-emma@anholt.net>
MIME-Version: 1.0
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Emma Anholt <emma@anholt.net>
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

This is an SMMU for the adreno gpu, and adding this compatible lets
the driver use per-fd page tables, which are required for security
between GPU clients.

Signed-off-by: Emma Anholt <emma@anholt.net>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

v2: moved qcom,adreno-smmu earlier

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a92230bec1dd..aae7b841b81a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2513,7 +2513,7 @@ gpucc: clock-controller@3d90000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sm8250-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sm8250-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
