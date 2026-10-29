Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282016;
	b=FsWjgoyEW0FKCaXpTFCCt1kZJY7q7jTNGgrPSfdKsVjQF4LWVLkU7RZon/xBod1+1qiC
	 BagxryKqnNDHUPbi/EmWyG+4d30dhyvAOWTY4N8Sm26Z19EFCf/zsypFnphHXGAx9aFVT
	 1ixYtG2C5W2lx3fhsIOzHsAM9oHM9iOasqGWUPQriEUej4wK1zux2UVrwNPe9lGh0t6to
	 r00ZJ1f8ejnMBxhv5EDjUEXWqmrf+7gWtt8pLm1YDXLR9xO6NgGXwwzG49atDoOGSebeF
	 ZhjPRIGpWLhhXkwbEKnYHnmNu/DaNVF3X2mBAiZFYt0vow+8YPkmy+L/Epn4U1ZfKxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=IhFC/E+vn7Ne1GmfoUxjx/snlj06M4a6yUZTElbwzmM=;
	b=CP07ua37tb1Jy84dt8G7zbuKJymroInobTAnEXJOYEnG20Q+8aGl6qDb63dx83b/HdbI
	 K2nx6b8b4dodmb+16nxvXKCg5Zg6OWmFRpkMOYy6drFNmg8Ine4WBFfe2stXUveODTiEx
	 zb+EV9Na8DdwwD92ox1F/5nqEzZ+fKhAxk01/3ZtxxDYlqq7xRdC08ELzMgEwoiutOud2
	 S4eQnY8MJ/O7BtO2f3791dg3VPBnD5VahpBN6yR6YAcRz27pJfxOnJZddltx5tuxYAHRL
	 VcFhaHqPbi3HWL9szoayZ5oSnbzHcB8l9eDAm3yfff4wM/G+WpS0GvvGU6NCJBodRqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpRyw5cq;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB6606A81E
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01FB6606A81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpRyw5cq
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1179934f8f.2
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793282014; x=1793886814; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhFC/E+vn7Ne1GmfoUxjx/snlj06M4a6yUZTElbwzmM=;
        b=HpRyw5cqvIvYwUmcIKics7F05PjRnQUZL0fY+3zutUJ7c47x73QJ8nCUtqR5Z4BvIn
         HLVZ1Y2PuXdUl13onSBf9QYGJqcT0LpLOOK7rWUEVv/ZKozP1hCo6kMWJR1SY70cWGgn
         J0D2RtdA1jDR6oWyc5XNfa+MEXlvu0Zv492fLIXBHTeoF2fThjgXISDw0p7FWIin+uqs
         6yWKBBpEnseOYcwGkrLB9LbyPhDPySE8gz5i5/55RBFIa7/XapOmHeK9aueH+Q7RuLaj
         rWXJoXBjtkHBA2aC/5gXpfrYJG3f1nIi2f6GZSe+Tqx5eIqFM/GPMOpl7yIlf5AFeLZo
         mtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282014; x=1793886814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhFC/E+vn7Ne1GmfoUxjx/snlj06M4a6yUZTElbwzmM=;
        b=JBH+A5GqzjAmXb+4AAcYbKVF9VLUMaAkYApauwGxIScHZNbSjD8aUaRXUGb+3LJOon
         FxO1H6mVv7e/mGMfJrn+MgJZseA3vrSM2xN9JCjuxkwvkZwM3K0JtEC60qYAltDJO3IM
         wyp+kGp4ZHz7LqGgFj/yWGSsLUJjqXSiKr/mhydSWR+qpTakdzofpqgMMhlrV62Kq0bu
         p47SDtfLP+GB0pLEXAqFIkHfrHyoOiwkxSR4xaKrwqyCZL0h2Oq3hxRmQYwvhpLtXigY
         kG9zpWtzgjkCkN9VAkIhdeLFev+G/Y+8GxmjFLwYhZN89q0A6CI+eDur0QORqPIm68Fe
         7ZRg==
X-Gm-Message-State: AFq9FYKXHhWlSa5zrZo1VSemD8vGVk/Cn17BQ9FwQ+9OzdCWON+fF9ht
	Pa9D47rFD/JR2Vx0KvCmP8AS/+3jGdf+ZLKc39b+X5Uzpv8l1NIsdPU=
