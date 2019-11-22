Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6E9C432C3
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 23:32:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3F420706
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 23:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pn6/wdh/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="St0WpFNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3F420706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7F4E879F8;
	Fri, 22 Nov 2019 23:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QHDtNHhirR0s; Fri, 22 Nov 2019 23:32:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 66F59883D5;
	Fri, 22 Nov 2019 23:32:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54C04C1DD8;
	Fri, 22 Nov 2019 23:32:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D2BEC18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 23:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2706C203DE
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 23:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id agr65-tYtam8 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 23:31:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-18.smtp-out.us-west-2.amazonses.com
 (a27-18.smtp-out.us-west-2.amazonses.com [54.240.27.18])
 by silver.osuosl.org (Postfix) with ESMTPS id 50370261F6
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 23:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574465517;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
 bh=ujD+t6S3GdDVcNP4xWAN1Vtk6wbhhHyNGHYlJn0JQRA=;
 b=Pn6/wdh/dO7YIt3wtIyUDhM0skshVVFSsY2vYHqvVps5XplTEqJOuTiPoNlcpzen
 PypNmCZjNpunJrFUQYga7Rb54axz2MhbsIppSt9hUG+7nVbraytiO6hU2W7UENZkWb2
 2fbD1Z2mJx9mksIBMPSMtU8nESguhFPZytBpCJRo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574465517;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
 bh=ujD+t6S3GdDVcNP4xWAN1Vtk6wbhhHyNGHYlJn0JQRA=;
 b=St0WpFNAdcFyEh7he4nTKi0VPN0yfpUwQm8AeEmw79hiqV7zGBqgptttRBTdLSj0
 cjZbxWPLmH6fKtHMESfjP13jJWVkf2oj+yaC4wlwz64QUQ1h7X1PkzqkEuk7wWibAce
 y/y8JeVaRLBNGPiniAVsKWRmIFc53UKnAUD3PJbQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2E06C76F4D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 5/8] drm/msm: Attach the IOMMU device during initialization
Date: Fri, 22 Nov 2019 23:31:57 +0000
Message-ID: <0101016e957537cb-b5164f4d-0f0d-4de9-abe6-6e5c060d7019-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
References: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
X-SES-Outgoing: 2019.11.22-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Cc: freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jonathan Marek <jonathan@marek.ca>, Sam Ravnborg <sam@ravnborg.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, David Airlie <airlied@linux.ie>,
 Sean Paul <sean@poorly.run>, robin.murphy@arm.com,
 dri-devel@lists.freedesktop.org, Georgi Djakov <georgi.djakov@linaro.org>,
 Bruce Wang <bzwang@chromium.org>, Mamta Shukla <mamtashukla555@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
 Drew Davenport <ddavenport@chromium.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, will@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
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

Everywhere an IOMMU object is created by msm_gpu_create_address_space
the IOMMU device is attached immediately after. Instead of carrying around
the infrastructure to do the attach from the device specific code do it
directly in the msm_iommu_init() function. This gets it out of the way for
more aggressive cleanups that follow.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  8 --------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c |  4 ----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  7 -------
 drivers/gpu/drm/msm/msm_gem_vma.c        | 23 +++++++++++++++++++----
 drivers/gpu/drm/msm/msm_gpu.c            | 11 +----------
 drivers/gpu/drm/msm/msm_gpummu.c         |  6 ------
 drivers/gpu/drm/msm/msm_iommu.c          | 15 +++++++--------
 drivers/gpu/drm/msm/msm_mmu.h            |  1 -
 8 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 6c92f0f..b082b23 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -704,7 +704,6 @@ static int _dpu_kms_mmu_init(struct dpu_kms *dpu_kms)
 {
 	struct iommu_domain *domain;
 	struct msm_gem_address_space *aspace;
-	int ret;
 
 	domain = iommu_domain_alloc(&platform_bus_type);
 	if (!domain)
@@ -720,13 +719,6 @@ static int _dpu_kms_mmu_init(struct dpu_kms *dpu_kms)
 		return PTR_ERR(aspace);
 	}
 
-	ret = aspace->mmu->funcs->attach(aspace->mmu);
-	if (ret) {
-		DPU_ERROR("failed to attach iommu %d\n", ret);
-		msm_gem_address_space_put(aspace);
-		return ret;
-	}
-
 	dpu_kms->base.aspace = aspace;
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index dda0543..9dba37c 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -518,10 +518,6 @@ struct msm_kms *mdp4_kms_init(struct drm_device *dev)
 		}
 
 		kms->aspace = aspace;
-
-		ret = aspace->mmu->funcs->attach(aspace->mmu);
-		if (ret)
-			goto fail;
 	} else {
 		DRM_DEV_INFO(dev->dev, "no iommu, fallback to phys "
 				"contig buffers for scanout\n");
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index e43ecd4..653dab2 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -736,13 +736,6 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
 		}
 
 		kms->aspace = aspace;
