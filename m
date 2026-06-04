Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B65480354
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581186; cv=none; b=XroRG7Kh6e73DueCM3+DUGe3eC/9kYXXcsWa9G650XnPGS4o+kpXpSJTIMdQ7JSVs6O4D7AdHHYPcxHV9PiUxHiP7z+ctjtJP7AJOhJFQG/Y/FZUVYYLGYMYTRjI7zn2DPUZycS+fjogy1RZRo997g8sSEdclDoopApgpPjTPYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581186; c=relaxed/simple;
	bh=J+pt5zvnEKM9VdXyU6yLJevyaM3Qj+rO7ivwmnH2i3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ul/Ept+38jseFo/nnPmAe3izAlffQr0ZEdrwdX9Pro0ADRjzv1QwApeWoC6+vqfFpBaioaDTXPO+7CuL/SAAMVEDOimRk0ABMFBcfJJZYCozM2mLS7KmVnjwZezkxTgMYXURVF0LXNnzcgl36Vo2Iw16yymXbPY4Kz1QHWdaK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtJnx/c2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtJnx/c2"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ee6d32402so421620f8f.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581181; x=1781185981; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peByEg9qkw/NuaYmCEAUEFnpiWasS3prWUS+hf7e7ys=;
        b=QtJnx/c2l33XbydpyDsHfz5Ktbzn8SCaWEMA4evu5SlOdfhUS02qrCNxPmNRuqHnpJ
         KzzVxIqdJyvMIIR+3U5hcCyHCwogEcobwyLLxrTl38zNjrHGeUGVkN5AxvPVn4KOz/cc
         ZD0tldrv34Q3mCxvDkgaFhW7gh0Yq2LGMoVIsgO01ZXYMdIAORB4fSTooNDJr9hpgqtZ
         8+m/PPClOMuzTNamMhHMTsv+4eMQ/ZP0uybL3IXJI1Oph8F25wRXqa+4f8fan5gQUtNY
         zfICqyzvlBcbtacxSz7GMpcLghnFaxdQn2GF8e4WNcZ4lmIz1RLBoJqguV4syccsN6TA
         CbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581181; x=1781185981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=peByEg9qkw/NuaYmCEAUEFnpiWasS3prWUS+hf7e7ys=;
        b=E7nZ0/HqmM6jXOidlenVm6PeMiSchISdfNMup84ZpiYltAnewYsJ4HJWU1DJl9zvej
         DuI47JtsBMh9FrKRPIosZpPGgIFxhVYZdXWbJbb5252kT4w2BZdNwbyZgvct+FSRGMoz
         BJN19M/ZwgWciPT9UMegEVbDdn9bWN/u6LgI81vPmRa8cu17atwrm+YOr75q4TSSE34Y
         0RNQGi+EgSvsCX5492J+rD8X5pLjcnAYUVHFw73ac8XG2grzJp3gQw8bUi2zKEEc4ri1
         SW8OQ54p4orrFfl61mrOnShOJXO2AWWuWC3H13dxLtGqnnLxEAoosbIODuDdnWCWxuhW
         XHZw==
X-Forwarded-Encrypted: i=1; AFNElJ+XOGP6cL3fpRLa9/MuVEGb6sr51N8XobMY+0Sn0fbiMTunTu49a90D3XRWPiSfxN6BYabzvw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg3ChDDrkdvjLFXkD41mZjrYLLCfoZtcfu2p2sLC0+siu37sZQ
	DPxYiimxXlmJBGXL/heqg/aRx1V/7e+RehToHsqtAu67ItX8SlrmuakX
X-Gm-Gg: Acq92OHyLbYg7BP9rhdbqCWYxYZc8QZcp9N813SJ4EVL4enQvDrM9FWSXP8arThcwN8
	B9dLV1PWLmNfjEnCUtnqzPTUWVH+BEAwB9X5W+nlhjyehQeNaahqoEVTVsPP5DKwnCesv7LePWK
	F7DhfjeV9RdcvQWOWagS7vWcbhEumvGuk+vs0VlmcVgIYryVXm7NPXbS6gAqgk0/jFWH8MkJCKX
	xCu75fkQ8n5re/kATSWAWLB6QYtIaVpfGcGwObg6l1OGJx8BBbDRNaCHmQiY8IYBumLmKcrTzxn
	q3Win0TItIsSwA/nWuXvC2/pUCqaB4wAZFEhqDKiNpTMExMjBpd3YP22fM7yKmf0ZfiEMJ9StIN
	atE4l+Rs1ozyFXi5Ljyq6Y9/A+zwiVLmMorD7NCRSL3cQaI8ernTC9ZwW1rW7R++ZBAeKPQEvlt
	QEvTRC/iOmEpToThzdFFQCKmYTFwGfmB16+5HkvlKYHduqPCdDM8zB6b237idw/yQ=
