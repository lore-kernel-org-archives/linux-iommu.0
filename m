Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769528C2C6
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339185; cv=none; b=KXqjkW1eUIRCMxaqQIFUTK7QfdIQCbkiG5KUqRXUiz6wLMd/s/oZ/RHaacbWeRcHqpWGa1I6BVfa+eVUmoMKrYWQ3oM4E6skMsEEholfva0jcKPUAddoOwPM7kCFPgE7/WMduwkb0vJNd7/dtmUcqxtpgYdWOSUwrtqMeCS6P/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339185; c=relaxed/simple;
	bh=BC6iPoxvTfFoKvzZxMJ/DcbtAIrxCCZiQQVyyoYGKgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2en6kgHdX0LyZd7B7RR9LrfS4xB+Hy09ofMiRphsoRUrMlBAicHtRRTOGL9Dt22NQDYq9WD/TrNRaqHHEneWE3xH+r6DCsPSchZOmhVxXFO/NEMUOdyrJox0JLk2lPYP0w7V0VGldM2JAWr0PCu6jhfnBMyUMu/s9rmE1rWbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU12iBnI; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU12iBnI"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8a694d622so1305266d6.1
        for <iommu@lists.linux.dev>; Thu, 15 May 2025 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747339182; x=1747943982; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3UKLAKS32/3D/mX73DiA7ewZNIUl/OD69FTo/T8pQI=;
        b=kU12iBnIUWNAvCFWIR8qO6TIluEtGcvxEDeLcc6wUG9GoJ1EysN1uf6MZKIkf8jGuT
         p3BYWTW7+0Rmt67AcHsHraokPpdYI45LeDKcds59IpUTshrkVAqdXw1PEyIZi0TRy3qy
         EAr719fxkjTAHC/DVBjKCr0wof7KMFU0AR+lcj8/xv2sHphN9ZCpGTvaDN4nFdQmVoMo
         TyzRue7BqHhtBRrJItVNK7wNBTNLxWXGdMald6ynbghphyvrmA/clN4XlNjVJ/vQ0JmN
         IHrU37bBxUreX+AJTkv/eKETqOEf7o1KKApG8eCIQ5oPJzQsc6NHZ8Kl8cO6SNTirLG4
         NNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339182; x=1747943982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3UKLAKS32/3D/mX73DiA7ewZNIUl/OD69FTo/T8pQI=;
        b=YBou4f9SfUi1mhaQffUgTHXH5YzB0wFdTA4rPimpshUwNT8HaUteEV1wDJicVpW1ek
         S3fZ+xKl3IZvFwBsokDefDsH/+jbPNN/mU2IN6r/30gIzEBw/f6ICzRHm0kMG0fqNyhZ
         Mc54hqkE6on44RBtIuEeHX77vCmfWbFz54imRjp1xFSzpcqfiDYnf3siTbfa9rL3Vw4k
         20l6GAZx8K+nsubaTieh43LKREagCInUadRWLdP3l9b/1Z00vNnYtlYnW/wYQP71OhbO
         H8Vega0k6Lyr2nXmzEcSQP0QED4ndwxR1uh8Q0FVUKP/iuRFmeiVb3sn589pVzv9I405
         gqnA==
X-Gm-Message-State: AOJu0YxXnIfZh336NPXN9tcdf1MuwWR07lwh5ISUNHL+BEK/bWVXXlub
	H+98cU9VoEincfTxUGjxc13l1fAymui8ERi3cAjNrzXRF+hRJR2NzBYr
X-Gm-Gg: ASbGncvESyqMGTPLPE+VkmSXlRM3V6oa82g2oLTaz5hFQJNd4Kp2VywMoJ1NBefeVu8
	PJensNjyT0GbuI7TvlQ7iqLcOOZAOAshlCHTRLZDppaOzPTs7CurZ5uepRBzRQwsHcIqnHslqKT
	XoIX/tecUQ2HcVQjhQOnbFuh1qJPLwJMnpRyl48OmMty4Zdz/lpNxY29rlfaT3xohRgoUne32Xs
	q2iQAOSndpVZliCFr6bKSm21NZYgm8PgFqkjAUK2HEatiCMksHHCDt/iIA9ATmLn2FSuMC+hn3v
	OSeOJ1T26Ym99IHSSx/rwzwygzX9+v7/bxVfFINA3uyl9lYgqolaUv3ijN+O1HriiYCVwxbQB4X
	SnpFuFMd2Kbc79kIdN1o=
