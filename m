Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3700EC11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 04:06:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFEC61D28
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 04:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFEC61D28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A222A83AB0;
	Wed, 30 Jun 2021 04:06:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lfHYZTEe2YFw; Wed, 30 Jun 2021 04:06:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9A4DD83AAE;
	Wed, 30 Jun 2021 04:06:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 771F9C001A;
	Wed, 30 Jun 2021 04:06:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0080CC000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 04:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAE75605E8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 04:06:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RGiOVAgV3I7I for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 04:06:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53E5D60594
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 04:06:23 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id g21so1187187pfc.11
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vBJD4JFUNrU/4Zr4GHTZ0cbKWbsN7ynXpqMyWSZuNks=;
 b=dwNl699PBL5B58FmaDpVfL75n8ZRKUXs2RNoJqAhVYMvToRUCqOPdJslYwxpyi8x/o
 PUG7M7nd3CueZnEyY1roDTdHocmQob3cdTJTB/XJooAVzdHxjFqMsFFnq7MmpDNQxBsC
 59fIJvd6H6q/qwTjGKOk57dw/7R583m8iL3Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vBJD4JFUNrU/4Zr4GHTZ0cbKWbsN7ynXpqMyWSZuNks=;
 b=GmWbx+uxKu3fVoWhmLi5t8VwpIHpBsIjbF+9tF3IIzuoxZ7xNueIRpQ4QA7jaCZ4OQ
 EK3mVthjRCiTYAasVKMJ8zpVwwKBT4u8EmTEcuKdd3WbbwmUG+BzlrMOukh+gPC/mDD3
 IMAHKTTNjZekXAvpwkVE096OUy0BELqv8JxGAIktAchktkTI4hXXIFy46IeKlphbynRg
 X+hRtyf3CZsOEtn5Efss2du/7GairglOSPg/Rgea56u8A5djlmbAznKioxmq9WEud8Sp
 OAzR7LlV5Z9igMKeEGq9AAkT6mtvWTQJTxDI+9FeOK49ig+rK4b6o0EWpdtFjqqrQXpK
 ztkg==
X-Gm-Message-State: AOAM530L0/b8BQu3eAjJu2UBfM2WaGux8qVDQXKY4ueA3jwOM2TyZm3k
 7CXSMh4ENFy7e0KB9q31uXJK1Q==
X-Google-Smtp-Source: ABdhPJyDNSfiMLEx1IjDrOQBQe0ELtIJOclgwIvSOu8aXf3zCZlrspUVX6l2BzINSKHYgZOnxNzdQg==
X-Received: by 2002:a63:f609:: with SMTP id m9mr9895587pgh.74.1625025982775;
 Tue, 29 Jun 2021 21:06:22 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:94c8:1447:c37c:e392])
 by smtp.gmail.com with UTF8SMTPSA id b25sm19665184pft.76.2021.06.29.21.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 21:06:22 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, Will Deacon <will@kernel.org>, sstabellini@kernel.org
Subject: [PATCH v3] swiotlb: fix implicit debugfs_create_dir declaration
Date: Wed, 30 Jun 2021 12:06:15 +0800
Message-Id: <20210630040616.3914990-1-tientzu@chromium.org>
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

Factor out the debugfs bits from rmem_swiotlb_device_init() into a separate
rmem_swiotlb_debugfs_init().

Fixes: 461021875c50 ("swiotlb: Add restricted DMA pool initialization")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0ffbaae9fba2..355dc98d381c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -709,6 +709,16 @@ static int __init swiotlb_create_default_debugfs(void)
 
 late_initcall(swiotlb_create_default_debugfs);
 
+static void rmem_swiotlb_debugfs_init(const char *name, struct io_tlb_mem *mem)
+{
+	mem->debugfs = debugfs_create_dir(name, debugfs_dir);
+	swiotlb_create_debugfs_files(mem);
+}
+#else
+__maybe_unused static void rmem_swiotlb_debugfs_init(const char *name,
+						     struct io_tlb_mem *mem)
+{
+}
 #endif
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
@@ -766,11 +776,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 		rmem->priv = mem;
 
-		if (IS_ENABLED(CONFIG_DEBUG_FS)) {
-			mem->debugfs =
-				debugfs_create_dir(rmem->name, debugfs_dir);
-			swiotlb_create_debugfs_files(mem);
-		}
+		if (IS_ENABLED(CONFIG_DEBUG_FS))
+			rmem_swiotlb_debugfs_init(rmem->name, mem);
 	}
 
 	dev->dma_io_tlb_mem = mem;
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
