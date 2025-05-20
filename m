Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE0281525
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768150; cv=none; b=W9RueheuhRq9HLOJV+RKhu8caFQAqwh29w6cZX5j6Jei5lAQ76U9KML5CqnyQrob4aBqE828pXKWEBS8v8GsRA3XUnkAEMj8hZZ8bOjCOOTuXoIA5Zkf+f6xHLGjzXYk1MHwP5cwqhA1w18bYUHddjvwMPRAYhE+b1X3WW2VXLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768150; c=relaxed/simple;
	bh=FCsMQ/lDosid4e/Pi7b+7W8zAGLYgmp9uHd4ek8IEi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ER1EMViHroRltRuzy7h9EFWEOvHvdwoga7mavlWSuddWVOP9dZ6lOlEki1b1rDh+HCsW5vx6Q/JwBDmvnyyE5XAYatxsDs36ag7vdMH3fzaHB7fe1KMFhzvxYGBryx2u7yPgUENT8Or36HzoOZYlklrO4zriwA+bCpg5myzjses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vavc8SNh; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vavc8SNh"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5a3334fddso92593685a.1
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747768147; x=1748372947; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p605H/gwYQGbgiKDoVqvqTFDpgFsHP3ae2OvlNB6R7c=;
        b=Vavc8SNho+UZ/Pw70XICuMWHuGABMT/wTuFgsR/S3sDtjj3i88TAiAiw5YGpDslTpl
         lUhepxx57Msj3+TFcn8lWVrEe3b/RJ0QKrV5Z5A78D9+83qO6NzshoBSTTm9/Nc4dCp3
         rku8vkTsHCIOZPwqY4/hPexpQmebUUpysIJ6CqjGmSCQ13gG34xOUyGZbuyZPebehRcV
         wr/eIDS4dT04uZQU/d9X39kr/nrfXHqzQSsJ4u+tsMJIXAXeJf6H+u82xDZqdUXF3eC4
         Shzk2YTvoTDnWJEsb0KCG6clsCXYWCMfmYDD1BXXtbxkmEWzHB5aPXcT9JtoUtpvc+mq
         97Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747768147; x=1748372947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p605H/gwYQGbgiKDoVqvqTFDpgFsHP3ae2OvlNB6R7c=;
        b=mjuw+3z3eWwNdzEgkPKTMUgq6ZajDDoGNl/E/Z1eaX4oT1MVBfNP4Qv1s6c8CBqMfX
         PvojPg3gvF4F1eQrYT6VOHFZjaPFliG+chRqDtszT5UaKVY95d4QgI+gsohbOmoIDvDg
         4dcA4GiUeGggnsldCMhF6k8jCtw2lw6BoPzFiY7Lia0z5d0OfNDcRsEZqofmT1XfCQ29
         a7UQf9YcfmaawaG/XwJmBflSS/lknfvvY5mjhuQ20dluGK8beENCTf9t1vr/zXOePc86
         4nrFPMT8a3WtiAbiulbXI6fbrGhWPRpyiSmrr+7jG93AIOFj17t4f1EmZeHS4LOLVk2h
         F2TA==
X-Gm-Message-State: AOJu0YwmU5sX2AQ8J1BVkv8VEvmT9jOU529XsvCUWmuIrRlOKbykPRjn
	7MGvxSfPLwLHBwVb2g7VcGB8/IhhGCl3lAO+bzSvjMDZA5NAUeZbc8Wt
X-Gm-Gg: ASbGncu/iRjDGWSvLJ30Llm2D2NCjxJUxGcxE/dH/lNIxzqTg5Qli9XvFIKV5HZTE6x
	UThQnlpppNv3y1uLLpjwJCibIug88YmStiif5X02UTGxlYKEXF7xWQKl/gh/Pwko7ThMbpmNa08
	V44/5lU2h9jjJWyMOau7vROjHQ2JcIoX8QqFMocYXclGeHhsBtk1+3k+2SARe4T2G23IkCrAgSy
	j31gcYYc5+rWI088posxXlIgJvMSUG4m18XTzumAOA1pBs/n7EFEae/QMWKLpEZLSb/DIKjK3B6
	VLq94vtBNXBXLqa5QTGL/+uF2vkJ5QV9kgeu9ReLYW6IayLRBKK8eebk/CwivL9zTQVilguv+Tv
	ODEm3p412wvhsYV+YDb0=
