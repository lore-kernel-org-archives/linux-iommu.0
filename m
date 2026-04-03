Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9324A078
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177510; cv=none; b=Gpl7a7EK6NNANQPjO0xj0dJKz7btUudXT2ze9UC7yl6Jk45wedveroWi1ZEd3LGO4Cv27yTMFxNAISWCfGvvxWBRrmwypuVt4IK7tn/ViNbNdj0FmhOLzZWdBD64Xxz2RnD1rtavJtVkmqgeNI698zYtp4koCs/DQxbOYU6q7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177510; c=relaxed/simple;
	bh=MbYSEBw2mR7uS899ItjNFULIEA7303rlJjU6gRTcFao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRJnOVeDWbT5Pz96e+gho+Ggd+bkfVu3XIckkkD3VdDJb/AJtkDA3hTZZtmw5xrdvQ9DrfGwqap+Rxig8r5Fj1xBNRONDdVJuExwt7fjjMOP8+UeKSFaKJd14WnocMxQrwFT7iYa+HxpniAeOcw3+JObF6Mk5ItVI4zNdpxSdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hgZM+Z+n; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hgZM+Z+n"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3280913eec.1
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 17:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177507; x=1775782307; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM9+eAkKdOrABgkFmwCHnBiWfkCG9uPNCsfKJXOxWMI=;
        b=hgZM+Z+njjMF46daVh7ncfkiYjogQC2JRBGT98vyDUvqKJHoJqOBELmn5/0XYJ3ojN
         hXNQWBM+FK7X2Td/km0yvf6x+QBLoD/hxd8rz8LB7PAge2h/gZ4yvQDySvPgem8jMm0r
         pWlblBDXeGX3EoFjq7F/QZMsVAX78r/7kZ0go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177507; x=1775782307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HM9+eAkKdOrABgkFmwCHnBiWfkCG9uPNCsfKJXOxWMI=;
        b=dlakYZktb3LAcY7eCsyPxYyt1jX+ftDpVpixA8toneXbg4luGOPwZD3rCTGLw8IhSu
         vruVgM6RgWspVlaxEgGiW3mnnwuakyWywKk6NUBb65pepLavtB8P0Y/cOs2zeFeHRx9D
         /S3CBPXK2CLUU4h27ue2oykUu4weEsclcG56OlAR9689Hf6hxXr2uuyLtHzCstV9mt/x
         hQcGTjFkg8kOCLprRMI3l0yo8QoNEYBWQhgM07rHyfO23rIOGQ/EXxM1AjXJjWSpVfX5
         Kf6NMnmqjGHpbuMgcTDjbwFRx7DyAg/sKU6toog3TLkgETAHH2UVvy//KjURUukWaJQR
         vzlA==
X-Forwarded-Encrypted: i=1; AJvYcCVVMyI89xkWQxTwZXKH+UmchxWSkc/1/Oh+/bj9/SRvMyd8Dmdn7tDor4rtY9SrF/OGxibXNw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2nbO+SEwrbrKxNNYTsRzyPDd2j7WSqHNiIxQTMEBdgo+Z3nd+
	r+zYjxx8RrRrfnn8sJiX8nHhI7PtosNuJaDP7pp23fE5gO7mUNeOlLW9wxwzIWUJvw==
X-Gm-Gg: AeBDieuZuv0h1YrVM/MXGzcD8ndJoGRBAIwPkh2JHB+44tdE4D3SHhf7dHGkSbRFsaM
	69AGnGm6mMW14FSbHW95KV5UKcogOzl1oOhaDM0NDZUuv3uIziMlP9klKRB2lum2+X6oQ2wkNnP
	zw+Ovyg8Kbi/YuY4FC27yXbKN63r/48y0vkH6IeKDyJBeN7fz8ZnV0jdB9PS50wGtvafIN3xF2r
	ehMlhO6BZkI4WTiwAapc+TDJm2e9f8+63P/LB/Syddy0d5W7n0p6tsKYiWiKRyrl7ZRtG1HLfTH
	Oz9Os5hoH80rJ7iJInzXbYudEG4HReDD6YDmqgxboSYeMgfd6KHnwFjgwUSjrUtuRCDZNVjbdOK
	vGtrwwUKgJlZ/vCwJ6ZBQVNltAoRi3lsx/N4ch/Zc5Z10YnB5h0MGJZQDVDq3BOt8VpsP8qvVQg
	5WP5u3us2WAgegWFeq/rPPldvM0KzIslplgEyb0Nwm10pna7tutppqMHE6VhAm5iE2BvIYe5iEM
	wWpoVGUYYU=
X-Received: by 2002:a05:7300:a506:b0:2c5:50fe:c786 with SMTP id 5a478bee46e88-2cbfa2ce19dmr720875eec.9.1775177507537;
        Thu, 02 Apr 2026 17:51:47 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:51:46 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	driver-core@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	m.szyprowski@samsung.com
