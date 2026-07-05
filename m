Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118533A7D82
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278883; cv=none; b=MxpJPdbrJu569oW3F01DVv7TjZATCNaSUl5xb6W0GbhZG+R+YPjBC50xM1PoJ0iN4r0y7uAR+wOrouTP4b9jxrMmrK1VfVsQcnv+9EYBBASe+Sb3CvGHi4BjgPjQvUACuI+z1DjLBoblxmA4ZVKlilJhNQHVjN5cqCKFQuXcZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278883; c=relaxed/simple;
	bh=wmCqgt9bbc7y6girDLeQUG/lasgVe98klmVzcoHOM/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SS9HUvrqphaKmyu+b/xcirpe3NVqJkJ/F77rKg/JId9hXjR8+vTGPkNK23pinLf2BmCFsSRQMKoK7TO+iGe6WzTrg0hAlLbx9Pq/6JVTcwBtn7IXXhkjjzs+bGcz1EuSec0N/vLFBeanTzLdlj3lLcimoFBiKNmwPD/mRIWXmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV03w9Hu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV03w9Hu"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c733f15aso23263335e9.0
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278879; x=1783883679; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8zcaiL31SCCh1YPdlPY6GbxJWdviTylW/ogJ//b4zE=;
        b=VV03w9Hu+XOC1ZoYdF7hXSKwNf6a5eUAzaIYqlhP61YvsPemMScMtiJff8kWFH5G8J
         O8TL1/J0r1eu0uggLoKwcHeuFQQdzRnsfLaUVStLEf7h/ER6j/04e8efctLwKUNJR+0O
         IVFUUT9upvEYDANTUIK1q1x6pvSM+cWdWd3k4KYWFbChjrCIADmLYRRQdJrG1nL+8OYm
         lrMxhqiP++q0Lq+OvTBVUoBegysowE4dbqKF6gwyNkYxmBUORbFBXhVki9O7P+G5WTcA
         a6/Qb57nwbnt4+Pu3ANZMZu5HCMaRfR1njG8dQLbg112CSRZFuGD/THKyVW3ytumeoan
         ysEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278879; x=1783883679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C8zcaiL31SCCh1YPdlPY6GbxJWdviTylW/ogJ//b4zE=;
        b=NiazePJvv4Vh0Jj8m5vW/em46j0DN++H2xFttTV8TjvryBYjKUssxrztKOcBStB1Xm
         INRA6DaB1SLOYKhKn7KvdRnrcyhZrBGhA7jTp6u1L42O7F3Ivt3RfqGmxI2XZzDEzCLw
         qepv2PYeTOe3dqh0JB/47fi/d432ft26j84ZPSQD7ouqfdEkUmScFEikCXVw74aNoDG3
         cSrH8vmXK/vLU+CuQ7nixs/Ydri9NqstKYp5JUpVtj0S4Ofe4P2whlJZaCwdKZMbXkhH
         2TP6A+iwI5CeZE+oIap6qUZwkgjH2HPzz1atrThm23nHxQrZRBYdXcrMTn54MrYYanOQ
         tgvQ==
X-Gm-Message-State: AOJu0Yx/4wsGF3wFdE3919nsZnXEgHfyqeClHik6/Y7caJC3cYJSYgof
	rZF8sL3SQYfc0N6AYn9yJ+Xqingnczra7FDrOXtMXFWq5+Ot8cii2lc=
X-Gm-Gg: AfdE7cnOgaaQMXzVQ8tLe+WnO8ENxzAFRCuPznBVMj3SeveFo90sui/Osu3FbeRtKsU
	3Ep+Ss0j22uqIzWDucv6areIcp3ztOhW2AgSgP6gGzf4vPQIXyO/K39IuahuVrrVN5tmTzGS2qH
	tgCid/9s6zREEQUcKUn0qnS++1zKq5P28wTvRCjnhtR/Xpagd/m/TYvpQL94sQGT3GUy+enjy4g
	qqsA9Hk75DG7R2nVDbrO4QL4KCgykpw4vjAoxEkiGnaGzDXD0a7sX0KatvTWzsUHBVdxzBBUvbj
	bvFMkAh+NLDRWD5DY6tKZ34bz3JnKsGWZDUfxrEG+GwoG68siSv5d8BNCoZkvDhZ+uRg6NKUT9a
	gOUYjv33KTtuwVo2PBdf8M5ZxBoNCVPyScJHEv8jjfkOd6GrjtHRsVg/u4x6LLny+UB1hTnRY/Z
	udPCp+OflCIxgsQzw=
