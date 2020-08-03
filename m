Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87806C433E0
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 19:36:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090CD207DF
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 19:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="huOpSAJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090CD207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA39E85045;
	Mon,  3 Aug 2020 19:36:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z0+I6l78XFeD; Mon,  3 Aug 2020 19:36:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 60A8284ECF;
	Mon,  3 Aug 2020 19:36:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E76EC0051;
	Mon,  3 Aug 2020 19:36:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4EA2C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 19:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 947A1853C3
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 19:36:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pfrzfphokNq0 for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 19:36:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 565FB852D5
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 19:36:27 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1596483387; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/WjUrlTXh5D2SPZiwegkNsn6ZuyTBrGm+RToSc4ezM0=;
 b=huOpSAJ+aBaUfEEeJANnmWjPONSOMTQndglyMqXhWJBhiOABPFBNulCJVuY0JyYh/1sK0OoR
 dBPhiVo8s1MY7pOK3P1zpkjWxab8uih6gILUZSJTsXOyX+uh9q6cjKyfm74IM6H7MqUz9z3O
 DCQ8G7v8LxdMhjBUo7HFcxtWLdU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f28673b21feae908b5d231a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 Aug 2020 19:36:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id BC8BDC43459; Mon,  3 Aug 2020 19:36:21 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 74B77C433B2;
 Mon,  3 Aug 2020 19:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74B77C433B2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v11 07/12] drm/msm: Add a context pointer to the submitqueue
Date: Mon,  3 Aug 2020 13:35:42 -0600
Message-Id: <20200803193547.305660-8-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803193547.305660-1-jcrouse@codeaurora.org>
References: <20200803193547.305660-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Emil Velikov <emil.velikov@collabora.com>, Jonathan Marek <jonathan@marek.ca>,
 iommu@lists.linux-foundation.org, Ben Dooks <ben.dooks@codethink.co.uk>,
 Wambui Karuga <wambui.karugax@gmail.com>,
 Sharat Masetty <smasetty@codeaurora.org>, Brian Masney <masneyb@onstation.org>,
 Sean Paul <sean@poorly.run>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Shawn Guo <shawn.guo@linaro.org>, freedreno@lists.freedesktop.org
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

Each submitqueue is attached to a context. Add a pointer to the
context to the submitqueue at create time and refcount it so
that it stays around through the life of the queue.

GPU submissions can access the active context via the submitqueue
instead of requiring it to be passed around from function to
function.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 12 +++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  5 ++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  5 ++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  3 +--
 drivers/gpu/drm/msm/msm_drv.c           |  3 ++-
 drivers/gpu/drm/msm/msm_drv.h           |  8 ++++++++
 drivers/gpu/drm/msm/msm_gem.h           |  1 +
 drivers/gpu/drm/msm/msm_gem_submit.c    |  8 ++++----
 drivers/gpu/drm/msm/msm_gpu.c           |  9 ++++-----
 drivers/gpu/drm/msm/msm_gpu.h           |  7 +++----
 drivers/gpu/drm/msm/msm_submitqueue.c   |  8 +++++++-
 11 files changed, 39 insertions(+), 30 deletions(-)

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
index e23641a5ec84..b38a8126541a 100644
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
index 99bb468f5f24..0ae8b373c428 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -267,8 +267,7 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
 		const struct firmware *fw, u64 *iova);
 int adreno_hw_init(struct msm_gpu *gpu);
 void adreno_recover(struct msm_gpu *gpu);