X-Google-Smtp-Source: AGHT+IEQjQf0fT8qgLmZr+6iLcHLgcDi9fUiiL8m/7lrWjaOZGrI3mQflKlah/0QM9S0VMm54v4xhA==
X-Received: by 2002:a05:622a:10f:b0:472:58b:463f with SMTP id d75a77b69052e-494ae3307c5mr4501831cf.3.1747339181799;
        Thu, 15 May 2025 12:59:41 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae4fd80bsm1957231cf.56.2025.05.15.12.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:59:41 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 15 May 2025 15:58:46 -0400
Subject: [PATCH v6 4/7] drm/msm: Don't use a worker to capture fault
 devcoredump
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-msm-gpu-fault-fixes-next-v6-4-4fe2a583a878@gmail.com>
References: <20250515-msm-gpu-fault-fixes-next-v6-0-4fe2a583a878@gmail.com>
In-Reply-To: <20250515-msm-gpu-fault-fixes-next-v6-0-4fe2a583a878@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339176; l=6005;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=BC6iPoxvTfFoKvzZxMJ/DcbtAIrxCCZiQQVyyoYGKgg=;
 b=ax8wqfUD5w5AtJIx8e8BSTWwfIH8+CcskJsen4Q3OMpNIsG3qxBGWU8xdKN5yMT7NKGAIwiIj
 mK9QryMx8yFBhA3Ab0QKac/sXryZHyNB7WLh9EIpKIqDfcynBiP1okG
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

Now that we use a threaded IRQ, it should be safe to do this in the
fault handler.

We can also remove fault_info from struct msm_gpu and just pass it
directly.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 22 ++++++++--------------
 drivers/gpu/drm/msm/msm_gpu.c           | 20 +++++++++-----------
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++------
 3 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 1238f326597808eb28b4c6822cbd41a26e555eb9..1a4069a73aa42821cb9af7871e6ff8ec7b44d1ef 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -257,14 +257,6 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 	const char *type = "UNKNOWN";
 	bool do_devcoredump = info && !READ_ONCE(gpu->crashstate);
 
-	/*
-	 * If we aren't going to be resuming later from fault_worker, then do
-	 * it now.
-	 */
-	if (!do_devcoredump) {
-		gpu->aspace->mmu->funcs->resume_translation(gpu->aspace->mmu);
-	}
-
 	/*
 	 * Print a default message if we couldn't get the data from the
 	 * adreno-smmu-priv
@@ -291,16 +283,18 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 			scratch[0], scratch[1], scratch[2], scratch[3]);
 
 	if (do_devcoredump) {
+		struct msm_gpu_fault_info fault_info = {};
+
 		/* Turn off the hangcheck timer to keep it from bothering us */
 		del_timer(&gpu->hangcheck_timer);
 
-		gpu->fault_info.ttbr0 = info->ttbr0;
-		gpu->fault_info.iova  = iova;
-		gpu->fault_info.flags = flags;
-		gpu->fault_info.type  = type;
-		gpu->fault_info.block = block;
+		fault_info.ttbr0 = info->ttbr0;
+		fault_info.iova  = iova;
+		fault_info.flags = flags;
+		fault_info.type  = type;
+		fault_info.block = block;
 
-		kthread_queue_work(gpu->worker, &gpu->fault_work);
+		msm_gpu_fault_crashstate_capture(gpu, &fault_info);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0d4a3744cfcbd2662d27f9929ff691581707325b..8ea8991aa40931c4c3d1a60c433fcd1aeccc45ff 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -257,7 +257,8 @@ static void msm_gpu_crashstate_get_bo(struct msm_gpu_state *state,
 }
 
 static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
