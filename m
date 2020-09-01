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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E44C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312E72067C
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2/URyDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312E72067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E4400870E4;
	Tue,  1 Sep 2020 16:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id igR-jH49GZN2; Tue,  1 Sep 2020 16:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 71C8887049;
	Tue,  1 Sep 2020 16:47:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69069C0052;
	Tue,  1 Sep 2020 16:47:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79387C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6856386366
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y33cTLLDEIxm for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 16:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D384C8647F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:47:40 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id x18so818350pll.6
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VJrx+AWRDEEJgr3DuJf5FGtuFm676MmhtRSCNhrUo5I=;
 b=d2/URyDwjchuggwTyHw8d/OgnYrxNo2olK6OBqsGffjs9tubNZacMeAts3N4QEfxw8
 5Q6mP/Io1kZ6ShbzKsdMp66CaPux8VHjQyV2cKCN9Xa0KLS+9ZSDrVarpGKC172y1hw6
 AfTeVgZ0r3PwraILILQvgL8q68+6/C3O3c2itMcUplLuX4Uw8as90AeNj4yxr2mng2/D
 U9PHtA6MttoyqkO7LLkNGz6fP5ePa4dmCRHpzecQ94K0BOVx9z2rfL9ZetZaMKGMMvxC
 zICl0CqJ2zk04r8CDOMEUTsvAtNeEM+44tgYS4vy503g6QOoJCmAH7g2srag0k4AM47h
 dE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VJrx+AWRDEEJgr3DuJf5FGtuFm676MmhtRSCNhrUo5I=;
 b=HG76BX/jUoJz+BjYbsbHP74jihxjElOkMrWu2ldbrovhT1O2CqwwCimp0xlg8BXa3h
 xDZ9PkyNYTZhtWlPntG7q6i8f0T/6M3iEbPHDzSoDyi+jnmLf5hE+ikwTucGaQ953lSG
 L95QuYAr2wGWgx9xH7FhnVv0A/pIsnqAh/PXG/msxwv0tuL//t7SjtoFWrBxzBB8trQ6
 5FTeH3BWAd3W/cwo7+SK3MHWKpUj6As53dnKEja3VTvjjPW5Ucz4jPnWwqDo4E9CnF04
 NWl0GJUifLgVGQwy/fR523JuhYHSbopLkRwcPIzEUlT4HsMAx+GUnjZDBWn9D6pG4RMT
 59Rg==
X-Gm-Message-State: AOAM5327yDIQGDnqIpZiMpG3nrKeiZFq3I0q7KXxcMsECGVukML2oqzE
 P/acdmsLF6qVCx5YZu8V2iY=
X-Google-Smtp-Source: ABdhPJxfV0FiOo9Kg84TzFlg6WinbO0JkLmr3QdQ0ZPhheez1khfYC5+K4MYQGR60MpSKWKBwCPGmQ==
X-Received: by 2002:a17:90a:718c:: with SMTP id
 i12mr2397826pjk.101.1598978860386; 
 Tue, 01 Sep 2020 09:47:40 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id k4sm2755950pfp.189.2020.09.01.09.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:47:39 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v16 19/20] arm: dts: qcom: sm845: Set the compatible string
 for the GPU SMMU
Date: Tue,  1 Sep 2020 09:46:36 -0700
Message-Id: <20200901164707.2645413-20-robdclark@gmail.com>
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

From: Jordan Crouse <jcrouse@codeaurora.org>

Set the qcom,adreno-smmu compatible string for the GPU SMMU to enable
split pagetables and per-instance pagetables for drm/msm.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 9 +++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 64fc1bfd66fa..39f23cdcbd02 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -633,6 +633,15 @@ &mdss_mdp {
 	status = "okay";
 };
 
+/*
+ * Cheza fw does not properly program the GPU aperture to allow the
+ * GPU to update the SMMU pagetables for context switches.  Work
+ * around this by dropping the "qcom,adreno-smmu" compat string.
+ */
+&adreno_smmu {
+	compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+};
+
 &mss_pil {
 	iommus = <&apps_smmu 0x781 0x0>,
 		 <&apps_smmu 0x724 0x3>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2884577dcb77..76a8a34640ae 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4058,7 +4058,7 @@ opp-257000000 {
 		};
 
 		adreno_smmu: iommu@5040000 {
-			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+			compatible = "qcom,sdm845-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
 			reg = <0 0x5040000 0 0x10000>;
 			#iommu-cells = <1>;
 			#global-interrupts = <2>;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
