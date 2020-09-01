Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B2AC433E7
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF192078B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb+hIQo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF192078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 043F486B27;
	Tue,  1 Sep 2020 16:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tGa08lg5twZx; Tue,  1 Sep 2020 16:46:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F4D886AB6;
	Tue,  1 Sep 2020 16:46:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59CC6C0052;
	Tue,  1 Sep 2020 16:46:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AACE8C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A68E22152E
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OukBfGYv+fBt for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 16:46:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by silver.osuosl.org (Postfix) with ESMTPS id BC71D214EB
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:46 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id 31so964493pgy.13
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WYTCQC7k5r6oYpQvFiV0f8NKzeE5fQRzSiH1SNa55g4=;
 b=jb+hIQo4YGVb49rppc+dz9dcrA81hb6Q9w9XfGZU/rRy8WtQYB/H8RhxPhMl8lqvhk
 CnBPmZFZbAvKQlYIDdQGuyQtrXI1jApM7UWplLCzVbN1kOCNwE7oE+6N8kOR6ZLtGfFB
 sknqzo82iFq43GlBXKj6Sp0t5wuqY3/XgCp7ppDbOyKD+z982LP5FC1AITsiBGUyw+fk
 KTczjYdilU1eyDT1SxjdLrKVuDjTJ0Ee0DLkZLdRnXdWKfeaIntbNUKsH4qq0U0TGpDk
 +TYEo7M7WXQHWrLSe6grt+buv5rj4jfYOqvKGlk0z6Hh3Tt5cvLwkjKy7cCz3GoeJYOP
 ACKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WYTCQC7k5r6oYpQvFiV0f8NKzeE5fQRzSiH1SNa55g4=;
 b=a7klT0RqQXeFhrbrNMe2yMg2grItAJp9/zD5Fuo3Lw1o1stqtMGk9w1hCSXoqtjIgH
 yUmbR2nh1SHCNxWRQZXFxjxc6e9ZDH1C9UlBHT6AF5k6vKS0GHUBdNsA9CUh1+3de0+p
 tMLRjuBK5JENrVOcGZJyOvVg1M2naWSVhTKcU9QGJpuvhNEzchcBFhfQiY2RuSfwP9Oh
 CPPI/1HDfMQThBKi3URgo4C70X3eCYmwsv3WnAzoeGUaT4iUIgOWFYatSHG44ybRxAUh
 HTnq4at1bSywTZpO36bWfUhP2A4s35FqCH+vMZPIbGm15yMG0WWPNmCjsw3M3r7IAPO7
 bEHg==
X-Gm-Message-State: AOAM533ISjc8T9JxBhrS7PdzuSForVLzr1HJY9MHnpu+knRX3CQIXz5e
 RZS4DZHSUaBw/bKIH4bMcTA=
X-Google-Smtp-Source: ABdhPJxdpDEnCgSW8zbZaOw6jGWCE36JSntOzr47h8AkVBEnCZ4Nk+OIeewO2v/DiaBr7gpt/Hcl+g==
X-Received: by 2002:a05:6a00:44:: with SMTP id
 i4mr2719453pfk.276.1598978806321; 
 Tue, 01 Sep 2020 09:46:46 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id q5sm2509374pfu.16.2020.09.01.09.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:46:45 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v16 07/20] drm/msm: Set the global virtual address range from
 the IOMMU domain
Date: Tue,  1 Sep 2020 09:46:24 -0700
Message-Id: <20200901164707.2645413-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901164707.2645413-1-robdclark@gmail.com>
References: <20200901164707.2645413-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Takashi Iwai <tiwai@suse.de>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Sean Paul <sean@poorly.run>,
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
