Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EBDC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 04:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD07F61007;
	Wed, 15 Jun 2022 04:20:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UW1mhgWvJ3A4; Wed, 15 Jun 2022 04:20:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D56C261008;
	Wed, 15 Jun 2022 04:20:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58728C0082;
	Wed, 15 Jun 2022 04:20:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22F35C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 23:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03A8040327
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 23:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=anholt-net.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wWWxMWpOAiee for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 23:01:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1338740176
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 23:01:38 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id i15so8970326plr.1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anholt-net.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F4m9A8Qo6zOltjkzi0N0zgRLf5Grbh0WeCZKflLJ7DY=;
 b=vuq62C9vlXng27Gng4avkt6GXFI/9GQfRmTb1j/9RpzgytIr+h8bLihhhQ2Kdu8qxN
 U+0N/Nw3VoStnuJhi1y87mQxOG1cio2AKy7jHmg5PzX9HABxw99eoZH8NbNDLwKdran/
 fMfs22HceHQFa3ZNFgHaxWQzaVuRvEUx0a9d0DMc7Jqywcn0FIiLIIxTKKPYTkQZMJQi
 M71kLAhFrB9vsfTpMpS1gunPEJdIJ70J4KofJg1WUloyOIQVqeebQRQacQeatC2GYSUi
 XEiGzsqY2R9EQEVXD5wqx1AVGpGOSc9XCoMEGLgnWj17FTo4dnXsKWyPBO7FNhC+v8Um
 xy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F4m9A8Qo6zOltjkzi0N0zgRLf5Grbh0WeCZKflLJ7DY=;
 b=68xQibx0evDYeqqptwbQmZ+H9961h6c5BPwXWyNI3uafoQ73pIy0BEL36slF937UA2
 1QO8zlwzZy1S1Cho44S8W9zL9+toStKXTRBQqHsF7sHZTRVvACS4BBPkkAq2cxSurcRO
 cH3mDST/G4TFMoky4uPNrn1Y+5wBzHrnVA+5wbc6/JrUNrvjDMy+YZIJbIpjRGJ4L66v
 XFMAlgr5AJwYOPooO2NotE/Qg26yevCiuQFK+KNYlf0Z0fBgSB4N6iogJ6OavtHcbT+3
 if0G1V4vs/n5RAA+Op3Ntdb77XkLt4G35J2Db/Hb8eNRayF7xRlswrqr2sa3zIibt7ML
 uT1g==
X-Gm-Message-State: AJIora+rxKprSB9q+ERFBwR7rgnybIickIC++WVAb3G/im5gS52LmpQr
 B5ec7RydzvedE/6LBqqCzc+AeQ==
X-Google-Smtp-Source: AGRyM1sysLwTU+O4gfQ75Td7Y5l63JSZ6kQ5+2cLmKQHoxX1bX2xDe6Y/djjDLJekIO9y4ae3uDmHw==
X-Received: by 2002:a17:90b:1bcd:b0:1e2:c8da:7c29 with SMTP id
 oa13-20020a17090b1bcd00b001e2c8da7c29mr6858481pjb.4.1655247698383; 
 Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
Received: from wildbow.anholt.net (97-115-79-125.ptld.qwest.net.
 [97.115.79.125]) by smtp.gmail.com with ESMTPSA id
 cp15-20020a170902e78f00b00168c5230332sm7787768plb.148.2022.06.14.16.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
From: Emma Anholt <emma@anholt.net>
To: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
 Jordan Crouse <jcrouse@codeaurora.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8250: Enable per-process page tables.
Date: Tue, 14 Jun 2022 16:01:36 -0700
Message-Id: <20220614230136.3726047-2-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614230136.3726047-1-emma@anholt.net>
References: <20220614230136.3726047-1-emma@anholt.net>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 15 Jun 2022 04:20:45 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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
---

Tested with a full deqp-vk run on RB5, which did involve some iommu faults.

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a92230bec1dd..483c0e0f1d1a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2513,7 +2513,7 @@ gpucc: clock-controller@3d90000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sm8250-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sm8250-smmu-500", "arm,mmu-500", "qcom,adreno-smmu";
 			reg = <0 0x03da0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
