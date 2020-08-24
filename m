Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1475C433E4
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711042074D
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzXe1XLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711042074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 644D185C63;
	Mon, 24 Aug 2020 18:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ZA3yZ9o1DwM; Mon, 24 Aug 2020 18:42:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5F19D85B4A;
	Mon, 24 Aug 2020 18:42:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4676DC016F;
	Mon, 24 Aug 2020 18:42:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8068C0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B655985B4A
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQGhfCVMZVhI for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 18:42:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4E22885C62
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:44 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id m34so4983686pgl.11
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wLbeJH0vy/co+tOlHv+Q071qhqctu1gmId0WOcDhB1o=;
 b=WzXe1XLab1pe34SLaAgPidP9d55vSx9EEjqbutNuKH8EZvb9xBATBpPaFoNr0rlse5
 3P5REdY7H+qU+trq4vpkGe8o1EsL53tdk0CwE5Bi0dNR+3OXVwj0ThuEwzAMMeWK+E+r
 fViyVzPiGc62+FO4vnGtvgU9SYdUNtC3WhXN6WmRGaT9ow4BkQBDuaCaspKn3uIQeM+G
 cmw8nM21h6jLCkWK89U23OlOuWgD7uAL4gUGm5pN+ir5AO6pI6RgHyp0Hviv/i9nKPXA
 S4DijhwxAyxdDdtOcWFhNiBUlvo0z5KWiv7k5ifeA5wOf2tveabBh6vL8Dw9ZTglsbkS
 IeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wLbeJH0vy/co+tOlHv+Q071qhqctu1gmId0WOcDhB1o=;
 b=ea03mTxeHDdS+7/+VbN+qPCORu+9wY4v1jyf+cq1tUQVza8J8DokVSIHn9rd4RvWJs
 jv5LlGPLIhBgJrkz1KISd561F235Z4rLkLsr2hEV75aVun6677Sa21Ixj3VzZpTAaFfB
 HAOEUHO1DeRleO3UiFxhDexxBkvetJaMYiU8UykWO4vf/9R7eQpdIVq5zV+CrlmgxcY4
 SVuGi9eFhvWVMPUscPn7TyLCgMU8wY037WPDLFDQVdV6rlO3upA/GrtSrk8EROPes0xa
 23c3RsbwWWjARC/9JFw3gGH+fQQjnIPftG0bRafR2ibqdTh+WrXOHNq9gwIqo6uF8zRB
 QHcg==
X-Gm-Message-State: AOAM5301w4iUixZEmUGKdbgvg8ldR5ccCcCDu8emaE6IKm2Ue4CLCWO8
 xCDBoRypEvSxvH+YDlylifU=
X-Google-Smtp-Source: ABdhPJxVjMjtXULAe8wuDP3Pw4FeqTrpxcR90YcJh6b89GTC5TLSaFE1qaHeoByTC3f1ziZzIoHj1A==
X-Received: by 2002:a17:902:ba8f:: with SMTP id
 k15mr4836518pls.79.1598294563773; 
 Mon, 24 Aug 2020 11:42:43 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id 131sm124142pfw.167.2020.08.24.11.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 11:42:42 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 12/20] drm/msm: Drop context arg to gpu->submit()
Date: Mon, 24 Aug 2020 11:37:46 -0700
Message-Id: <20200824183825.1778810-13-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, Akhil P Oommen <akhilpo@codeaurora.org>,
 Eric Anholt <eric@anholt.net>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Emil Velikov <emil.velikov@collabora.com>, Rob Clark <robdclark@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, Fabio Estevam <festevam@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Sibi Sankar <sibis@codeaurora.org>,
 Brian Masney <masneyb@onstation.org>, Joerg Roedel <jroedel@suse.de>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 John Stultz <john.stultz@linaro.org>, Sean Paul <sean@poorly.run>,
 Shawn Guo <shawn.guo@linaro.org>, freedreno@lists.freedesktop.org,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Wambui Karuga <wambui.karugax@gmail.com>, Robin Murphy <robin.murphy@arm.com>
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

Now that we can get the ctx from the submitqueue, the extra arg is
redundant.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
[split out of previous patch to reduce churny noise]
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 12 +++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  5 ++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  5 ++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  3 +--
 drivers/gpu/drm/msm/msm_gem_submit.c    |  2 +-
 drivers/gpu/drm/msm/msm_gpu.c           |  9 ++++-----
 drivers/gpu/drm/msm/msm_gpu.h           |  6 ++----
 7 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 9e63a190642c..eff2439ea57b 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -43,8 +43,7 @@ static void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 		gpu_write(gpu, REG_A5XX_CP_RB_WPTR, wptr);
 }
 
-static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-	struct msm_file_private *ctx)
+static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
 	struct msm_drm_private *priv = gpu->dev->dev_private;
 	struct msm_ringbuffer *ring = submit->ring;
