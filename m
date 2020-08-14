Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261E8C433DF
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:42:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1E020768
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk+7Hl6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1E020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C83DB24B99;
	Fri, 14 Aug 2020 02:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k2CxcypV1ETp; Fri, 14 Aug 2020 02:41:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9BA8C203F0;
	Fri, 14 Aug 2020 02:41:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8600AC07FF;
	Fri, 14 Aug 2020 02:41:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 722E5C004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5CAFB2352E
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aFkI+zETmiCK for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 02:41:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 95F18203F0
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:41:57 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id g33so3817852pgb.4
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VoyPgLas/EUNbQEYprU6PB/6pOwjqGOdvclKJYENFWw=;
 b=Kk+7Hl6Efr2M0W6Mr2kvdh1+JooaGtg6CSQiC+Gcx5/7ZdNt7BmbjJ0M+5T4eyx425
 2yhKvw/1ddgLP/60NJWlRRMObazbCLCuG7W7gMZIMnLj4Hng3OxhgDabufSc1J94+Jm8
 L8taiAyktkmHpxXIVuEwZA6fLB5iw5c15XH3InX+W17OBmivv3r1r5pujFUt86pTi7cO
 YvuehJalbVemNc/Q6imgPxuyclmHmcU7Z+sfdXi5gWizE4DHAiaiNTxG5w3znn7KD/3K
 dN+5xLfBX0wM7ezxOR4er8LW6ms0SzJQwIxxg5niHTffidDtkG5vv5EGLCzaVFT+tfLA
 nszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VoyPgLas/EUNbQEYprU6PB/6pOwjqGOdvclKJYENFWw=;
 b=RHwkActEm6ALcNSXwI554tdHQUyK86/zPQ1lHhxnp6Ws8j1sPjHQNWo/M3ZC4uzPZV
 TTa6bItN4TkpAmYzyGtx+4CLGRIBQOgYTMJi28MG6SM8ZNDAwnJl69PGt9eaIk+nfP3W
 0xdnXthXsJ27y1WYHWnBaUriY5r0ITopmIZZ82AjcSOrjl58vr7/GI2Ees4Y4Gn3Dky2
 rK3zpKIDVa6gwPkem3ZZryAIyGPUCoC72AgDXtk1GnZ+qjPRxz2O8NWEfgELZsV9fDpB
 FF2kukWRbOHkmfwnkWzk/gJ8rozkbFDq+bU9SG5JvZpRfQ4HKu5FVpCNUwP8kHwoGv60
 wiAw==
X-Gm-Message-State: AOAM531Kf6Yx4jEC/RGShNwndpmib2M2O55UG/+i9+iqppluX//E0V5z
 4jfqHp3pxqpNbyWPtAZxheK68Ac1YvYRRA==
X-Google-Smtp-Source: ABdhPJzS8EmHYdaB4TYgGRibn6tgMJWztb3cFYLHYX0JcSr4cvye2A6xSCFod3AzMIOFbAejJk6H4Q==
X-Received: by 2002:aa7:8514:: with SMTP id v20mr304938pfn.18.1597372917143;
 Thu, 13 Aug 2020 19:41:57 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id g5sm7254311pfh.168.2020.08.13.19.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 19:41:55 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 13/19] drm/msm: Set the global virtual address range from the
 IOMMU domain
Date: Thu, 13 Aug 2020 19:41:08 -0700
Message-Id: <20200814024114.1177553-14-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200810222657.1841322-1-jcrouse@codeaurora.org>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Shawn Guo <shawn.guo@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sean Paul <sean@poorly.run>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 Brian Masney <masneyb@onstation.org>
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

Use the aperture settings from the IOMMU domain to set up the virtual
address range for the GPU. This allows us to transparently deal with
IOMMU side features (like split pagetables).

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 13 +++++++++++--
 drivers/gpu/drm/msm/msm_iommu.c         |  7 +++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 533a34b4cce2..34e6242c1767 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -192,9 +192,18 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
 	struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
 	struct msm_mmu *mmu = msm_iommu_new(&pdev->dev, iommu);
 	struct msm_gem_address_space *aspace;
+	u64 start, size;
 
-	aspace = msm_gem_address_space_create(mmu, "gpu", SZ_16M,
-		0xffffffff - SZ_16M);
+	/*
+	 * Use the aperture start or SZ_16M, whichever is greater. This will
+	 * ensure that we align with the allocated pagetable range while still
+	 * allowing room in the lower 32 bits for GMEM and whatnot
+	 */
+	start = max_t(u64, SZ_16M, iommu->geometry.aperture_start);
+	size = iommu->geometry.aperture_end - start + 1;
+
+	aspace = msm_gem_address_space_create(mmu, "gpu",
+		start & GENMASK(48, 0), size);
 
 	if (IS_ERR(aspace) && !IS_ERR(mmu))
 		mmu->funcs->destroy(mmu);
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 3a381a9674c9..1b6635504069 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -36,6 +36,10 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	size_t ret;
 
+	/* The arm-smmu driver expects the addresses to be sign extended */
+	if (iova & BIT_ULL(48))
+		iova |= GENMASK_ULL(63, 49);
+
 	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
 	WARN_ON(!ret);
 
@@ -46,6 +50,9 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t len)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 
+	if (iova & BIT_ULL(48))
+		iova |= GENMASK_ULL(63, 49);
+
 	iommu_unmap(iommu->domain, iova, len);
 
 	return 0;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
