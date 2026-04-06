Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999F3A2543
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517939; cv=none; b=X5bfKbBIvQVmBkQZrGHlqhjh5gzCFOfUdw187hvXG1NrKHz7p1YLY1N6sQSbQci/TAyxWxn4BupO1WJ+KLQ+sFwug3JT4AawZ68XmD1wzMtEWkLyXfSwLTQSIEKa2yh+o93g2xYIpoMkx93nv0JA9br0HMSCh04LGfcbwrcLjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517939; c=relaxed/simple;
	bh=5LVNiArQZYUSI+ZEaYqr74aA326eok+3E4kn/jEWtrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8KaBDjrNjZ9uHgB07zhxV5fnLf33l+MjPiPKJ6q/5AgDGoaGrR4pTXRk6jTpxI44JbCDB2uc2r6L3FDX4U7nKrI0C5/TFARNN4inOJRV0MheMZv7lUacb8Q4ddpIlQrGuGBdiQB/+0Q9Cq1Lkr5UIo6+qOiZQSXb86Krus7heI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XaPf7aLx; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XaPf7aLx"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2cfd69b564dso2334876eec.0
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775517936; x=1776122736; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLh8ZGhB5dU98LppXST8xiQJL4Zgmni3hu9P++EXxzM=;
        b=XaPf7aLx/Rte9ze5GXrGe9yw0xEgYuRXQE2P8gNxZnWGNUTeuXZooco3I2e99Wn1J4
         WHSRSdGDUNQEFFbPv9rfz53xMfShGHOKHOlX4Qg2ZWqE60hce9pDppp/5Ked3XDZ1Ct5
         vRZu5zJcIfUaPKMSdD6WhdXxxN0rqib2My3gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517936; x=1776122736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLh8ZGhB5dU98LppXST8xiQJL4Zgmni3hu9P++EXxzM=;
        b=ixbY5v/6i+u8JRorZIGwLeNPGWatmjfgm6DHkr99llrdOwk8f8YrGAioNRScws9ew7
         YNr8SjpME3k2nOGtTyW8Sa/nTCq37RAjXrETqPMXu9rb/UuGxDK11hGcoyTKnprV7A+7
         l4db6s/H2xy+zYVFtPWDKYNPB+uOMycgjCN99lYBWINgBQpMhFrT610cla33Y++6zTOB
         wofDMRotOzQuf0n+l9Xe4vSoIDMl5DMN/8Heebqg1Irl65j1abY72nN+Dc9oNSVS9Ky1
         HJWjbD+41Ja+fas3Kd9mdbz1gZ2lTm3RUCW11ePwBPn1TGhxiX6UAYIhqnBwb3PrgPvX
         WABw==
X-Forwarded-Encrypted: i=1; AJvYcCXrHm6CPjB27KjCBRIWRXG/tH5Ykl3GaIaswBkUh4awM0bz09bueRXW5MPQtTYvARwWRdLTYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoZUhLY8+r7SO/zLh5pLY063fUq3ItHI6NXrzd7Pw0ubFlWohE
	/6geoGMjpAWQcDY00qgYsRYR869B553QKNqdr6axABc2nn48M5BA1ET45NlMQhir9g==
X-Gm-Gg: AeBDiev3A/qsVfQaNVhuAhsCIhDDf72hfNBBXORpCOG2QWW8gjEbWgqaFSjTwkFfcsu
	ulByTH6nUzGuLmISfjAnAtERwWnGSki0jKg/hUc9tCF7U0eEUyumCpaXHWDw43hZ7lyVTg8x30P
	PbumzoDA9DDblTAgOyOspbdPuX/RqSfcE6uPKskZiCaw/7uFWe8OMpqXkVdkVx06pjPyzJFMV7H
	R9/9BnS67LUZHzqSPjzx4E9wZqyNyEpx8fRhhmcTzy8jUKrd075hVlL9hlB3GE3Ze8kqd5Aodlq
	ODrBGob8GLexBtLpp//LPDeJ2dch1+1mp7AwwmSNBBz5dvmZFk3RzQYpdsELfQZ/1y1Bdg2qivb
	PGRlTsWNfEU6plSNIR2kCvfKeD5C4iMEvGHbs144p3O6uUOvghvrEkZ/LwOarEG3ETE2IWcUk6P
	Llc3dsUmYelIHlt6+WR+4GARNaycVELpeuEYfMGdADADRLdYOmq+1ZtlNtXvH9rC0YWgyJvZxaf
	mDyZ8eymQ==
X-Received: by 2002:a05:7300:f190:b0:2c4:ec89:be0 with SMTP id 5a478bee46e88-2cbf9fe1d36mr7655035eec.9.1775517936536;
        Mon, 06 Apr 2026 16:25:36 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:c071:3b78:5a5:824a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm14730975eec.0.2026.04.06.16.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:25:35 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	maz@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
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
Subject: [PATCH v5 5/9] driver core: Replace dev->dma_ops_bypass with dev_dma_ops_bypass()
Date: Mon,  6 Apr 2026 16:22:58 -0700
Message-ID: <20260406162231.v5.5.If62b84471ef2c85e7ad250f0468867d6dba965ab@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260406232444.3117516-1-dianders@chromium.org>
References: <20260406232444.3117516-1-dianders@chromium.org>
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
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

NOTE: even though previously we only took up a bit if
CONFIG_DMA_OPS_BYPASS, in this change I reserve the bit
unconditionally.  While we could get the "dynamic" behavior by
changing the flags definition to be an unnumbered "enum", Greg has
requested that the numbers be stable. This also allows us to move one
"#ifdef" to an "if", getting better compile-time testing of both sides
of the "if".

(no changes since v4)

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
index c38593cf2583..1c43ff695e83 100644
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
 
 #undef __create_dev_flag_accessors
 
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