@@ -57,7 +56,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
-			if (priv->lastctx == ctx)
+			if (priv->lastctx == submit->queue->ctx)
 				break;
 			/* fall-thru */
 		case MSM_SUBMIT_CMD_BUF:
@@ -103,8 +102,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 	msm_gpu_retire(gpu);
 }
 
-static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-	struct msm_file_private *ctx)
+static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
@@ -114,7 +112,7 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 
 	if (IS_ENABLED(CONFIG_DRM_MSM_GPU_SUDO) && submit->in_rb) {
 		priv->lastctx = NULL;
-		a5xx_submit_in_rb(gpu, submit, ctx);
+		a5xx_submit_in_rb(gpu, submit);
 		return;
 	}
 
@@ -148,7 +146,7 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
-			if (priv->lastctx == ctx)
+			if (priv->lastctx == submit->queue->ctx)
 				break;
 			/* fall-thru */
 		case MSM_SUBMIT_CMD_BUF:
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c5a3e4d4c007..5eabb0109577 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -81,8 +81,7 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 	OUT_RING(ring, upper_32_bits(iova));
 }
 
-static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-	struct msm_file_private *ctx)
+static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
 	unsigned int index = submit->seqno % MSM_GPU_SUBMIT_STATS_COUNT;
 	struct msm_drm_private *priv = gpu->dev->dev_private;
@@ -115,7 +114,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
-			if (priv->lastctx == ctx)
+			if (priv->lastctx == submit->queue->ctx)
 				break;
 			/* fall-thru */
 		case MSM_SUBMIT_CMD_BUF:
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index d2dbb6968cba..533a34b4cce2 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -457,8 +457,7 @@ void adreno_recover(struct msm_gpu *gpu)
 	}
 }
 
-void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-		struct msm_file_private *ctx)
+void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct msm_drm_private *priv = gpu->dev->dev_private;
@@ -472,7 +471,7 @@ void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
 			/* ignore if there has not been a ctx switch: */
-			if (priv->lastctx == ctx)
+			if (priv->lastctx == submit->queue->ctx)
 				break;
 			/* fall-thru */
 		case MSM_SUBMIT_CMD_BUF:
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index e55abae365b5..848632758450 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -269,8 +269,7 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
 		const struct firmware *fw, u64 *iova);
 int adreno_hw_init(struct msm_gpu *gpu);
 void adreno_recover(struct msm_gpu *gpu);
-void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-		struct msm_file_private *ctx);
+void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit);
 void adreno_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 bool adreno_idle(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 1464b04d25d3..aa5c60a7132d 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -785,7 +785,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		}
 	}
 
-	msm_gpu_submit(gpu, submit, ctx);
+	msm_gpu_submit(gpu, submit);
 
 	args->fence = submit->fence->seqno;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 806eb0957280..e1a3cbe25a0c 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -520,7 +520,7 @@ static void recover_worker(struct work_struct *work)
 			struct msm_ringbuffer *ring = gpu->rb[i];
 
 			list_for_each_entry(submit, &ring->submits, node)
-				gpu->funcs->submit(gpu, submit, NULL);
+				gpu->funcs->submit(gpu, submit);
 		}
 	}
 
@@ -747,8 +747,7 @@ void msm_gpu_retire(struct msm_gpu *gpu)
 }
 
 /* add bo's to gpu's ring, and kick gpu: */
-void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-		struct msm_file_private *ctx)
+void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
 	struct drm_device *dev = gpu->dev;
 	struct msm_drm_private *priv = dev->dev_private;
@@ -788,8 +787,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 			msm_gem_move_to_active(&msm_obj->base, gpu, false, submit->fence);
 	}
 
-	gpu->funcs->submit(gpu, submit, ctx);
-	priv->lastctx = ctx;
+	gpu->funcs->submit(gpu, submit);
+	priv->lastctx = submit->queue->ctx;
 
 	hangcheck_timer_reset(gpu);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 97c527e98391..1f96ac0d9049 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -45,8 +45,7 @@ struct msm_gpu_funcs {
 	int (*hw_init)(struct msm_gpu *gpu);
 	int (*pm_suspend)(struct msm_gpu *gpu);
 	int (*pm_resume)(struct msm_gpu *gpu);
-	void (*submit)(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-			struct msm_file_private *ctx);
+	void (*submit)(struct msm_gpu *gpu, struct msm_gem_submit *submit);
 	void (*flush)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 	irqreturn_t (*irq)(struct msm_gpu *irq);
 	struct msm_ringbuffer *(*active_ring)(struct msm_gpu *gpu);
@@ -290,8 +289,7 @@ int msm_gpu_perfcntr_sample(struct msm_gpu *gpu, uint32_t *activetime,
 		uint32_t *totaltime, uint32_t ncntrs, uint32_t *cntrs);
 
 void msm_gpu_retire(struct msm_gpu *gpu);
-void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-		struct msm_file_private *ctx);
+void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit);
 
 int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
