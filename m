Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998A2C43461
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241E3613C2
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241E3613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C3BB940428;
	Tue, 20 Apr 2021 17:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XLtUHVVjKPhX; Tue, 20 Apr 2021 17:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA2D34024A;
	Tue, 20 Apr 2021 17:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7943C000E;
	Tue, 20 Apr 2021 17:25:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DE3EC000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8882483C26
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D_s3OGR6ZqX2 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8169883C2B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:52 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id g5so52754289ejx.0
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vz/zyZ47TrozGRsIa2tK+ufxsCFVoosfjna/ca4O/c0=;
 b=aVjoNEMiGwN5Lx+kpE0qEfP1uo8Al+w9/1qZbSxv72ywzCQu2k9YlZjwLBxzIGxUN+
 kcZDfsUTdhASLUq94nNRF4nvKMWEQVwJMww6W7mYpQFODk6JAzP5KOokivLnY3o3O/XE
 BbTv9xfW5UtNxcGy2iMtGSd7dJEO7cRa56EA1p2XF0Ik9dyKnWGRnOIZy+oHsQILsZws
 asw61xqlOH4Fj5DCjYezjLZ7A5GZGsM5NqxfUtxjmQrufFp9l0cGHD0WH3ckKC3nAwNB
 w8bsZz59BZAcouWtPRyvn2fFYRRghJWtFpgxY9laczlHFANH305JGjQySqz42mU+dusz
 KJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vz/zyZ47TrozGRsIa2tK+ufxsCFVoosfjna/ca4O/c0=;
 b=NehdqXgpUTpymQ1Cw1obRrS+IcyJSJtvFBFiragCz0iMrY3Q2jHqfozE4wxfQdg/+n
 H+tnWx6I0kI5GGj34NreFxhhg4m6TTDqX3nfEoCZHSRjdiZ65GRZrfhGk1Wyn6yx5M8+
 FMgkzqCzxGE69SMSBJvcKl6GcqpeYAMIhmsdxObev6v8CtBN571b2huRwROHUiInAJFC
 FKwfUv74yJArhy9Z6vrxfhQp17MNtBLqz5ddeky4KZd5YoAs1AO6jiZBjZjfFMSvhUYu
 AHVaeADyl9M69W6k+yfS/qx65vHQhWslBMjra2cHKoBQj96NRX1W4RgNzhX/7ujNDtDk
 mJTQ==
X-Gm-Message-State: AOAM531PiXPC1bJJOD5rBiv0aDINw85GW0IPVpp1N8p/KlCyCOXkia1g
 /AP21A547IwAftkzlq8zJzU=
X-Google-Smtp-Source: ABdhPJwZCdHDE7NG0mwEAEDc9JwkflUVViR7hF+HAhuinZYY9qCwxULzmByvXibRb3tsjc/edR/Hew==
X-Received: by 2002:a17:906:134d:: with SMTP id
 x13mr29062800ejb.61.1618939550792; 
 Tue, 20 Apr 2021 10:25:50 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id c13sm10630242edw.88.2021.04.20.10.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:50 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 07/10] arm64: tegra: Use correct compatible string for
 Tegra186 SMMU
Date: Tue, 20 Apr 2021 19:26:16 +0200
Message-Id: <20210420172619.3782831-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
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

From: Thierry Reding <treding@nvidia.com>

The SMMU found on Tegra186 requires interoperation with the memory
controller in order to program stream ID overrides. The generic ARM SMMU
500 compatible is therefore inaccurate. Replace it with a more correct,
SoC-specific compatible string.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 9f75bbf00cf7..a173f40256ae 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1082,7 +1082,7 @@ pci@3,0 {
 	};
 
 	smmu: iommu@12000000 {
-		compatible = "arm,mmu-500";
+		compatible = "nvidia,tegra186-smmu", "nvidia,smmu-500";
 		reg = <0 0x12000000 0 0x800000>;
 		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