X-Google-Smtp-Source: AGHT+IERko68tjSRXwzHehFMdLYwGfBcZEiVZ+HJEyjzfXIk8XlXd8CWDgt9mnwB3yU5B9kiA/nGyw==
X-Received: by 2002:a05:622a:19a0:b0:474:faeb:50aa with SMTP id d75a77b69052e-494ae3509fcmr97992671cf.5.1747768147025;
        Tue, 20 May 2025 12:09:07 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae445b99sm76554051cf.48.2025.05.20.12.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:09:06 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 15:08:59 -0400
Subject: [PATCH v8 6/7] drm/msm: Temporarily disable stall-on-fault after a
 page fault
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-msm-gpu-fault-fixes-next-v8-6-fce6ee218787@gmail.com>
References: <20250520-msm-gpu-fault-fixes-next-v8-0-fce6ee218787@gmail.com>
In-Reply-To: <20250520-msm-gpu-fault-fixes-next-v8-0-fce6ee218787@gmail.com>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747768138; l=11849;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=FCsMQ/lDosid4e/Pi7b+7W8zAGLYgmp9uHd4ek8IEi4=;
 b=1H940zl22KNPnuJyClBlD1/DnqrUirZl5DpdXOyMTw/3GpoHapw90t4z6143/3qezWcEmP6Dx
 q7IbxNp6LYFAzyH62QyvwvsM14dulXC5iwBNsZ1KnA55wXpDtrbIg55
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

When things go wrong, the GPU is capable of quickly generating millions
of faulting translation requests per second. When that happens, in the
stall-on-fault model each access will stall until it wins the race to
signal the fault and then the RESUME register is written. This slows
processing page faults to a crawl as the GPU can generate faults much
faster than the CPU can acknowledge them. It also means that all
available resources in the SMMU are saturated waiting for the stalled
transactions, so that other transactions such as transactions generated
by the GMU, which shares translation resources with the GPU, cannot
proceed. This causes a GMU watchdog timeout, which leads to a failed
reset because GX cannot collapse when there is a transaction pending and
a permanently hung GPU.

On older platforms with qcom,smmu-v2, it seems that when one transaction
is stalled subsequent faulting transactions are terminated, which avoids
this problem, but the MMU-500 follows the spec here.

To work around these problems, disable stall-on-fault as soon as we get a
page fault until a cooldown period after pagefaults stop. This allows
the GMU some guaranteed time to continue working. We only use
stall-on-fault to halt the GPU while we collect a devcoredump and we
always terminate the transaction afterward, so it's fine to miss some
subsequent page faults. We also keep it disabled so long as the current
devcoredump hasn't been deleted, because in that case we likely won't
capture another one if there's a fault.

After this commit HFI messages still occasionally time out, because the
crashdump handler doesn't run fast enough to let the GMU resume, but the
driver seems to recover from it. This will probably go away after the
HFI timeout is increased.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  4 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 40 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  2 ++
 drivers/gpu/drm/msm/msm_debugfs.c       | 32 ++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.c           |  4 ++++
 drivers/gpu/drm/msm/msm_drv.h           | 23 +++++++++++++++++++
 drivers/gpu/drm/msm/msm_iommu.c         |  9 ++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  1 +
 9 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 650e5bac225f372e819130b891f1d020b464f17f..60aef079623606bb1ae44ba59ac45e391595b0ba 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -131,6 +131,8 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i, ibs = 0;
 
