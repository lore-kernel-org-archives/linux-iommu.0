Return-Path: <SRS0=9AUr=X3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6EC4360C
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 20:47:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAB02070B
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 20:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/zOukb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAB02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F26601657;
	Wed,  2 Oct 2019 20:47:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B45BA1651
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 20:46:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C10C43D0
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 20:46:57 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id q7so254238pgi.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 02 Oct 2019 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=date:from:to:cc:subject:message-id:mime-version:content-disposition; 
	bh=NXZoaM8JnR0+26PVfw4tVHTn5SdQ45I7gpO85lvpiP0=;
	b=d/zOukb8JkdaGMJDkXWNp2Q+WzlGXbZZGxLJkrMZ8FFJBwkDoe1BlOgLfvcWlg7OIV
	FswyVy2UdZ9QywcGA3Shg+vQFos67XMyw9AqTmCvhSNVv+Z7IwtD7IvbVEWeiDoS8aFM
	McCilSu2GEofjob8stzUmA8e/JlxTLTzVMtbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition;
	bh=NXZoaM8JnR0+26PVfw4tVHTn5SdQ45I7gpO85lvpiP0=;
	b=aRnWwM1QQKERbZhFNBww6Z6d3XO5VKqmuP7778o+pgcaZUnltOjuOh6SWCXZC3/iA7
	fEXajkfJir+b5GJHyta99oqQDvcIXPmRt77D2R3LSIp8iK5NFdgbkDDbnqUYUdLzbJKV
	6cxOtYE442A98kFL+ayJVlbbM/9LBQYcsbkEAkAVWjid1o9ie07ys9FVCX9EwwjKFaQM
	FNcIOn5uxta0Wl86tviGo8/bZMs30ENQ9NXLiLhXC2hch35+/0UfvPe3pTRfV410SGXO
	mjbxQLswW9f3Qfu/flk8DsiUBku8jtG0pApNhJjVeCHjo15pkmLVQAYKdDO8ityQglnG
	XZNQ==
X-Gm-Message-State: APjAAAV0HifZaH6T7xPpd5UEgR7JGWOw8rRlIQT4N36OWY/yQGuigS84
	JDPH80sQCJ3w/gfkt3OJpWydxg==
X-Google-Smtp-Source: APXvYqz4cuEetDgLVL9xZEkahkfeg3mPz43ZiRkqQe1eIgZwxKs63wCyjcBd+aYAmiRIbW1RZftzuw==
X-Received: by 2002:a63:4142:: with SMTP id o63mr6002272pga.426.1570049217206; 
	Wed, 02 Oct 2019 13:46:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
	by smtp.gmail.com with ESMTPSA id
	z13sm359178pfq.121.2019.10.02.13.46.56
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 02 Oct 2019 13:46:56 -0700 (PDT)
Date: Wed, 2 Oct 2019 13:46:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] dma-mapping: Lift address space checks out of debug code
Message-ID: <201910021341.7819A660@keescook>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Semmle Security Reports <security-reports@semmle.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Allison Randal <allison@lohutok.net>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

As we've seen from USB and other areas, we need to always do runtime
checks for DMA operating on memory regions that might be remapped. This
consolidates the (existing!) checks and makes them on by default. A
warning will be triggered for any drivers still using DMA on the stack
(as has been seen in a few recent reports).

Suggested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/dma-debug.h   |  8 --------
 include/linux/dma-mapping.h |  8 +++++++-
 kernel/dma/debug.c          | 16 ----------------
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index 4208f94d93f7..2af9765d9af7 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -18,9 +18,6 @@ struct bus_type;
 
 extern void dma_debug_add_bus(struct bus_type *bus);
 
-extern void debug_dma_map_single(struct device *dev, const void *addr,
-				 unsigned long len);
-
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
 			       int direction, dma_addr_t dma_addr);
@@ -75,11 +72,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
 {
 }
 
-static inline void debug_dma_map_single(struct device *dev, const void *addr,
-					unsigned long len)
-{
-}
-
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      int direction, dma_addr_t dma_addr)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fca475a..2d6b8382eab1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -583,7 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	debug_dma_map_single(dev, ptr, size);
+	/* DMA must never operate on stack or other remappable places. */
+	WARN_ONCE(is_vmalloc_addr(ptr) || !virt_addr_valid(ptr),
+		"%s %s: driver maps %lu bytes from %s area\n",
+		dev ? dev_driver_string(dev) : "unknown driver",
+		dev ? dev_name(dev) : "unknown device", size,
+		is_vmalloc_addr(ptr) ? "vmalloc" : "invalid");
+
 	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
 			size, dir, attrs);
 }
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 099002d84f46..aa1e6a1990b2 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1232,22 +1232,6 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 #endif
 }
 
-void debug_dma_map_single(struct device *dev, const void *addr,
-			    unsigned long len)
-{
-	if (unlikely(dma_debug_disabled()))
-		return;
-
-	if (!virt_addr_valid(addr))
-		err_printk(dev, NULL, "device driver maps memory from invalid area [addr=%p] [len=%lu]\n",
-			   addr, len);
-
-	if (is_vmalloc_addr(addr))
-		err_printk(dev, NULL, "device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
-			   addr, len);
-}
-EXPORT_SYMBOL(debug_dma_map_single);
-
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 			size_t size, int direction, dma_addr_t dma_addr)
 {
-- 
2.17.1


-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