X-Gm-Gg: AYBFou1jE2/xLZ9lHoFkqZhiSYLfyRbOq9l0EA2ftxnVF5LCAjbluYSZ3zDbgT/fI0i
	O4OtLDCdmBoKkC4MOChziLLaxBC6pcHXLkrZ/iYxcI0RzeuMVROlsQAQXSuRYmmTwSnsjqTp9qa
	ftNc1sFs42r9exEWm4IK+O2baWFLZMf/2muukTZtraeLHiKkfpsk7WPPsOwKBqVQ60qYYsgb0dY
	s843xItfU2THoUY/+mt+uTReaXWHQ8uCj4IEauEwQnFGHGIyo3OkVdndBjyzYy4JMSQIqmH4sX3
	OzKjCpHqiK4FNItPtn99W3qtUcU/NPXxU6GLHU/gQlj2wgI6NOQridZ2Hzp7dcwbPj6XZUoiF73
	5ZVr/zrAngk/X/benTDW6ewr8PNuPQ6KdRv/ZrrSIYYJIICmTwywJZOeY/R2Gn3gJVcTvg3Qe+B
	T7KN8tUuQROt5AgroKgMfcrcyHiDFdMcGHGCTjF6DuoQ2c0BkaSpAm/57spvGYV9onJ0dMeUViW
	0TWNbTf6D33XiK+yGQz5DJ0mQ8snYJ3wabmfjiXeB8jtlhXkgpLU9wC/7IAzYejNwJ34w9Ywhn6
	umbnZ40my2O3uodS8LGIjXha0X8WkSmV8L13rdH2BeVFZA==
X-Received: by 2002:adf:f491:0:b0:48e:1421:ed49 with SMTP id ffacd0b85a97d-48e5d5909aamr9182569f8f.18.1793282014126;
        Thu, 29 Oct 2026 06:53:34 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:33 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:50 +0100
Subject: [PATCH RFC v2 13/14] drm/msm: gate lpac behind modparam
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
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-13-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=1928;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=ZEwODnTsRSIiQzAvYlWfm8pmWhNZkrTmOspw3E7UZvA=;
 b=Z9dhvvnQgx4S38zM+b46UTdfg9SThPOIVSdAoOz7EGATYLcY7dL9exHHWjN9XuX2BOku7wLrT
 FTPWSEv0DrrDpKLv4feGQ8Wj41R/cQfHXOM+Z/TSHsGDJf0un1xYOaN
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Add a mod param to allow initializing and exposing the LPAC ring.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++++
 drivers/gpu/drm/msm/msm_gpu.c              | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 6e2333466d7f..51781a2e8a00 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -30,6 +30,10 @@ static bool skip_gpu;
 MODULE_PARM_DESC(no_gpu, "Disable GPU driver register (0=enable GPU driver register (default), 1=skip GPU driver register");
 module_param(skip_gpu, bool, 0400);
 
+int enable_lpac = 0;
+MODULE_PARM_DESC(enable_lpac, "Enable LPAC (A7xx+ only) (1=on , 0=disable, -1=auto (default))");
+module_param(enable_lpac, int, 0600);
+
 extern const struct adreno_gpulist a2xx_gpulist;
 extern const struct adreno_gpulist a3xx_gpulist;
 extern const struct adreno_gpulist a4xx_gpulist;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 4244d9324cda..f6927c797fa5 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -889,6 +889,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		const char *name, struct msm_gpu_config *config)
 {
 	struct msm_drm_private *priv = drm->dev_private;
+	extern int enable_lpac;
 	int i, ret, nr_rings = config->nr_rings;
 	void *memptrs;
 	uint64_t memptrs_iova;
@@ -1012,7 +1013,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		memptrs_iova += sizeof(struct msm_rbmemptrs);
 	}
 
-	if (config->has_lpac) {
+	if (config->has_lpac && enable_lpac != 0) {
 		gpu->lpac_rb = msm_ringbuffer_new(gpu, nr_rings, memptrs, memptrs_iova);
 
 		if (IS_ERR(gpu->lpac_rb)) {

-- 
2.56.0

