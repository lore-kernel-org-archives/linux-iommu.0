Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281987;
	b=lL1QLiK2FpwdAnVCHGo5jg4nTertZ9HRSDmXLJWuAs58fuxbLZSQ5Gq5sZvSEbmXm7nl
	 k+FADh3kLplzoLPsRVDluMr9I9vuNPA+N5v3D0vFHnIxyAe0G1heBPd9a3SoiJ1HQvhhd
	 es8pXR6+C35QT01rkrRU3D4WW5hMmsZXn8OOlHekB6n1SVUYSbAVJ1I2vpH3frabCJjmM
	 nMeJBnqNRRkJ1hHeEuqWbzRxJsdDsYDy01SEL8knC7WW1xNr17a2yGZ8N8MOWN+eGkZ0I
	 bf9niHYbdfpSP1+cR3Kv0MkOfoFbdwGt1Y5WXoWsgpfAPPDRGoNiQiYo9I5YQXeSJIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=gaJ4+9mmPD4lBBlHsni916fB1brqPSLNtulQU+Q8NCs=;
	b=ufDtG8LaiNuNHJL4GTLIgEwCypWWg72KmVDJPc3nrwwNjrK3mbg1tiL0J2M9rJwAHHh2
	 wzVacCod2AgFvPnfosx5VKVSJytl8CONFqVbTY1BuK8e32n0m1kP1yNfiL+1CRreajfQW
	 nrAx7OSdCCOyaGqr3PlPA+ekiEJbJYhBcMiHNLz5NfHcSLg2FpnZzC5J3Msz3jqk3W5na
	 kBmPzEtpBIpNI34XR6cZEDln1DaUoa4w3XvbFidAGaryuZGaDP/4FhM2iJvgvBEU4R1Sc
	 iVs5CJC8Px2cnzsT2PKISQlknj0Ej3EfjVEcngUSUHWpBnfILtqLg2F54R10ANEyzrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=notnJA4n;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5460A261A
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C5460A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=notnJA4n
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so14485825e9.2
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793281986; x=1793886786; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gaJ4+9mmPD4lBBlHsni916fB1brqPSLNtulQU+Q8NCs=;
        b=notnJA4n1gXvSEioxCg81FlljYaR9/gFl8aYvkROuvSg+DHSS4toQX4SW0kjRTn5og
         kicqldyXyq27WqnNuUTLNQB1twqGEZerifDEpUTQszW7FDACOEKbt0SVFpnubNyikhGD
         4cJeonWUe2X0act/Ruj41nU0WHtUcggYq40MalY3vP6bIrjRC4xP0XMyg/pRgk++LsMj
         KChM+yaXNP5uQyybVEaTbsrXm70eeWNF8FlLoeV1OUhuFN5vlolLN1rhUdyiZWp6Y384
         iWAtBiosLlMvHlaN0oAdnKlOo207nxvc1XHHpEEc655MNKV4yiQ2hByP29JA/VLeCGVG
         Bxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281986; x=1793886786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaJ4+9mmPD4lBBlHsni916fB1brqPSLNtulQU+Q8NCs=;
        b=OEo2zU+T7dNfYTr3Z/rGdQZ8Sx0S6t1TvLQA7dUSGc6AxpA9EQVQTJpIvnw3yvz6i6
         NMzh1WdSb0aNMlTutykZ0qq/VXu9e+tHYqgbuzqPHcLJXJh4kjq9a7WAXsNaYxeFY9b/
         K0e3bkOWqaqudOS2u+NaFLY3C6CayJwMrhd/vq1AmcdTSbPs3dlhdAP69fkC62/fecEF
         efGmD17xp2nLZxXlzJIZMVsF5EYGh01hBY+ineDF16bPW+CQa6yxPsQYRVY2FxA7Jfho
         q1MC6KHmca3t6GQot4uw4kN1Fvxou7pwGS89X+c6zsE+CUHjBKiMQe549lWI4dTWSs2Z
         MFqA==
