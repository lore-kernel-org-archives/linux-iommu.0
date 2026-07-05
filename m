Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE32D3733
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278880; cv=none; b=IEgqzhw8olQaMBhM0ziAy+hqUIqlzljNvyOxsKZgvvbQbDxQo5cGlu27qgUH+5DU2KXHezA+FYXmCbeZADkrImYaLV/leJI9+EpikfFw+jyHWUHC25OToxJh3+cZ06vDNnd+GHXzUXVzx8jkfLivhVjU8s3rYV1EIvlk3qy+W/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278880; c=relaxed/simple;
	bh=QVn4kOxQbknn82h4eX+EDDWOieltJQF858rkTdECiao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZsYClCv7arNm1hjwhLF4avyaxAb+4TCdC4aDPpqaJRo7gPa4LQ1iqQHwiDTVfD9g4YY4s7SknYh0BB2YbI1g4c+6MEYVSQk8DnAMJdez+lNNAG8wni9a4KHQ7DlI2A+GHk79G5uAKrv1xyAinOEXuYeCVHYKVRaqZkg8dyNSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpFXDHkL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpFXDHkL"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1930580f8f.3
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278875; x=1783883675; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMcg9y67rwunE2DKGeLYI29d8HcuwR2xGbFAhvqNdDI=;
        b=GpFXDHkLJ2JAoPwX135UiMZOkjtOIqH03pjSbNdFkstjspTC244pGfRXsGDQ6cajtf
         JmObJ0Hn9DMTeHKD2exgK0eyRkB7OcGeiNBQuh3Ysa1EsEtSytolVzEfo28b2x2qPy0S
         rx2oytYroH7SWRDhXcgE86QHJHxpISZEZEa2RV7gxp/WHEUVRhM7NPXYY3kgowjfpARV
         Cv4cWXC0/0chFLt7XQM0qgJaXSt+UerUQI/SO4DWkHANK8Ckk7xv9bi237X6FA/Y63A2
         lGCCgyFP18GIj+MpzH/Y7JOqUvhQFqjkarWpxrrl4lFMvHM3z7xdMCj8KhvffTiAfAPB
         W79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278875; x=1783883675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMcg9y67rwunE2DKGeLYI29d8HcuwR2xGbFAhvqNdDI=;
        b=TAuxwTueAQBn/gzGIQG2jBPJ3EiAeAxz4ckD+oIhenu6smVD0w7Db8/DE3m/kGP4yJ
         O+B9QDKXsr2CrREXgdFB6DbRkDOMex4WBGeepWzezYz9Wi21Kmxp5utk3aNglS4H9GSZ
         lsWogrVP/6h1tiK0K6ARaD66eYxOsMuG4Ml+Nojyyfx20h0g3PnL0+8WzPokggH9uTBV
         bL7XEx8N2p33K5RJ5VPD1pBtfoPOWvjQ+MP5PbSxlcgrN6xtI66i85EyAKwNY4rlzqri
         P2X4SUMXt6Z4dMUWYzb0rDafIsg/CAKQOfgFog5r+tbXvyHIAqpVfx/CMyLaw1Z/i5Fy
         31XA==
X-Gm-Message-State: AOJu0Ywrv5x1XtNtuELJFHnnhGgiV+I9e3ohQ9j/1cUel9OCv7Z4n/B8
	OexQvgqbKOPzr7hQufAhWG0Z/2HdpnpYNEvdLxuLtXGm+NTm/KKnsOc=
X-Gm-Gg: AfdE7clK1y7bhNxL67eY8eLa+3+ciJznkbYemqvS+0XC9cRTox4oimawwCnjggOgiUV
	YcY/VoBPIsuHk6gQyXpZ5V9+miSUxQyzZzFSNyYEIJw5g/qp+hDwzQNGriwXNB2P8n9ETqqXv3x
	woQA1ZeyHPeQmQEiKPdIgoL56I8wMprLi5QZrU82pUK3gJbkLDhzxr7ZtkdHVcAc7W9KJE1eiv7
	bkDFTvHqoPCulzNker8kloCli+QHIl1PPMdljgO10fuekCg8Rb3WQEAzrdZ1NxP0qeC1jQZLvYZ
	N3SOLUE79K+pQVAnl6+XjkKBxHqtgUCxBoQ3YUzMa6npi6tqRjA6mUVHI8zaO33p4I14pwrKo+P
	xkCjnb2FS+SJx9Lrmk8ErBJqZnK3Wy1nrYeqzesJT306OiHo8es2oIqMZnLlpro88ODHZwDy3j6
	y4RuQIkQ004F2PuzU=
