Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CC25B090
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505295; cv=none; b=CG+/LclZhhFLtPTWYSqX1dMQF/JskMwTqElQaYZHYECVzClfa7J5pXS2Tg2MarfUtcGd7tS64nwB4SVGIOQfbjF7H+6aHaYyzSUG6GP2vtmCuHJSIXP2D9/qcy+SCpxa/RR/tIHxbB61KxkKuwl6NY2tqA1/noyaB3D2a1qFBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505295; c=relaxed/simple;
	bh=NVIDiLXAJf3+ZJHF4QiA1R4ioaT/JGKrOJyAdNKIbc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koZVF70wNWGMs5jOXxr8JTz9Eb8OVKjrSDe/n1J2kIPykQnyz1F8SlaSc19U8Mf/wWYkQ0oXg8ls3fUyI+2rYHsLdxliJ1Zou8eYC1vqf0q697AB+yF/Bhp80RpQ3n0EDfMTW/C6WSHZiB9oxUCbJ1MjQUlwdXKDiXi20WUVgWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERELywP6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERELywP6"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso28041395e9.0
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791505291; x=1792110091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIz/qZTA1DVdo8Wv1KvtH0Jov9NyNDxXYjGr4vU3wa4=;
        b=ERELywP6WkhPSCH/hr0awY9DQkZkC0FIFHa4nYx8JxxrIZQF6rW7l3fKx2Fx1ZtUWS
         SskWHVLIqowuMTPjn3jpVz/810QF0PLnyLErHJn34A7T2XapQPBAxu1jmhN3nDbFNioK
         WHZIky0v5bKc7S92SsHhK1Hcv/YQ716DsnOaFEm+55C9rSCL+a5MiQ/I50+szudnDkmx
         WHzhjH7D+X0s689Z/zq+wQjB/VXvyqA6cW6CjTqnaheag2EvsiSh+wsuuapYR8Cr1I0R
         qcVT7bOpPDppFggl9duuN2pGTmZjUWOD3DruKDBR9hmu6IKuDzXuA1nMwwrfNKPgtI6l
         ujHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791505291; x=1792110091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kIz/qZTA1DVdo8Wv1KvtH0Jov9NyNDxXYjGr4vU3wa4=;
        b=Ba4n5JbT/zBdVZfvZuiyfEk4X/X15ChvZutiY/TocSW119qAZYYY1E4FEEgCQ6vTb/
         gvXKlJttDxxgFSYoSHnoaAt+BKbGi4E26vdsOLF0LQZgNVF4lKA+9fGp9wlwwXP/0Tq5
         pv5kfGOc8DT+Wjj2m5uUjl/SqfW2u215dltZRL/5nWes4kE9zNEVADeUi55KwuYVIJWA
         ySxhniiflfuI7NMGVBty079yWTQcDQF59QrOoicu85j7WTLwyEucJfOoTExjJQlaWq69
         ujOjYW0fNokhUKTT3hITF6t9rw+aLkAP+IIfJULPmpo53mxMl6kiUcNuw7h4tEOpWs65
         KrZg==
X-Gm-Message-State: AFuF++n1nB35czHj4FiZiAd4TPdEVDjs+OpqMtCGoUBH8rjNsnf+eX9k
	45P+WNfrNv965EfCw7nt6I7Nj5JJRfZ5UvxQ2pS6r32Gwgv4cof8N078i6WRYa8P
