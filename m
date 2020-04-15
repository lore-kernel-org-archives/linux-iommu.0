Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D8FC38A29
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC8E2076B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="B8Zpz7Tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC8E2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2676D86C1A;
	Wed, 15 Apr 2020 00:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MtdOHLs-cAm1; Wed, 15 Apr 2020 00:05:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1BA3F86BE0;
	Wed, 15 Apr 2020 00:05:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1B44C1D8D;
	Wed, 15 Apr 2020 00:05:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51AD3C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 374E086BAD
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZOCQVTCckGCN for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 00:05:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9BA5486B94
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:05:01 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id x3so715256pfp.7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=ESsKmnN/8XjLZGFCRgaE4t6oba6cTfi788uzFnxL0dM=;
 b=B8Zpz7TgZ1vEk8R/IpXo/21kD7KbRuD+XLLWXecF+QlLac8VLY2jSNWWBUXQwDhEdH
 lqqcgClcDh2UJeu8UR4B8dAEiRwzdwUJ3wq/Rdc814Jt8PsyHkUwIDPC7Bu5ApdVzgqc
 Pfl+mVhUnQpuYKHQMNXiUmkRnL3+OostdVxdmsYR4y63MEzRq0S8Lm5sLkP6zs7m1C1U
 UX+ZNvmkNypoZBKFiH0Aye9M5y+wEYwVZoPbv0T2HxR4RLDnIEWF8JOGjBmzOvlV0Fo2
 pK+8Q2H/XmRMQijHm6TF5DygcosQAubi/LPQYJiy0xpzyz7fsMTUpSyFBu/D8p45eevb
 mDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=ESsKmnN/8XjLZGFCRgaE4t6oba6cTfi788uzFnxL0dM=;
 b=WJGdeHOf9Q4PsT/WHCtCXgzVfi+gpOMwduI90eZBFZ7slrZCA1bfuN/hT0GTKnhoRn
 GX3iL45SOLeWnkGnnfBuLY+2izyfUKCyFfueczdeb3//eO9aZb0QN53pfRUKNIjkxPGk
 AeLdFt4E4VwqW4v0JhyxF8vdOLekU0ZBjnPinuBqnmCyglGrFY5ztoyTw2WRQRcQDIY0
 CHD+nam9m1GlaGBQwu6sTDacTVVQcip3D4d6abtlMiYroGBfdhqa4lLEFy3bAOuLj4wL
 ZQjLW+doZSxTD7EAgA6rrgfLqgOT74UyY8gQQmq3xvMdPFy/oEsKHHiW5IvCUPHr0svm
 EIQA==
X-Gm-Message-State: AGi0PubpCSrytPPHOh7PBgC1nrAHBGsmxG5P7UUc9dwaqsjaO1jNGlWp
 kqlvkV3k11dgSv6rmgwzT1ZkRA==
X-Google-Smtp-Source: APiQypKpwtllReFLyE2xu1cCo0pm7Ljw/fcrwwCvtindDxqER/rQzn6+x2HPLd5dFwKyTkquVr7vCQ==
X-Received: by 2002:a63:d904:: with SMTP id r4mr24446955pgg.323.1586909101065; 
 Tue, 14 Apr 2020 17:05:01 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id 128sm1061161pfx.187.2020.04.14.17.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 17:05:00 -0700 (PDT)
Date: Tue, 14 Apr 2020 17:04:59 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 5/7] dma-pool: add pool sizes to debugfs
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141704050.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: x86@kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The atomic DMA pools can dynamically expand based on non-blocking
allocations that need to use it.

Export the sizes of each of these pools, in bytes, through debugfs for
measurement.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index cf052314d9e4..3e22022c933b 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2020 Google LLC
  */
+#include <linux/debugfs.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/dma-contiguous.h>
@@ -15,6 +16,11 @@
 static struct gen_pool *atomic_pool_dma __ro_after_init;
 static struct gen_pool *atomic_pool_dma32 __ro_after_init;
 static struct gen_pool *atomic_pool_kernel __ro_after_init;
+#ifdef CONFIG_DEBUG_FS
+static unsigned long pool_size_dma;
+static unsigned long pool_size_dma32;
+static unsigned long pool_size_kernel;
+#endif
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
 static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
@@ -29,6 +35,38 @@ static int __init early_coherent_pool(char *p)
 }
 early_param("coherent_pool", early_coherent_pool);
 
+#ifdef CONFIG_DEBUG_FS
+static void __init dma_atomic_pool_debugfs_init(void)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("dma_pools", NULL);
+	if (IS_ERR_OR_NULL(root))
+		return;
+
+	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
+	debugfs_create_ulong("pool_size_dma32", 0400, root, &pool_size_dma32);
+	debugfs_create_ulong("pool_size_kernel", 0400, root, &pool_size_kernel);
+}
+
+static void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
+{
+	if (gfp & __GFP_DMA)
+		pool_size_dma += size;
+	else if (gfp & __GFP_DMA32)
+		pool_size_dma32 += size;
+	else
+		pool_size_kernel += size;
+}
+#else
+static inline void dma_atomic_pool_debugfs_init(void)
+{
+}
+static inline void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 			      gfp_t gfp)
 {
@@ -76,6 +114,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	if (ret)
 		goto encrypt_mapping;
 
+	dma_atomic_pool_size_add(gfp, pool_size);
 	return 0;
 
 encrypt_mapping:
@@ -160,6 +199,8 @@ static int __init dma_atomic_pool_init(void)
 		if (!atomic_pool_dma32)
 			ret = -ENOMEM;
 	}
+
+	dma_atomic_pool_debugfs_init();
 	return ret;
 }
 postcore_initcall(dma_atomic_pool_init);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
