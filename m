Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281994;
	b=MyTZmsSGCSV2sCww5vNF4QTD1cLdOWGGRjuqAo8QEy1Q0LOShNF+ZuZKpMECP7eu9gID
	 CSVHmL6uJQ8q5ExAPEGKjnXZPl4OwkErmPGn2N7gwI6YU82hZqyhFNX9ObqBId80wArSW
	 BU14xtiCsIbwcklt8WtQir2G8Qmux6UHclBiz2OG9Y+g8qWxaqcKHMGUeWXDWGOij3KgP
	 jxk/OYllW/xV8FUMhdnVnEE0mCBRrqUQJ9JhedXE0N53Ekmos8cUQY6rfhTqYT0PBKOqz
	 AgKON7F7Z4yVBCuI4DZxANsUBtuYgaUJzNi7rBZ8AMW3trZk6BAqp4ggX4mTUVmPhzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=T/SMmhEanFf2ZRlLzrXMdAPzQTHRLaYYpOnEMjr9oaE=;
	b=ZZ7vYeJDOtKaP5W/4TPJtPVDA8HraKUwdp/0UrMQw5yWBaA6fTPobWKyX/wrL4xjHL2S
	 Dm59nCn2njwfnzXMllxX3jNZJKbH7ROZPG0yb+tkoCn2UlxSzBWDlZuId9hdvIx0ZEhPm
	 gpnXULLvGPYuQEMpYdS1rg3eGQ1QxQ2G4/34d1IZ79so6vgMMibIzq79DYmdE8KE0/kOR
	 AvABwKEOHeCc0Ih/Bl5V7eEesmGEAfCRvoZ+gzafS2sEnQtdv1Y3NwEkwevKHiT6iTEqJ
	 QNHphV/dHckqnL9jI3j09rufyB6rMXpVe77VitKe8qGmN4mfZQb5vbtHeGVwKIvhJhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n65eLrbC;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32760A381A
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A32760A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n65eLrbC
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48df8fe8513so1810024f8f.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793281991; x=1793886791; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/SMmhEanFf2ZRlLzrXMdAPzQTHRLaYYpOnEMjr9oaE=;
        b=n65eLrbCY0sZY5HJg5GxrqTSyy2QoeqX1BH24tfmvXjgOzYWhyEwcj9bPWiHmtypy0
         /qmU9qepueGwRagUXnihIvIEQbhys+krrzKVtuQT/+WnU6VI4GyGeMwd/ei835XcRQuo
         WnY+I2RJTZOZPLh/Tw7ekOTS+lCaP9Pk8Pwm5mQAoUNdZ354ZPLjWX2jNmuciukEJ2Gu
         YrUToyR1TEcKnmGhAB2Nzc4Zx+Od6+NWWYLM3Bvd3GVIUqQme4BAT9Nu8Fmbd1nrmWsh
         /CR+0Sk4K4zdHA6eEWG0mX2Na27fzllLN7/XY0U4getjStqga88VajvrLtXCYqCIGYXT
         77eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281991; x=1793886791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/SMmhEanFf2ZRlLzrXMdAPzQTHRLaYYpOnEMjr9oaE=;
        b=qUyyPEVf93m/s3vNP1y+4WV99GBrAqgcJ7WdEFGECz+3Dae1YZe0WAICykC+pgrlC4
         wgm98ozEyTsv0ziKsqX9shKAaZat7JJaz7Dox+OfyFUipLGBcsaNBCUSWprJWy+Suv+T
         47TRNO380ixvNL7tGVLazzJcrg0fDtAllNPx9kUlstBQPxw6fqCL46ojHnd4pZq+ayhU
         PLUJjxr2uN6rTB1oD150PGmF/Z729hVS95ob7Zwz3eDB7EHsUCoFtfSwRkLHO4sintzj
         t9nIoelp4DdU5yR04Q5xXkeogNgn9ZvFNyAdWNYX1ZKRnqKmjMXVOxbzAvxX18FM8cyD
         l2ww==
X-Gm-Message-State: AFq9FYIr1+Z25sq4XyMzoZRgE9saKfseWeCjaNP0OZElb32kYOyE/78R
	N5QP01ZoxJxPweZf4y5syLRK//l27YIPT4BCjjPd4xNwurlYvN2kKjU=
