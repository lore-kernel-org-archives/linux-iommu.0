Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E85C433F5
	for <iommu@archiver.kernel.org>; Thu, 20 Jan 2022 20:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B701260EBE;
	Thu, 20 Jan 2022 20:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DBTgFjs8fqED; Thu, 20 Jan 2022 20:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A3A4D60B5A;
	Thu, 20 Jan 2022 20:42:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8BA7C007F;
	Thu, 20 Jan 2022 20:42:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADD66C002F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 20:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8717140537
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 20:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SomTfAziMm3Y for <iommu@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 20:20:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FF01404B9
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 20:20:06 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id x11so26051222lfa.2
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pw1RtCNR2WInVJgGie+Q591Om/Vjp92bOiH63X22+is=;
 b=FAdCTNmkHImYatU6XdpAhSzDgjpEHYTA8ykjZkL8qQEwt8M3aGeEkFew2DxyYDo6S4
 clRFhXaNpa1+MvZ8/upKHqiLhBleahsBjGp6tcbdWPsg+qiTp43SFtaujb7+uBS4Mgek
 SexbAtvOX/BaIeXgG5eZf/ZMWrhW33TwD1t3jTa4H18pqPjGSBTPGBEcM3Bp4opSJMZb
 HVRJp2m6N0zdFXwLGXlCvot2JLouKrJsrtdfMUU5H8mh5TFf2lSGTQeFBtEmAMdbWB0C
 r4VbzJixNVw618ma7tF3/l7cNZQHjHzcnzdWNdHhgyxG+l+ONcIRukEw51/BNDRgGjbI
 Xvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pw1RtCNR2WInVJgGie+Q591Om/Vjp92bOiH63X22+is=;
 b=oZnDcULEeGkcfyDumNGPt5Gyndkd2f9gwkRQX5IjFmbFTptg0aErqZTJdu1N4gR6io
 ysjtqXKEEz21PPjoepGeeF/Tq/0pthsSnCQVumWIayAtiqDwZjYYPF5D9S/B4PHxBbVp
 xUOElma8/KWS4uhZLJMup52jsoEkg4vvlwbt+tdNOPlBKaWW5dP2AQlm1cRYpFJtJVFW
 9vjONU/u1tugdALtByJfzw5Bg1F8KieRXQDiWlkQbSwRH7O2egw+zT0vgFB+wwt64iEG
 v6dYAjt0QCMwgS5/ebPEijNPTnlsalcAVRCYwH0ij4W0v9F3m59euvz+3aXsjtyliiuY
 3gXQ==
X-Gm-Message-State: AOAM531qFXYtXB07MGWtvhah/S8qB29BDE1lorYtnvriXq4QZ0j7Zo3S
 xYzc0A7w1ORq8nShxrBVNQp87g==
X-Google-Smtp-Source: ABdhPJyRbihYr9cGQwla7AU56lEI70374A+Hs+FgskQxGyDvi3BiO6ZqsqY2fvBEWKGvjsTKNn1jjA==
X-Received: by 2002:a05:6512:74a:: with SMTP id
 c10mr750754lfs.234.1642710005001; 
 Thu, 20 Jan 2022 12:20:05 -0800 (PST)
Received: from localhost ([31.134.121.151])
 by smtp.gmail.com with ESMTPSA id h4sm21716lfv.220.2022.01.20.12.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 12:20:04 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [RFC 3/3] arm64: defconfig: Enable sysmmu-v8 IOMMU
Date: Thu, 20 Jan 2022 22:19:58 +0200
Message-Id: <20220120201958.2649-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120201958.2649-1-semen.protsenko@linaro.org>
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 Jan 2022 20:42:08 +0000
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Carlos Llamas <cmllamas@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-samsung-soc@vger.kernel.org,
 Mark Salyzyn <salyzyn@google.com>, Jinkyu Yang <jinkyu1.yang@samsung.com>,
 Thierry Strudel <tstrudel@google.com>, Will McVicker <willmcvicker@google.com>,
 Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Jonglin Lee <jonglin@google.com>, "J . Avila" <elavila@google.com>,
 Alex <acnwigwe@google.com>, linux-kernel@vger.kernel.org,
 Hyesoo Yu <hyesoo.yu@samsung.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
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

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30516dc0b70e..bb03628b5e25 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1033,6 +1033,8 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_SAMSUNG_IOMMU=m
+CONFIG_SAMSUNG_IOMMU_GROUP=y
 CONFIG_REMOTEPROC=y
 CONFIG_QCOM_Q6V5_MSS=m
 CONFIG_QCOM_Q6V5_PAS=m
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
