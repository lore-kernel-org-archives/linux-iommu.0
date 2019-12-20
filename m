Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00814C43603
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA012465E
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVabQMVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA012465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9AD5924A75;
	Fri, 20 Dec 2019 00:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id arjL06agGA6H; Fri, 20 Dec 2019 00:32:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0976E20426;
	Fri, 20 Dec 2019 00:32:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCD82C1D83;
	Fri, 20 Dec 2019 00:32:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 321ADC077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1AFAD24991
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p9nnAk5NW0Wx for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 00:32:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 7689920426
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:32 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id p9so3321929plk.9
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7/Hluy6r2VW8M5PHO8z1hcbWtjMcwj/79LYueYPEReY=;
 b=bVabQMVqnaD1wxYaqbc41uMz1hUBO6Y6CTs8bokHeGCAwwt5Zcp7i3fptcZFlK/iwB
 dbVyVoiXdVOH81rG1Uz/+dTwvngouWGqQqUrCu7VSbFH8BdyIXalmtC4kj8HvLNmjt3L
 VC+HLZkHFViqlmPjws24dF8llKxYYOHG1i5iyecaLfMm3mkFFdyFWLXhoLlIi0XtAOEN
 /GvheGWlmXZNKQNmx2m5CJVzdc8+YExe5DxcDxu4Tt0HxbAZFkPKoeLM0lIyslg2Xqr6
 k/8A4PzPhRUoUU3cR7C+WhgNNrTq2us95DbcrgyMSM/3c2Rf+mppm+pZ+lSMGuVoVson
 suOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7/Hluy6r2VW8M5PHO8z1hcbWtjMcwj/79LYueYPEReY=;
 b=DGsplOYRIc1uf3K3IPN3g2sUEi37ZHM0IWH/4MGoEhaif1qwt7YkxSHsqqnpTApdGe
 Eczvl1M3RFIW51V2SP/EnyR327I8PmvJ4Lt0ILm+dMbhfevRAe2glZxILMg9Sg4acM5j
 MdXbz6RomdSiCvLJCPFCWhcNpTUm+t+3RtRYP2B3CVBUqBwc5tSKx0BLWrTHWx6QEPLX
 hOfdHE4oGkSBFzgN8F51gC9PI3EF2XkXvxDG3DQyp1u3PxFJWR7iQ1tqJ7BI7b83OIqh
 h5jrn491FIcV6T7lcdSjwvzXZRtZepS2TaJapnykN/rqXxeWm6zECqcdjhTBKsMhE7D9
 UkTw==
X-Gm-Message-State: APjAAAWVasE0cu1taXOQTTK4c8a+W+p2ZigpPCD2EoIMN6V/vJoOhRpW
 i4oGX2PLopel5KAqh+LAg9E=
X-Google-Smtp-Source: APXvYqyejX7YMmVp34ctzUEmdK5Wj6hSszdLT49vgsiUfowiWDd13bl0Ef/tISxORYtldA5F34R+bg==
X-Received: by 2002:a17:902:aa41:: with SMTP id
 c1mr2608420plr.340.1576801951886; 
 Thu, 19 Dec 2019 16:32:31 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a23sm10145845pfg.82.2019.12.19.16.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 16:32:31 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH 0/4] iommu/tegra-smmu: A set of small fixes
Date: Thu, 19 Dec 2019 16:29:10 -0800
Message-Id: <20191220002914.19043-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

Hi all,

This series of patches are some small fixes for tegra-smmu, mainly
tested Tegra210 with downstream kernel. As we only enabled limited
clients for Tegra210 on mainline tree, I am not sure how critical
these fixes are, so not CCing stable tree.

Nicolin Chen (4):
  memory: tegra: Correct reset value of xusb_hostr
  iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
  iommu/tegra-smmu: Fix iova->phy translation
  iommu/tegra-smmu: Prevent race condition between map and unmap

 drivers/iommu/tegra-smmu.c      | 29 ++++++++++++++++++++++++-----
 drivers/memory/tegra/tegra210.c |  2 +-
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