X-Received: by 2002:a5d:44d2:0:b0:45e:9431:ee3c with SMTP id ffacd0b85a97d-46021792538mr9334388f8f.10.1780581181471;
        Thu, 04 Jun 2026 06:53:01 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:53:01 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 5/9] accel: rocket: Keep the IOMMU domain attached across jobs
Date: Thu,  4 Jun 2026 13:52:51 +0000
Message-Id: <20260604135255.62682-6-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket attached the job's IOMMU domain in rocket_job_run() and
detached it again on every completion and reset. Each attach/detach
toggles the rk_iommu stall/force-reset/paging handshake, and on
RK3568 the NPU MMU is idle between jobs, so that handshake times out
and logs a burst of "stall/paging request timed out" errors for
every job.

Attach the per-context domain once and keep it: track the attached
domain in the core, swap it only when a job from a different context
runs, and detach it at core teardown. A reference on the attached
domain is held so it outlives the job that first attached it and is
released on swap/teardown.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  6 ++++++
 drivers/accel/rocket/rocket_core.h |  3 +++
 drivers/accel/rocket/rocket_job.c  | 27 +++++++++++++++++++++------
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index a8de876365873..634f78dfe2887 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -13,6 +13,7 @@
 #include <linux/reset.h>
 
 #include "rocket_core.h"
+#include "rocket_drv.h"
 #include "rocket_job.h"
 
 int rocket_core_init(struct rocket_core *core)
@@ -112,6 +113,11 @@ void rocket_core_fini(struct rocket_core *core)
 {
 	pm_runtime_dont_use_autosuspend(core->dev);
 	pm_runtime_disable(core->dev);
+	if (core->attached_domain) {
+		iommu_detach_group(NULL, core->iommu_group);
+		rocket_iommu_domain_put(core->attached_domain);
+		core->attached_domain = NULL;
+	}
 	iommu_group_put(core->iommu_group);
 	core->iommu_group = NULL;
 	rocket_job_fini(core);
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index 66d138a8ed773..05a197a9c0113 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -42,6 +42,8 @@ struct rocket_soc_data {
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
+struct rocket_iommu_domain;
+
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
@@ -56,6 +58,7 @@ struct rocket_core {
 	struct reset_control_bulk_data resets[2];
 
 	struct iommu_group *iommu_group;
+	struct rocket_iommu_domain *attached_domain;
 
 	struct mutex job_lock;
 	struct rocket_job *in_flight_job;
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index e25234261536b..b248371be8a1e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -9,6 +9,7 @@
 #include <drm/rocket_accel.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/kref.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -314,9 +315,26 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	if (ret < 0)
 		return fence;
 
-	ret = iommu_attach_group(job->domain->domain, core->iommu_group);
-	if (ret < 0)
-		return fence;
+	/*
+	 * Attach the job's IOMMU domain only when it differs from the one
+	 * already attached. Re-attaching per job toggles the rk_iommu
+	 * stall/reset handshake on an idle NPU MMU, which is slow and
+	 * noisy; keep the domain attached across jobs instead.
+	 */
+	if (core->attached_domain != job->domain) {
+		if (core->attached_domain) {
+			iommu_detach_group(NULL, core->iommu_group);
+			rocket_iommu_domain_put(core->attached_domain);
+			core->attached_domain = NULL;
+		}
+
+		ret = iommu_attach_group(job->domain->domain, core->iommu_group);
+		if (ret < 0)
+			return fence;
+
+		kref_get(&job->domain->kref);
+		core->attached_domain = job->domain;
+	}
 
 	scoped_guard(mutex, &core->job_lock) {
 		core->in_flight_job = job;
@@ -340,7 +358,6 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 				return;
 			}
 
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
 			dma_fence_signal(core->in_flight_job->done_fence);
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
@@ -376,8 +393,6 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 	 */
 	rocket_core_reset(core);
 
-	iommu_detach_group(NULL, core->iommu_group);
-
 	/* NPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&core->reset.pending, 0);
 
-- 
2.39.5

