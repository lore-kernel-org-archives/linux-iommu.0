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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FCEC433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0342078B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diYFxRQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0342078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 79A63870D7;
	Tue,  1 Sep 2020 16:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z2IdsyoPQXkB; Tue,  1 Sep 2020 16:46:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E2490870BB;
	Tue,  1 Sep 2020 16:46:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEDCAC0052;
	Tue,  1 Sep 2020 16:46:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 279E7C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1EB4A204E8
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SZeyZQ18F60A for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 16:46:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 923A32034D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:32 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id f18so1110281pfa.10
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9GY8MTV08PrdHUp+EWWyNucwylbtR4J8MJ49qiKRTr8=;
 b=diYFxRQBFCAYzBMr1oUdzb90W8KPNy1WuyBKtljKjHAsRM6NJtOgedMjx4M0bbCDQg
 1NokvIoSeI5QQcdk6vTojUxuiMokN3r33V1FHU8uVaQ14ufEsfsb3Nvx1iVIBAexr9H/
 283ozm+4h7ZptZESKcLhyBqrLn89MnSBsD9w0mibZJZ7q0oEdNm6nJpnsenZRJHEuHPY
 Bz+lAcKZMBzXfwiFf0M2NtgabZxm4VoIyDyGNYia6T7GB7gtM49q9T0bxdundFLyn1Iu
 ouTkPBFotIrezZ9aXt71kBbK+tYVdLk09S967qZQ4Emfr+8HXiXcg5A2UTZMlWa/dxCX
 hHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9GY8MTV08PrdHUp+EWWyNucwylbtR4J8MJ49qiKRTr8=;
 b=A3rAEeUCLP/uTRyYuukArIOc4zGSk/W4BSYL8VXDltsz8+Y9FQRZ6wt9zpEREIr/C3
 Qe606RSeWW9gbird1IKl3xirkP4ir7QfWkJ/dfZLbFuTytQMcLAumW/k60SRDEUExxRa
 UTUNiXH3aClIEGqlcPHJyU1llPao1HDwAWKW4mp10QHS5dWqX3oHr4Toa/sCKJOWvQqG
 2xdoIB1pfOdzy52YKJ3KSKqHfcTR9juQ0VO2sVN4eeYfVdpdAX9/hBCcXNEofmhLNal6
 6Aigj3iXJPtdRvgY692GgESRTDRiEE9KwRC18g+lD/ZMsMo4uO+uP4upU37Df1XL6L8w
 TSZg==
X-Gm-Message-State: AOAM531ZKXEaLQyUF4RD6Jek2h4Q9CU4YHYKVe5+KtBOriRpR4E/s7t0
 kbefIpFiH4wfMrYXIhNZgP0+0Oxiw0gxCmqU
X-Google-Smtp-Source: ABdhPJxkErnGII/ajapuRB93tieR8/YaguR9xdhO4M2IHzqSfAfV4/ovlSOHBb+EyThZc7WuL4iTfA==
X-Received: by 2002:a63:2043:: with SMTP id r3mr2258427pgm.289.1598978792128; 
 Tue, 01 Sep 2020 09:46:32 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id s187sm79986pfc.134.2020.09.01.09.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:46:31 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v16 04/20] drm/msm: Set adreno_smmu as gpu's drvdata
Date: Tue,  1 Sep 2020 09:46:21 -0700
Message-Id: <20200901164707.2645413-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901164707.2645413-1-robdclark@gmail.com>
References: <20200901164707.2645413-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>,
 David Airlie <airlied@linux.ie>, Shawn Guo <shawn.guo@linaro.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
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

From: Rob Clark <robdclark@chromium.org>

This will be populated by adreno-smmu, to provide a way for coordinating
enabling/disabling TTBR0 translation.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 2 --
 drivers/gpu/drm/msm/msm_gpu.c              | 2 +-
 drivers/gpu/drm/msm/msm_gpu.h              | 6 +++++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 26664e1b30c0..58e03b20e1c7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -417,8 +417,6 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(gpu);
 	}
 
-	dev_set_drvdata(dev, gpu);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 6aa9e04e52e7..806eb0957280 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -892,7 +892,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		gpu->gpu_cx = NULL;
 
 	gpu->pdev = pdev;
-	platform_set_drvdata(pdev, gpu);
+	platform_set_drvdata(pdev, &gpu->adreno_smmu);
 
 	msm_devfreq_init(gpu);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 8bda7beaed4b..f91b141add75 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -7,6 +7,7 @@
 #ifndef __MSM_GPU_H__
 #define __MSM_GPU_H__
 
+#include <linux/adreno-smmu-priv.h>
 #include <linux/clk.h>
 #include <linux/interconnect.h>
 #include <linux/pm_opp.h>
@@ -73,6 +74,8 @@ struct msm_gpu {
 	struct platform_device *pdev;
 	const struct msm_gpu_funcs *funcs;
 
+	struct adreno_smmu_priv adreno_smmu;
+
 	/* performance counters (hw & sw): */
 	spinlock_t perf_lock;
 	bool perfcntr_active;
@@ -143,7 +146,8 @@ struct msm_gpu {
 
 static inline struct msm_gpu *dev_to_gpu(struct device *dev)
 {
-	return dev_get_drvdata(dev);
+	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(dev);
+	return container_of(adreno_smmu, struct msm_gpu, adreno_smmu);
 }
 
 /* It turns out that all targets use the same ringbuffer size */
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