X-Gm-Gg: AYBFou2B/UIU+y9fBi141Dk9LRsOiNxF2wmtEZs1V5TggQrrJuErMaePfY3fiwl7WyA
	M+39BH6KiEyuzHSnv2+7PJX+HAEXSIcx21K8s0Js87KVHGwW8J+QC5wEfQeNVYWmUVGQtC0GSoz
	xrlL6CqpLt/8D/gJqRbBnQ0BGO0M3uAzI6ipEatGgjUN9CLaAgYBqj0rrt4U2FoDbamCa7gNk21
	s7dMoglXZrCdIiZRu7d1C2pcD6t2D9T2mlIqv1j8GH4gIsTTHGnNSFVgboPhHwk8M/XtbPjFKSl
	8xg9Q5umSPQIXRmYlNSeKwXKx6SY/1j4d3koGWWpcG0uVV26kxylmbRbyBOWTHWULz+QgMHVyiF
	AQ1oxn4H8FMSXkWm8WrcivKrZLoxE8FLV2G8HY4H8MSZ8qBswiwZ0KkRKqClnQCrbLo3E1TGj+E
	5s4XwsLeqDIRO+JyCdOcEuB7Mmsy/6iP2eXuN1jhlJYQwNIIaw9QFRXirL9zjZSb9/r9ooaKIpv
	1QhveXnybdIuqlygwYpNhGJHTtlYceKG2r5yO2NuWLWBbLX31nxnME51ExxlPgYL76g0N/kAnpY
	PCKygUVVGH0VN+NVMOYRFM1liDLp+IPSlmoGKj0Agt5eNJkVWa3Y1pt3q+oicI5oOF9Tn5743kj
	JAmWoet8=
X-Received: by 2002:a05:600c:6990:b0:4a0:1ea1:477a with SMTP id 5b1f17b1804b1-4a18e4d8bbamr2152055e9.27.1791505291199;
        Thu, 08 Oct 2026 17:21:31 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad61-5a01-743c-891f-b33c-cae7.310.pool.telefonica.de. [2a02:3100:ad61:5a01:743c:891f:b33c:cae7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4987casm3364605e9.1.2026.10.08.17.21.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 17:21:30 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] drm/rockchip: Map imported buffers from DMA addresses
Date: Fri,  9 Oct 2026 02:21:14 +0200
Message-Id: <20261009002114.67851-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261009002114.67851-1-kmehltretter@gmail.com>
References: <20261009002114.67851-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rockchip_gem_prime_import_sg_table() uses iommu_map_sgtable(), which reads
CPU-side pages and lengths. DMABUF_DEBUG clears these fields, causing
the RK3588 import failures reported by Diederik de Haas.

The attachment's DMA addresses belong to the VOP's default domain,
while scanout uses a separate DRM domain. Use iommu_map_sgtable_dma()
to copy the live mapping into that domain.

Keep native allocations unchanged. Unsupported imports still use the
old page-based path and remain unfixed under strict DMABUF_DEBUG.
This RFC retains reverse translation rather than sharing the DMA domain.

Reported-by: Diederik de Haas <diederik@cknow-tech.com>
Link: https://lore.kernel.org/r/DLR74W1U9YPC.375IK0HOYHDIG@cknow-tech.com/
Link: https://lore.kernel.org/r/DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 9a1dc9f12072..501c94cb921a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -20,7 +20,8 @@
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
 
-static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
+static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj,
+				  struct device *dma_dev)
 {
 	struct drm_device *drm = rk_obj->base.dev;
 	struct rockchip_drm_private *private = drm->dev_private;
@@ -40,8 +41,16 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 
 	rk_obj->dma_addr = rk_obj->mm.start;
 
-	ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sgt,
-				prot);
+	if (dma_dev) {
+		ret = iommu_map_sgtable_dma(private->domain, rk_obj->dma_addr,
+					    dma_dev, rk_obj->sgt, prot);
+		if (ret == -EOPNOTSUPP)
+			ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr,
+						rk_obj->sgt, prot);
+	} else {
+		ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr,
+					rk_obj->sgt, prot);
+	}
 	if (ret < (ssize_t)rk_obj->base.size) {
 		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
 			  ret, rk_obj->base.size);
@@ -131,7 +140,7 @@ static int rockchip_gem_alloc_iommu(struct rockchip_gem_object *rk_obj,
 	if (ret < 0)
 		return ret;
 
-	ret = rockchip_gem_iommu_map(rk_obj);
+	ret = rockchip_gem_iommu_map(rk_obj, NULL);
 	if (ret < 0)
 		goto err_free;
 
@@ -457,7 +466,7 @@ rockchip_gem_iommu_map_sg(struct drm_device *drm,
 			  struct rockchip_gem_object *rk_obj)
 {
 	rk_obj->sgt = sg;
-	return rockchip_gem_iommu_map(rk_obj);
+	return rockchip_gem_iommu_map(rk_obj, attach->dev);
 }
 
 static int
-- 
2.53.0

