Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B62AC3F2D4
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED753246B4
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aMm4+bks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED753246B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A8D5B2035B;
	Mon,  2 Mar 2020 00:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c+YPFrp5AxkC; Mon,  2 Mar 2020 00:05:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4E58120029;
	Mon,  2 Mar 2020 00:05:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38D44C1D74;
	Mon,  2 Mar 2020 00:05:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC40BC013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A962687582
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rcYoO3LeHNaz for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 00:05:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E532D8757D
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:08 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id z12so4506112pgl.4
 for <iommu@lists.linux-foundation.org>; Sun, 01 Mar 2020 16:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=HL4U/mhSqP+I8ieHIpJ1bevhb68hH4LDsXHxJRde9Ok=;
 b=aMm4+bksmSzN4Xi5NWUAAvfgFK8Xo4CKpy8hgZHVs9TJURoyfuiSqmauJJ8fYwvbMT
 NWx7zsQaz+fCtPpDoL0cp9HBqs2svj44p7RQPXVR6OBHdPYpDCFV58282l9/GeDD8pUK
 ovv+BYmkRjI4e7MhXgy4nHO3wY/AbsYChLWqOOZtL1IyyW2X2sJFbVxAqcItxAV3YsSG
 otB2iLZ0GiRiZNAJOX3tDbGluV9P966Ee5+aDXVxcp98a2LEkwmXfo2DhEki0cUVZDAt
 2oyfPxjqoYKDqNXMzHFdLFvyP/Lsv0IUs8kfwlC2prTPTyD3RFBG/71eLoGjjGMxFI+9
 MnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=HL4U/mhSqP+I8ieHIpJ1bevhb68hH4LDsXHxJRde9Ok=;
 b=to75KBv0cQnhEY8K2FIH3RE0qyxnTI0yOhK1r7NYx5isa4UvJjOpIWCznaXKcrtv0w
 Fh4aZbGX1Ku0EDGqqKdEDRX3o11jVt/XMECKWQWMwzTR5gKL7a/fr+Olr19UEJR6ifqA
 NiArdQ32jK9jnA7VjugF+8yJsq3gK5cn5qYfXpJonNTIbZdOEJaCOSR/qFtuz60GNtGd
 F+C6wPhMkK5YKPeMbSURBgdPgCVL+mKOTubMbADOru5DETNSJKNiswu/VQJyMx4LBo9v
 z0OPeKd1RCLn/zM/zbGHCuM81nJoudKpaNcNz/uh6fsvj65wa8dhxNAMMDPdrVdpmagn
 yd9A==
X-Gm-Message-State: ANhLgQ2FI7iABNeaD0aFVAY5OKrfgIo9bZTL2ZouWsCDZUOlkbvanGFm
 olN+N7Z59tRdMcJ6dnt/iojtsg==
X-Google-Smtp-Source: ADFU+vsEOC/HzMkuaeWddnFs9Umo1QdxDB48tqkJBHcoBlw19DJR6MFjGfO2P7dsKuTLNAkSkIPkyQ==
X-Received: by 2002:aa7:8426:: with SMTP id q6mr8892478pfn.221.1583107508211; 
 Sun, 01 Mar 2020 16:05:08 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id 5sm5851383pfw.179.2020.03.01.16.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 16:05:07 -0800 (PST)
Date: Sun, 1 Mar 2020 16:05:06 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc 1/6] dma-mapping: pass device to atomic allocation functions
In-Reply-To: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003011536330.213582@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 baekhw@google.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

This augments the dma_{alloc,free}_from_pool() functions with a pointer
to the struct device of the allocation.   This introduces no functional
change and will be used later to determine the optimal gfp mask to
allocate memory from.

dma_in_atomic_pool() is not used outside kernel/dma/remap.c, so remove
its declaration from the header file.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/iommu/dma-iommu.c   | 5 +++--
 include/linux/dma-mapping.h | 6 +++---
 kernel/dma/direct.c         | 4 ++--
 kernel/dma/remap.c          | 9 +++++----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -952,7 +952,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 
 	/* Non-coherent atomic allocation? Easy */
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_free_from_pool(cpu_addr, alloc_size))
+	    dma_free_from_pool(dev, cpu_addr, alloc_size))
 		return;
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
@@ -1035,7 +1035,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
-		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+		cpu_addr = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page,
+					       gfp);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
 	if (!cpu_addr)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -630,9 +630,9 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 			pgprot_t prot, const void *caller);
 void dma_common_free_remap(void *cpu_addr, size_t size);
 
-bool dma_in_atomic_pool(void *start, size_t size);
-void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags);
-bool dma_free_from_pool(void *start, size_t size);
+void *dma_alloc_from_pool(struct device *dev, size_t size,
+			  struct page **ret_page, gfp_t flags);
+bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -127,7 +127,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    dma_alloc_need_uncached(dev, attrs) &&
 	    !gfpflags_allow_blocking(gfp)) {
-		ret = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
 		if (!ret)
 			return NULL;
 		goto done;
@@ -210,7 +210,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_free_from_pool(cpu_addr, PAGE_ALIGN(size)))
+	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
 		return;
 
 	if (force_dma_unencrypted(dev))
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -173,7 +173,7 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-bool dma_in_atomic_pool(void *start, size_t size)
+static bool dma_in_atomic_pool(struct device *dev, void *start, size_t size)
 {
 	if (unlikely(!atomic_pool))
 		return false;
@@ -181,7 +181,8 @@ bool dma_in_atomic_pool(void *start, size_t size)
 	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
 }
 
-void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
+void *dma_alloc_from_pool(struct device *dev, size_t size,
+			  struct page **ret_page, gfp_t flags)
 {
 	unsigned long val;
 	void *ptr = NULL;
@@ -203,9 +204,9 @@ void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
 	return ptr;
 }
 
-bool dma_free_from_pool(void *start, size_t size)
+bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	if (!dma_in_atomic_pool(start, size))
+	if (!dma_in_atomic_pool(dev, start, size))
 		return false;
 	gen_pool_free(atomic_pool, (unsigned long)start, size);
 	return true;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
