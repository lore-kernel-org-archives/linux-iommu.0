Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34E8C4332F
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A0C61216
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38A0C61216
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EACB6607A1;
	Tue, 14 Sep 2021 01:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QYpf8J5nqR7B; Tue, 14 Sep 2021 01:47:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C39906060F;
	Tue, 14 Sep 2021 01:47:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DFA0C000F;
	Tue, 14 Sep 2021 01:47:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 925CFC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E11B80C3D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZUdwsEnsKXVS for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 01:47:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 941DC80C3B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:31 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id 18so10610303pfh.9
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=wZqHoyadq44npl8Iti+BxptrXlSWbYpcF970LVVeoyc=;
 b=X6j9hu+tKaHtxvWbiO9+nifx3OR+ly2BXHSI8eMNTy5q9sShGeM79vednhO1IYoZe4
 boIbuzhe2kioia/W9WZKr/a6/5CSi6TeXrE21Brb3EWJE7yQJruYU0twe6Je+Qrmp47H
 8JyjQZxAV9sQ1eA+S8wHYtPHcnbAcGWJQz3dFwCHEt+WMsjEPQzLz+QSzF01efusBX0X
 gdev54VoEAb49LbS+h6Fa8vokgP7uCAhH3TNkXxWk3RXZEqhU8s2GhH3uSI6q2rc9jWk
 SkOcclxJTyDeVvuCPcatnrYMRndsdD01+sWJ/1OQ/Kfn1pc8+CQ1W9GISY5RW29FWc0Q
 n/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wZqHoyadq44npl8Iti+BxptrXlSWbYpcF970LVVeoyc=;
 b=4sul6G1zoer6Jvmv2AjbdTYfkeFGObzjPJdX3md8EyhFvUNMvvtJ6C0ZHQH5kKPvV8
 0dWGrqB/xO0GmVPzRGfG/NMqh1PYTiWHUrwvRN2vnq6Qcwl8qZDh2o2wVLD9lTUGsc8J
 VHIN/6tciNITdxZS7iFck5htRuGJJ2lsh6F5ngF+FMFUrjqXu4zGZbyBeczyz1WtX0SY
 Xl2TMMUPVsSQ9/rzRTX3Gbm8DJNRJbcvav36uAy1Rpgu0P+lw/7oC0iFJy6B+kJqPycR
 LOYDP4DlsNmaRdoPDLeW8yWf4XzB8Qf5th6aRXBt3VhoK6h+9EcfbjbLkkr5FSyt0N5G
 GS2w==
X-Gm-Message-State: AOAM532TSMLCaFxpnP/FAfxO/ZozbdyrsL4uZAOrx9UHJ2cfhbYITWsL
 WBErkdz/wWgH1sTPDcK8IpE=
X-Google-Smtp-Source: ABdhPJyR7k/9948k7wHoMhA2p1sY4Jl5beEBsCLL1KcVjdQ+hMH4nAx2veJWCzYMXRPAU6Y9KSMdgw==
X-Received: by 2002:aa7:9056:0:b0:412:444e:f601 with SMTP id
 n22-20020aa79056000000b00412444ef601mr2282788pfo.84.1631584050925; 
 Mon, 13 Sep 2021 18:47:30 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id z11sm8270101pfr.157.2021.09.13.18.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 18:47:30 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v6 0/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Date: Mon, 13 Sep 2021 18:38:52 -0700
Message-Id: <20210914013858.31192-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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

This series of patches adds a new mappings node to debugfs for
tegra-smmu driver. The first five patches are all preparational
changes for PATCH-6, based on Thierry's review feedback against
v5: https://lkml.org/lkml/2021/3/16/447

Changelog
v6:
 * Added PATCH1-3 for better naming conventions
 * Added PATCH4-5 to embed previous struct tegra_smmu_group_debug
   into struct tegra_smmu_group
 * Dropped parentheses at SMMU_PTE_ATTR_SHIFT
 * Dropped swgrp->reg print
 * Replaced ptb_reg contents with as->attr and as->pd_dma
 * Added "index" and "count" in the PD entries for readability
 * Removed Dmitry's Tested-by and Reviewed-by for the big change
   from v5 to v6.
v5: https://lkml.org/lkml/2021/3/15/2473
 * Fixed a typo in commit message
 * Split a long line into two lines
 * Rearranged variable defines by length
 * Added Tested-by and Reviewed-by from Dmitry
v4: https://lkml.org/lkml/2021/3/14/429
 * Changed %d to %u for unsigned variables
 * Fixed print format mismatch warnings on ARM32
v3: https://lkml.org/lkml/2021/3/14/30
 * Fixed PHYS and IOVA print formats
 * Changed variables to unsigned int type
 * Changed the table outputs to be compact
v2: https://lkml.org/lkml/2021/3/9/1382
 * Expanded mutex range to the entire function
 * Added as->lock to protect pagetable walkthrough
 * Replaced devm_kzalloc with devm_kcalloc for group_debug
 * Added "PTE RANGE" and "SIZE" columns to group contiguous mappings
 * Dropped as->count check
 * Added WARN_ON when as->count mismatches pd[pd_index]
v1: https://lkml.org/lkml/2020/9/26/70

Nicolin Chen (6):
  iommu/tegra-smmu: Rename struct iommu_group *group to *grp
  iommu/tegra-smmu: Rename struct tegra_smmu_group_soc *soc to
    *group_soc
  iommu/tegra-smmu: Rename struct tegra_smmu_swgroup *group to *swgrp
  iommu/tegra-smmu: Use swgrp pointer instead of swgroup id
  iommu/tegra-smmu: Attach as pointer to tegra_smmu_group
  iommu/tegra-smmu: Add pagetable mappings to debugfs

 drivers/iommu/tegra-smmu.c | 312 +++++++++++++++++++++++++++++++------
 1 file changed, 262 insertions(+), 50 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
