Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03C7479;
	Tue, 25 Oct 2022 16:54:51 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id v1so22134891wrt.11;
        Tue, 25 Oct 2022 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj7FhB58uMn4h8H3wgZfmSRd9vXTbsp8lRGrOrs+X1o=;
        b=KoO/IFDIdAddmPIJ1BG+QvpjyIUIS+dN795VoEhPKi5wfaQcbf+E+GBzzCH6fbXB/f
         d9ezM6PZerO2XMyIMxsSkwcP20hElLy6CA53mi4Ad70JlUoEJZ4K5wCBfivlaTzslW/j
         YMhNodNgw0XA0BPiiU+0Hcacb+yulPiCGfNKmvPAuKajNPunn14TvN1/MPH986ZC67w0
         zkf6rSBJMR4omsaTAkmgZQtJcYGtOFewv3K43i1E5CtMwARAPVfK5Tq/KrxUNFrk7sYb
         2mv3NfngdOVyfsvD7dk7CUw6njAMR0Vg70i5toRbU7IqeLnCDaRSm4G0ppSF5+EIz4O0
         73lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj7FhB58uMn4h8H3wgZfmSRd9vXTbsp8lRGrOrs+X1o=;
        b=W7sTc2F5efYP/CeqF0PXAikqbIw7vBnPwiSpn0n+8wFQcbXpvE8kUyDeSRDdHIrzBY
         kvNGV2OyPcy+unOpKVahYJpVz8KLO0qEKz/OqawKyU7MvXVjHO7JjeR+OgQnPgCS9k06
         ZkskHHAqfPTiBXAKqjCZ8HYyRwnMYwVbM7NVwRdWw/5glhS1aS21nLD7rHpnQzJj6FCZ
         0sKTHPu78qdychahhAMOxAvs10QZuzTH4AUi/nJB8GV191iLYAutjV6WwL1oJNLlv+88
         LROdQ/n9JKTaDv8l5HHqNkfp2Dc6foCb391ZeN8boDPE+unnPjYNjTy8dUDJbTZpNhCP
         419A==
X-Gm-Message-State: ACrzQf1XxbivY4ZQUZXBbSgNSS6Md9lAfhddL5boRRjqhHSSSNyAYbLh
	SHMp19QBC1AGFRY8kCYP0KLq1FeJnqSZmQ==
X-Google-Smtp-Source: AMsMyM4QbdbhgbDyi34T6qfyQKp7IPL827BhF9NwQyMqQzPbUOVWRISJYasElMB6P/tEeZYiLkd+dQ==
X-Received: by 2002:a5d:64c2:0:b0:22e:41b1:faf7 with SMTP id f2-20020a5d64c2000000b0022e41b1faf7mr24834767wri.428.1666716879104;
        Tue, 25 Oct 2022 09:54:39 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:38 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: maxime@cerno.tech,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: wens@csie.org,
	samuel@sholland.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 5/5] iommu/sun50i: Implement .iotlb_sync_map
Date: Tue, 25 Oct 2022 18:54:15 +0200
Message-Id: <20221025165415.307591-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025165415.307591-1-jernej.skrabec@gmail.com>
References: <20221025165415.307591-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocated iova ranges need to be invalidated immediately or otherwise
they might or might not work when used by master or CPU. This was
discovered when running video decoder conformity test with Cedrus. Some
videos were now and then decoded incorrectly and generated page faults.

According to vendor driver, it's enough to invalidate just start and end
TLB and PTW cache lines. Documentation says that neighbouring lines must
be invalidated too. Finally, when page fault occurs, that iova must be
invalidated the same way, according to documentation.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
 - new patch

 drivers/iommu/sun50i-iommu.c | 73 ++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index e62e245060ac..5cb2d44dfb92 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -93,6 +93,8 @@
 #define NUM_PT_ENTRIES			256
 #define PT_SIZE				(NUM_PT_ENTRIES * PT_ENTRY_SIZE)

