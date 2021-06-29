Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4C2C11F68
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 12:16:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9CA61D8B
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 12:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9CA61D8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFFCC40410;
	Tue, 29 Jun 2021 12:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D92uivTO3NXW; Tue, 29 Jun 2021 12:16:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C52C4040D;
	Tue, 29 Jun 2021 12:16:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50961C0010;
	Tue, 29 Jun 2021 12:16:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38922C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 12:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1720760784
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 12:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWAQXnSk5LfG for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 12:16:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCCDF6077E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 12:16:32 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id f11so586787plg.0
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JTFvXmTEK7ZNerH/JtM4n3rDUhmzB5t0n3YIuLeO91E=;
 b=P/Cem1OLebedCiFEzX+z+nyRcO8XCyCPwO2cT6NQpGSax1j38jYuB8ZxuzUMG550QJ
 N6AXqDrucmMBL3XOHkMnUUI8oG2yZmO2NzfzH3OQw+xxF2UUZp6CDJa2vRxgtl0nSOgg
 A81exZpPokUUyZawnZohBg9MTXxaHuGNY+rx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JTFvXmTEK7ZNerH/JtM4n3rDUhmzB5t0n3YIuLeO91E=;
 b=TH+6i95bqcV8gUN9R0kFpsUtyPEbcUnJM16QMfudu3/VDN1Rt498lG3xbhrBOo31Hi
 yGlvg/ZHTdQcpCKf+ndV7yRYWyXpCYJKQxZB2apCRulOzKGTRrFOcseHywAz2g01NCsX
 YwtXKv3WgR0vvLkVwBtBRtVPIkpxG+gyM3JwFLHN+Z3Prx1TpGspu2R+DgLohocyrJZv
 QXEiE2RaP+vab6io6zZ12io3s5MmPfD3c5VGZXlitQInWFl9JypVNKVxpfnqqLq710zQ
 NPrXXWaToGGgwXH02KeGQFQ0nLn03h5FA+5OzwldWporhrBf8Gn0/KYxLHu2IwzIJU0G
 hEUQ==
X-Gm-Message-State: AOAM533WehNhdaTu8CvSvjQ17EH4YTHnscMmgsBLXV4/U40DP409zitv
 ZONOZJYgG7zDZ4XI/PgL6G3W0g==
X-Google-Smtp-Source: ABdhPJzbJDsgus4m2r74nhMTRhIy44L6PLzl+efQb5XZsUNrh6rba/6GUjo5ZaMgftY7iMWaxmMhLQ==
X-Received: by 2002:a17:90b:605:: with SMTP id
 gb5mr13165548pjb.62.1624968992397; 
 Tue, 29 Jun 2021 05:16:32 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:3adb:8783:d6da:e6ca])
 by smtp.gmail.com with UTF8SMTPSA id x20sm7319646pge.41.2021.06.29.05.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 05:16:31 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, Will Deacon <will@kernel.org>, sstabellini@kernel.org
Subject: [PATCH v2] swiotlb: fix implicit debugfs_create_dir declaration
Date: Tue, 29 Jun 2021 20:16:25 +0800
Message-Id: <20210629121625.3633999-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Cc: Nicolas Boichat <drinkcat@chromium.org>, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Claire Chang <tientzu@chromium.org>
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

Remove the ifdef to fix implicit function declaration for other pools.

Fixes: 1d9f94400a7a ("swiotlb: Refactor swiotlb_create_debugfs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0ffbaae9fba2..8ae0bef392c3 100644
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
@@ -686,7 +684,6 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
-#ifdef CONFIG_DEBUG_FS
 static struct dentry *debugfs_dir;
 
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
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