X-Gm-Message-State: AFq9FYKbPX7iDx7dh5JqXy0SHalav3od7dQtTA4nOeyoqXb5GmD3eO/f
	pBdvmf6xgIcGu1bh4XOUrUw7N+6XAEqXUTZKjKaOlpS5BnHdCBa//fw=
X-Gm-Gg: AYBFou3EHWb836zgtz9Bc7Y96ncgqQvNV7yvM45SvkChvUxqVwxuDLnAQJxX4/39+AQ
	eLEL7cUG+ANO3IXlwxQFA6AwlAsUt+5Qh1+t79svynZKqwLff2aCyyo9HTbcfi5PBorxVGt0GWT
	Um71ntYut/ZYKO2Z6NFdm6TPcFXiGXihrwz/LzgQB89+z9IOyjI7SvoOuMSJUk0BYwL/m0q9ygY
	cSCeoQt0Lcf+QuUlEDj/VdrA2tIjK+/lXJI7hTVMbw1gsg/aG/DFgMQS+UIkFGTRlz7Q6bPKZ3/
	FVJ5td6+yqROmj3GHdGbKUciQ+n1fwZe0h6zmjxq3NzmZVhB9AOGJDSul53k3L0oA0YvRTVdGeX
	t23wzSrwrvEecDozjTFiYulSFUy8MgnXqoh6b8+cNBq22ITMIoGhKriqOwRUYN6krhP8sKBnmmA
	yp0UIpAHBM1cHTZsh2/I+k2csCo6PYU0d09DmxxtLVsaa+hifeJxGTNAF7dOF7+adMHOZGyU5iO
	o5jS++Fu6iR7Ukzk8Pyt5kKwNkpi0lthSDNiFxTV/aYQKoEdRax84JZ22J6t7c9BV3rVMTi+fzV
	XeXGnzZBBNzxBwgUugUSbBa9pligqRiObrFNFyoo/0JxeA==
X-Received: by 2002:a05:6000:200c:b0:48b:116d:56fb with SMTP id ffacd0b85a97d-48e5d567e85mr13366844f8f.1.1793281985638;
        Thu, 29 Oct 2026 06:53:05 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:05 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:40 +0100
Subject: [PATCH RFC v2 03/14] drm/msm: look for lpac from dts
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-3-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=6436;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=XpQ9AteTwMtLcsxYohB2gJNeRwk7JfV+tvwdBjYtlVM=;
 b=qJvSiqvDD9GrBlIaJ1RKA9o8A4IaM3JohySZtd/JVEOLdgV49X0tKEgfd5R3pjwNDTF4Zh1r/
 nkMzJe2orBYCYxYltUajmFOI3R3Mior3UrbO69vtb5EGuRS9UYNb5Ry
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

In order to associate the SID used by LPAC to it's own domain and
context bank we need a separate node on the DTS.

Add the code to look up that node on initialization.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 10 +++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 36 ++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_gpu.c              |  6 +++++
 drivers/gpu/drm/msm/msm_gpu.h              |  1 +
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7f20320ef66a..4d22223c3323 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -6,6 +6,8 @@
  * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/of_platform.h>
+
 #include "adreno_gpu.h"
 
 bool hang_debug = false;
