Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999FCC433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 08:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C00484021;
	Fri, 29 Apr 2022 08:23:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HIRy0KlaaHMS; Fri, 29 Apr 2022 08:22:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 41A4583FF8;
	Fri, 29 Apr 2022 08:22:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C940BC007F;
	Fri, 29 Apr 2022 08:22:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F39BC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C0D241C89
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xgkNy8HTMjMi for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 08:22:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3795F419B2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:57 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id 4so9591331ljw.11
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PAlN+PTUyqks6hqGrW+qckqB/lH9aZjKYWgmrQYYHa4=;
 b=fUqJrWvtrx8Af1i1dIKCvDN65PW96rX20FLwt+ie7pGKrJuRIq5FJhHpdmjo8bNp2a
 hjNQjVLxsxnZ7pQMF4RKdt1pcwonGXo2nE2ewIIj/yvzYz/MYLAlN3bPZFD1jKGlinaq
 IGk+NWifc1meAHo1k0pEZT3pdD/EneCDx4HJ46ltwQSZuGycNQT2r6H4awyAuYWys/Nt
 76Odh6+ZOWivq3i++ViCecadNgQiH642RERe4sQWEga5G8yYfCjN1mdNywPsoPAIQC4F
 LAAy7+r8mJGOHpI8G7LidTTD/kZDEqvrv+ZpoAz1Syv140gdhf65HqzMpe2tSvM3y5Cm
 NGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PAlN+PTUyqks6hqGrW+qckqB/lH9aZjKYWgmrQYYHa4=;
 b=0HWhwYgUl6UPG4xXZ9H5wH5mTy7Xbj7zxyMxzlFfEVTZQza7eDoa6yQw4B9WBUni3w
 Eyjeq2to44wslXxaxX+snEpWjHM33yUBrweB4m7Y7bodVbY14YkwpZuXK76ZQyG3+U6Y
 mI3y20lCZulvORePIfsS7MdnSpFJJxeIG9QsSaw4ATffaw+aheeMJo57Ct/bZXxwLFyR
 M6cZGYiQVUlz5ZqeXokMmBvII+C8rUk17MT9Dpi86oGsL+ms/L+f/H3wYML7auFBSsOQ
 MoQO69D6eVshZdbEj0QqMZM1KTbJDLPYQn7axslfAP/myHKvCFFxQ1EozCdw7Mf5xzu3
 /oYA==
X-Gm-Message-State: AOAM530Zkscu963HOWxbhGL3B825DUgaaBbvuhBOtwT9bKOqxtvuakh4
 QzHp6R2ZUYx2RjM22RMy/oI=
X-Google-Smtp-Source: ABdhPJxQNk6WVaoL+9t7XN7z10p4srU1Oi91euacYwvlEX3pKTPyIRh42d6HgZfmjfH3BSEQY0XflQ==
X-Received: by 2002:a05:651c:893:b0:249:4023:3818 with SMTP id
 d19-20020a05651c089300b0024940233818mr24408230ljq.44.1651220575123; 
 Fri, 29 Apr 2022 01:22:55 -0700 (PDT)
Received: from localhost ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 d11-20020a19f24b000000b0047224d546adsm178803lfk.132.2022.04.29.01.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 01:22:54 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 3/3] iommu/arm-smmu: Support Tegra234 SMMU
Date: Fri, 29 Apr 2022 10:22:43 +0200
Message-Id: <20220429082243.496000-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429082243.496000-1-thierry.reding@gmail.com>
References: <20220429082243.496000-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
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

Allow the NVIDIA-specific ARM SMMU implementation to bind to the SMMU
instances found on Tegra234.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Will Deacon <will@kernel.org>
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
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
