Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959C39EF20
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278866; cv=none; b=KJMUQrM+HrfZfODse7MebiJi8hnbPHRl3ngW3aQORA1gFQRhW5W11xGWTYwha9/sDwA46+3xY/k43b+mCAnm8L1zKf2TLoEOmZZPF5ZrMyMcjRsW8CqYth3jxdIaR7Nm0ifylcJr4tp1eidQCQeoMfk1ajKj6DzKRUVyQvWj6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278866; c=relaxed/simple;
	bh=bbKLUcBLFub1tb5TatUPZPAkNtWF5490OkNoXJdO3Uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8HiptXV+OgREoNbN9fnukJ3me3CIx9gRDqbKZS8QPK7DS8g+3HT2qPfh87sj7ax6WtDEiYbIm7P/fodBd95mUGUOuGFeRn0cvgOZkRj0xS4B1OcKR/vc7nnklo4zBLOSa7RiN/xqoEamZR/QYSeE+z9SxYDHrb1Lxi7Q/XjiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUu03ZOA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUu03ZOA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso2406152f8f.0
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278859; x=1783883659; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDQluHb0hl8HpKdUOUtAwKScA61PoZ6/9MDK96/p22Q=;
        b=gUu03ZOAsX2KAS4Cgi+ClJQbN6hwUuEbJ+tf6iUumWY4LQB2qxjl051DXpVXryTcTJ
         mQ/9BzxiGoPpD269wnL3mx/WS1yT/8SO/+B8iJSFIHzrpxC0tJKaxzWcMkAXEDNZPMUg
         Fg9U3aFKrVAovzDArZ9xacCkDpMMuL7LwMatHpM3wY/5psalqzYUznUYwdkmjqaxizL/
         wZVbqPgwI27wjNiqFB/tR6C2ZdBl4pEnM7oE9YuCt6iTbEtVl/WiradFzVSoAbruEjh7
         pdKKZTebfsmFyHPsJERU2izYan1Vpk1dFRt+UIUq8tAfVRxA31UFo18MrxW4j6IPMrfl
         arzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278859; x=1783883659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zDQluHb0hl8HpKdUOUtAwKScA61PoZ6/9MDK96/p22Q=;
        b=r8mtcbuVd7N6DFJNZ0qRJWXpm+SeFdBa34t1Q0FGG1+KSuzsgVseu5v9yW+hjqeVRu
         F7bU5UFePffb/RjOnwhLZdYeN1jDndv8APQAFEWTB7VOYc0bDwE83QKA5NTZWokB6exm
         wkz0QVO0j6BzfJa/+twARbo4FMpEzSQU1zhgvIShR/J+icXADqvaOpz21nRCI50aILtS
         BtG8hhGvKgGDuK4i6zcuEH4lDJ5HLQrGD0+m39AOxPSHQLLqTqefhC3pndl/SuWRkYiu
         a32EolulLMvkZcbyjZYVMmKFsbTm7jugDM+l5SL0eGAiPpiw59cKG/k+B5JoDbW4thx9
         CKkw==
X-Gm-Message-State: AOJu0YzEVCJZAejzFHGxot9v5KwVy/1RYFHvy4+AYwu4Li+8INTN4Y+1
	1PdPl+QUw2j3Q+NWJYywc5LtXJw4jTvITHXoRCIQO7piSh+SR18II8I=
X-Gm-Gg: AfdE7ckW7BqT3RTQh2xN3Wuc2njzaANQEKk9gG2lBfpljrAZRM+29y9DafMd923smVj
	dUfhSvZT7prpVVe+ajGVQ0PkoGpmolyJyGea4cW/UFACxaPYJcy/i0NTv5drhKleoWoIAl2YDq1
	6S7ZyB4CfpopC3KG8BG0Yu2y4yfNwGcRyNDJge50Mx/ZP44/JZEXFJOVm0OYFGMMxCuveA0bYNw
	mu4e9NIGcsSck0KByRuRy0nGIFZxA3H7PnrseBc0d1tUNfIjaKToLcVSVfHzpewgX5SbwsiKHzh
	prthuOxwIcNR4bWD2x04yaQ6U+WKDXQ1SygN8Uhn2HKEzYEIL+KVFKESs4GzjkKdX1DnBfrluEJ
	YbXpk0T2MoJNJtcG9N/5UFx94lhAlvrhB8qfRV+i2vp0AoQzcs5pUJqRaSZfG/lCnNaHMTu0OCW
	geGm7elfqE45rZRAvVCQPL8/mNwtgpGA==
X-Received: by 2002:a05:6000:41e2:b0:46f:ca9:465a with SMTP id ffacd0b85a97d-47aaa60d512mr9236488f8f.21.1783278859133;
        Sun, 05 Jul 2026 12:14:19 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:18 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:37 +0200
Subject: [PATCH RFC 03/13] drm/msm: look for lpac from dts
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=3023;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=bbKLUcBLFub1tb5TatUPZPAkNtWF5490OkNoXJdO3Uk=;
 b=7V8X3RcC17AsLp4EvKV8VBh99CxZsYWbT6DX1+PJ1oeSqvZHrZHxSjd1CzKlfExV5zUSLhrW1
 hjyiu/P/E73CA/bsNLALt50GwglEelh/PKZjB7H/Z0Rc38c39U6bUFN
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

In order to associate the SID used by LPAC to it's own domain and
context bank we need a separate node on the DTS.

Add the code to look up that node on initialization.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_gpu.h           |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f3fc7032fadc..71ce4cbbf27a 100644
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
@@ -1200,6 +1205,20 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
 	gpu->pdev = pdev;
 
+	lpac_node = of_parse_phandle(pdev->dev.of_node, "qcom,lpac", 0);
+	if (lpac_node)
+		gpu->lpac_pdev = of_find_device_by_node(lpac_node);
+	if (gpu->lpac_pdev) {
+		of_dma_configure(&gpu->lpac_pdev->dev, lpac_node, true);
+		platform_set_drvdata(gpu->lpac_pdev, &gpu->lpac_adreno_smmu);
+		if (!device_link_add(&pdev->dev, &gpu->lpac_pdev->dev,
+				     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER))
+			dev_err(&gpu->lpac_pdev->dev, "failed to link to gpu device\n");
+		pm_runtime_enable(&gpu->lpac_pdev->dev);
+	}
+	if (lpac_node)
+		of_node_put(lpac_node);
+
 	/* Only handle the core clock when GMU is not in use (or is absent). */
 	if (adreno_has_gmu_wrapper(adreno_gpu) ||
 	    adreno_has_rgmu(adreno_gpu) ||
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
2.54.0