+#define SPAGE_SIZE			4096
+
 struct sun50i_iommu {
 	struct iommu_device iommu;

@@ -295,6 +297,62 @@ static void sun50i_table_flush(struct sun50i_iommu_domain *sun50i_domain,
 	dma_sync_single_for_device(iommu->dev, dma, size, DMA_TO_DEVICE);
 }

+static void sun50i_iommu_zap_iova(struct sun50i_iommu *iommu,
+				  unsigned long iova)
+{
+	u32 reg;
+	int ret;
+
+	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_REG, iova);
+	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_MASK_REG, GENMASK(31, 12));
+	iommu_write(iommu, IOMMU_TLB_IVLD_ENABLE_REG,
+		    IOMMU_TLB_IVLD_ENABLE_ENABLE);
+
+	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_TLB_IVLD_ENABLE_REG,
+					reg, !reg, 1, 2000);
+	if (ret)
+		dev_warn(iommu->dev, "TLB invalidation timed out!\n");
+}
+
+static void sun50i_iommu_zap_ptw_cache(struct sun50i_iommu *iommu,
+				       unsigned long iova)
+{
+	u32 reg;
+	int ret;
+
+	iommu_write(iommu, IOMMU_PC_IVLD_ADDR_REG, iova);
+	iommu_write(iommu, IOMMU_PC_IVLD_ENABLE_REG,
+		    IOMMU_PC_IVLD_ENABLE_ENABLE);
+
+	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_PC_IVLD_ENABLE_REG,
+					reg, !reg, 1, 2000);
+	if (ret)
+		dev_warn(iommu->dev, "PTW cache invalidation timed out!\n");
+}
+
+static void sun50i_iommu_zap_range(struct sun50i_iommu *iommu,
+				   unsigned long iova, size_t size)
+{
+	assert_spin_locked(&iommu->iommu_lock);
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
+
+	sun50i_iommu_zap_iova(iommu, iova);
+	sun50i_iommu_zap_iova(iommu, iova + SPAGE_SIZE);
+	if (size > SPAGE_SIZE) {
+		sun50i_iommu_zap_iova(iommu, iova + size);
+		sun50i_iommu_zap_iova(iommu, iova + size + SPAGE_SIZE);
+	}
+	sun50i_iommu_zap_ptw_cache(iommu, iova);
+	sun50i_iommu_zap_ptw_cache(iommu, iova + SZ_1M);
+	if (size > SZ_1M) {
+		sun50i_iommu_zap_ptw_cache(iommu, iova + size);
+		sun50i_iommu_zap_ptw_cache(iommu, iova + size + SZ_1M);
+	}
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, IOMMU_AUTO_GATING_ENABLE);
+}
+
 static int sun50i_iommu_flush_all_tlb(struct sun50i_iommu *iommu)
 {
 	u32 reg;
@@ -344,6 +402,18 @@ static void sun50i_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
 }

+static void sun50i_iommu_iotlb_sync_map(struct iommu_domain *domain,
+					unsigned long iova, size_t size)
+{
+	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
+	struct sun50i_iommu *iommu = sun50i_domain->iommu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->iommu_lock, flags);
+	sun50i_iommu_zap_range(iommu, iova, size);
+	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
+}
+
 static void sun50i_iommu_iotlb_sync(struct iommu_domain *domain,
 				    struct iommu_iotlb_gather *gather)
 {
@@ -767,6 +837,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
 		.attach_dev	= sun50i_iommu_attach_device,
 		.detach_dev	= sun50i_iommu_detach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
+		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
 		.iova_to_phys	= sun50i_iommu_iova_to_phys,
 		.map		= sun50i_iommu_map,
@@ -786,6 +857,8 @@ static void sun50i_iommu_report_fault(struct sun50i_iommu *iommu,
 		report_iommu_fault(iommu->domain, iommu->dev, iova, prot);
 	else
 		dev_err(iommu->dev, "Page fault while iommu not attached to any domain?\n");
+
+	sun50i_iommu_zap_range(iommu, iova, SPAGE_SIZE);
 }

 static phys_addr_t sun50i_iommu_handle_pt_irq(struct sun50i_iommu *iommu,
--
2.38.1

