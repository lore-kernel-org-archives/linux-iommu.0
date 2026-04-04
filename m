Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5D16F288
	for <iommu@lists.linux.dev>; Sat,  4 Apr 2026 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261249; cv=none; b=EqtK0PMMh0wVUGmxcVyGxYfuZ/9IH6Ytp4yJm0o3wO1HPQIKAnnTiaqBF3guhvLp9kR1iVV7R2xZtjtOzIxGaIGS8DPuhEyuK7Z4X0D1QtqW1Ys8+IRDdBiI1m/PA4i4hAWtG6hOq0xIytqb2aXDzGzG38iS3NjsIK5pwQabJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261249; c=relaxed/simple;
	bh=aZahSfnZH2LIxSJe6x6zdQFMTyLs4fu+wjkHHWUcL+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnEYTARqj8w4+kLnah0HEyvmA4lJxV3liEmOm8xzOXiH7wv2Ji7pbXROijrPgo7SedxPQ+BL4xndI02GlETv8Ls95ZU7ci4kXp0lK86wDGSgwOEXm6iwdBYcJZSpN9IjKrU4AicYr6t7fzrvOLm7oGZm6Wh1kaiR6/dxjO4NipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KVllSYGk; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KVllSYGk"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c56aa62931so5294909eec.0
        for <iommu@lists.linux.dev>; Fri, 03 Apr 2026 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775261247; x=1775866047; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo4F8ZRupwn9qN0zyBWrlRKw8XW6T5nN42rVGGZxhtU=;
        b=KVllSYGkAtAYLQx9uz+YM6jp3fTXkepNo+VDuy577ds3IIV33s4OJ/y8Dar8KH3kTv
         0dGORf+SasNSDOxeNBvOFboKdNp8oB5krEFT8tF8oPbf3HEeCDP9yux+R2CyopWh0ECD
         4hFfR8ksyeVVPYXbNQw7p+XUDq2aDT/utzOTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775261247; x=1775866047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jo4F8ZRupwn9qN0zyBWrlRKw8XW6T5nN42rVGGZxhtU=;
        b=A+a6RT9E3vb5gKleSNYos6/zOsviR5wC7WhlIeO7pICaM1LquXavQx+1io6jw1uxVy
         vkORpIagcYVQQqf1UF4HnQf5yA38o1GGlLGH2BIbNRq2hBo+EnHMtF4+XdZzJiriQMPH
         zgWYoS6jIE2/MYIbkXCC8TtzMBX+cM222QcZuGZT2wDHBR6sHPtQkrLV/stcsrSlVD3S
         WxdBXg6J9ozzC9RrHiJBE+AeiUpnKqpTa+HPFC7HP3GS4UgCm64j8+EsMCjMbdl464x+
         G0Ph9z9qPIEGtzS+ykKu16yrbo5XcjCRTE536UN8dFGyTMk8mLhanltyy9e36hRrotwl
         U3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXZl1PGYn0fswq6bisUFAYO9ra4PGh4JEnx5AfOp8Y/V0MdFbQtqpgdBQ7ZCxCVJNvVpHzKWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7RRJ8/4w5A5w8o1N1wszELrzx8bvdrRbjrSOs34IHxmy1x+Hx
	7Dd6OGGbq/GSuy+R0LbsPqV57dfKiYNPPrK9lbh8JbtlmH5BsOP8mUezQBOtAx3pUQ==
X-Gm-Gg: AeBDiesthV9+tzJ2zoxzbZajrCTqEmOoSLhZ+Xge7HxqqEZCAQ2p+gBev/VCb0RKxNT
	hIqeV0EvNdDvZUrUJN/70pvfLrDINNZfJ7S/cUV46cdBxVNCT42ucbi/09Z0aBdnE9wXp9bvwHj
	4HzCV2UHMbajnf3IxTlURNAovCMUNroTapPZPiNGCbxyuRWIAcGRYa0YICZvJdvCOTtOdfUj9cl
	C+p41FYtqfnKA/x3qD4STnS2mPETMudjpVp6UNjtpbAgS/rJhdT1XrDh4g6+itn+MhPYq+Grqxd
	ZN2B9iz4kitbsLOkp2WkS8YZB2DBebjAeBWmY7qmAT91RWYP6iLrxXLJhoBDsy2Katqi1ZGUtwC
	nKOCVWaO0ngutCpQH0Fu4G44UOvP1k22oC22ARCSHWHqqHgtABTSpju0pKI9TzNCJ+CfPWWjCQD
	Asg9VnR3HpK4dbzTWVSwpa894gBDDn2FrqrfP6Hquu4n6xC9jMHvTVTtOXdfNB3ZJpoiHuzee/M
	nrFgpWpUhY=
X-Received: by 2002:a05:7300:748b:b0:2c7:2c0b:f33b with SMTP id 5a478bee46e88-2cbfba8e8eamr2595200eec.20.1775261246987;
        Fri, 03 Apr 2026 17:07:26 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:a8b6:55b2:3eb6:2c0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm6520716eec.12.2026.04.03.17.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:07:26 -0700 (PDT)
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
	driver-core@lists.linux.dev,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org
Subject: [PATCH v4 3/9] driver core: Replace dev->dma_iommu with dev_dma_iommu()
Date: Fri,  3 Apr 2026 17:04:57 -0700
Message-ID: <20260403170432.v4.3.Id20d5973cbff542fea290e13177e9423f5d81342@changeid>
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
threads without locking. Switch "dma_iommu" over to the "flags" field
so modifications are safe.

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

NOTE: even though previously we only took up a bit if
CONFIG_IOMMU_DMA, in this change I reserve the bit unconditionally.
While we could get the "dynamic" behavior by changing the flags
definition to be an "enum", it doesn't seem worth it at this
point. This also allows us to move one "#ifdef" to an "if", getting
better compile-time testing of both sides of the "if".

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
index 5e42261ba3aa..feb11ba1ba71 100644
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
 
 /**
  * struct device_link - Device link representation.
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

