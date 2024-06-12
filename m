Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5C1802B6
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200403; cv=none; b=fPq+cqCGdhOeZ4GRe4SuMwvAivY7874JP4A8UwmKWYwl9lEX6UuVR8s+XV2J03yRMQSaltxfIm5IksUqdGwub5yJVHaE1lR0kqBtFISekwvzxYVkePfh9fqUlg5x54saIG5sRbQMbPYmLKvy45lO5I9TYcUcy5eWX294DVPiEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200403; c=relaxed/simple;
	bh=Lhzd/BXorU4/wEhxcXs0r7FJ4VlqgdRpbDmk+vD47pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AOezjPaBLLruwlUS4QYPG5r8MJdipAEowjzkwbAegV323unJb3015N5pu4C2hyp5pJ2TpfJNqdPBttmXP8C0UApCQLgJFwbCV/qYHFrhyZp+99lUGSZYC2+QkurxqrU1BwL1CLXJ9e2w7E3dxBEpctV8XZzvTzy9BTCtu43xcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217136a74dso42510365e9.2
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200400; x=1718805200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEuYpCh3XjM5GPcfydkJgiyDWJJzYzsPQgvZ1sCjljI=;
        b=gI5TaYkEIO5QfKabvFhTwWi6FR47RNInqJSBql/G/7RWkNPotzJ4t0qW3Bj0gcM7wl
         BGXl0RKRXtBKD4PEbsPQsYN32j1IpZZqkSPaUrK1Coxs5R17Ym7AqNMw1FCAwhtvtc59
         eogv3nLDiMUObOwfj/e4u8OcKkunQlvc/HDPisATZu4oc921AzRQ1Qr2ziBvhHgzmyge
         q5EQC/aLG05SQ7hquGJmODYLxeJUxGNqYqR/FFl47y5LRWpWUJ2wg8qoImQo6+wWwD1g
         8VYM3TnDRuYY1yRyLLyzWJrJ41P6wVvjGhn8xwnkHiM/dnPu6IR4nXGohmoKfGG8Hleb
         kQTg==
X-Gm-Message-State: AOJu0YwUarEGE3OF38FDacb2c9hSkY7TgqYhavKRiwdly/V66ujL0QgZ
	jKUgKbSIR+x+4JQyfMHPXZmo0kW/zLJ1ebcE4ls5oh7SQr0Ikc+c
X-Google-Smtp-Source: AGHT+IHXyaNzrcBPeDigrcv5sVOrfalp6CstFjfzQPxgWGQHwRBknXSb0FuvFQr5BVQNXu8vkORxVQ==
X-Received: by 2002:a05:600c:4f49:b0:422:1def:e17f with SMTP id 5b1f17b1804b1-422866bc707mr16912265e9.31.1718200400311;
        Wed, 12 Jun 2024 06:53:20 -0700 (PDT)