X-Received: by 2002:adf:e014:0:10b0:460:67e0:563e with SMTP id ffacd0b85a97d-47aad54f110mr5661523f8f.35.1783278875081;
        Sun, 05 Jul 2026 12:14:35 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:34 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:45 +0200
Subject: [PATCH RFC 11/13] drm/msm: Add LPAC submitqueue
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-11-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=12622;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=QVn4kOxQbknn82h4eX+EDDWOieltJQF858rkTdECiao=;
 b=qgqiL6ZgqTya10uwOa+sdOJJc60i/UBr7933iu9z7wQw2WuosSibD6SgaGUPuNFU6OvwcK7Gr
 V9DFTssdykwBSfoa9LDlO7j5SA0jc2oy1m/9+kJ8wvFv/CEhL6RdkSP
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Add UAPI and infostructure to support sending submission to the LPAC
ring.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 86 ++++++++++++++++++++++-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c  |  6 ++-
 drivers/gpu/drm/msm/msm_gpu.c         |  8 ++--
 drivers/gpu/drm/msm/msm_gpu.h         |  4 +-
 drivers/gpu/drm/msm/msm_submitqueue.c | 11 ++++-
 include/uapi/drm/msm_drm.h            |  2 +
 7 files changed, 78 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 9f69aada9b7b..4417a9d04d7c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -204,8 +204,10 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 void
 a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
+	bool is_lpac = ring == gpu->lpac_rb;
+
 	/* If preemption is enabled */
-	if (gpu->nr_rings > 1) {
+	if (gpu->nr_rings > 1 && !is_lpac) {
 		/* Yield the floor on command completion */
 		OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
 
@@ -244,6 +246,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	struct drm_gpuvm *vm = msm_context_vm(submit->dev, ctx);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	phys_addr_t ttbr;
+	bool is_lpac = ring == a6xx_gpu->base.base.lpac_rb;
 	u32 asid;
 	u64 memptr = rbmemptr(ring, ttbr0);
 
@@ -261,25 +264,27 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		OUT_RING(ring, upper_32_bits(rbmemptr(ring, fence)));
 		OUT_RING(ring, submit->seqno - 1);
 
-		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
+		if (!is_lpac) {
+			OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+			OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
 
-		/* Reset state used to synchronize BR and BV */
-		OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
-		OUT_RING(ring,
-			 CP_RESET_CONTEXT_STATE_0_CLEAR_ON_CHIP_TS |
-			 CP_RESET_CONTEXT_STATE_0_CLEAR_RESOURCE_TABLE |
-			 CP_RESET_CONTEXT_STATE_0_CLEAR_BV_BR_COUNTER |
-			 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
+			/* Reset state used to synchronize BR and BV */
+			OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
+			OUT_RING(ring,
+				 CP_RESET_CONTEXT_STATE_0_CLEAR_ON_CHIP_TS |
+				 CP_RESET_CONTEXT_STATE_0_CLEAR_RESOURCE_TABLE |
+				 CP_RESET_CONTEXT_STATE_0_CLEAR_BV_BR_COUNTER |
+				 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
 
-		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
+			OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+			OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
 
-		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
-		OUT_RING(ring, LRZ_FLUSH_INVALIDATE);
+			OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+			OUT_RING(ring, LRZ_FLUSH_INVALIDATE);
 
-		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BR);
+			OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+			OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BR);
+		}
 	}
 
 	if (!sysprof) {
@@ -493,7 +498,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = submit->ring;
-	u32 rbbm_perfctr_cp0, cp_always_on_context;
+	u32 rbbm_perfctr_cp0, cp_always_on_context,
+	    cp_always_on_counter;
+	bool is_lpac = ring == gpu->lpac_rb;
+	u64 timestamp_iova;
 	unsigned int i, ibs = 0;
 
 	adreno_check_and_reenable_stall(adreno_gpu);
@@ -511,19 +519,24 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	 * If preemption is enabled, then set the pseudo register for the save
 	 * sequence
 	 */
-	if (gpu->nr_rings > 1)
+	if (gpu->nr_rings > 1 && !is_lpac)
 		a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, submit->queue);
 
 	if (adreno_is_a8xx(adreno_gpu)) {
 		rbbm_perfctr_cp0 = REG_A8XX_RBBM_PERFCTR_CP(0);
 		cp_always_on_context = REG_A8XX_CP_ALWAYS_ON_CONTEXT;
+		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_COUNTER;
 	} else {
 		rbbm_perfctr_cp0 = REG_A7XX_RBBM_PERFCTR_CP(0);
 		cp_always_on_context = REG_A6XX_CP_ALWAYS_ON_CONTEXT;
+		cp_always_on_counter = REG_A6XX_CP_ALWAYS_ON_COUNTER;
 	}
 
 	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, cpcycles_start));