Subject: [PATCH v3 4/9] driver core: Replace dev->dma_skip_sync with DEV_FLAG_DMA_SKIP_SYNC
Date: Thu,  2 Apr 2026 17:49:50 -0700
Message-ID: <20260402174925.v3.4.Icf072aa4184dd86a88fa8ca195b09d1651984000@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260403005005.30424-1-dianders@chromium.org>
References: <20260403005005.30424-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In C, bitfields are not necessarily safe to modify from multiple
threads without locking. Switch "dma_skip_sync" over to the "flags"
field so modifications are safe.

Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

NOTE: even though previously we only took up a bit if
CONFIG_DMA_NEED_SYNC, in this change I reserve the bit
unconditionally. While we could get the "dynamic" behavior by changing
the flags definition to be an "enum", it doesn't seem worth it at this
point.

Changes in v3:
- New

 include/linux/device.h      | 7 +++----
 include/linux/dma-map-ops.h | 4 ++--
 include/linux/dma-mapping.h | 2 +-
 kernel/dma/mapping.c        | 8 ++++----
 mm/hmm.c                    | 2 +-
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index e74c7d0813ce..e900748d3038 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -470,11 +470,14 @@ struct device_physical_location {
  *		until other devices probe successfully.
  * @DEV_FLAG_DMA_IOMMU: Device is using default IOMMU implementation for DMA and
  *		doesn't rely on dma_ops structure.
+ * @DEV_FLAG_DMA_SKIP_SYNC: DMA sync operations can be skipped for coherent
+ *		buffers.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE,
 	DEV_FLAG_CAN_MATCH,
 	DEV_FLAG_DMA_IOMMU,
+	DEV_FLAG_DMA_SKIP_SYNC,
 };
 
 /**
@@ -566,7 +569,6 @@ enum struct_device_flags {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
- * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -683,9 +685,6 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
-#ifdef CONFIG_DMA_NEED_SYNC
-	bool			dma_skip_sync:1;
-#endif
 
 	unsigned long		flags;
 };
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 60b63756df82..4d9d1fe3277c 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -245,8 +245,8 @@ static inline void dma_reset_need_sync(struct device *dev)
 {
 #ifdef CONFIG_DMA_NEED_SYNC
 	/* Reset it only once so that the function can be called on hotpath */
-	if (unlikely(dev->dma_skip_sync))
-		dev->dma_skip_sync = false;
+	if (unlikely(test_bit(DEV_FLAG_DMA_SKIP_SYNC, &dev->flags)))
+		clear_bit(DEV_FLAG_DMA_SKIP_SYNC, &dev->flags);
 #endif
 }
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 99ef042ecdb4..23273b0fe84e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -419,7 +419,7 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 static inline bool dma_dev_need_sync(const struct device *dev)
 {
 	/* Always call DMA sync operations when debugging is enabled */
-	return !dev->dma_skip_sync || IS_ENABLED(CONFIG_DMA_API_DEBUG);
+	return !test_bit(DEV_FLAG_DMA_SKIP_SYNC, &dev->flags) || IS_ENABLED(CONFIG_DMA_API_DEBUG);
 }
 
 static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 6d3dd0bd3a88..f50b648ed460 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -467,7 +467,7 @@ bool dma_need_unmap(struct device *dev)
 {
 	if (!dma_map_direct(dev, get_dma_ops(dev)))
 		return true;
-	if (!dev->dma_skip_sync)
+	if (!test_bit(DEV_FLAG_DMA_SKIP_SYNC, &dev->flags))
 		return true;
 	return IS_ENABLED(CONFIG_DMA_API_DEBUG);
 }
@@ -483,16 +483,16 @@ static void dma_setup_need_sync(struct device *dev)
 		 * mapping, if any. During the device initialization, it's
 		 * enough to check only for the DMA coherence.
 		 */
-		dev->dma_skip_sync = dev_is_dma_coherent(dev);
+		assign_bit(DEV_FLAG_DMA_SKIP_SYNC, &dev->flags, dev_is_dma_coherent(dev));
 	else if (!ops->sync_single_for_device && !ops->sync_single_for_cpu &&
 		 !ops->sync_sg_for_device && !ops->sync_sg_for_cpu)
 		/*
 		 * Synchronization is not possible when none of DMA sync ops
 		 * is set.
 		 */
-		dev->dma_skip_sync = true;
+		set_bit(DEV_FLAG_DMA_SKIP_SYNC, &dev->flags);
 	else
-		dev->dma_skip_sync = false;
+		clear_bit(DEV_FLAG_DMA_SKIP_SYNC, &dev->flags);
 }
 #else /* !CONFIG_DMA_NEED_SYNC */
 static inline void dma_setup_need_sync(struct device *dev) { }
diff --git a/mm/hmm.c b/mm/hmm.c
index 5955f2f0c83d..137450e096bc 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -709,7 +709,7 @@ int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
 	 * best approximation to ensure no swiotlb buffering happens.
 	 */
 #ifdef CONFIG_DMA_NEED_SYNC
-	dma_need_sync = !dev->dma_skip_sync;
+	dma_need_sync = !test_bit(DEV_FLAG_DMA_SKIP_SYNC, &dev->flags);
 #endif /* CONFIG_DMA_NEED_SYNC */
 	if (dma_need_sync || dma_addressing_limited(dev))
 		return -EOPNOTSUPP;
-- 
2.53.0.1213.gd9a14994de-goog

