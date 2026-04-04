Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227C288B8
	for <iommu@lists.linux.dev>; Sat,  4 Apr 2026 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261260; cv=none; b=EtrFcCD2oDMl6sSl+40yw1Xboyk/kH8zoo4nAw7qMhpBmIxSKm9I7/Hb0nVcSwmZsM3GG0Sa0tPrhQ6r2Uwu7aBba++mV6Rl5LDmNeFQFEhPVftIG7F2EogZw9XW78ctxtkWyfQNmUG75tqXiAnxt5QqSSoiyyDNJuziYXgZF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261260; c=relaxed/simple;
	bh=WYnONCXDXDti47RwGt2EPBGJDVoWzZZNYS486IRVgHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhbdJbv78qLIN8VWmHaG6NU+Um1JK91yfRdlOl+sxweyzWlC/OV0wx1CzF6gfMwpeeIcHzzH+GOeKsPlNVq6JxyITKg2099dHHIVma94we3LzyPNx3zFNJ2nNp0QgBUmbZfVoExwuJAniRdwzx1pjl+xyWfeiJrsq2Balvivbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=huDNEriQ; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="huDNEriQ"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2cd339aeab4so528248eec.0
        for <iommu@lists.linux.dev>; Fri, 03 Apr 2026 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775261254; x=1775866054; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bet9w8b/blm24LZki1Y+b44Iyovbn2Yvd3IPo+HAgFA=;
        b=huDNEriQ8+gKBhSI7EHqxXjw5Gth4Wv4JiowLYz5Abw6ost6KNfbmvEWZKfNbODhYx
         R3IlgP/3vY2do0+Nh/zl8vSJ8i79iyiX1WDbUVvYmOkvBVBpCQa45b3k3BlOi8UFEcw0
         X/KvMF3TDgTTAG9JVoL9b5qoRI3Cz4KMWhQT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775261254; x=1775866054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bet9w8b/blm24LZki1Y+b44Iyovbn2Yvd3IPo+HAgFA=;
        b=tMWkPS99NbkJzu38Css46rsMYzYfgCuBNiDyLbROZa1wpAnqYIt29OKMw1LeP5OmBO
         TjQuq1JIELKjKzAYSimrk1g7fx6jczlkcL5FKpJjPKR7e6ljKuqq2Lrzk2WrIAbWHIo7
         ZeQZp3GucKnidVlUws1NOsORe8tkf9riqIwImtrpmFQxxNP6TThjwkKzB+I1WQmkd4Mh
         qIDBjWkcA1L67Oe41StKaSF1NxN/NLi0WVnY7F66+gwxlcX5zGI4HfxqLBxI6pHdEJYY
         1nm1ueHIVxBrYuvmAZcAMcc/wafA+mhb6Mvp2UUmpmjmuGcSliMVlxdN6HTSzoXvtTCA
         ABWA==
X-Forwarded-Encrypted: i=1; AJvYcCUMfnWadHJvHMIAZz+GQ9d9yaT4F4fvm7v7zIKOlI4MVBHadvQQOZCbCvnu0KazZgPe3mo18g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy31myuEAlESevCD4OBL6Ua8ZagglUomg3IdxaOI0OrnCnaa/Cy
	GqMsnoUtIGc2b4hRmmCIZqxRKQBiwCzElQrGlJTIUaqvMJsdmE+iD5Q8CrOHIQ0vsQ==
X-Gm-Gg: AeBDievoT8N3ZU/iS9e45fYkdSiwtoKwzj4al5WiEyFLEywuOSJqPDsMgrZNjix9lix
	LvyB6K6Ymx1HpDR2jtg7ZeUW2axsP6VGThW8WDQR3qAKRGBzNJUpSNasn221fKt7D7/5YUYpmHX
	jEO7RH/GCr/ssiVqOX0WWMKBfDqLvT7yfgDq/qehhH9RExe8MX2uC58kM/ikDNf8Q4N5glDjwds
	KRVMvPyeUb7fxYzRCQheccFWiNMzeTIBhuSPu8WhX91kyu/SQM7DEixdwBuBSHqiKCc2vpuVzj3
	ClZwBjmFTjiHIjWcnWXNGsh7oNve6UejgcNIaMHtMUrRRUC3ntKTGX7Z+7RR/Cg5BIMErnq5/n/
	K5puBFqTw9gN+cdXweJBkYADZYHHhJ60xRvrfWy4TP/D+cGY3jA7A6p+BfYsuHRIE9BNjpy1dXq
	2va0u7Zgo3rQrJToAYHnCTyQU53XLzkiJQmyz7m120PyizSaFQcqDt4/pYI9teIgzm7b0l3EkLn
	6YuSMN2chL/hrgYMFYTuw==