@@ -271,6 +273,12 @@ static const struct component_ops a3xx_ops = {
 
 static int adreno_probe(struct platform_device *pdev)
 {
+	int ret = 0;
+
+	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+	if (ret)
+		return ret;
+
 	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
 	    msm_gpu_no_components())
 		return msm_gpu_probe(pdev, &a3xx_ops);
@@ -282,6 +290,8 @@ static void adreno_remove(struct platform_device *pdev)
 {
 	struct msm_drm_private *priv = platform_get_drvdata(pdev);
 
+	of_platform_depopulate(&pdev->dev);
+
 	if (priv->kms_init)
 		component_del(&pdev->dev, &a3xx_ops);
 	else
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f3fc7032fadc..1dedeb19946e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -11,6 +11,8 @@
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/kernel.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -201,7 +203,9 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
 	struct drm_gpuvm *vm;
 	u64 start, size;
 
-	mmu = msm_iommu_gpu_new(&pdev->dev, NULL, gpu, quirks);
+	mmu = msm_iommu_gpu_new(&pdev->dev,
+				gpu->lpac_pdev ? &gpu->lpac_pdev->dev : NULL,
+				gpu, quirks);
 	if (IS_ERR(mmu))
 		return ERR_CAST(mmu);
 
@@ -1187,6 +1191,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		const struct adreno_gpu_funcs *funcs, int nr_rings)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *lpac_node;
 	struct adreno_platform_config *config = dev->platform_data;
 	struct msm_gpu_config adreno_gpu_config  = { 0 };
 	struct msm_gpu *gpu = &adreno_gpu->base;
@@ -1200,6 +1205,18 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
 	gpu->pdev = pdev;
 
+	lpac_node = of_get_compatible_child(pdev->dev.of_node, "qcom,lpac");
+	if (lpac_node)
+		gpu->lpac_pdev = of_find_device_by_node(lpac_node);
+	if (gpu->lpac_pdev) {
+		pm_runtime_enable(&gpu->lpac_pdev->dev);
+		if (!device_link_add(&pdev->dev, &gpu->lpac_pdev->dev,
+				     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER))
+			dev_err(&gpu->lpac_pdev->dev, "failed to link to lpac device\n");
+	}
+	if (lpac_node)
+		of_node_put(lpac_node);
+
 	/* Only handle the core clock when GMU is not in use (or is absent). */
 	if (adreno_has_gmu_wrapper(adreno_gpu) ||
 	    adreno_has_rgmu(adreno_gpu) ||
@@ -1221,8 +1238,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
 			ADRENO_CHIPID_ARGS(config->chip_id));
-	if (!gpu_name)
-		return -ENOMEM;
+	if (!gpu_name) {
+		ret = -ENOMEM;
+		goto err_put_lpac_pdev;
+	}
 
 	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
 
@@ -1230,7 +1249,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	ret = adreno_get_pwrlevels(dev, gpu);
 	if (ret)
-		return ret;
+		goto err_put_lpac_pdev;
 
 	init_completion(&adreno_gpu->fault_coredump_done);
 	complete_all(&adreno_gpu->fault_coredump_done);
@@ -1241,6 +1260,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
 			gpu_name, &adreno_gpu_config);
+err_put_lpac_pdev:
+	if (gpu->lpac_pdev)
+		put_device(&gpu->lpac_pdev->dev);
+	return ret;
 }
 
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
@@ -1256,4 +1279,9 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 		pm_runtime_disable(&priv->gpu_pdev->dev);
 
 	msm_gpu_cleanup(&adreno_gpu->base);
+
+	if (gpu->lpac_pdev) {
+		pm_runtime_disable(&gpu->lpac_pdev->dev);
+		put_device(&gpu->lpac_pdev->dev);
+	}
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 18ed00e5f143..20581be10ca7 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -963,6 +963,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		gpu->gpu_cx = NULL;
 
 	platform_set_drvdata(pdev, &gpu->adreno_smmu);
+	if (gpu->lpac_pdev)
+		platform_set_drvdata(gpu->lpac_pdev, &gpu->lpac_adreno_smmu);
 
 	msm_devfreq_init(gpu);
 
@@ -1032,6 +1034,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);
 
 	platform_set_drvdata(pdev, NULL);
+	if (gpu->lpac_pdev)
+		platform_set_drvdata(gpu->lpac_pdev, NULL);
 	return ret;
 }
 
@@ -1062,4 +1066,6 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 	msm_perfcntr_cleanup(gpu);
 
 	platform_set_drvdata(gpu->pdev, NULL);
+	if (gpu->lpac_pdev)
+		platform_set_drvdata(gpu->lpac_pdev, NULL);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index e2291dfe3ca8..271956e7f870 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -172,6 +172,7 @@ struct msm_gpu {
 	const char *name;
 	struct drm_device *dev;
 	struct platform_device *pdev;
+	struct platform_device *lpac_pdev;
 	const struct msm_gpu_funcs *funcs;
 
 	struct adreno_smmu_priv adreno_smmu;

-- 
2.56.0

