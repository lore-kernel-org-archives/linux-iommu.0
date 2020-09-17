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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD3CC433E2
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 11:35:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62E2208DB
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 11:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYEi0omm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62E2208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D598C8701A;
	Thu, 17 Sep 2020 11:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xJcDFUFx-Mpq; Thu, 17 Sep 2020 11:35:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5711D86DE0;
	Thu, 17 Sep 2020 11:35:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28E59C0888;
	Thu, 17 Sep 2020 11:35:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8699FC0859
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 11:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6AF2C27428
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 11:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i-u9aV3AJyVp for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 11:35:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 63A8E274FC
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 11:35:23 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id l71so1206695pge.4
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=44JkQ0xk/m6YNhH3hVjpFztigV1A13fyXiwxKi+U+Xc=;
 b=VYEi0ommvZ/cuDCP/38rRPYUvZFPkgwB+TFwx9CUcF0Rrc6CxikinYRSo8JLeozSM4
 nZuR/iudhktaOl9035RVAB1bWwE2aNPKQ68RqJ2moK7wErajVDa2W4KsVdgnxqATvPsH
 qesyy7x4S9n/tF5N6LU7GbCS2rAPfNYR31ArlBn5YdLYdyd3k5GY0UvtN38CEeWqksWS
 +2t76vzN9kETK9E65XfknlmpGtSxnX4uN06GS+Mm362bhgkQ8lrobYQdvP4612iOYdmD
 jaBuIkEgTga2SwFSc3gNmg9/eFJxTUGf+egOJ+Qm16Pdufzuscb9EXB7pVV8KRmOL+zM
 OSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=44JkQ0xk/m6YNhH3hVjpFztigV1A13fyXiwxKi+U+Xc=;
 b=i20g3NQlUmhXVfknVu6zeGcaWgviPvl/MJpUOt1BlxAQ8Q8SXaNfvg3QGW54sFxB/W
 PkMAeZ805lC4jXPQDcEfa+wZ7nm/zaZvSEug0Rnhi5FFRgrCPTLiCkYZ7PdDCzJbFrUz
 A/ghDeI6vPlhJQBKzJ+ShmXUHLtJu+nWdW6ZsE3sYgb5eesdwzhjJTHrelnM8s0xTluc
 BmLhj8KZFVuyJEejTA8cpHAfw7LN/7bFI7/adPM6aMocExKHyTVDEEpKs2XSBKxVSK+O
 NkV9kSQvrPxaM44FBMotctV5fmdQX5iLKTJzMdh69gFeddjAEdlXE4/sxCWhO9bUF2Ba
 lsfw==
X-Gm-Message-State: AOAM5309JxNL4xzJVz7l8jIuG7ho300BjOgArxgHOmjRIcLl5U8NVYXO
 /A6hEQ5oaxRh7JFwr84R+/w=
X-Google-Smtp-Source: ABdhPJyP5LqjnXvH1LhpCFGPDM4Dnp5PmbvsiDx0qDuxmUYG+ysZXqB6qzdfLj9uIk8o7d38xlH5Ng==
X-Received: by 2002:a05:6a00:1356:b029:13e:d13d:a084 with SMTP id
 k22-20020a056a001356b029013ed13da084mr26669802pfu.27.1600342522940; 
 Thu, 17 Sep 2020 04:35:22 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a138sm21128382pfd.19.2020.09.17.04.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 04:35:22 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: krzk@kernel.org,
	joro@8bytes.org
Subject: [RESEND][PATCH 2/2] memory: tegra: Correct num_tlb_lines for tegra210
Date: Thu, 17 Sep 2020 04:31:55 -0700
Message-Id: <20200917113155.13438-3-nicoleotsuka@gmail.com>
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

According to Tegra210 TRM, the default value of TLB_ACTIVE_LINES
field of register MC_SMMU_TLB_CONFIG_0 is 0x30. So num_tlb_lines
should be 48 (0x30) rather than 32 (0x20).

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index 51b537cfa5a7..4fbf8cbc6666 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1074,7 +1074,7 @@ static const struct tegra_smmu_soc tegra210_smmu_soc = {
 	.num_groups = ARRAY_SIZE(tegra210_groups),
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
-	.num_tlb_lines = 32,
+	.num_tlb_lines = 48,
 	.num_asids = 128,
 };
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
