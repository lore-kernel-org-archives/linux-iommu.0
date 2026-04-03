Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C125A2A4
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177514; cv=none; b=ED2juD4MXHGkfhMUx4yzI7OTLFHqsbf1af1pic4mJV0tski4u1awdwzBt0khkxKoxavZOljxLtg/HRCJUtrOa0ZXgQVXf6nld7RPpOAZtMKq9Nkii5RHxlhA5yLPsSzy/ZKEXk5X+ZBFUBT0997UFLsw3PmwUSZMChnrc+QIsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177514; c=relaxed/simple;
	bh=ORnE0BsVMRNzS+pVx3neQe1CQGlfWvsbwoU0QJEuCPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMkbWJrKVCBUC06ytflLPGWBM7YZ+Y7JLqRAShHu8Do9JvM3zPejL44vMvJrtq22antrGCfnSeKZaf2ZbdyNvAuhuK+cCM1+i4aCnkngZcLNYaixlOsmLu+ryfmvPEDifn/EtFCwOLJ0WdjKhiZ2+C3N28Ru+80HnXsRtxY1dZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NhZXL0IT; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NhZXL0IT"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c1632faeb9so2914280eec.0
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 17:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177511; x=1775782311; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZiTiKY0xg6ysj9D1M7VJbCxfmHcK2OdGCIMJgNJnE8=;
        b=NhZXL0ITwYHj4fKB2aBz4zjnBWSlMEPQfjGgT8U5erz/+4cc5vlTSktpbtQtM/Ho73
         Y0h1Eup+tzLMaBbArQFOEh3cz/xfwO+t+9Dtw/M1EpmSiXd1wRDUH250tzqB8T3TJ+yW
         Tf1PxXM/Y6EOqMmLteQvBVfbjtF6bvszlKfbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177511; x=1775782311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZiTiKY0xg6ysj9D1M7VJbCxfmHcK2OdGCIMJgNJnE8=;
        b=UuqHiT9bEZ9ozP+trJ9waecOIyihlgsA4zKGpTz2xi7+984FkLZ4/+xN9fZFg1kl79
         EFtWeQUXrgbGA29Fo3Nd/Tbem3y3FvR8RC47l+kj8oXpm+YG9Sw1di1M95v6li741jIo
         tio/2IyzYsYLGqW0bXhnlynjM3vDRVtpccpRuwb+C27exWbS/V3vsh4XGbcQv7ixLeZ7
         XnKsqC1Sncenahwtk/1w4ayrw2zVcbqqw+keIkYWqHlZDyzfMKMli9BOybYy8St+iGY7
         nstTUXrVUpypdikAD8jm6DZm0iIB73d+TYx9Wfj1NKepalGoSK5em3nZczCNIla/4kA3
         WpPg==
X-Forwarded-Encrypted: i=1; AJvYcCWfgKsaMuzMn30OUaK3b9MUErT/5i2LMZl2zL6Rn42+tJgTcA2Ot7R2dXINQ0c7rlKmYU6DuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFdukLB70pHEBky9caCJN+0/hXXhlXE74bnKpDv5S4le5s/sr0
	zbCKc6ZOM+fpbxNyCDMFRFxRaKiJoDmnp7pMiFYeWrMvN2L3Z4pYhQhoovybP7ZCPg==
X-Gm-Gg: AeBDietb1OvLADdMP+uFOB2WUX3aR3DVY0c9hDdtqeq/puYrFRiFmhJNj67DNa+77U0
	Iijmq1W0Na7MiU6PUORguUsLxM+Y89fwyGKCnJYHAk2WMxJ/nScPwQCpO9zd25jupmaz7mNYehG
	0ttWADdwlK1ddFoY4gdNKoQsXl9rfBPqbRyLTs3XN3A0orUpNue5S4xoS6MxotU3gc1pT9qTBV3
	UY7HxaXDbfl1vDyYjeGrWAvGB8ixrdSrPky+lZK/wBrUgGDQDL026GqdukNhXLgIMcmCq0e/kKL
	WhxUZNCsgUa51m/IfckXa2XG0/0/Uxpd4W8iUqZTR5dAMf8GBG3q2AYfSVk7nn26exurCpVBZG5
	ZPrn6wPlKshf60WOGUv91NBr6NSrfS2vJlzuimTQOTSxtGSRic6W7QyO/dykactZUWbtlYIFC1J
	5MwfqG9XLabMKHyvC6wCXYZroJs7oy0wl9JCbCcEFgKEDqzBRTDHxfINPZkoL4B2/kUhwFxFGln
	5J+0cGQn/o=
