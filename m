Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8213A380C
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517933; cv=none; b=p3ZTrFv6jq7ZY1fjVAd4LxY3ZpbFvi6x+R5inmIqJW7MvcYlEqqKPMXWi4ljkeEtPV81AsyFQCTs11NBncqb5OEm1VNiZzcsXJNuqlDBuIYUbWZODT9lRjwfZ6+v8bOD/en8cN65fbISrb6ZNG2+ObSRR4CQH4MtqNDrP08FRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517933; c=relaxed/simple;
	bh=mJC4O1w2J/M3FPcvGJMNtUaUKMlSqjDOXiDV5TBZZbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRBrnjJ+Tro3GOOArOfwK1Wwbdcuf+V7jxLtrnLaTUf0lIU+ZeXo25deXdV4DdNkkwT+5XXxThifdI69cTs8Dhoz5kLUNPGkPtbsQwyvCHuiLPiXbFaXsfJjP1FH7LEC7AfUiGfU+WxT1I1HFfpkM6NDUGkBOQQ+lsIEWozeNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LZaabc6h; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LZaabc6h"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c15849aa2cso5681795eec.0
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775517931; x=1776122731; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNJDAfopkqTSKFek9BA2OkT2NzzRFpZlW9wrOT8gPH0=;
        b=LZaabc6hWrvwK/SH4HQCzOFcTGiF7HQxhSxeiSsB9afD3lcpB+0oG5wFKGlvlc/FTi
         K7Ty/gi+XYLP/QxLG0aTdrNRi6bsanwsw1ypOgWbUUfTokinU1VImWMas4jJ1UMJdv+d
         6urEs8Av5Xi9BW6UrGm1GmOixqoMDPCSOfJjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517931; x=1776122731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNJDAfopkqTSKFek9BA2OkT2NzzRFpZlW9wrOT8gPH0=;
        b=NZB4j+w6hfBgBg5njrLERyOiyYqMC1OjporyZB/TfGP4R5Gpe3WnWh0/7sncLS5Ai+
         7v429E1Zer/HPS3lEus5W/ivf1W+Db4YJ5rKmPDts3LTEUHXJyvXelpUEa8IKwGPYXug
         OALcaFWmBoUOQapTjqIoTjmZoxBJg3zx6PYUx+FHDSrI9F1u6DDbcN5HSOK8aHTXIEfO
         efzZPaUbBd9PzPOnZs+9sQPBzqDH/SYpIBLxnsbLa/PUed7qvO2vDOrnL5PoUvomwwyo
         Kfm7y5KbaRsFLnww42AoOjjp2r3pa31Cdpiu5FzYSUZblhsOdGXKCYh4huMrY562DFYk
         A1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXkCwR8wvSanLHtAliIlcZU76u0ZmTCDoTpdzti4hq9VcDYAf3tAU137Tz8vyzxmDQAYgDmXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaTXSlYZCXF7JpPljIFv+3A1XfnyngLThlHIWWcvSEROLNwykU
	Wsl3zoqrm0o+AhR2B5RD8EDbYQGQuK9Vix3K7Fhalf5U3SdcEZaMLB8Rl/Ulvsw66A==
X-Gm-Gg: AeBDievy/Fi8N3H6TqpkCmCAcz30kH3oegB37vHWCrTw3VDf7icDM7xL1efdOisfoVV
	V1qdGs/65FCpu9pSNpETxsEO5ein4GYhWaYwxYswUJO57mWTTbr6wy1X21nuPTelRg9aUIAY2sV
	efi57zMRbRoridgf8vMmaMlQgZjwsbuj2wcz01g8Znyhz3oXq13sPthY+Rfj1Pg4ZwZnLN8bapb
	xBe7CGQVGQTV/XiAhL16kamuuafataNHxPqBq70SGb1MlUqCMHATnEmsZCaSIq82uf+PocecwnG
	dRbcdJCL4P4BE38FvbpL5pZtHDCsguTC0ovw/YDtbTmn4KkLTrLURL4V1nuMNOI3dDqD2xFHy/w
	rkx2XCPrIiUZmymvggp5/3NJizZGrL/xbG2VKgqZMS0X9wEzTJQSbWEV+7Om1dT7Xd9tKI9xbO9
	EgyFRXzdmTb8CUVusUvg9QxKOX4zsspb0kzQJFAvhmzpPB6B59Ajyn1ihFsJGq5z9KTys9SG7D2
	BiOQFdLWw==
X-Received: by 2002:a05:7300:fd05:b0:2c0:d46d:cfc2 with SMTP id 5a478bee46e88-2cbfbe7d5e0mr6829547eec.23.1775517931001;
        Mon, 06 Apr 2026 16:25:31 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:c071:3b78:5a5:824a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm14730975eec.0.2026.04.06.16.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:25:29 -0700 (PDT)
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
	driver-core@lists.linux.dev,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org
