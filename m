Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD59C433DF
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:42:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F68B20838
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFIXpeqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F68B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 831D488A5E;
	Fri, 14 Aug 2020 02:42:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id othPdfFi-q6u; Fri, 14 Aug 2020 02:42:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E266B88A56;
	Fri, 14 Aug 2020 02:42:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCA82C07FF;
	Fri, 14 Aug 2020 02:42:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14560C004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 10DAC878FE
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:42:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RWM4bqyojbf4 for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 02:42:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 579908796C
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:42:02 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id v15so3818691pgh.6
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 19:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E59Nq2pttf4LeQXvZqVPv0sPEVlUkfb3pwyFFLxnuGA=;
 b=EFIXpeqexttFjeEDRuhe+DhNoMr3tB1PiDz671qzAllqT3f59uuNhJjtIkYdsRGCVb
 0pI2GRkvRnTHv+kxv/mZZMZEFfz3kB8MjGbhhL/YtpA1M9rjWNfJoVRmxCm7WiWdKn9p
 vHtrjgta/w0HhClZywrtHfG4M9Pa/YrESyWG/BGKAJLhgc/Kw4Zo75NvA6z0MWQof/qr
 hY4cZiJ5DrFOX8YUwfQNh8u2X3DgDNZdZp9/BrwriOcX3kF9cb7ZOlfD8xn49wnvSsU1
 IRFuYssusa5sV9+x67BmcBdNZvrXX+nBw02FbjJikXHVHGEUAgvs14RvYTQnCqtmkgpW
 SVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E59Nq2pttf4LeQXvZqVPv0sPEVlUkfb3pwyFFLxnuGA=;
 b=o0TbhKBlkXoe2Uh4lW8eXijrmeZSF5axOQQ1XeEjG/uRguuTykZVb+NHzL+rVT/T7a
 FeSjTP76lGm8gYKjctWixvXTp9RmuW1TaxJ8F1VpAGwUQWZG7mJSUhaucXeu0aduurqX
 A2Q0waUWgv7nyqUsLIg/iYjpc5Pmw391WUIUtSPt49Sf7v8DkahczS8DLF86CLnhnXOt
 0BjIvwcQBTtyQGgYT3z4lO63AYAZrJG4yzeoZFBnrTl/JLyANhkEqqn78SvV8x6tv91c
 5px2J5A8j1KHFpvXlyoQwKdsYjL5JSb/pN/jbP+x2xm3lH9tgOGLG6hEub3SOAC9yJSM
 DC8A==
X-Gm-Message-State: AOAM532NI7ygkDzYBRV5aEchygboXXvL6DfZI0sUUpdvlrN1qXStRhbM
 llPwM85Nhj7k0qMp4J3LM3g=
X-Google-Smtp-Source: ABdhPJzsyABvOOf2O9DGT5EKq+q6ngPmNzGfyyoO6Rzaje181mDwB92bG4ZFa1F8atypLlY9SNR+fQ==
X-Received: by 2002:a63:7a06:: with SMTP id v6mr354721pgc.441.1597372921873;
 Thu, 13 Aug 2020 19:42:01 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id d23sm2233273pgm.11.2020.08.13.19.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 19:42:00 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 15/19] drm/msm: Add support for private address space instances
Date: Thu, 13 Aug 2020 19:41:10 -0700
Message-Id: <20200814024114.1177553-16-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200810222657.1841322-1-jcrouse@codeaurora.org>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
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

Add support for allocating private address space instances. Targets that
support per-context pagetables should implement their own function to
allocate private address spaces.

The default will return a pointer to the global address space.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c     | 13 +++++++------
 drivers/gpu/drm/msm/msm_drv.h     |  5 +++++
 drivers/gpu/drm/msm/msm_gem_vma.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.c     | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.h     |  5 +++++
 5 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 01845a3b8d52..8e70d220bba8 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -597,7 +597,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 	kref_init(&ctx->ref);
 	msm_submitqueue_init(dev, ctx);
 
-	ctx->aspace = priv->gpu ? priv->gpu->aspace : NULL;
+	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu);
 	file->driver_priv = ctx;
 
 	return 0;