X-Received: by 2002:a05:600c:c16f:b0:492:523f:a3df with SMTP id 5b1f17b1804b1-493d52ac417mr60885215e9.5.1783278878843;
        Sun, 05 Jul 2026 12:14:38 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:38 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:47 +0200
Subject: [PATCH RFC 13/13] drm/msm: add lpac ring to devcoredump
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-13-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=2731;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=wmCqgt9bbc7y6girDLeQUG/lasgVe98klmVzcoHOM/o=;
 b=PVK05TezP6oByIlmJqXX6RCKZc0Sfa+FvqbaJD2D2MNQt18wh5zplyqPzMUoPj4wq2v3x/AHS
 ORhKtsBbYDeCcbFNugaM2rR3PLhNr8TrJkg/x8sEhnkPAzo9vnVPIw+
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Add the LPAC ring state to the devcoredump for debugging.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 19 ++++++++++---------
 drivers/gpu/drm/msm/msm_gpu.h           |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 94dbec9464a4..030bb1aeb7ee 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -782,25 +782,26 @@ int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state)
 
 	ktime_get_real_ts64(&state->time);
 
-	for (i = 0; i < gpu->nr_rings; i++) {
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
+		struct msm_ringbuffer *ring = i < gpu->nr_rings ? gpu->rb[i] : gpu->lpac_rb;
 		int size = 0, j;
 
-		state->ring[i].fence = gpu->rb[i]->memptrs->fence;
-		state->ring[i].iova = gpu->rb[i]->iova;
-		state->ring[i].seqno = gpu->rb[i]->fctx->last_fence;
-		state->ring[i].rptr = get_rptr(adreno_gpu, gpu->rb[i]);
-		state->ring[i].wptr = get_wptr(gpu->rb[i]);
+		state->ring[i].fence = ring->memptrs->fence;
+		state->ring[i].iova = ring->iova;
+		state->ring[i].seqno = ring->fctx->last_fence;
+		state->ring[i].rptr = get_rptr(adreno_gpu, ring);
+		state->ring[i].wptr = get_wptr(ring);
 
 		/* Copy at least 'wptr' dwords of the data */
 		size = state->ring[i].wptr;
 
 		/* After wptr find the last non zero dword to save space */
 		for (j = state->ring[i].wptr; j < MSM_GPU_RINGBUFFER_SZ >> 2; j++)
-			if (gpu->rb[i]->start[j])
+			if (ring->start[j])
 				size = j + 1;
 
 		if (size) {
-			state->ring[i].data = kvmemdup(gpu->rb[i]->start, size << 2, GFP_KERNEL);
+			state->ring[i].data = kvmemdup(ring->start, size << 2, GFP_KERNEL);
 			if (state->ring[i].data)
 				state->ring[i].data_size = size << 2;
 		}
@@ -1001,7 +1002,7 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 
 	drm_puts(p, "ringbuffer:\n");
 
-	for (i = 0; i < gpu->nr_rings; i++) {
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
 		drm_printf(p, "  - id: %d\n", i);
 		drm_printf(p, "    iova: 0x%016llx\n", state->ring[i].iova);
 		drm_printf(p, "    last-fence: %u\n", state->ring[i].seqno);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 263dafeb9652..4fbf0dedc334 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -639,7 +639,7 @@ struct msm_gpu_state {
 		void *data;
 		int data_size;
 		bool encoded;
-	} ring[MSM_GPU_MAX_RINGS];
+	} ring[MSM_GPU_MAX_RINGS+1];
 
 	int nr_registers;
 	u32 *registers;

-- 
2.54.0

