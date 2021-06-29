Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF5CC11F66
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC7261DC4
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC7261DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACBFD607C6;
	Tue, 29 Jun 2021 08:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bt9vWop9M8d6; Tue, 29 Jun 2021 08:11:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9976360784;
	Tue, 29 Jun 2021 08:11:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E9FAC0010;
	Tue, 29 Jun 2021 08:11:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F469C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 08:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A38A6078B
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 08:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id beseoUIOA_ge for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 08:11:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6360460784
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 08:11:32 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id u19so4766751plc.3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DZ7Eych3eQIlfh+/2Dgt3JxjlYh8mhidB3EhZ1LJg5c=;
 b=iFPEbA8zgUYfgyJoITZ74CL2TVC6IEoPhXSOY36VdqsimRVnR28PiSeFaghcurm+vA
 c6D7TG3UumCGZURl8jL1rLNGqN3+zI0JtDcOTiLbOR7pPIfN8jtNV0GPjeiKoKP0+mN+
 pVFfIVa8qShaj51VryS1rVOhwdgOOchqhuNpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DZ7Eych3eQIlfh+/2Dgt3JxjlYh8mhidB3EhZ1LJg5c=;
 b=ecsyhhOaDN7eA72e2ILJIWxvnnZdboDbkzbZyucG3IRMNSAVdk2vtazEwYDGS1qtac
 VThkM3Zbu8RofLuTjSu8OOoK+4T8jTEIl9xYxhM461ifosZGPrcuQYxNLurXzyvPyAVw
 NFGbxXBwMPyfy2WUaZnUCBTgZQcsKP9wMfzSxd5t/lEUSmAOd4D/UW85o47LtSUD5mp2
 XQMKG9yyEH8icOgrNDclKRGUVhsO9vHy/cqGXP4o/daSbPEYkJPj8IKtDHrH7Zo8xvO4
 DuI4B2b6mchTsf+VsB1JFSpnygF6BDsOT0SarNxCQYkApYdaoLaNJvC1PTY9ne9c6Wfb
 js3w==
X-Gm-Message-State: AOAM533KHWBYz4ND2eqw6h7jmcTxrWFxkHMSahpfZZoXCQOatfIf62MU
 tQAnLv2BgDq8D3YSnQxpPOQNZw==
X-Google-Smtp-Source: ABdhPJw1FVWlWOx5X6EYkjASANlLpC8tRNRt7cR/woChlKwIfBoBkiDo1jmCzD+pRBe1ktNKZS0LAA==
X-Received: by 2002:a17:902:ea12:b029:128:977b:fa78 with SMTP id
 s18-20020a170902ea12b0290128977bfa78mr20661461plg.15.1624954291887; 
 Tue, 29 Jun 2021 01:11:31 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:3adb:8783:d6da:e6ca])
 by smtp.gmail.com with UTF8SMTPSA id m21sm1992037pjz.57.2021.06.29.01.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 01:11:31 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
Subject: [PATCH] swiotlb: fix implicit debugfs_create_dir declaration
Date: Tue, 29 Jun 2021 16:11:24 +0800
Message-Id: <20210629081124.3585539-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Cc: Claire Chang <tientzu@chromium.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
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

Use __maybe_unused instead of ifdef to fix implicit function declaration
for other pools.

Fixes: 1d9f94400a7a ("swiotlb: Refactor swiotlb_create_debugfs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0ffbaae9fba2..508b678f6448 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,9 +36,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
-#ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
-#endif
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 #include <linux/io.h>
 #include <linux/of.h>
@@ -686,10 +684,9 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
-#ifdef CONFIG_DEBUG_FS
-static struct dentry *debugfs_dir;
+__maybe_unused static struct dentry *debugfs_dir;
 
-static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
+__maybe_unused static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
 {
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
@@ -709,8 +706,6 @@ static int __init swiotlb_create_default_debugfs(void)
 
 late_initcall(swiotlb_create_default_debugfs);
 
-#endif
-
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 struct page *swiotlb_alloc(struct device *dev, size_t size)
 {
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
