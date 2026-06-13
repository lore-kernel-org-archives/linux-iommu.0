Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5C37DE98
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333920; cv=none; b=Uzq9IBujgLMtbGvZoKoQBdTbMoogI8MSumIwdbZ0jFU4zpC11a1TNm5hzHSdbM/CDwjKpIDNX7wpvreaCMBhoIOxJCdXflTVeQ8FAHXp17Uk6+TOeamSFRh2P/GLpBRIOz7OlmrXXuQ1qQ1elZM6Xd+DTxiZQNcEqkdlfNCYL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333920; c=relaxed/simple;
	bh=jDvwLKLt9ko7MMPzHKQNkwtiWAgYwLL7BmG6Frw38eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Djp618aAKyCyC0lty2tMk1KToBbzMozQVK4oADUFPCIOMpHUBW44zHzOcj8AVYRQqRTpypakfy0BBb3qTqB/iRRC8O/OKTZOVlRFBHb8aU2kU/PNThtSeoVraq4vpWjYGwCBVDvEb9eRQxYB0umIJs34GJ/5w50cIRL0/bcWK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVTtKK7/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVTtKK7/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so18026355e9.2
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333918; x=1781938718; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O65kp4uYeS0m80wrjHhLdSErrpFdma2VMG6AHvedRp8=;
        b=BVTtKK7/1RAy5byKabLDC74afT9sRn1gTCRW2Yl7IwFQqkRB18eKD89nB64f4VYAoD
         2Acc2R7byzVpOL4bFkGbo2BBa4q0nz0YkGtmCVtzEJY0UnIQ56Zb6kWI84kq2bR79PZu
         Ss/8usW6eLGKPTTiFx110kfhVZcJIO73Hp4JKESdmohagNg2M6YPUQugsvH20dibb2iD
         /B1TvLBjLX7lGSNQ5kMHh7H9PuawuyiKaHy8heyxRaOcqenuwXWx6pM3FSF4qfbXDLR0
         67SUBA84oHP8NoxvwNP+KOxoNm0Gd0+qsWj4UVOVBJvYDvhcmSidp249Satkn/M6Uq2m
         PaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333918; x=1781938718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O65kp4uYeS0m80wrjHhLdSErrpFdma2VMG6AHvedRp8=;
        b=nhLY4slPQvy+wsucL+S7OLFyR70nQ0N5l6iPPmWXkE5OM1rUaPiln9M43XYYncG7xB
         AXpTcPpYcX3X/aNWc5vWuOdpwj2WaHCbc4P6e690KwV6nHDd7xxIQDRvOaiHc/9C+F96
         iO+dUcqUZ5pGauvIv78k7AnFaB7bE9XGrrjxBim7sboScKUGD2sE52KsxpEFTsnXmFK3
         1jskE5+DUWut9anMOgscF3Ncmv/iKKUmbNoOkPs0uxP/s3eNollxeAMim3ogA3D0xYui
         ELMewy9021yqjfXpZLAAPcv4KS7pHTf/DseNw7PGgz5dLUdaYUMPhWHuEghdsxGq74AW
         fpaw==
X-Forwarded-Encrypted: i=1; AFNElJ8htLVBX5nRq2InanCWm3uTgk4YEhsf6dvsKqP/bWht+pRf5TIb3cpETb/CwYj13v+GKMJDng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9yfBY5y42ssPEkVAh4w+JkszUIpOs6tYM8r/GhDWtzwrzsy/D
	iJI3AJiR01/2AODg3omkK1+1aX0tMgW7r2AVxY13EPfezjQTnaorU+yn
X-Gm-Gg: Acq92OGT+8onQqM9bno3Pb9PJWmUQkjw5ATh5jvk2/bqNaGQ2TbB5RYJ9ftYQJrQbAn
	uPdjMblbzwSIs1yeMrQj6el0PP0JBIUhDaOzYq9DQ6aHvpB/j8c3VMQl26DWhtJddgN0JaKYgDx
	4GQM3Po7SA8RZznTEmoRFFv0hzgl72wslvoxYPi6MOwfcTbkbUKVokX1Hd8l2fNS5zbYjzc6Oqo
	16KejCrlk4RtGdnCmXRJiofe0DFuLxa1m9AFGszVTiDxoEhWhmwIKWcWIJtDggLILjEpLX0K/r4
	kemZJfFzbKFDud98EQ9NiP8tFmykodb3ARXQC3N6vhXJoKUZ3VobFA7h+Jq38gB7/kKxAGDXoDQ
	Jzr5BZOcyTTDGamdXDGqyrkFKcO9b3Z2IM/iyAAR9pxpkiA38srvJndzugbj7bafFRsaUNrkqWy
	/JR4rFkgr390d1kOEjProX94KsJWIos4dMyjMji7xlpaigEzm3OQVC
X-Received: by 2002:a05:600c:5296:b0:492:1e7f:d426 with SMTP id 5b1f17b1804b1-4921e7fd54bmr38722125e9.2.1781333917619;
        Fri, 12 Jun 2026 23:58:37 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:37 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 5/9] accel: rocket: Keep the IOMMU domain attached across jobs
Date: Sat, 13 Jun 2026 09:01:12 +0200
Message-Id: <20260613070116.438906-6-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

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

Because a hardware reset (on job timeout) wipes the IOMMU page-table
base register, drop the attached domain after rocket_core_reset() so
the next job re-attaches and reprograms it. Also tear down the
scheduler before detaching the IOMMU in rocket_core_fini(), so an
in-flight job can no longer reach the domain being detached.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c | 14 +++++++++++-
 drivers/accel/rocket/rocket_core.h |  3 +++
 drivers/accel/rocket/rocket_job.c  | 35 +++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 779e951596a15..6c128f585cff4 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -13,6 +13,7 @@
 #include <linux/reset.h>
 
 #include "rocket_core.h"
+#include "rocket_drv.h"
 #include "rocket_job.h"
 
 int rocket_core_init(struct rocket_core *core)
@@ -112,9 +113,20 @@ void rocket_core_fini(struct rocket_core *core)
 {
 	pm_runtime_dont_use_autosuspend(core->dev);
 	pm_runtime_disable(core->dev);
+
+	/*
+	 * Stop the scheduler before tearing down the IOMMU so an in-flight
+	 * job can no longer touch the (about to be detached) domain.
+	 */
+	rocket_job_fini(core);
+
+	if (core->attached_domain) {
+		iommu_detach_group(NULL, core->iommu_group);
+		rocket_iommu_domain_put(core->attached_domain);
+		core->attached_domain = NULL;
+	}
 	iommu_group_put(core->iommu_group);
 	core->iommu_group = NULL;
-	rocket_job_fini(core);
 }
 
 void rocket_core_reset(struct rocket_core *core)
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index 5a145ba8c5a92..78791ecb32e75 100644
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
index e25234261536b..368b2ebead1b3 100644
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
@@ -376,7 +393,15 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 	 */
 	rocket_core_reset(core);
 
-	iommu_detach_group(NULL, core->iommu_group);
+	/*
+	 * The reset wipes the IOMMU page-table base, so drop the attached
+	 * domain to force the next job to re-attach and reprogram it.
+	 */
+	if (core->attached_domain) {
+		iommu_detach_group(NULL, core->iommu_group);
+		rocket_iommu_domain_put(core->attached_domain);
+		core->attached_domain = NULL;
+	}
 
 	/* NPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&core->reset.pending, 0);
-- 
2.39.5