+	adreno_check_and_reenable_stall(adreno_gpu);
+
 	if (IS_ENABLED(CONFIG_DRM_MSM_GPU_SUDO) && submit->in_rb) {
 		ring->cur_ctx_seqno = 0;
 		a5xx_submit_in_rb(gpu, submit);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 06465bc2d0b4b128cddfcfcaf1fe4252632b6777..afa4626d58f577d5d47f47b494b26953adcf230f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -212,6 +212,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i, ibs = 0;
 
+	adreno_check_and_reenable_stall(adreno_gpu);
+
 	a6xx_set_pagetable(a6xx_gpu, ring, submit);
 
 	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
@@ -335,6 +337,8 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i, ibs = 0;
 
+	adreno_check_and_reenable_stall(adreno_gpu);
+
 	/*
 	 * Toggle concurrent binning for pagetable switch and set the thread to
 	 * BR since only it can execute the pagetable switch packets.
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 4a6dc29ff7071940e440297f5fbbe4e2d06c3ffd..0f8211641c318f1b619e1a72bb77f064fb78397b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -246,16 +246,54 @@ u64 adreno_private_address_space_size(struct msm_gpu *gpu)
 	return SZ_4G;
 }
 
+void adreno_check_and_reenable_stall(struct adreno_gpu *adreno_gpu)
+{
+	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct msm_drm_private *priv = gpu->dev->dev_private;
+	unsigned long flags;
+
+	/*
+	 * Wait until the cooldown period has passed and we would actually
+	 * collect a crashdump to re-enable stall-on-fault.
+	 */
+	spin_lock_irqsave(&priv->fault_stall_lock, flags);
+	if (!priv->stall_enabled &&
+			ktime_after(ktime_get(), priv->stall_reenable_time) &&
+			!READ_ONCE(gpu->crashstate)) {
+		priv->stall_enabled = true;
+
+		gpu->aspace->mmu->funcs->set_stall(gpu->aspace->mmu, true);
+	}
+	spin_unlock_irqrestore(&priv->fault_stall_lock, flags);
+}
+
 #define ARM_SMMU_FSR_TF                 BIT(1)
 #define ARM_SMMU_FSR_PF			BIT(3)
 #define ARM_SMMU_FSR_EF			BIT(4)