-void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-		struct msm_file_private *ctx);
+void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit);
 void adreno_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 bool adreno_idle(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 7d641c7e3514..108b663c3ef2 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -594,6 +594,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 	if (!ctx)
 		return -ENOMEM;
 
+	kref_init(&ctx->ref);
 	msm_submitqueue_init(dev, ctx);
 
 	ctx->aspace = priv->gpu ? priv->gpu->aspace : NULL;
@@ -615,7 +616,7 @@ static int msm_open(struct drm_device *dev, struct drm_file *file)
 static void context_close(struct msm_file_private *ctx)
 {
 	msm_submitqueue_close(ctx);
-	kfree(ctx);
+	kref_put(&ctx->ref, msm_file_private_destroy);
 }
 
 static void msm_postclose(struct drm_device *dev, struct drm_file *file)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index af259b0573ea..f69c6d62584d 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -57,6 +57,7 @@ struct msm_file_private {
 	struct list_head submitqueues;
 	int queueid;
 	struct msm_gem_address_space *aspace;
+	struct kref ref;
 };
 
 enum msm_mdp_plane_property {
@@ -428,6 +429,13 @@ void msm_submitqueue_close(struct msm_file_private *ctx);
 
 void msm_submitqueue_destroy(struct kref *kref);
 
+static inline void msm_file_private_destroy(struct kref *kref)
+{
+	struct msm_file_private *ctx = container_of(kref,
+		struct msm_file_private, ref);
+
+	kfree(ctx);
+}
 
 #define DBG(fmt, ...) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
 #define VERB(fmt, ...) if (0) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 972490b14ba5..9c573c4269cb 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -142,6 +142,7 @@ struct msm_gem_submit {
 	bool valid;         /* true if no cmdstream patching needed */
 	bool in_rb;         /* "sudo" mode, copy cmds into RB */
 	struct msm_ringbuffer *ring;
+	struct msm_file_private *ctx;
 	unsigned int nr_cmds;
 	unsigned int nr_bos;
 	u32 ident;	   /* A "identifier" for the submit for logging */
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 8cb9aa15ff90..aa5c60a7132d 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -27,7 +27,7 @@
 #define BO_PINNED   0x2000
 
 static struct msm_gem_submit *submit_create(struct drm_device *dev,
-		struct msm_gpu *gpu, struct msm_gem_address_space *aspace,
+		struct msm_gpu *gpu,
 		struct msm_gpu_submitqueue *queue, uint32_t nr_bos,
 		uint32_t nr_cmds)
 {
@@ -43,7 +43,7 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 		return NULL;
 
 	submit->dev = dev;
-	submit->aspace = aspace;
+	submit->aspace = queue->ctx->aspace;
 	submit->gpu = gpu;
 	submit->fence = NULL;
 	submit->cmd = (void *)&submit->bos[nr_bos];
@@ -677,7 +677,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		}
 	}
 
-	submit = submit_create(dev, gpu, ctx->aspace, queue, args->nr_bos,
+	submit = submit_create(dev, gpu, queue, args->nr_bos,
 		args->nr_cmds);
 	if (!submit) {
 		ret = -ENOMEM;
@@ -785,7 +785,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		}
 	}
 
-	msm_gpu_submit(gpu, submit, ctx);
+	msm_gpu_submit(gpu, submit);
 
 	args->fence = submit->fence->seqno;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index d5645472b25d..a1f3da6550e5 100644
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
index 0db117a7339b..d496d488222c 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -44,8 +44,7 @@ struct msm_gpu_funcs {
 	int (*hw_init)(struct msm_gpu *gpu);
 	int (*pm_suspend)(struct msm_gpu *gpu);
 	int (*pm_resume)(struct msm_gpu *gpu);
-	void (*submit)(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-			struct msm_file_private *ctx);
+	void (*submit)(struct msm_gpu *gpu, struct msm_gem_submit *submit);
 	void (*flush)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 	irqreturn_t (*irq)(struct msm_gpu *irq);
 	struct msm_ringbuffer *(*active_ring)(struct msm_gpu *gpu);
@@ -181,6 +180,7 @@ struct msm_gpu_submitqueue {
 	u32 flags;
 	u32 prio;
 	int faults;
+	struct msm_file_private *ctx;
 	struct list_head node;
 	struct kref ref;
 };
@@ -280,8 +280,7 @@ int msm_gpu_perfcntr_sample(struct msm_gpu *gpu, uint32_t *activetime,
 		uint32_t *totaltime, uint32_t ncntrs, uint32_t *cntrs);
 
 void msm_gpu_retire(struct msm_gpu *gpu);
-void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
-		struct msm_file_private *ctx);
+void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit);
 
 int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index a1d94be7883a..10f557225a3e 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -49,8 +49,10 @@ void msm_submitqueue_close(struct msm_file_private *ctx)
 	 * No lock needed in close and there won't
 	 * be any more user ioctls coming our way
 	 */
-	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node)
+	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node) {
+		kref_put(&ctx->ref, msm_file_private_destroy);
 		msm_submitqueue_put(entry);
+	}
 }
 
 int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
@@ -81,6 +83,9 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
 
 	write_lock(&ctx->queuelock);
 
+	kref_get(&ctx->ref);
+
+	queue->ctx = ctx;
 	queue->id = ctx->queueid++;
 
 	if (id)
@@ -177,6 +182,7 @@ int msm_submitqueue_remove(struct msm_file_private *ctx, u32 id)
 			list_del(&entry->node);
 			write_unlock(&ctx->queuelock);
 
+			kref_put(&ctx->ref, msm_file_private_destroy);
 			msm_submitqueue_put(entry);
 			return 0;
 		}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