X-Received: by 2002:a05:7300:371f:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2cbfc268d12mr658562eec.23.1775177510944;
        Thu, 02 Apr 2026 17:51:50 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:51:49 -0700 (PDT)
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
	chleroy@kernel.org,
	driver-core@lists.linux.dev,
	gbatra@linux.ibm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com
Subject: [PATCH v3 5/9] driver core: Replace dev->dma_ops_bypass with DEV_FLAG_DMA_OPS_BYPASS
Date: Thu,  2 Apr 2026 17:49:51 -0700
Message-ID: <20260402174925.v3.5.If62b84471ef2c85e7ad250f0468867d6dba965ab@changeid>
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
threads without locking. Switch "dma_ops_bypass" over to the "flags"
field so modifications are safe.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

NOTE: even though previously we only took up a bit if
CONFIG_DMA_OPS_BYPASS, in this change I reserve the bit
unconditionally.  While we could get the "dynamic" behavior by
changing the flags definition to be an "enum", it doesn't seem worth
it at this point. This also allows us to move one "#ifdef" to an "if",
getting better compile-time testing of both sides of the "if".

Changes in v3:
- New

 arch/powerpc/kernel/dma-iommu.c |  8 ++++----
 include/linux/device.h          | 14 ++++++--------
 kernel/dma/mapping.c            |  8 +++-----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 73e10bd4d56d..6486417c8acb 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 }
 bool arch_dma_alloc_direct(struct device *dev)
 {
-	if (dev->dma_ops_bypass)
+	if (test_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags))
 		return true;
 
 	return false;
@@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
 
 bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
 {
-	if (!dev->dma_ops_bypass)
+	if (!test_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags))
 		return false;
 
 	return is_direct_handle(dev, dma_handle);
@@ -164,7 +164,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		 * fixed ops will be used for RAM. This is limited by
 		 * bus_dma_limit which is set when RAM is pre-mapped.
 		 */
-		dev->dma_ops_bypass = true;
+		set_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags);
 		dev_info(dev, "iommu: 64-bit OK but direct DMA is limited by %llx\n",
 			 dev->bus_dma_limit);
 		return 1;
@@ -185,7 +185,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 	}
 
 	dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
-	dev->dma_ops_bypass = false;
+	clear_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags);
 	return 1;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index e900748d3038..f5845bd7c3e6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -472,12 +472,18 @@ struct device_physical_location {
  *		doesn't rely on dma_ops structure.
  * @DEV_FLAG_DMA_SKIP_SYNC: DMA sync operations can be skipped for coherent
  *		buffers.
+ * @DEV_FLAG_DMA_OPS_BYPASS: If set then the dma_ops are bypassed for the
+ *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*), and
+ *		optional (if the coherent mask is large enough) also for dma
+ *		allocations. This flag is managed by the dma ops instance from
+ *		->dma_supported.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE,
 	DEV_FLAG_CAN_MATCH,
 	DEV_FLAG_DMA_IOMMU,
 	DEV_FLAG_DMA_SKIP_SYNC,
+	DEV_FLAG_DMA_OPS_BYPASS,
 };
 
 /**
@@ -564,11 +570,6 @@ enum struct_device_flags {
  *		  sync_state() callback.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
- * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
- *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
- *		and optionall (if the coherent mask is large enough) also
- *		for dma allocations.  This flag is managed by the dma ops
- *		instance from ->dma_supported.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -682,9 +683,6 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
-#ifdef CONFIG_DMA_OPS_BYPASS
-	bool			dma_ops_bypass : 1;
-#endif
 
 	unsigned long		flags;
 };
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f50b648ed460..44d4c319ffad 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -126,11 +126,9 @@ static bool dma_go_direct(struct device *dev, dma_addr_t mask,
 	if (likely(!ops))
 		return true;
 
-#ifdef CONFIG_DMA_OPS_BYPASS
-	if (dev->dma_ops_bypass)
+	if (IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && test_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags))
 		return min_not_zero(mask, dev->bus_dma_limit) >=
 			    dma_direct_get_required_mask(dev);
-#endif
 	return false;
 }
 
@@ -895,8 +893,8 @@ bool dma_pci_p2pdma_supported(struct device *dev)
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	/*
-	 * Note: dma_ops_bypass is not checked here because P2PDMA should
-	 * not be used with dma mapping ops that do not have support even
+	 * Note: DEV_FLAG_DMA_OPS_BYPASS is not checked here because P2PDMA
+	 * should not be used with dma mapping ops that do not have support even
 	 * if the specific device is bypassing them.
 	 */
 
-- 
2.53.0.1213.gd9a14994de-goog