Subject: [PATCH v5 3/9] driver core: Replace dev->dma_iommu with dev_dma_iommu()
Date: Mon,  6 Apr 2026 16:22:56 -0700
Message-ID: <20260406162231.v5.3.Id20d5973cbff542fea290e13177e9423f5d81342@changeid>
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
threads without locking. Switch "dma_iommu" over to the "flags" field
so modifications are safe.

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

NOTE: even though previously we only took up a bit if
CONFIG_IOMMU_DMA, in this change I reserve the bit unconditionally.
While we could get the "dynamic" behavior by changing the flags
definition to be an unnumbered "enum", Greg has requested that the
numbers be stable. This also allows us to move one "#ifdef" to an
"if", getting better compile-time testing of both sides of the "if".

(no changes since v4)

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- New

 drivers/iommu/dma-iommu.c | 9 ++++++---
 drivers/iommu/iommu.c     | 5 ++---
 include/linux/device.h    | 9 ++++-----
 include/linux/iommu-dma.h | 3 ++-
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 94d514169642..036994069b80 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2112,18 +2112,21 @@ EXPORT_SYMBOL_GPL(dma_iova_destroy);
 
 void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain)
 {
+	bool dma_iommu;
+
 	if (dev_is_pci(dev))
 		dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
 
-	dev->dma_iommu = iommu_is_dma_domain(domain);
-	if (dev->dma_iommu && iommu_dma_init_domain(domain, dev))
+	dma_iommu = iommu_is_dma_domain(domain);
+	dev_assign_dma_iommu(dev, dma_iommu);
+	if (dma_iommu && iommu_dma_init_domain(domain, dev))
 		goto out_err;
 
 	return;
 out_err:
 	pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
 		dev_name(dev));
-	dev->dma_iommu = false;
+	dev_clear_dma_iommu(dev);
 }
 
 static bool has_msi_cookie(const struct iommu_domain *domain)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 50718ab810a4..8dc50a0eee85 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -589,9 +589,8 @@ static void iommu_deinit_device(struct device *dev)
 	dev->iommu_group = NULL;
 	module_put(ops->owner);
 	dev_iommu_free(dev);
-#ifdef CONFIG_IOMMU_DMA
-	dev->dma_iommu = false;
-#endif
+	if (IS_ENABLED(CONFIG_IOMMU_DMA))
+		dev_clear_dma_iommu(dev);
 }
 
 static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
diff --git a/include/linux/device.h b/include/linux/device.h
index 38f4316b3cde..620306e8380a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -469,10 +469,13 @@ struct device_physical_location {
  * @DEV_FLAG_CAN_MATCH: The device has matched with a driver at least once or it
  *		is in a bus (like AMBA) which can't check for matching drivers
  *		until other devices probe successfully.
+ * @DEV_FLAG_DMA_IOMMU: Device is using default IOMMU implementation for DMA and
+ *		doesn't rely on dma_ops structure.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE = 0,
 	DEV_FLAG_CAN_MATCH = 1,
+	DEV_FLAG_DMA_IOMMU = 2,
 
 	DEV_FLAG_COUNT
 };
@@ -567,8 +570,6 @@ enum struct_device_flags {
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
  * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
- * @dma_iommu: Device is using default IOMMU implementation for DMA and
- *		doesn't rely on dma_ops structure.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -688,9 +689,6 @@ struct device {
 #ifdef CONFIG_DMA_NEED_SYNC
 	bool			dma_skip_sync:1;
 #endif
-#ifdef CONFIG_IOMMU_DMA
-	bool			dma_iommu:1;
-#endif
 
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
@@ -719,6 +717,7 @@ static inline bool dev_test_and_set_##accessor_name(struct device *dev) \
 
 __create_dev_flag_accessors(ready_to_probe, DEV_FLAG_READY_TO_PROBE);
 __create_dev_flag_accessors(can_match, DEV_FLAG_CAN_MATCH);
+__create_dev_flag_accessors(dma_iommu, DEV_FLAG_DMA_IOMMU);
 
 #undef __create_dev_flag_accessors
 
diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index a92b3ff9b934..060f6e23ab3c 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -7,12 +7,13 @@
 #ifndef _LINUX_IOMMU_DMA_H
 #define _LINUX_IOMMU_DMA_H
 
+#include <linux/device.h>
 #include <linux/dma-direction.h>
 
 #ifdef CONFIG_IOMMU_DMA
 static inline bool use_dma_iommu(struct device *dev)
 {
-	return dev->dma_iommu;
+	return dev_dma_iommu(dev);
 }
 #else
 static inline bool use_dma_iommu(struct device *dev)
-- 
2.53.0.1213.gd9a14994de-goog

