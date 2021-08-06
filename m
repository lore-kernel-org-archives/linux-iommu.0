Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BBAC4338F
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBDB611C3
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 10:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFBDB611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F4CA402F1;
	Fri,  6 Aug 2021 10:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UP_ODrlyvggx; Fri,  6 Aug 2021 10:35:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3237B4010A;
	Fri,  6 Aug 2021 10:35:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10B78C001A;
	Fri,  6 Aug 2021 10:35:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5303EC000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41D8F4035E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dliUH9iaobm6 for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 10:35:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95CAE4027D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 10:35:26 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 u21-20020a17090a8915b02901782c36f543so13190927pjn.4
 for <iommu@lists.linux-foundation.org>; Fri, 06 Aug 2021 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q1mq8OVdPA80W1OExBfSV/W93H3mior+3W3/MDGRcPA=;
 b=WiK7nCyqlQFTBMZR9JJTdkj1kZjISOnsxD0sZZqZRttMOKdD7tNOx7SohDYrRPB/vS
 jVshrw+ma253776vxv7OuO7qNXWcABcU9y+C+lqyPYQa0LhHzQS7sqOiH4iyzJSxuHLw
 zBNXvOo7bxz4tkV1givX47JWukXhflrU29vCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q1mq8OVdPA80W1OExBfSV/W93H3mior+3W3/MDGRcPA=;
 b=hBHutoG8xavC3o6j8c2/IawtIVayTu9UVcEp2tzGwZIgRV2PaLkYrVsbZjVauQFlk3
 L5+45qtWwge2nHgsSbC34HEUlN0jU5pwg1zef986GNJAC+Gv6FgUE6zw6mJtwVfneGvv
 bYhftMMWF+UuLuHxvlUUdx7s8SA+/7uDyi1Q5+qUWAC8t1qaX2cU9i7nl7+ZKJxOeVgI
 552HTRkTj0hjaq9fc1NXiAvs8CgNMLtsEBflECo8zND1cfDPWmFlmeVw8pxtwFK2R5MH
 pEaJ/++m395CrNovdgg1VuykF/B7Mj4Ikt/2hXKwlSiYml3frHjUMaIDU+BECx+NIxNK
 IbtQ==
X-Gm-Message-State: AOAM530hUXri1wHAsZuZXzK9YM0EE2n2BGNedlktybRAgoWU8ETy0aLG
 NIwTejcyhrXVQZLcS5FaLS5vQA==
X-Google-Smtp-Source: ABdhPJxXz1rKwjtjRyr6RAhIU4x/csYMr6Flkwf754fyqLMJNih4b/f9Y7xhRTLzhRZpZaHngGi3BA==
X-Received: by 2002:a17:90a:138f:: with SMTP id
 i15mr9796044pja.173.1628246126098; 
 Fri, 06 Aug 2021 03:35:26 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
 by smtp.gmail.com with UTF8SMTPSA id x24sm12172935pjk.43.2021.08.06.03.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 03:35:25 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 8/9] dma-mapping: add persistent streaming mapping flag
Date: Fri,  6 Aug 2021 19:34:22 +0900
Message-Id: <20210806103423.3341285-9-stevensd@google.com>
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

Add a DMA_ATTR_PERSISTENT_STREAMING flag which indicates that the
streaming mapping is long lived and that the caller will manage
coherency either through the dma_sync_* functions or via some other
use-case specific mechanism. This flag indicates to the platform that
it should optimize for more efficient syncing at the cost of more
expensive mapping and unmapping.

This flag is used to skip optional bounce buffers when
CONFIG_IOMMU_BOUNCE_BUFFERS is enabled. With respect to these bounce
buffers, in most cases the flag is an optimization. However, callers
which do not use the dma_sync_* calls to manage coherency must use this
flag to work properly when CONFIG_IOMMU_BOUNCE_BUFFERS is enabled.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/io-bounce-buffers.c | 14 +++++++++++---
 include/linux/dma-mapping.h       | 11 +++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-bounce-buffers.c b/drivers/iommu/io-bounce-buffers.c
index af8c2a51eeed..3a0071d5a9ea 100644
--- a/drivers/iommu/io-bounce-buffers.c
+++ b/drivers/iommu/io-bounce-buffers.c
@@ -409,8 +409,16 @@ static bool io_bounce_buffers_map_buffer(struct io_bounce_buffers *buffers,
 	return mapped >= info->size;
 }
 
-static bool use_bounce_buffer(bool force_bounce, size_t size)
+static bool use_bounce_buffer(struct device *dev, unsigned long attrs,
+			      bool force_bounce, size_t size)
 {
+	if (attrs & DMA_ATTR_PERSISTENT_STREAMING) {
+		WARN_ONCE(force_bounce,
+			  "Skipping bounce buffer for untrusted mapping %s\n",
+			  dev_name(dev));
+		return false;
+	}
+
 	if (IS_ENABLED(CONFIG_IOMMU_BOUNCE_BUFFERS) &&
 	    size <= always_bounce_limit)
 		return true;
@@ -429,7 +437,7 @@ bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
 	bool force_bounce = buffers->untrusted &&
 			    iova_offset(buffers->iovad, offset | size);
 
-	if (!use_bounce_buffer(force_bounce, size))
+	if (!use_bounce_buffer(dev, attrs, force_bounce, size))
 		return false;
 
 	*handle = DMA_MAPPING_ERROR;
@@ -476,7 +484,7 @@ bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
 				buffers->iovad, iter->offset | iter->length);
 	}
 
-	if (!use_bounce_buffer(force_bounce, size))
+	if (!use_bounce_buffer(dev, attrs, force_bounce, size))
 		return false;
 
 	*out_nents = 0;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 183e7103a66d..5d318753bb79 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -61,6 +61,17 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_PERSISTENT_STREAMING: Indicates that the streaming mapping is long
+ * lived, so syncing performance should be prioritized over mapping/unmapping
+ * performance. Platform code will establish a mapping which only requires CPU
+ * cache synchronization.
+ *
+ * Callers that create long lived mappings and directly handle CPU cache
+ * management without calling using dma_sync_* functions must set this flag.
+ */
+#define DMA_ATTR_PERSISTENT_STREAMING	(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
