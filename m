Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD774C43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 11:35:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA9621655
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 11:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsuvpATr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA9621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5AF4A8701A;
	Thu, 17 Sep 2020 11:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b6c1hqn3e970; Thu, 17 Sep 2020 11:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E971986FA0;
	Thu, 17 Sep 2020 11:35:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7411C0888;
	Thu, 17 Sep 2020 11:35:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F116C0859
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 11:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D4B952037A
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 11:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id to-f10WMLiyt for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 11:35:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 993C5274E3
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 11:35:22 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id o20so1023498pfp.11
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hqyi/xOOSPbq2sLccfUIMg/IBaONt+TI3nAR/jdQ8+0=;
 b=XsuvpATrxnyOdZ082PfZTqiGJyd5VlehgmOaeJaKRRM4R126cOSKFT+qJcTU6uOvhV
 ZMeLo0Hd67CjMu2Md6hOJ+f0sz9wpK1I34RwwfwYoEGlPEmF2O//beqQGvqdc5czH1aY
 cKq68fsy6BWWkX1ByTwnGJt3xJShFoWN4X68TTILMXcBDsIh/xEEikgKPxFHBmSbghkI
 XddoxBFZxims91ZXYarpGtGau7mgsKN51Ky4lzIdDt8QcXo+j48GdBsD8a222U71Oa3D
 ucHWKBWBD0cxomnrN3w4puxhAefRMSxx5eyYYYmZd4MCFs57W/or90JBmp9umAnuyN7e
 56wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hqyi/xOOSPbq2sLccfUIMg/IBaONt+TI3nAR/jdQ8+0=;
 b=JT6CEkCzNGrcclkc9sBoLNrVUTo+0u4fUkBgYmE6BpMzOMx8SxpdGXvIfOZNbsBpXx
 xPXa6WgssduHxo4xz7ss7qPt7SyMlw2lNBOlqwjNz1ZxDDp+dENKKEm9x89Kpu3Mnna/
 O/icYzIH5uMggVc7yylY+Edh24B5IaLVQR9qv2FfaU/0x7svbswHvAoCTi0LUY+y3F8n
 zjU2T5JKbUQtfkR4Q15RGr/p8ZQryFS67LBjILTZL8R7GSKhKKFbr9CTDgUbtoUpTBFa
 bXF28v9/QI06LFNnYtIaHgphblkuYeCsgipGb3j639VVOMVAQOnJb/FCfJboYrKEUyor
 ZXaw==
X-Gm-Message-State: AOAM533R3F0aijC/L1t9ff4HQ2dJ6IVuqEHd7wjHkOhFEtvapRCTs3xh
 QXLdn5P3Wz50GlMlKtXiwZg=
X-Google-Smtp-Source: ABdhPJxaX6IVt6BLr1kYX9VUY1eqb/Tte57kwnZ5NhQhWQmbw/7fD278jhNmMt53/Cf0dMC3L/LUEg==
X-Received: by 2002:a62:2b52:0:b029:142:2501:39e9 with SMTP id
 r79-20020a622b520000b0290142250139e9mr10824105pfr.56.1600342522014; 
 Thu, 17 Sep 2020 04:35:22 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a138sm21128382pfd.19.2020.09.17.04.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 04:35:21 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: krzk@kernel.org,
	joro@8bytes.org
Subject: [RESEND][PATCH 1/2] iommu/tegra-smmu: Fix tlb_mask
Date: Thu, 17 Sep 2020 04:31:54 -0700
Message-Id: <20200917113155.13438-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917113155.13438-1-nicoleotsuka@gmail.com>
References: <20200917113155.13438-1-nicoleotsuka@gmail.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, jonathanh@nvidia.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The "num_tlb_lines" might not be a power-of-2 value, being 48 on
Tegra210 for example. So the current way of calculating tlb_mask
using the num_tlb_lines is not correct: tlb_mask=0x5f in case of
num_tlb_lines=48, which will trim a setting of 0x30 (48) to 0x10.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 84fdee473873..0becdbfea306 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1120,7 +1120,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
 		mc->soc->num_address_bits, smmu->pfn_mask);
-	smmu->tlb_mask = (smmu->soc->num_tlb_lines << 1) - 1;
+	smmu->tlb_mask = (1 << fls(smmu->soc->num_tlb_lines)) - 1;
 	dev_dbg(dev, "TLB lines: %u, mask: %#lx\n", smmu->soc->num_tlb_lines,
 		smmu->tlb_mask);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