-	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, index, alwayson_start));
+	if (is_lpac)
+		get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring, index, alwayson_start));
+	else
+		get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, index, alwayson_start));
 
 	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
 	OUT_RING(ring, CP_SET_THREAD_BOTH);
@@ -582,17 +595,19 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 		OUT_RING(ring, submit->seqno);
 	}
 
-	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-	OUT_RING(ring, CP_SET_THREAD_BR);
+	if (!is_lpac) {
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_SET_THREAD_BR);
 
-	OUT_PKT7(ring, CP_EVENT_WRITE, 1);
-	OUT_RING(ring, CCU_INVALIDATE_DEPTH);
+		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+		OUT_RING(ring, CCU_INVALIDATE_DEPTH);
 
-	OUT_PKT7(ring, CP_EVENT_WRITE, 1);
-	OUT_RING(ring, CCU_INVALIDATE_COLOR);
+		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+		OUT_RING(ring, CCU_INVALIDATE_COLOR);
 
-	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-	OUT_RING(ring, CP_SET_THREAD_BV);
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_SET_THREAD_BV);
+	}
 
 	/*
 	 * Make sure the timestamp is committed once BV pipe is
@@ -638,10 +653,12 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	a6xx_flush_yield(gpu, ring);
 
 	/* Check to see if we need to start preemption */
-	if (adreno_is_a8xx(adreno_gpu))
-		a8xx_preempt_trigger(gpu);
-	else
-		a6xx_preempt_trigger(gpu);
+	if (!is_lpac) {
+		if (adreno_is_a8xx(adreno_gpu))
+			a8xx_preempt_trigger(gpu);
+		else
+			a6xx_preempt_trigger(gpu);
+	}
 }
 
 static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
@@ -1219,6 +1236,7 @@ int a6xx_zap_shader_init(struct msm_gpu *gpu)
 		       A6XX_RBBM_INT_0_MASK_PM4CPINTERRUPT | \
 		       A6XX_RBBM_INT_0_MASK_CP_RB_DONE_TS | \
 		       A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS | \
+		       A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS_LPAC | \
 		       A6XX_RBBM_INT_0_MASK_RBBM_ATB_BUS_OVERFLOW | \
 		       A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT | \
 		       A6XX_RBBM_INT_0_MASK_UCHE_OOB_ACCESS | \
@@ -2030,6 +2048,9 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 		a6xx_preempt_trigger(gpu);
 	}
 
+	if (status & A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS_LPAC)
+		msm_gpu_retire(gpu);
+
 	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
 		a6xx_preempt_irq(gpu);
 
@@ -2500,6 +2521,9 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
 		return true;
 
