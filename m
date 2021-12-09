Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66A4C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 16:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8325F412DF;
	Thu,  9 Dec 2021 16:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t2QlPJXF2cAW; Thu,  9 Dec 2021 16:36:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 441FF412DC;
	Thu,  9 Dec 2021 16:36:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB15C002F;
	Thu,  9 Dec 2021 16:36:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66373C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46961856BE
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:36:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LNh_JTxZFHTQ for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 16:36:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B22A856B4
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:36:13 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id a9so10674321wrr.8
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 08:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RBVbB9vWDMJLfuwUYZUrRPLV7w25shhYgWxxhrA4Z48=;
 b=DGTmwROcRMmvUsuy3YNzANsG6/H/eUb9VX0utTdtacM8z6GqwRXVbC16JeNePjBBHE
 O55Lqu5LqXYX+xVavU00nqw3JV3zVVvasfffLIOYCVbEYjBFW9sEf63e7WXDdodZoRYU
 VdG0oFsYnOuIc5CcB7i9KT7XGIj9UPc9DzI6JfaZIhNaBiTRx6DPT9BTC9H2PLGY9Dln
 KgylB4YajKqGbcfIVCX7ea8KgNU6l+mp3oOP1+5NSJil2XFG3yZaisW4rMhV8dbJ73/w
 OnhDDp6NUZyATkuzV4x3mnHSiQELVzNokQT7UIOiSyRr01Echrq5VC4Lc2vlGZ3UHlKR
 3OKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RBVbB9vWDMJLfuwUYZUrRPLV7w25shhYgWxxhrA4Z48=;
 b=OvGY8533noKKuDsxgcZFGSp0YrMGYx7fhF8/r32LJdKbcgG4f6v7l8UOXrexkNYx7N
 VuB+CqwhAdiLn8zN1/yHJNSIzt3GIo4P/sHBB42ZvkahBkGTC8N+FaSDNwu3jWeD5CDd
 zuaftaAFYD+ZHBdqxDus2Fvu6dpfMxHzuX2BIPLRgtOd45ud7uuziJtWciAIhY6TEHZa
 4m3lb1M7KFv8PWUiaTGaasF/iM4UAURtgWghQbB2OqMkB82IoBQqBAgO5mAqm8qpRvnK
 6djrdfo8RXqXymE/Tp/V4cbyrU9Rq6E6CWwhrE2Qe/tBfKASw8EtBrzYB6OeqyiXbS5R
 u+1g==
X-Gm-Message-State: AOAM533JVS7J0Bci80oR3GM6MtXOUeHbgw7VLuBuTAAyQhE4ZQOUbKk6
 G/hiclI7UX9zJ/8wgRsBVYc=
X-Google-Smtp-Source: ABdhPJyoyzm35sKhtbHbEgfcyRTMC6E0F0fB9LiKI1mNHER0VWEYotU23cMbHIBCAVjMsVva3cZv1A==
X-Received: by 2002:adf:f491:: with SMTP id l17mr7747810wro.525.1639067771765; 
 Thu, 09 Dec 2021 08:36:11 -0800 (PST)
Received: from localhost ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id v2sm250094wmc.36.2021.12.09.08.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Dec 2021 08:36:10 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 3/4] iommu/arm-smmu: Support Tegra234 SMMU
Date: Thu,  9 Dec 2021 17:35:59 +0100
Message-Id: <20211209163600.609613-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209163600.609613-1-thierry.reding@gmail.com>
References: <20211209163600.609613-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Allow the NVIDIA-specific ARM SMMU implementation to bind to the SMMU
instances found on Tegra234.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 2c25cce38060..658f3cc83278 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -211,7 +211,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
 		smmu->impl = &calxeda_impl;
 
-	if (of_device_is_compatible(np, "nvidia,tegra194-smmu") ||
+	if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
+	    of_device_is_compatible(np, "nvidia,tegra194-smmu") ||
 	    of_device_is_compatible(np, "nvidia,tegra186-smmu"))
 		return nvidia_smmu_impl_init(smmu);
 
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