-
-		ret = aspace->mmu->funcs->attach(aspace->mmu);
-		if (ret) {
-			DRM_DEV_ERROR(&pdev->dev, "failed to attach iommu: %d\n",
-				ret);
-			goto fail;
-		}
 	} else {
 		DRM_DEV_INFO(&pdev->dev,
 			 "no iommu, fallback to phys contig buffers for scanout\n");
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 1af5354..91d993a 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -131,8 +131,8 @@ msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
 		const char *name)
 {
 	struct msm_gem_address_space *aspace;
-	u64 size = domain->geometry.aperture_end -
-		domain->geometry.aperture_start;
+	u64 start = domain->geometry.aperture_start;
+	u64 size = domain->geometry.aperture_end - start;
 
 	aspace = kzalloc(sizeof(*aspace), GFP_KERNEL);
 	if (!aspace)
@@ -141,9 +141,18 @@ msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
 	spin_lock_init(&aspace->lock);
 	aspace->name = name;
 	aspace->mmu = msm_iommu_new(dev, domain);
+	if (IS_ERR(aspace->mmu)) {
+		int ret = PTR_ERR(aspace->mmu);
 
-	drm_mm_init(&aspace->mm, (domain->geometry.aperture_start >> PAGE_SHIFT),
-		size >> PAGE_SHIFT);
+		kfree(aspace);
+		return ERR_PTR(ret);
+	}
+
+	/*
+	 * Attaching the IOMMU device changes the aperture values so use the
+	 * cached values instead
+	 */
+	drm_mm_init(&aspace->mm, start >> PAGE_SHIFT, size >> PAGE_SHIFT);
 
 	kref_init(&aspace->kref);
 
@@ -164,6 +173,12 @@ msm_gem_address_space_create_a2xx(struct device *dev, struct msm_gpu *gpu,
 	spin_lock_init(&aspace->lock);
 	aspace->name = name;
 	aspace->mmu = msm_gpummu_new(dev, gpu);
+	if (IS_ERR(aspace->mmu)) {
+		int ret = PTR_ERR(aspace->mmu);
+
+		kfree(aspace);
+		return ERR_PTR(ret);
+	}
 
 	drm_mm_init(&aspace->mm, (va_start >> PAGE_SHIFT),
 		size >> PAGE_SHIFT);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 18f3a5c..f7bf80e 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -808,7 +808,6 @@ msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
 		uint64_t va_start, uint64_t va_end)
 {
 	struct msm_gem_address_space *aspace;
-	int ret;
 
 	/*
 	 * Setup IOMMU.. eventually we will (I think) do this once per context
@@ -833,17 +832,9 @@ msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
 			va_start, va_end);
 	}
 
-	if (IS_ERR(aspace)) {
+	if (IS_ERR(aspace))
 		DRM_DEV_ERROR(gpu->dev->dev, "failed to init mmu: %ld\n",
 			PTR_ERR(aspace));
-		return ERR_CAST(aspace);
-	}
-
-	ret = aspace->mmu->funcs->attach(aspace->mmu);
-	if (ret) {
-		msm_gem_address_space_put(aspace);
-		return ERR_PTR(ret);
-	}
 
 	return aspace;
 }
diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
index 34980d8..0ad0f84 100644
--- a/drivers/gpu/drm/msm/msm_gpummu.c
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -21,11 +21,6 @@ struct msm_gpummu {
 #define GPUMMU_PAGE_SIZE SZ_4K
 #define TABLE_SIZE (sizeof(uint32_t) * GPUMMU_VA_RANGE / GPUMMU_PAGE_SIZE)
 
-static int msm_gpummu_attach(struct msm_mmu *mmu)
-{
-	return 0;
-}
-
 static void msm_gpummu_detach(struct msm_mmu *mmu)
 {
 }
@@ -85,7 +80,6 @@ static void msm_gpummu_destroy(struct msm_mmu *mmu)
 }
 
 static const struct msm_mmu_funcs funcs = {
-		.attach = msm_gpummu_attach,
 		.detach = msm_gpummu_detach,
 		.map = msm_gpummu_map,
 		.unmap = msm_gpummu_unmap,
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index ad58cfe..544c519 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -23,13 +23,6 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 	return 0;
 }
 
-static int msm_iommu_attach(struct msm_mmu *mmu)
-{
-	struct msm_iommu *iommu = to_msm_iommu(mmu);
-
-	return iommu_attach_device(iommu->domain, mmu->dev);
-}
-
 static void msm_iommu_detach(struct msm_mmu *mmu)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
@@ -66,7 +59,6 @@ static void msm_iommu_destroy(struct msm_mmu *mmu)
 }
 
 static const struct msm_mmu_funcs funcs = {
-		.attach = msm_iommu_attach,
 		.detach = msm_iommu_detach,
 		.map = msm_iommu_map,
 		.unmap = msm_iommu_unmap,
@@ -76,6 +68,7 @@ static const struct msm_mmu_funcs funcs = {
 struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
 {
 	struct msm_iommu *iommu;
+	int ret;
 
 	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
@@ -85,5 +78,11 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
 	msm_mmu_init(&iommu->base, dev, &funcs);
 	iommu_set_fault_handler(domain, msm_fault_handler, iommu);
 
+	ret = iommu_attach_device(iommu->domain, dev);
+	if (ret) {
+		kfree(iommu);
+		return ERR_PTR(ret);
+	}
+
 	return &iommu->base;
 }
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index 67a623f..bae9e8e 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -10,7 +10,6 @@
 #include <linux/iommu.h>
 
 struct msm_mmu_funcs {
-	int (*attach)(struct msm_mmu *mmu);
 	void (*detach)(struct msm_mmu *mmu);
 	int (*map)(struct msm_mmu *mmu, uint64_t iova, struct sg_table *sgt,
 			unsigned len, int prot);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
