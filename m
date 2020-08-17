Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F09C433E4
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:02:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0A320786
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSiV58US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0A320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D1EA878BB;
	Mon, 17 Aug 2020 22:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZksAa6eBT2k; Mon, 17 Aug 2020 22:02:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7ED43878A8;
	Mon, 17 Aug 2020 22:02:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B3E0C088B;
	Mon, 17 Aug 2020 22:02:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFF0FC0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8C72985722
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SkHbT05o3t9P for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 22:02:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 56587855CC
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:35 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id t10so8219605plz.10
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wvz5YKiT932AWU4GOoumP4PC6lpfTwxubtkW9TJEg2g=;
 b=PSiV58USy6C7h9g+3N7CkyKem7FFwM9Mj3+dcYPerZWcI1GQVjnBu1vlu5xI3SHctE
 etWYrHQomPdBIiVuCk5OPu/yUi+/uCXg9z4r3BfYBudEj4TXVx6AlwgHrxOn3Djkuh6I
 VId/SC3aj3Kh2LfNnB5eS8IxzkOkdzbVrCi2QlLDwSq4jdMX1TUukLoPbW9vEZCWO3Pg
 E3UO1M84JGXmykPB8O2fY0nAqKxWWJzru4tNF/2ClDXvuIzaVUhCZbtPeP2/dI9pdG2Q
 YCN/FgzAb3zhoks4dcm8MIL9XVc8GRI+rd8d9/xLbHacPd7eohpHB3DBwbsxuyAMUYs1
 9oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wvz5YKiT932AWU4GOoumP4PC6lpfTwxubtkW9TJEg2g=;
 b=NVoDIXxEInNCm6u0nVrU5oxyYfDGh2gOx7xt35XSUvrEUHM8/pn1uv+6NCnAJF+hTw
 DomoTpcX8XFI76uiIlxF1QwAytKli2H5uLjt/7qVVCEAfxAs73Web7RHJy9NOa9Eihyh
 Vb6q669gfNE0Gvnc6ZDxIAkJxRLbaTCZKGK7rEqMV6DLEe0tAK/hSH3ozlcl/PSfz76V
 k2ip/UNDGz1AcsD/GbjgAFixWJkzD0DW+sojuJYXVwsBA28cTYQZRako0UkYNWvzxnN8
 YeJk7COg9UrYpRtDcMF8/hepE/StA6tJxbeJKfY8tjPmzb7KwSgQFyi6mmwdmSyAh4EB
 +88A==
X-Gm-Message-State: AOAM530aNnwNMqTleUVgN7b/cfZxGEwQAJuEcsJZ7fSz+7FwQuTEF1o2
 /GkRJCwydiRgJZ/hcnNnO/c=
X-Google-Smtp-Source: ABdhPJygcQQMG1n+yfZRF3rHKTdu4DvQo6yoXYPF3Kp0PgJGNgE8mv3gC7OazZ3tfaqONTYigjsxmw==
X-Received: by 2002:a17:902:9693:: with SMTP id
 n19mr5444193plp.33.1597701754348; 
 Mon, 17 Aug 2020 15:02:34 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 2sm19274989pjg.32.2020.08.17.15.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 15:02:32 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 06/20] drm/msm/gpu: add dev_to_gpu() helper
Date: Mon, 17 Aug 2020 15:01:31 -0700
Message-Id: <20200817220238.603465-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817220238.603465-1-robdclark@gmail.com>
References: <20200817220238.603465-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sean Paul <sean@poorly.run>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Sharat Masetty <smasetty@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
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

From: Rob Clark <robdclark@chromium.org>

In a later patch, the drvdata will not directly be 'struct msm_gpu *',
so add a helper to reduce the churn.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 10 ++++------
 drivers/gpu/drm/msm/msm_gpu.c              |  6 +++---
 drivers/gpu/drm/msm/msm_gpu.h              |  5 +++++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 9eeb46bf2a5d..26664e1b30c0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -282,7 +282,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	int ret;
 
 	if (pdev)
-		gpu = platform_get_drvdata(pdev);
+		gpu = dev_to_gpu(&pdev->dev);
 
 	if (!gpu) {
 		dev_err_once(dev->dev, "no GPU device was found\n");
@@ -425,7 +425,7 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 static void adreno_unbind(struct device *dev, struct device *master,
 		void *data)
 {
-	struct msm_gpu *gpu = dev_get_drvdata(dev);
+	struct msm_gpu *gpu = dev_to_gpu(dev);
 
 	pm_runtime_force_suspend(dev);
 	gpu->funcs->destroy(gpu);
@@ -490,16 +490,14 @@ static const struct of_device_id dt_match[] = {
 #ifdef CONFIG_PM
 static int adreno_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_gpu *gpu = platform_get_drvdata(pdev);
+	struct msm_gpu *gpu = dev_to_gpu(dev);
 
 	return gpu->funcs->pm_resume(gpu);
 }
 
 static int adreno_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_gpu *gpu = platform_get_drvdata(pdev);
+	struct msm_gpu *gpu = dev_to_gpu(dev);
 
 	return gpu->funcs->pm_suspend(gpu);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index d5645472b25d..6aa9e04e52e7 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -24,7 +24,7 @@
 static int msm_devfreq_target(struct device *dev, unsigned long *freq,
 		u32 flags)
 {
-	struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
+	struct msm_gpu *gpu = dev_to_gpu(dev);
 	struct dev_pm_opp *opp;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
@@ -45,7 +45,7 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
 static int msm_devfreq_get_dev_status(struct device *dev,
 		struct devfreq_dev_status *status)
 {
-	struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
+	struct msm_gpu *gpu = dev_to_gpu(dev);
 	ktime_t time;
 
 	if (gpu->funcs->gpu_get_freq)
@@ -64,7 +64,7 @@ static int msm_devfreq_get_dev_status(struct device *dev,
 
 static int msm_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
 {
-	struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
+	struct msm_gpu *gpu = dev_to_gpu(dev);
 
 	if (gpu->funcs->gpu_get_freq)
 		*freq = gpu->funcs->gpu_get_freq(gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 0db117a7339b..8bda7beaed4b 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -141,6 +141,11 @@ struct msm_gpu {
 	struct msm_gpu_state *crashstate;
 };
 
+static inline struct msm_gpu *dev_to_gpu(struct device *dev)
+{
+	return dev_get_drvdata(dev);
+}
+
 /* It turns out that all targets use the same ringbuffer size */
 #define MSM_GPU_RINGBUFFER_SZ SZ_32K
 #define MSM_GPU_RINGBUFFER_BLKSIZE 32
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