+	if (ring == gpu->lpac_rb)
+		return true;
+
 	cp_state = (struct msm_cp_state) {
 		.ib1_base = gpu_read64(gpu, REG_A6XX_CP_IB1_BASE),
 		.ib2_base = gpu_read64(gpu, REG_A6XX_CP_IB2_BASE),
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index b50c57f427b4..d85f2536551c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -75,7 +75,7 @@ struct a6xx_gpu {
 	struct drm_gem_object *preempt_smmu_bo[MSM_GPU_MAX_RINGS];
 	void *preempt_smmu[MSM_GPU_MAX_RINGS];
 	uint64_t preempt_smmu_iova[MSM_GPU_MAX_RINGS];
-	uint32_t last_seqno[MSM_GPU_MAX_RINGS];
+	uint32_t last_seqno[MSM_GPU_MAX_RINGS + 1];
 
 	atomic_t preempt_state;
 	spinlock_t eval_lock;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 26ea8a28be47..45e7f8b72dc9 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -71,7 +71,8 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 	submit->cmd = (void *)&submit->bos[nr_bos];
 	submit->queue = queue;
 	submit->pid = get_pid(task_pid(current));
-	submit->ring = gpu->rb[queue->ring_nr];
+	submit->ring = queue->ring_nr == gpu->nr_rings ?
+		gpu->lpac_rb : gpu->rb[queue->ring_nr];
 	submit->fault_dumped = false;
 
 	/* Get a unique identifier for the submission for logging purposes */
@@ -599,7 +600,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		goto out_post_unlock;
 	}
 
-	ring = gpu->rb[queue->ring_nr];
+	ring = queue->ring_nr == gpu->nr_rings ?
+		gpu->lpac_rb : gpu->rb[queue->ring_nr];
 
 	if (args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
 		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 932e2a7c24b3..38fdf8d95cc0 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -537,8 +537,8 @@ static void recover_worker(struct kthread_work *work)
 	 * needs to happen after msm_rd_dump_submit() to ensure that the
 	 * bo's referenced by the offending submit are still around.
 	 */
-	for (i = 0; i < gpu->nr_rings; i++) {
-		struct msm_ringbuffer *ring = gpu->rb[i];
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
+		struct msm_ringbuffer *ring = i < gpu->nr_rings ? gpu->rb[i] : gpu->lpac_rb;
 
 		uint32_t fence = ring->memptrs->fence;
 
@@ -561,8 +561,8 @@ static void recover_worker(struct kthread_work *work)
 	 * Replay all remaining submits starting with highest priority
 	 * ring
 	 */
-	for (i = 0; i < gpu->nr_rings; i++) {
-		struct msm_ringbuffer *ring = gpu->rb[i];
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
+		struct msm_ringbuffer *ring = i < gpu->nr_rings ? gpu->rb[i] : gpu->lpac_rb;
 		unsigned long flags;
 
 		spin_lock_irqsave(&ring->submit_lock, flags);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 9a213fb65b4f..263dafeb9652 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -490,9 +490,11 @@ struct msm_context {
 	 * create at most one &drm_sched_entity per-process per-priority-
 	 * level.
 	 */
-	struct drm_sched_entity *entities[NR_SCHED_PRIORITIES * MSM_GPU_MAX_RINGS];
+	struct drm_sched_entity *entities[NR_SCHED_PRIORITIES * (MSM_GPU_MAX_RINGS + 1)];
+
 	/**
 	 * @ctx_mem:
+	 *
 	 * Total amount of memory of GEM buffers with handles attached for
 	 * this context.
 	 */
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 1a5a77b28016..042b4f90fb73 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -175,6 +175,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	struct msm_drm_private *priv = drm->dev_private;
 	struct msm_gpu_submitqueue *queue;
 	enum drm_sched_priority sched_prio;
+	struct msm_ringbuffer *ring;
 	unsigned ring_nr;
 	int ret;
 
@@ -211,6 +212,13 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 		queue = kzalloc_obj(*queue);
 	}
 
+	if (flags & MSM_SUBMITQUEUE_LPAC) {
+		ring_nr = priv->gpu->nr_rings;
+		ring = priv->gpu->lpac_rb;
+	} else {
+		ring = priv->gpu->rb[ring_nr];
+	}
+
 	if (!queue)
 		return -ENOMEM;
 
@@ -227,8 +235,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	} else {
 		queue->ring_nr = ring_nr;
 
-		queue->entity = get_sched_entity(ctx, priv->gpu->rb[ring_nr],
-						 ring_nr, sched_prio);
+		queue->entity = get_sched_entity(ctx, ring, ring_nr, sched_prio);
 	}
 
 	if (IS_ERR(queue->entity)) {
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 7f2e594be4eb..058228a56213 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -465,10 +465,12 @@ struct drm_msm_gem_madvise {
 
 #define MSM_SUBMITQUEUE_ALLOW_PREEMPT	0x00000001
 #define MSM_SUBMITQUEUE_VM_BIND	0x00000002  /* virtual queue for VM_BIND ops */
+#define MSM_SUBMITQUEUE_LPAC	0x00000004
 
 #define MSM_SUBMITQUEUE_FLAGS		    ( \
 		MSM_SUBMITQUEUE_ALLOW_PREEMPT | \
 		MSM_SUBMITQUEUE_VM_BIND | \
+		MSM_SUBMITQUEUE_LPAC | \
 		0)
 
 /*

-- 
2.54.0