+#define ARM_SMMU_FSR_SS			BIT(30)
 
 int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 			 struct adreno_smmu_fault_info *info, const char *block,
 			 u32 scratch[4])
 {
+	struct msm_drm_private *priv = gpu->dev->dev_private;
 	const char *type = "UNKNOWN";
-	bool do_devcoredump = info && !READ_ONCE(gpu->crashstate);
+	bool do_devcoredump = info && (info->fsr & ARM_SMMU_FSR_SS) &&
+		!READ_ONCE(gpu->crashstate);
+	unsigned long irq_flags;
+
+	/*
+	 * In case there is a subsequent storm of pagefaults, disable
+	 * stall-on-fault for at least half a second.
+	 */
+	spin_lock_irqsave(&priv->fault_stall_lock, irq_flags);
+	if (priv->stall_enabled) {
+		priv->stall_enabled = false;
+
+		gpu->aspace->mmu->funcs->set_stall(gpu->aspace->mmu, false);
+	}
+	priv->stall_reenable_time = ktime_add_ms(ktime_get(), 500);
+	spin_unlock_irqrestore(&priv->fault_stall_lock, irq_flags);
 
 	/*
 	 * Print a default message if we couldn't get the data from the
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 92caba3584da0400b44a903e465814af165d40a3..6116f03e3d39bb208c7fa34f203931c563e029f9 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -634,6 +634,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 			 struct adreno_smmu_fault_info *info, const char *block,
 			 u32 scratch[4]);
 
+void adreno_check_and_reenable_stall(struct adreno_gpu *gpu);
+
 int adreno_read_speedbin(struct device *dev, u32 *speedbin);
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index 7ab607252d183f78b99c3a8b878c949ed5f99fec..6af72162cda4c8d4bc8dd4c6473cbc29817bb3c6 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -208,6 +208,35 @@ DEFINE_DEBUGFS_ATTRIBUTE(shrink_fops,
 			 shrink_get, shrink_set,
 			 "0x%08llx\n");
 
+/*
+ * Return the number of microseconds to wait until stall-on-fault is
+ * re-enabled. If 0 then it is already enabled or will be re-enabled on the
+ * next submit (unless there's a leftover devcoredump). This is useful for
+ * kernel tests that intentionally produce a fault and check the devcoredump to
+ * wait until the cooldown period is over.
+ */
+
+static int
+stall_reenable_time_get(void *data, u64 *val)
+{
+	struct msm_drm_private *priv = data;
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&priv->fault_stall_lock, irq_flags);
+
+	if (priv->stall_enabled)
+		*val = 0;
+	else
+		*val = max(ktime_us_delta(priv->stall_reenable_time, ktime_get()), 0);
+
+	spin_unlock_irqrestore(&priv->fault_stall_lock, irq_flags);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(stall_reenable_time_fops,
+			 stall_reenable_time_get, NULL,
+			 "%lld\n");
 
 static int msm_gem_show(struct seq_file *m, void *arg)
 {
@@ -319,6 +348,9 @@ static void msm_debugfs_gpu_init(struct drm_minor *minor)
 	debugfs_create_bool("disable_err_irq", 0600, minor->debugfs_root,
 		&priv->disable_err_irq);
 
+	debugfs_create_file("stall_reenable_time_us", 0400, minor->debugfs_root,
+		priv, &stall_reenable_time_fops);
+
 	gpu_devfreq = debugfs_create_dir("devfreq", minor->debugfs_root);
 
 	debugfs_create_bool("idle_clamp",0600, gpu_devfreq,
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index c3588dc9e53764a27efda1901b094724cec8928a..04a4bde2d33b03ae8fb06b2134ee1910debd774a 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -245,6 +245,10 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	drm_gem_lru_init(&priv->lru.willneed, &priv->lru.lock);
 	drm_gem_lru_init(&priv->lru.dontneed, &priv->lru.lock);
 
+	/* Initialize stall-on-fault */
+	spin_lock_init(&priv->fault_stall_lock);
+	priv->stall_enabled = true;
+
 	/* Teach lockdep about lock ordering wrt. shrinker: */
 	fs_reclaim_acquire(GFP_KERNEL);
 	might_lock(&priv->lru.lock);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index a65077855201746c37ee742364b61116565f3794..c8afb1ea6040b1ac94ac95a785e6fc366c8dbfd1 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -222,6 +222,29 @@ struct msm_drm_private {
 	 * the sw hangcheck mechanism.
 	 */
 	bool disable_err_irq;
+
+	/**
+	 * @fault_stall_lock:
+	 *
+	 * Serialize changes to stall-on-fault state.
+	 */
+	spinlock_t fault_stall_lock;
+
+	/**
+	 * @fault_stall_reenable_time:
+	 *
+	 * If stall_enabled is false, when to reenable stall-on-fault.
+	 * Protected by @fault_stall_lock.
+	 */
+	ktime_t stall_reenable_time;
+
+	/**
+	 * @stall_enabled:
+	 *
+	 * Whether stall-on-fault is currently enabled. Protected by
+	 * @fault_stall_lock.
+	 */
+	bool stall_enabled;
 };
 
 const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format, uint64_t modifier);
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index aae885d048d0d2fd617d7b2a16833da25f5e84cc..739ce2c283a4613e74df4542ca3b68f180aa8335 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -372,6 +372,14 @@ static int msm_disp_fault_handler(struct iommu_domain *domain, struct device *de
 	return -ENOSYS;
 }
 
+static void msm_iommu_set_stall(struct msm_mmu *mmu, bool enable)
+{
+	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(mmu->dev);
+
+	if (adreno_smmu->set_stall)
+		adreno_smmu->set_stall(adreno_smmu->cookie, enable);
+}
+
 static void msm_iommu_detach(struct msm_mmu *mmu)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
@@ -419,6 +427,7 @@ static const struct msm_mmu_funcs funcs = {
 		.map = msm_iommu_map,
 		.unmap = msm_iommu_unmap,
 		.destroy = msm_iommu_destroy,
+		.set_stall = msm_iommu_set_stall,
 };
 
 struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index c3d17aae88b0a57b3c7d1df3351b39ec39bca60a..0c694907140d00bae86eb20411aed45650367e74 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -15,6 +15,7 @@ struct msm_mmu_funcs {
 			size_t len, int prot);
 	int (*unmap)(struct msm_mmu *mmu, uint64_t iova, size_t len);
 	void (*destroy)(struct msm_mmu *mmu);
+	void (*set_stall)(struct msm_mmu *mmu, bool enable);
 };
 
 enum msm_mmu_type {

-- 
2.47.1