Received: from ramallet.home (cst-prg-45-36.cust.vodafone.cz. [46.135.45.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871ec9e6sm28201695e9.38.2024.06.12.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:53:19 -0700 (PDT)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 12 Jun 2024 15:53:02 +0200
Subject: [PATCH 9/9] accel/rocket: Add IOCTLs for synchronizing memory
 accesses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-6-10-rocket-v1-9-060e48eea250@tomeuvizoso.net>
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
In-Reply-To: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
X-Mailer: b4 0.13.0

The NPU cores have their own access to the memory bus, and this isn't
cache coherent with the CPUs.

Add IOCTLs so userspace can mark when the caches need to be flushed, and
also when a writer job needs to be waited for before the buffer can be
accessed from the CPU.

Initially based on the same IOCTLs from the Etnaviv driver.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/accel/rocket/rocket_drv.c |  2 ++
 drivers/accel/rocket/rocket_gem.c | 68 +++++++++++++++++++++++++++++++++++++++
 drivers/accel/rocket/rocket_gem.h |  7 +++-
 include/uapi/drm/rocket_accel.h   | 20 +++++++++++-
 4 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index adcb9a685dd8..d41a4f4b330d 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -73,6 +73,8 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(ROCKET_##n, rocket_ioctl_##func, 0)
 
 	ROCKET_IOCTL(CREATE_BO, create_bo),
+	ROCKET_IOCTL(PREP_BO, prep_bo),
+	ROCKET_IOCTL(FINI_BO, fini_bo),
 	ROCKET_IOCTL(SUBMIT, submit),
 };
 
diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index e10eb886f150..afacdf91491e 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -2,7 +2,9 @@
 /* Copyright 2024 Tomeu Vizoso <tomeu@tomeuvizoso.net> */
 
 #include <drm/drm_device.h>
+#include <drm/drm_utils.h>
 #include <drm/rocket_accel.h>
+#include <linux/dma-mapping.h>
 
 #include "rocket_gem.h"
 
@@ -66,3 +68,69 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 
 	return ret;
 }
+
+static inline enum dma_data_direction rocket_op_to_dma_dir(u32 op)
+{
+	if (op & ROCKET_PREP_READ)
+		return DMA_FROM_DEVICE;
+	else if (op & ROCKET_PREP_WRITE)
+		return DMA_TO_DEVICE;
+	else
+		return DMA_BIDIRECTIONAL;
+}
+
+int rocket_ioctl_prep_bo(struct drm_device *dev, void *data, struct drm_file *file)
+{
+	struct drm_rocket_prep_bo *args = data;
+	unsigned long timeout = drm_timeout_abs_to_jiffies(args->timeout_ns);
+	struct drm_gem_object *gem_obj;
+	struct drm_gem_shmem_object *shmem_obj;
+	bool write = !!(args->op & ROCKET_PREP_WRITE);
+	long ret = 0;
+
+	if (args->op & ~(ROCKET_PREP_READ | ROCKET_PREP_WRITE))
+		return -EINVAL;
+
+	gem_obj = drm_gem_object_lookup(file, args->handle);
+	if (!gem_obj)
+		return -ENOENT;
+
+	ret = dma_resv_wait_timeout(gem_obj->resv, dma_resv_usage_rw(write),
+				    true, timeout);
+	if (!ret)
+		ret = timeout ? -ETIMEDOUT : -EBUSY;
+
+	shmem_obj = &to_rocket_bo(gem_obj)->base;
+
+	dma_sync_sgtable_for_cpu(dev->dev, shmem_obj->sgt, rocket_op_to_dma_dir(args->op));
+	to_rocket_bo(gem_obj)->last_cpu_prep_op = args->op;
+
+	drm_gem_object_put(gem_obj);
+
+	return ret;
+}
+
+int rocket_ioctl_fini_bo(struct drm_device *dev, void *data, struct drm_file *file)
+{
+	struct drm_rocket_fini_bo *args = data;
+	struct drm_gem_object *gem_obj;
+	struct rocket_gem_object *rkt_obj;
+	struct drm_gem_shmem_object *shmem_obj;
+
+	gem_obj = drm_gem_object_lookup(file, args->handle);
+	if (!gem_obj)
+		return -ENOENT;
+
+	rkt_obj = to_rocket_bo(gem_obj);
+	shmem_obj = &rkt_obj->base;
+
+	WARN_ON(rkt_obj->last_cpu_prep_op == 0);
+
+	dma_sync_sgtable_for_device(dev->dev, shmem_obj->sgt,
+				    rocket_op_to_dma_dir(rkt_obj->last_cpu_prep_op));
+	rkt_obj->last_cpu_prep_op = 0;
+
+	drm_gem_object_put(gem_obj);
+
+	return 0;
+}
diff --git a/drivers/accel/rocket/rocket_gem.h b/drivers/accel/rocket/rocket_gem.h
index 2cb294f25c19..9b1c485ec600 100644
--- a/drivers/accel/rocket/rocket_gem.h
+++ b/drivers/accel/rocket/rocket_gem.h
@@ -13,16 +13,21 @@ struct rocket_gem_object {
 	struct mutex mutex;
 	size_t size;
 	u32 offset;
+	u32 last_cpu_prep_op;
 };
 
 struct drm_gem_object *rocket_gem_create_object(struct drm_device *dev, size_t size);
 
 int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *file);
 
+int rocket_ioctl_prep_bo(struct drm_device *dev, void *data, struct drm_file *file);
+
+int rocket_ioctl_fini_bo(struct drm_device *dev, void *data, struct drm_file *file);
+
 static inline
 struct  rocket_gem_object *to_rocket_bo(struct drm_gem_object *obj)
 {
 	return container_of(to_drm_gem_shmem_obj(obj), struct rocket_gem_object, base);
 }
 
-#endif
\ No newline at end of file
+#endif
diff --git a/include/uapi/drm/rocket_accel.h b/include/uapi/drm/rocket_accel.h
index 888c9413e4cd..1539af0af4fe 100644
--- a/include/uapi/drm/rocket_accel.h
+++ b/include/uapi/drm/rocket_accel.h
@@ -12,9 +12,13 @@ extern "C" {
 #endif
 
 #define DRM_ROCKET_CREATE_BO			0x00
-#define DRM_ROCKET_SUBMIT			0x01
+#define DRM_ROCKET_PREP_BO			0x01
+#define DRM_ROCKET_FINI_BO			0x02
+#define DRM_ROCKET_SUBMIT			0x03
 
 #define DRM_IOCTL_ROCKET_CREATE_BO		DRM_IOWR(DRM_COMMAND_BASE + DRM_ROCKET_CREATE_BO, struct drm_rocket_create_bo)
+#define DRM_IOCTL_ROCKET_PREP_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_ROCKET_PREP_BO, struct drm_rocket_prep_bo)
+#define DRM_IOCTL_ROCKET_FINI_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_ROCKET_FINI_BO, struct drm_rocket_fini_bo)
 #define DRM_IOCTL_ROCKET_SUBMIT			DRM_IOW(DRM_COMMAND_BASE + DRM_ROCKET_SUBMIT, struct drm_rocket_submit)
 
 /**
@@ -38,6 +42,20 @@ struct drm_rocket_create_bo {
 	__u64 offset;
 };
 
+#define ROCKET_PREP_READ        0x01
+#define ROCKET_PREP_WRITE       0x02
+
+struct drm_rocket_prep_bo {
+	__u32 handle;		/* in */
+	__u32 op;		/* in, mask of ROCKET_PREP_x */
+	__s64 timeout_ns;	/* in */
+};
+
+struct drm_rocket_fini_bo {
+	__u32 handle;		/* in */
+	__u32 flags;		/* in, placeholder for now, no defined values */
+};
+
 /**
  * struct drm_rocket_task - A task to be run on the NPU
  *

-- 
2.45.2