X-Received: by 2002:a05:7300:d05:b0:2be:10a6:647e with SMTP id 5a478bee46e88-2cbfc16e113mr2496039eec.19.1775261253576;
        Fri, 03 Apr 2026 17:07:33 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:a8b6:55b2:3eb6:2c0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm6520716eec.12.2026.04.03.17.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:07:31 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>,
	Douglas Anderson <dianders@chromium.org>,
	chleroy@kernel.org,
	driver-core@lists.linux.dev,
	gbatra@linux.ibm.com,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com
Subject: [PATCH v4 5/9] driver core: Replace dev->dma_ops_bypass with dev_dma_ops_bypass()
Date: Fri,  3 Apr 2026 17:04:59 -0700
Message-ID: <20260403170432.v4.5.If62b84471ef2c85e7ad250f0468867d6dba965ab@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260404000644.522677-1-dianders@chromium.org>
References: <20260404000644.522677-1-dianders@chromium.org>
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

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- New

 arch/powerpc/kernel/dma-iommu.c |  8 ++++----
 include/linux/device.h          | 15 +++++++--------
 kernel/dma/mapping.c            |  4 +---
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 73e10bd4d56d..6d1899b38c3d 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 }
 bool arch_dma_alloc_direct(struct device *dev)
 {
-	if (dev->dma_ops_bypass)
+	if (dev_dma_ops_bypass(dev))
 		return true;
 
 	return false;
@@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
 
 bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
 {
-	if (!dev->dma_ops_bypass)
+	if (!dev_dma_ops_bypass(dev))
 		return false;
 
 	return is_direct_handle(dev, dma_handle);
@@ -164,7 +164,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		 * fixed ops will be used for RAM. This is limited by
 		 * bus_dma_limit which is set when RAM is pre-mapped.
 		 */
-		dev->dma_ops_bypass = true;
+		dev_set_dma_ops_bypass(dev);
 		dev_info(dev, "iommu: 64-bit OK but direct DMA is limited by %llx\n",
 			 dev->bus_dma_limit);
 		return 1;
@@ -185,7 +185,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 	}
 
 	dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
-	dev->dma_ops_bypass = false;
+	dev_clear_dma_ops_bypass(dev);
 	return 1;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index fde0c72c3159..2ce89e3cfab9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -473,12 +473,18 @@ struct device_physical_location {
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
 	DEV_FLAG_READY_TO_PROBE = 0,
 	DEV_FLAG_CAN_MATCH = 1,
 	DEV_FLAG_DMA_IOMMU = 2,
 	DEV_FLAG_DMA_SKIP_SYNC = 3,
+	DEV_FLAG_DMA_OPS_BYPASS = 4,
 
 	DEV_FLAG_COUNT
 };
@@ -567,11 +573,6 @@ enum struct_device_flags {
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
@@ -685,9 +686,6 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
-#ifdef CONFIG_DMA_OPS_BYPASS
-	bool			dma_ops_bypass : 1;
-#endif
 
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
@@ -718,6 +716,7 @@ __create_dev_flag_accessors(ready_to_probe, DEV_FLAG_READY_TO_PROBE);
 __create_dev_flag_accessors(can_match, DEV_FLAG_CAN_MATCH);
 __create_dev_flag_accessors(dma_iommu, DEV_FLAG_DMA_IOMMU);
 __create_dev_flag_accessors(dma_skip_sync, DEV_FLAG_DMA_SKIP_SYNC);
+__create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
 
 /**
  * struct device_link - Device link representation.
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 76fc65d1a8a4..30bf8455730a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -126,11 +126,9 @@ static bool dma_go_direct(struct device *dev, dma_addr_t mask,
 	if (likely(!ops))
 		return true;
 
-#ifdef CONFIG_DMA_OPS_BYPASS
-	if (dev->dma_ops_bypass)
+	if (IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && dev_dma_ops_bypass(dev))
 		return min_not_zero(mask, dev->bus_dma_limit) >=
 			    dma_direct_get_required_mask(dev);
-#endif
 	return false;
 }
 
-- 
2.53.0.1213.gd9a14994de-goog

