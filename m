Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8CEC433E7
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85D62067C
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C20tEzs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85D62067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B09B8870DF;
	Tue,  1 Sep 2020 16:46:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id llObrDeNCSuy; Tue,  1 Sep 2020 16:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 09BFF870C7;
	Tue,  1 Sep 2020 16:46:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 030EFC0052;
	Tue,  1 Sep 2020 16:46:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3F82C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B1450204E8
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jgYwBqLOfTiN for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 16:46:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 120D820505
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:36 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id a8so821778plm.2
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2liumjG+7/DHabFJ1OVqIZ4d6sswHHCz0LQDjQhDWhY=;
 b=C20tEzs8cI1H5PWiGg7J6Kjt3dMuz4+iyz56eppjCZaUo+/nLcDmNVBSysjSmXR9MJ
 O5Dx3v1bteUe0y/A49OPZxOSqu/z0kM9BdIdemL6ZbLMU641IiYVpatlN5HEZGIJHrjf
 OPumT0M4psa//xyxK4VWjGxkiqHel7QA2TyIZip2qUIjGJoTnL4jXTSGDHJCfwktAoSh
 6argkZidvJ2KXJV83LigiE/qzq/lfm2JSx8Vj3zF+Yg1RnsmK8bhCs7WWdbWI0HQz1Di
 HwDJ7f2xiXpVeEoCK62ngnCL7P/LUMJo+H5yZRN7psT57RB0Eoj3v4J6+lKK2g6Df87H
 YwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2liumjG+7/DHabFJ1OVqIZ4d6sswHHCz0LQDjQhDWhY=;
 b=SYgxM5IEjXAY+wyipNsjyWaW8m0QDhpeKYJIUHgC+8BKC/DcCsvZH0MxFcUH0p9utN
 YU+d+rNNhaHsvPcmd4Hsxifg4rhjYdCGFvxuhM99b1hGnaqtAQXkPOG38WAYR3WiUdCN
 t3N/pUsw+3aa78A9CZSzMR49aZh1yc5ViuPQPs2xBEdsnVkZ/WL65CF9uwTyOD+3PX2y
 fKGNLSI12X7mrAAPlcDeNvgP776Uzg0IV4ivJNaoeDf9O+b0LvnEAyqteqbhYsuLH/ny
 VKB6MBliLXB4YMVY4y0e8cAxtD++iDeh8/09m8JmpLgMJ882Uk2KTtNu6C+0tEEQ3Ndm
 dnZA==
X-Gm-Message-State: AOAM5328/Lc+qrjoA43fc2NnZ1Z5lBEsYRMdIZfuq7K5w+pNPfj281Dl
 pHZzQolu0TYfYnG7oJcOIwI=
X-Google-Smtp-Source: ABdhPJxNThLmHXZCNlUm17Utzn//s/mjDY83Fykyc8blnjX/mneV7FWFBAjkw40Nltmm9C5ej2jfZw==
X-Received: by 2002:a17:902:758d:: with SMTP id
 j13mr1256122pll.174.1598978795601; 
 Tue, 01 Sep 2020 09:46:35 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id 9sm2548653pfv.22.2020.09.01.09.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:46:34 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v16 05/20] drm/msm: Add a context pointer to the submitqueue
Date: Tue,  1 Sep 2020 09:46:22 -0700
Message-Id: <20200901164707.2645413-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901164707.2645413-1-robdclark@gmail.com>
References: <20200901164707.2645413-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Sean Paul <sean@poorly.run>, open list <linux-kernel@vger.kernel.org>
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

Each submitqueue is attached to a context. Add a pointer to the
context to the submitqueue at create time and refcount it so
that it stays around through the life of the queue.

Co-developed-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/msm_drv.c         |  3 ++-
 drivers/gpu/drm/msm/msm_drv.h         | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/msm_gem.h         |  1 +
 drivers/gpu/drm/msm/msm_gem_submit.c  |  6 +++---
 drivers/gpu/drm/msm/msm_gpu.h         |  1 +
 drivers/gpu/drm/msm/msm_submitqueue.c |  3 +++
 6 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 79333842f70a..75cd7639f560 100644
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
+	msm_file_private_put(ctx);
 }
 
 static void msm_postclose(struct drm_device *dev, struct drm_file *file)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index af259b0573ea..4561bfb5e745 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -57,6 +57,7 @@ struct msm_file_private {
 	struct list_head submitqueues;
 	int queueid;
 	struct msm_gem_address_space *aspace;
+	struct kref ref;
 };
 
 enum msm_mdp_plane_property {
@@ -428,6 +429,25 @@ void msm_submitqueue_close(struct msm_file_private *ctx);
 
 void msm_submitqueue_destroy(struct kref *kref);
 
+static inline void __msm_file_private_destroy(struct kref *kref)
+{
+	struct msm_file_private *ctx = container_of(kref,
+		struct msm_file_private, ref);
+
+	kfree(ctx);
+}
+
+static inline void msm_file_private_put(struct msm_file_private *ctx)
+{
+	kref_put(&ctx->ref, __msm_file_private_destroy);
+}
+
+static inline struct msm_file_private *msm_file_private_get(
+	struct msm_file_private *ctx)
+{
+	kref_get(&ctx->ref);
+	return ctx;
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
index 8cb9aa15ff90..1464b04d25d3 100644
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
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index f91b141add75..97c527e98391 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -190,6 +190,7 @@ struct msm_gpu_submitqueue {
 	u32 flags;
 	u32 prio;
 	int faults;
+	struct msm_file_private *ctx;
 	struct list_head node;
 	struct kref ref;
 };
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 90c9d84e6155..c3d206105d28 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -12,6 +12,8 @@ void msm_submitqueue_destroy(struct kref *kref)
 	struct msm_gpu_submitqueue *queue = container_of(kref,
 		struct msm_gpu_submitqueue, ref);
 
+	msm_file_private_put(queue->ctx);
+
 	kfree(queue);
 }
 
@@ -83,6 +85,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
 
 	write_lock(&ctx->queuelock);
 
+	queue->ctx = msm_file_private_get(ctx);
 	queue->id = ctx->queueid++;
 
 	if (id)
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
