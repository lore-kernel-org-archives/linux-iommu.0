Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C3DC433DF
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:42:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FC32087C
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSjYyuU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FC32087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4202E24C4F;
	Fri, 14 Aug 2020 02:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e0decrPpYD+x; Fri, 14 Aug 2020 02:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 47C6024B99;
	Fri, 14 Aug 2020 02:42:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 343F4C07FF;
	Fri, 14 Aug 2020 02:42:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33E6FC004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 302818709E
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Emstvrp9x-8O for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 02:42:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id ACE5186FD7
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:42:09 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id ha11so3703077pjb.1
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 19:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/RMbEO1wS6ve28JkP/1VJiMbFcTiFM9NBrI4zgQscQM=;
 b=WSjYyuU3IicqTzGKZ+qyMjOajK0Y+CUj5/an3UNid9VEFQQQ/GpitZqkA4Xu71HuQ8
 uyDetJmFxIA+LZ4XKMdbTacXBdQ0BS3SOFEr+zfj8Vs4H+aqeVXRsK6JQK/JbDEBN6KL
 KRMXnTA5bzHXH18nGWyEk4Oe0sZ/kKopVL4uPgbxwS47tJ5mL4kSYON0DOcpPgu4ncj3
 JPOGnNh3/vssv6qpnjwMjU1C0PCegmTgZmDWFyDlNeNIQ2ThNiwnKSOI0nCAg2qqb6AX
 sLmkxHWNJBh1RrM51cityB+EYPnBq7MWoZfATphAbQy5D3+kK4PBubVAY2hgGHqvs2Xq
 TPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/RMbEO1wS6ve28JkP/1VJiMbFcTiFM9NBrI4zgQscQM=;
 b=UykledHSe5U+pjriIp3KRZ8tCev3QaL/UJ1m8L/VAG8mZJkhit1fLcOKbi8wXP3LjA
 1Bmw8zPWSwm86wsYZLdu6rotFhPrVS4ohxDmW1NIcHWQHBUa50F84mih4wNSyNUpEjNj
 5r45r6vcoVPCuckWnuqJ1M+fs6YwAgjZ7pQpHt9BXqG9x6+h/ocPzL8J4+YoMg0pBtpz
 Cqs+eb/xj3aIR74ftbQtnS/5eLMZodNVypQ3HvTDzuOvBaoJzKTbHsv0v80rE+1OcBCj
 iI8erAgnn1l0XQcWatXLiTOwqb7o2gXfpauNbfAK9hXXlg1fafTEDNK5JyVIuqkFvdvP
 cFgA==
X-Gm-Message-State: AOAM530LDM8d3MWseJHFdk/MJ0VDQfI7EJsW87MYFxUJCSpAnJGCRjp9
 4FNLcc9/SQ4irUN6L3c6PWQ=
X-Google-Smtp-Source: ABdhPJx2Hm4qJq+ws1Wzuo6A7am1wv6hPi7gD/YHP4Z3vqtJe3/ztGrQUEPhXJiyo9idH9IbGNEomw==
X-Received: by 2002:a17:902:b701:: with SMTP id d1mr562133pls.92.1597372929283; 
 Thu, 13 Aug 2020 19:42:09 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id x136sm7189060pfc.28.2020.08.13.19.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 19:42:08 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 17/19] arm: dts: qcom: sm845: Set the compatible string for
 the GPU SMMU
Date: Thu, 13 Aug 2020 19:41:12 -0700
Message-Id: <20200814024114.1177553-18-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200810222657.1841322-1-jcrouse@codeaurora.org>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
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
