Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42295C4338F
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5F761167
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC5F761167
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B55DF83A6C;
	Fri,  6 Aug 2021 10:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vDZnTmYw1uLg; Fri,  6 Aug 2021 10:35:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6B64D82446;
	Fri,  6 Aug 2021 10:35:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56452C001A;
	Fri,  6 Aug 2021 10:35:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD14C000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A3CC402F7
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n2WsbqPqTCiB for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 10:35:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7258B4033B
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:11 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id z3so6470356plg.8
 for <iommu@lists.linux-foundation.org>; Fri, 06 Aug 2021 03:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iVVuhQ4VdiThMZfAczPQAdsgcnyPsdF7TaM0E08i+Lg=;
 b=bCYmBsiVuWygmDud5P8U1YTWeHcJyxftI8U7BckjqyLVObAczE90aWdrfJYrBsHpjG
 GlsbN7xxLHbAfajC2eYt8XxvIJN9tdaSeLNjTorZpQ/SMElLLYRpqX2lBl4kPIR0KlYE
 BzA1BTRobERhZOks2elLE9MENaIXVg3hNVdfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iVVuhQ4VdiThMZfAczPQAdsgcnyPsdF7TaM0E08i+Lg=;
 b=B6liur00YJni+Fvpq8zgUmXC7/5Z8xY1L92JwvHSXHH3nCoK4UMiinlHpL4+ey4MWu
 owq3A05S5kpLfSroSFk5R2y9/zXsbG5piEF6Tir8jETQ17LkWcTL8Z4OWAzZsJJ5sGnK
 IDsxD0LtuV20mFmb7Xdx5YNJUzocZPJiywfNeEoWtboJniDP5isFg7R/8iESkSaEdV/l
 w1G2XqDe37Dc5CtAalABVygTD+Rl8lVzIrTjfBxZiCPAuOCD9T9CKNw3Arn1jmCwLZjX
 BS5dc8XgLwcaRjPcQMG09zwjPtmMFiaZfYyWSuF1esmbp5Xcn5KgYC472LIMXu8QW4H6
 7U9w==
X-Gm-Message-State: AOAM531b+dIjBtFPBKO2e7DPP/A8BWhY8qWuTIC4d+JPpE/KUKba3NFW
 H5i/0fBteu+IRB9Fgb9FMj9Ptg==
X-Google-Smtp-Source: ABdhPJxDsWyBNXXh1mvo6WYg6FiOrgZOm81aB2pQFOS33NCCozCCJyu35GPaQymcBaN2/dXnT6tgXg==
X-Received: by 2002:a63:4e4a:: with SMTP id o10mr431122pgl.350.1628246110949; 
 Fri, 06 Aug 2021 03:35:10 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
 by smtp.gmail.com with UTF8SMTPSA id a8sm11653910pgd.50.2021.08.06.03.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 03:35:10 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 4/9] dma-iommu: remove extra buffer search on unmap
Date: Fri,  6 Aug 2021 19:34:18 +0900
Message-Id: <20210806103423.3341285-5-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806103423.3341285-1-stevensd@google.com>
References: <20210806103423.3341285-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: David Stevens <stevensd@chromium.org>

Add callback to buffer manager's removal function so that the buffer can
be sync'ed during unmap without an extra find operation.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/io-bounce-buffers.c | 87 +++++++++++++++++++++++++------
 drivers/iommu/io-buffer-manager.c |  6 ++-
 drivers/iommu/io-buffer-manager.h |  6 ++-
 3 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/io-bounce-buffers.c b/drivers/iommu/io-bounce-buffers.c
index 78b4440b58c8..c7c52a3f8bf7 100644
--- a/drivers/iommu/io-bounce-buffers.c
+++ b/drivers/iommu/io-bounce-buffers.c
@@ -153,6 +153,20 @@ static void io_bounce_buffers_do_sync(struct io_bounce_buffers *buffers,
 	}
 }
 
