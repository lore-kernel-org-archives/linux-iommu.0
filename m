Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B45C433E2
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EEA20757
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjGHvXUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EEA20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9FBAE875EC;
	Sat,  5 Sep 2020 20:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rwnFUd7uW4yM; Sat,  5 Sep 2020 20:04:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 95D6A875CE;
	Sat,  5 Sep 2020 20:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8364AC07FF;
	Sat,  5 Sep 2020 20:04:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E19FC0051
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 93D1D85F8B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HNopEfK8FORG for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 20:04:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 00B9285F75
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:04:24 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id e33so6095362pgm.0
 for <iommu@lists.linux-foundation.org>; Sat, 05 Sep 2020 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Iw0dHrjTvuCQzC5e/gsNUQGkDUy9ocfveJcatBjwfs=;
 b=QjGHvXUXJ9nOFPLXCsSKoutaw8jE22c5npdiMT8+5I7EobBt6agwiN7rHYED3vK/9l
 R7iNxhwTEcVvZRKsF5b100zHVt8h+eF6TN4HcST2l2as/Z2Ezc02V8/N5ZoBWIbYYdoh
 TV77bcw5cLuGePbrP6NTNgGG7dNpcMgn338v6i5Unr0ThHS2LvAA/y2entZD1lr1kD/x
 pEOtDdGMn6hE8bDxaGm709UsmY2mIiUhpuRK//Fj+nBP0aDkIsK5ymgOTuvS5b06trvT
 5XZSFiNBDyWs9+waj326o+ude45/fYU+pfaPis4xi0H0yrJWn7FII3o+LBf1Sg8pj38f
 r+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6Iw0dHrjTvuCQzC5e/gsNUQGkDUy9ocfveJcatBjwfs=;
 b=JLJVyUNfHJsFlRSPV11NJqz5+vVNm3Btch7GqDElBL3imwfIqtO1rDUnAcc8RrbsZm
 xBcSIaZH76Z/7LpcS8j1d1VwBzFexx073g9CuQ//5hsMBFRk5iXFlWhgSIZ2gazT7J29
 0Uc54IDlzks3zOhqBksYbQI5/oCfUWIhU+yruhRi23gB05MdXegW3Q8u54yG8jhU031x
 sZ9Xr2GBGf0X7v2K+6UkXw6kvwvczJR1JQXZ000HrJQd6AY3RAZbTNOoiyjyrXivLVi5
 GiuIxA9PZ4kMRNH1vYFAA8TzDSH+09DO7q8zmeTFu84Vrw4Jf5dGaj5C4kf8H5y6/HxA
 4gxw==
X-Gm-Message-State: AOAM531OGv2MPYu7DdvZHsY9n1wOWYqyZGtekuzWZL99/l1l5LUWFHzi
 +k8I2i9UNGpv1GTuqCKxCd557Ib2hvU4JMVSa70=
X-Google-Smtp-Source: ABdhPJwA906n2s8az97kUmTej4LoK6ZyRxudC/BY/FsdmgjsN2Waiw224CFDRRMz5qg/zJr43MtwAQ==
X-Received: by 2002:aa7:93a8:0:b029:13c:1611:6534 with SMTP id
 x8-20020aa793a80000b029013c16116534mr12211051pff.6.1599336263849; 
 Sat, 05 Sep 2020 13:04:23 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 19sm8386881pjk.28.2020.09.05.13.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 13:04:22 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v17 07/20] drm/msm: Set the global virtual address range from
 the IOMMU domain
Date: Sat,  5 Sep 2020 13:04:13 -0700
Message-Id: <20200905200454.240929-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905200454.240929-1-robdclark@gmail.com>
References: <20200905200454.240929-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>,
 David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, freedreno@lists.freedesktop.org,
 open list <linux-kernel@vger.kernel.org>, Brian Masney <masneyb@onstation.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 13 +++++++++++--
 drivers/gpu/drm/msm/msm_iommu.c         |  7 +++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index a712e1cfcba8..b703e5308b01 100644
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
