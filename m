Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24FCC433E2
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA8A2073B
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBj7GWcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA8A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6405E86850;
	Sat,  5 Sep 2020 20:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wnvYMmiU2NPs; Sat,  5 Sep 2020 20:04:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EC25886772;
	Sat,  5 Sep 2020 20:04:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E320DC07FF;
	Sat,  5 Sep 2020 20:04:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A61FC0051
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 58FC586776
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NtfJKdtzLW9d for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 20:04:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CDF7886772
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 20:04:11 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id q3so2663953pls.11
 for <iommu@lists.linux-foundation.org>; Sat, 05 Sep 2020 13:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eBuEDGfYTy5PPn1RDxCycEVRZJaKkkv9eSmYF9/QNHA=;
 b=rBj7GWccfosFE5ZBxHIGrVT0r+K4byI3/hnMfzfkdhsP6dHgrnWuatoE2Hcu7egNBN
 h48KLqcTSVasryom6dH1s1FsCm7iVkSfNO5vxZ24cjYQukx8Rpw0AhWlHnw5qtymJCDK
 xyhsJ63y+KWEcozt1vkTgde5z8ha20eAV2xWI/GdqdGcD26kwh2Dzmv3NL4uxcU3OA9X
 BzEcSbi/GINB8iau0JS5h8q+00AELGfirlHFP6u6q0FJORf1fToSiXMSROk0DoLPblam
 zCpkMoPjbkHSs3rSmkVoM/8nn1REWd32/nW7NKiY1NEuTnI13gcJ8L6WnEsegmWrQQTE
 7FVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eBuEDGfYTy5PPn1RDxCycEVRZJaKkkv9eSmYF9/QNHA=;
 b=WD1Rodjp7wePRK0W6I0rVry6VEwAdu/oUAM/qha54SLTwjHSL6YRe7olxAf2Oxz2Kr
 RGyP4XZlpTpbcl3x8yT8ipQSCo/Afr1/k5dGZ6XV8JeW1t6dl8GHpRcWxr+NdR9yBKrI
 qW1yzWHPiQ2gnbpj/aXyk5+mn0qxGqkarUxCdab9A491MqKkeM2ik0n/AO6G6X5Yt7O0
 lhfS+BWb9rtSf25f5i2cXeeUezIOV6exJX0akhzFjMicCdMY/lBP584dUtsq/2YIGAFP
 GbdO4pUthyRKvh+sPOVRWtI6CUtRuxJIDnjaEOYQEUToB3sNpxz3b6Oz72gI/nmgVH7Q
 1l9Q==
X-Gm-Message-State: AOAM533onX28qvFr/ou9ekU+IzNzwSlTEEOtHvkwgBS6arBWW2T5yPZu
 0wlj2Ggxf4fQmtwjTa3zC+5x9xHAVztrDF84TtQ=
X-Google-Smtp-Source: ABdhPJzbfLaU/Mp1zLSe6ZuOihRa4QPrTK7zg3slAeaOAvr6/R99b+0gyQAeENp1hLMOVDs8q3JHEw==
X-Received: by 2002:a17:90a:e545:: with SMTP id
 ei5mr5624951pjb.45.1599336250560; 
 Sat, 05 Sep 2020 13:04:10 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 u3sm8034863pjn.29.2020.09.05.13.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 13:04:09 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v17 04/20] drm/msm: Set adreno_smmu as gpu's drvdata
Date: Sat,  5 Sep 2020 13:04:10 -0700
Message-Id: <20200905200454.240929-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905200454.240929-1-robdclark@gmail.com>
References: <20200905200454.240929-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Shawn Guo <shawn.guo@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>,
 David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, freedreno@lists.freedesktop.org,
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
index 4c67aedc5c33..144dd63e747e 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -892,7 +892,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		gpu->gpu_cx = NULL;
 
 	gpu->pdev = pdev;
-	platform_set_drvdata(pdev, gpu);
+	platform_set_drvdata(pdev, &gpu->adreno_smmu);
 
 	msm_devfreq_init(gpu);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index da1ae2263047..1f65aec57a8f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -7,6 +7,7 @@
 #ifndef __MSM_GPU_H__
 #define __MSM_GPU_H__
 
+#include <linux/adreno-smmu-priv.h>
 #include <linux/clk.h>
 #include <linux/interconnect.h>
 #include <linux/pm_opp.h>
@@ -74,6 +75,8 @@ struct msm_gpu {
 	struct platform_device *pdev;
 	const struct msm_gpu_funcs *funcs;
 
+	struct adreno_smmu_priv adreno_smmu;
+
 	/* performance counters (hw & sw): */
 	spinlock_t perf_lock;
 	bool perfcntr_active;
@@ -146,7 +149,8 @@ struct msm_gpu {
 
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