+static void __io_bounce_buffers_sync_single(struct io_bounce_buffers *buffers,
+					    dma_addr_t dma_handle, size_t size,
+					    struct io_bounce_buffer_info *info,
+					    struct page *orig_buffer, int prot,
+					    enum dma_data_direction dir,
+					    bool sync_for_cpu)
+{
+	size_t offset = dma_handle - info->iova;
+
+	io_bounce_buffers_do_sync(buffers, info->bounce_buffer, offset,
+				  orig_buffer, offset, size, dir, prot,
+				  sync_for_cpu);
+}
+
 bool io_bounce_buffers_sync_single(struct io_bounce_buffers *buffers,
 				   dma_addr_t dma_handle, size_t size,
 				   enum dma_data_direction dir,
@@ -160,17 +174,14 @@ bool io_bounce_buffers_sync_single(struct io_bounce_buffers *buffers,
 {
 	struct io_bounce_buffer_info info;
 	void *orig_buffer;
-	size_t offset;
 	int prot;
 
 	if (!io_buffer_manager_find_buffer(&buffers->manager, dma_handle, &info,
 					   &orig_buffer, &prot))
 		return false;
 
-	offset = dma_handle - info.iova;
-	io_bounce_buffers_do_sync(buffers, info.bounce_buffer, offset,
-				  orig_buffer, offset, size, dir, prot,
-				  sync_for_cpu);
+	__io_bounce_buffers_sync_single(buffers, dma_handle, size, &info,
+					orig_buffer, prot, dir, sync_for_cpu);
 	return true;
 }
 
@@ -219,16 +230,56 @@ bool io_bounce_buffers_sync_sg(struct io_bounce_buffers *buffers,
 	return true;
 }
 
+struct unmap_sync_args {
+	struct io_bounce_buffers *buffers;
+	unsigned long attrs;
+	enum dma_data_direction dir;
+	dma_addr_t handle;
+	size_t size;
+	int nents;
+};
+
+static void
+io_bounce_buffers_unmap_page_sync(struct io_bounce_buffer_info *info, int prot,
+				  void *orig_buffer, void *ctx)
+{
+	struct unmap_sync_args *args = ctx;
+
+	if (args->attrs & DMA_ATTR_SKIP_CPU_SYNC)
+		return;
+
+	__io_bounce_buffers_sync_single(args->buffers, args->handle, args->size,
+					info, orig_buffer, prot, args->dir,
+					true);
+}
+
 bool io_bounce_buffers_unmap_page(struct io_bounce_buffers *buffers,
 				  dma_addr_t handle, size_t size,
 				  enum dma_data_direction dir,
 				  unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		io_bounce_buffers_sync_single(buffers, handle, size, dir, true);
+	struct unmap_sync_args args = { .buffers = buffers,
+					.attrs = attrs,
+					.dir = dir,
+					.handle = handle,
+					.size = size };
+
+	return io_buffer_manager_release_buffer(
+		&buffers->manager, buffers->domain, handle, true,
+		io_bounce_buffers_unmap_page_sync, &args);
+}
+
+static void io_bounce_buffers_unmap_sg_sync(struct io_bounce_buffer_info *info,
+					    int prot, void *orig_buffer,
+					    void *ctx)
+{
+	struct unmap_sync_args *args = ctx;
+
+	if (args->attrs & DMA_ATTR_SKIP_CPU_SYNC)
+		return;
 
-	return io_buffer_manager_release_buffer(&buffers->manager,
-						buffers->domain, handle, true);
+	__io_bounce_buffers_sync_sg(args->buffers, orig_buffer, args->nents,
+				    info->bounce_buffer, args->dir, prot, true);
 }
 
 bool io_bounce_buffers_unmap_sg(struct io_bounce_buffers *buffers,
@@ -236,11 +287,13 @@ bool io_bounce_buffers_unmap_sg(struct io_bounce_buffers *buffers,
 				enum dma_data_direction dir,
 				unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		io_bounce_buffers_sync_sg(buffers, sgl, nents, dir, true);
+	struct unmap_sync_args args = {
+		.buffers = buffers, .attrs = attrs, .dir = dir, .nents = nents
+	};
 
 	return io_buffer_manager_release_buffer(
-		&buffers->manager, buffers->domain, sg_dma_address(sgl), true);
+		&buffers->manager, buffers->domain, sg_dma_address(sgl), true,
+		io_bounce_buffers_unmap_sg_sync, &args);
 }
 
 static bool io_bounce_buffers_map_buffer(struct io_bounce_buffers *buffers,
@@ -286,8 +339,9 @@ bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
 					  page, offset, size, dir, prot, false);
 
 	if (!io_bounce_buffers_map_buffer(buffers, &info, prot)) {
-		io_buffer_manager_release_buffer(
-			&buffers->manager, buffers->domain, info.iova, false);
+		io_buffer_manager_release_buffer(&buffers->manager,
+						 buffers->domain, info.iova,
+						 false, NULL, NULL);
 		return true;
 	}
 
@@ -328,8 +382,9 @@ bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
 					    false);
 
 	if (!io_bounce_buffers_map_buffer(buffers, &info, prot)) {
-		io_buffer_manager_release_buffer(
-			&buffers->manager, buffers->domain, info.iova, false);
+		io_buffer_manager_release_buffer(&buffers->manager,
+						 buffers->domain, info.iova,
+						 false, NULL, NULL);
 		return true;
 	}
 
diff --git a/drivers/iommu/io-buffer-manager.c b/drivers/iommu/io-buffer-manager.c
index 24e95a2faa37..79b9759da928 100644
--- a/drivers/iommu/io-buffer-manager.c
+++ b/drivers/iommu/io-buffer-manager.c
@@ -169,7 +169,8 @@ bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
 
 bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
 				      struct iommu_domain *domain,
-				      dma_addr_t handle, bool inited)
+				      dma_addr_t handle, bool inited,
+				      prerelease_cb cb, void *ctx)
 {
 	struct io_buffer_node *node;
 	unsigned long flags;
@@ -184,6 +185,9 @@ bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
 	if (!node)
 		return false;
 
+	if (cb)
+		cb(&node->info, node->prot, node->orig_buffer, ctx);
+
 	if (inited)
 		free_buffer = io_bounce_buffers_release_buffer_cb(
 			manager, node->info.iova, node->info.size);
diff --git a/drivers/iommu/io-buffer-manager.h b/drivers/iommu/io-buffer-manager.h
index aae560cc8512..0e75d89926ca 100644
--- a/drivers/iommu/io-buffer-manager.h
+++ b/drivers/iommu/io-buffer-manager.h
@@ -31,9 +31,13 @@ bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
 				   struct io_bounce_buffer_info *info,
 				   void **orig_buffer, int *prot);
 
+typedef void (*prerelease_cb)(struct io_bounce_buffer_info *info, int prot,
+			      void *orig_buffer, void *ctx);
+
 bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
 				      struct iommu_domain *domain,
-				      dma_addr_t handle, bool inited);
+				      dma_addr_t handle, bool inited,
+				      prerelease_cb cb, void *ctx);
 
 int io_buffer_manager_init(struct io_buffer_manager *manager);
 
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