@@ -780,18 +780,19 @@ static int msm_ioctl_gem_cpu_fini(struct drm_device *dev, void *data,
 }
 
 static int msm_ioctl_gem_info_iova(struct drm_device *dev,
-		struct drm_gem_object *obj, uint64_t *iova)
+		struct drm_file *file, struct drm_gem_object *obj,
+		uint64_t *iova)
 {
-	struct msm_drm_private *priv = dev->dev_private;
+	struct msm_file_private *ctx = file->driver_priv;
 
-	if (!priv->gpu)
+	if (!ctx->aspace)
 		return -EINVAL;
 
 	/*
 	 * Don't pin the memory here - just get an address so that userspace can
 	 * be productive
 	 */
-	return msm_gem_get_iova(obj, priv->gpu->aspace, iova);
+	return msm_gem_get_iova(obj, ctx->aspace, iova);
 }
 
 static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
@@ -830,7 +831,7 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		args->value = msm_gem_mmap_offset(obj);
 		break;
 	case MSM_INFO_GET_IOVA:
-		ret = msm_ioctl_gem_info_iova(dev, obj, &args->value);
+		ret = msm_ioctl_gem_info_iova(dev, file, obj, &args->value);
 		break;
 	case MSM_INFO_SET_NAME:
 		/* length check should leave room for terminating null: */
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 4561bfb5e745..2ca9c3c03845 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -249,6 +249,10 @@ int msm_gem_map_vma(struct msm_gem_address_space *aspace,
 void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma);
 
+
+struct msm_gem_address_space *
+msm_gem_address_space_get(struct msm_gem_address_space *aspace);
+
 void msm_gem_address_space_put(struct msm_gem_address_space *aspace);
 
 struct msm_gem_address_space *
@@ -434,6 +438,7 @@ static inline void __msm_file_private_destroy(struct kref *kref)
 	struct msm_file_private *ctx = container_of(kref,
 		struct msm_file_private, ref);
 
+	msm_gem_address_space_put(ctx->aspace);
 	kfree(ctx);
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 5f6a11211b64..29cc1305cf37 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -27,6 +27,15 @@ void msm_gem_address_space_put(struct msm_gem_address_space *aspace)
 		kref_put(&aspace->kref, msm_gem_address_space_destroy);
 }
 
+struct msm_gem_address_space *
+msm_gem_address_space_get(struct msm_gem_address_space *aspace)
+{
+	if (!IS_ERR_OR_NULL(aspace))
+		kref_get(&aspace->kref);
+
+	return aspace;
+}
+
 /* Actually unmap memory for the vma */
 void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index e1a3cbe25a0c..951850804d77 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -823,6 +823,28 @@ static int get_clocks(struct platform_device *pdev, struct msm_gpu *gpu)
 	return 0;
 }
 
+/* Return a new address space for a msm_drm_private instance */
+struct msm_gem_address_space *
+msm_gpu_create_private_address_space(struct msm_gpu *gpu)
+{
+	struct msm_gem_address_space *aspace = NULL;
+
+	if (!gpu)
+		return NULL;
+
+	/*
+	 * If the target doesn't support private address spaces then return
+	 * the global one
+	 */
+	if (gpu->funcs->create_private_address_space)
+		aspace = gpu->funcs->create_private_address_space(gpu);
+
+	if (IS_ERR_OR_NULL(aspace))
+		aspace = msm_gem_address_space_get(gpu->aspace);
+
+	return aspace;
+}
+
 int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
 		const char *name, struct msm_gpu_config *config)
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 1f96ac0d9049..4052a18e18c2 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -65,6 +65,8 @@ struct msm_gpu_funcs {
 	void (*gpu_set_freq)(struct msm_gpu *gpu, struct dev_pm_opp *opp);
 	struct msm_gem_address_space *(*create_address_space)
 		(struct msm_gpu *gpu, struct platform_device *pdev);
+	struct msm_gem_address_space *(*create_private_address_space)
+		(struct msm_gpu *gpu);
 };
 
 struct msm_gpu {
@@ -295,6 +297,9 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
 		const char *name, struct msm_gpu_config *config);
 
+struct msm_gem_address_space *
+msm_gpu_create_private_address_space(struct msm_gpu *gpu);
+
 void msm_gpu_cleanup(struct msm_gpu *gpu);
 
 struct msm_gpu *adreno_load_gpu(struct drm_device *dev);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
