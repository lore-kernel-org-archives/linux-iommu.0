Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA6C3F2CD
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1452246B4
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RA+paHxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1452246B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ABE478757C;
	Mon,  2 Mar 2020 00:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vpApl07f4wUX; Mon,  2 Mar 2020 00:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 39C9E8757D;
	Mon,  2 Mar 2020 00:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26604C1D74;
	Mon,  2 Mar 2020 00:05:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E4CFC013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1AB5385045
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wl+7RMOQEnzL for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 00:05:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E5DAC8506C
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:24 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id y30so4480937pga.13
 for <iommu@lists.linux-foundation.org>; Sun, 01 Mar 2020 16:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=n2z26x3A40N8extJFoFR/1kjizwIJ2psa4vNOP6D4IU=;
 b=RA+paHxh3lsDtcCFaWrHYBqPiCWIW0WA5M85Temkt10PhSH7s8uSgbzK2jSCkY0/Ey
 65+HTUWwpzLIbNV5d8f9mANOlLt8GBZHN4f0PK1lB57I7rrlZB4osmoQVzS/RAWolHcF
 aoPWKzGp/2tJPRbhNf5i1nIcaWo8w184BOcH1BFWBwxmp4Ngf9yLyVWc7eNcBhRmFsx8
 fbpx4uab0LQ8K2X6DRTpHF8YQyKCB77cKqAfc7yyzMArYe8twJNOFXTKJTunU8Uhrmot
 Dk0zitSoME6hyWL4qH+fI3kexaY2qur98n6s5vS80dmxOPpwnF005AQyRlzI/R5hRS1w
 eEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=n2z26x3A40N8extJFoFR/1kjizwIJ2psa4vNOP6D4IU=;
 b=Hj5D9YU/kkBn5FGICHL96D5/3Rux9M9i3zc/mHgibH97gMkgmKz7tRlG+P/Knn0fNc
 GRgiRfabBM1n+imrhgh73I0Jdd6JrOOzn49W2sGSuur77wL7Xq7XyimoUxfcYeplVacI
 CD7LirKXsXIAPsj+OIqJaaLttmO+i9P1vmCNgEMLgUviBjKP/aLj+NwYJMi4Ak0vcXbS
 LxJzUhSlrfShLnXZlnk+W8p7IMlIt4OggfnKXjejtN4EQh25rTzVoGjpE3vNEiB4Mdtq
 8KllflU4HhOXZh9eGDOEd1OJU6HkJoVs9Z6PSXGeHA4JZB8CVbgHjkMiH3/rOiNc9UiF
 DPPQ==
X-Gm-Message-State: APjAAAX6jNl+HLCmiVODPyTeQwwvdQ5lR3SlvTBR/pBsE4OXydQwhP1+
 m0PV3RBj56kRFvcNrHcKi4jkvA==
X-Google-Smtp-Source: APXvYqxzPvDKCutVwEF1pxEZuHkuvxtWhOYoY/LdE4IDi6GaBassCc+r6MwCxVVrfuMAN2HVaGRc3w==
X-Received: by 2002:a63:fc56:: with SMTP id r22mr16298681pgk.147.1583107524304; 
 Sun, 01 Mar 2020 16:05:24 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id q13sm18195897pgh.30.2020.03.01.16.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 16:05:23 -0800 (PST)
Date: Sun, 1 Mar 2020 16:05:23 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc 5/6] dma-direct: atomic allocations must come from unencrypted
 pools
In-Reply-To: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003011538040.213582@chino.kir.corp.google.com>
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

When AMD memory encryption is enabled, all non-blocking DMA allocations
must originate from the atomic pools depending on the device and the gfp
mask of the allocation.

Keep all memory in these pools unencrypted.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/Kconfig    | 1 +
 kernel/dma/direct.c | 9 ++++-----
 kernel/dma/remap.c  | 2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1523,6 +1523,7 @@ config X86_CPA_STATISTICS
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	select DMA_DIRECT_REMAP
 	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -125,7 +125,6 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_alloc_need_uncached(dev, attrs) &&
 	    !gfpflags_allow_blocking(gfp)) {
 		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
 		if (!ret)
@@ -202,6 +201,10 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 {
 	unsigned int page_order = get_order(size);
 
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
+		return;
+
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
@@ -209,10 +212,6 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
-	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
-		return;
-
 	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -8,6 +8,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/init.h>
 #include <linux/genalloc.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
@@ -141,6 +142,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	if (!addr)
 		goto free_page;
 
+	set_memory_decrypted((unsigned long)page_to_virt(page), nr_pages);
 	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
 				pool_size, NUMA_NO_NODE);
 	if (ret)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