X-Gm-Gg: AYBFou0mJtWX2pxKlfhFiPjXBQ0lm50a0Cx0UJjYC0/i+XapuAS4gWL6PFEzReCyGqo
	vO8MxPtOZheiNJVj+qOgrNslLFQZ9sFhnooFV9AuBAQKdHjkrMAgTVjx03wJBaXAOHdYOs2ciPd
	UbmQp6kbTTZGEXvPID6IHrknkSS7hf0ebNtt3UzjxVA43zspf1pOjL/dPSmvzIpdCFQ/8Fre/CV
	dEpIGMC1ZqW1cwBSyOfNdajHlDZSij/L+fPykkmbW8K/dy26wm0uw7DnuxW8dD5vN9vO7gvXysq
	RrXd8LFFVwYB8BvzEminLuRMGc6yXXUlTaHB2rHvvLOnkgBVvgiCf7wk0UXRdedWK3CJtFxNq6c
	yoxnNi8VNKubOMAzZ+W4naarHikIpTKY7qrUCAkVTuM1gWIBrJA76UJSqQLTdFxmVoF/r03i1x1
	SEKHCrEEQX96iWTcW2cWSQGk1iBpNqMH/z0kTMLJ5yGEmdjPWHOX7NwqHzmsIR7lvl3Vnbx1RId
	Yjz+LOrLgNuJSSNNEhQaJKJvWvonvRMdev+J3bey2px6tPsnUmLsuwDQM7IS1f5XxjiNJDWBmM9
	lfUg2iQbNJ2vKxy4acS5Szc1NHEMJ2rhHPE/D4DucpeILQ==
X-Received: by 2002:a05:6000:989:b0:48b:123e:2f5c with SMTP id ffacd0b85a97d-48e5d2f2222mr13148384f8f.29.1793281991354;
        Thu, 29 Oct 2026 06:53:11 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:10 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:42 +0100
Subject: [PATCH RFC v2 05/14] firmware: qcom: scm: Configure LPAC aperture
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
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-5-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=4016;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=ivUR5Pb7Po44Alwx0ZT6ubl1ZzDqmOPjsdTHTPY8+aE=;
 b=CzZBZhvXfsPR7VJKCtyL4sntORzIwyrw5dpz/xoNsZ5uORTwXp8jhcD9HDV0cCBFD+qYUv+9N
 gi7Oj1wgVHTBJ0bjH6egCOnjdXcy2F6zKpvCrmki17UM3EuffiJgPc1
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

In order to be able to update the SMMU registers from CP for page table
updates we need to configure the LPAC aperture to include the context
bank that will be associated with SID 1.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/firmware/qcom/qcom_scm.c        | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  6 ++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
 include/linux/firmware/qcom/qcom_scm.h  |  1 +
 4 files changed, 26 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 9b06a69d3a6d..92093399f20d 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1204,6 +1204,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg);
 
 #define QCOM_SCM_CP_APERTURE_CONTEXT_MASK	GENMASK(7, 0)
+#define QCOM_SCM_LPAC_APERTURE_CONTEXT_MASK	GENMASK(7, 1)
 
 bool qcom_scm_set_gpu_smmu_aperture_is_available(void)
 {
@@ -1229,6 +1230,23 @@ int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_aperture);
 
+int qcom_scm_set_gpu_smmu_lpac_aperture(unsigned int context_bank)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_CP_SMMU_APERTURE_ID,
+		.arginfo = QCOM_SCM_ARGS(4),
+		.args[0] = 0xffff0000 | (1 << 8 | context_bank),
+		.args[1] = 0xffffffff,
+		.args[2] = 0xffffffff,
+		.args[3] = 0xffffffff,
+		.owner = ARM_SMCCC_OWNER_SIP
+	};
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_lpac_aperture);
+
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 1dedeb19946e..65d34d0cfc38 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -658,6 +658,7 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
 int adreno_hw_init(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	const struct adreno_info *info = adreno_gpu->info;
 	int ret;
 
 	VERB("%s", gpu->name);
@@ -668,6 +669,11 @@ int adreno_hw_init(struct msm_gpu *gpu)
 		ret = qcom_scm_set_gpu_smmu_aperture(0);
 		if (ret)
 			DRM_DEV_ERROR(gpu->dev->dev, "unable to set SMMU aperture: %d\n", ret);
+		if (info->quirks & ADRENO_QUIRK_LPAC) {
+			ret = qcom_scm_set_gpu_smmu_lpac_aperture(1);
+			if (ret)
+				DRM_DEV_ERROR(gpu->dev->dev, "unable to set lpac SMMU aperture: %d\n", ret);
+		}
 	}
 
 	for (int i = 0; i < gpu->nr_rings; i++) {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 1f201322cb6e..ec234a483036 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -64,6 +64,7 @@ enum adreno_family {
 #define ADRENO_QUIRK_4GB_VA			BIT(6)
 #define ADRENO_QUIRK_IFPC			BIT(7)
 #define ADRENO_QUIRK_SOFTFUSE			BIT(8)
+#define ADRENO_QUIRK_LPAC			BIT(9)
 
 /* Helper for formating the chip_id in the way that userspace tools like
  * crashdec expect.
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 5747bd191bf1..70fb93e303e2 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -100,6 +100,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
 bool qcom_scm_restore_sec_cfg_available(void);
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
 int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank);
+int qcom_scm_set_gpu_smmu_lpac_aperture(unsigned int context_bank);
 bool qcom_scm_set_gpu_smmu_aperture_is_available(void);
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);

-- 
2.56.0