-		struct msm_gem_submit *submit, char *comm, char *cmd)
+		struct msm_gem_submit *submit, struct msm_gpu_fault_info *fault_info,
+		char *comm, char *cmd)
 {
 	struct msm_gpu_state *state;
 
@@ -276,7 +277,8 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 	/* Fill in the additional crash state information */
 	state->comm = kstrdup(comm, GFP_KERNEL);
 	state->cmd = kstrdup(cmd, GFP_KERNEL);
-	state->fault_info = gpu->fault_info;
+	if (fault_info)
+		state->fault_info = *fault_info;
 
 	if (submit) {
 		int i;
@@ -299,7 +301,8 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 }
 #else
 static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
-		struct msm_gem_submit *submit, char *comm, char *cmd)
+		struct msm_gem_submit *submit, struct msm_gpu_fault_info *fault_info,
+		char *comm, char *cmd)
 {
 }
 #endif
@@ -396,7 +399,7 @@ static void recover_worker(struct kthread_work *work)
 
 	/* Record the crash state */
 	pm_runtime_get_sync(&gpu->pdev->dev);
-	msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
+	msm_gpu_crashstate_capture(gpu, submit, NULL, comm, cmd);
 
 	kfree(cmd);
 	kfree(comm);
@@ -450,9 +453,8 @@ static void recover_worker(struct kthread_work *work)
 	msm_gpu_retire(gpu);
 }
 
-static void fault_worker(struct kthread_work *work)
+void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_info *fault_info)
 {
-	struct msm_gpu *gpu = container_of(work, struct msm_gpu, fault_work);
 	struct msm_gem_submit *submit;
 	struct msm_ringbuffer *cur_ring = gpu->funcs->active_ring(gpu);
 	char *comm = NULL, *cmd = NULL;
@@ -475,16 +477,13 @@ static void fault_worker(struct kthread_work *work)
 
 	/* Record the crash state */
 	pm_runtime_get_sync(&gpu->pdev->dev);
-	msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
+	msm_gpu_crashstate_capture(gpu, submit, fault_info, comm, cmd);
 	pm_runtime_put_sync(&gpu->pdev->dev);
 
 	kfree(cmd);
 	kfree(comm);
 
 resume_smmu:
-	memset(&gpu->fault_info, 0, sizeof(gpu->fault_info));
-	gpu->aspace->mmu->funcs->resume_translation(gpu->aspace->mmu);
-
 	mutex_unlock(&gpu->lock);
 }
 
@@ -873,7 +872,6 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	init_waitqueue_head(&gpu->retire_event);
 	kthread_init_work(&gpu->retire_work, retire_worker);
 	kthread_init_work(&gpu->recover_work, recover_worker);
-	kthread_init_work(&gpu->fault_work, fault_worker);
 
 	priv->hangcheck_period = DRM_MSM_HANGCHECK_DEFAULT_PERIOD;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 7cabc8480d7c5461ab8d8726fcc21690cbaf7366..ec83327779c4beb733cb38c932206245ab9bd2f2 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -245,12 +245,6 @@ struct msm_gpu {
 #define DRM_MSM_HANGCHECK_PROGRESS_RETRIES 3
 	struct timer_list hangcheck_timer;
 
-	/* Fault info for most recent iova fault: */
-	struct msm_gpu_fault_info fault_info;
-
-	/* work for handling GPU ioval faults: */
-	struct kthread_work fault_work;
-
 	/* work for handling GPU recovery: */
 	struct kthread_work recover_work;
 
@@ -697,6 +691,8 @@ static inline void msm_gpu_crashstate_put(struct msm_gpu *gpu)
 	mutex_unlock(&gpu->lock);
 }
 
+void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_info *fault_info);
+
 /*
  * Simple macro to semi-cleanly add the MAP_PRIV flag for targets that can
  * support expanded privileges

-- 
2.47.1

