Return-Path: <SRS0=xWGd=D6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8BBC388F9
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 06:45:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D242223F
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 06:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cD61j21U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D242223F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CD4EA86B10;
	Fri, 23 Oct 2020 06:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tVUKWax-zUBv; Fri, 23 Oct 2020 06:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9896886667;
	Fri, 23 Oct 2020 06:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CFCBC0052;
	Fri, 23 Oct 2020 06:45:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3201C0051
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 06:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9A3758772D
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 06:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FZPzcYSXxyqz for <iommu@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 06:45:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DCD1D8771E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 06:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=wPNl+zJq6Mnbyhzs/DqNqJV59Zk8jmrZ6DP1nbymsJY=; b=cD61j21UiSADC42yEFubhfEyp0
 XsFBCD3HFhOWthqd6nrEkpOa+BAh7k1dSOlXDrMSodZ+fRh1JyDXJPqHa6CW6QvQq7CBP9IeU0bm8
 Lz8+ofZEgHYBWR7/VnspqUM51/OYzfePlXASVgObUeyr4R1SzzbkcWCdN9PVjdJwLrzWtzudLzrMT
 Ja19mQ/1UZQ/od+ZADKMDoR4nIlJ51bDYgzK852zqCvzLn2IOPVsRfzWmHgMm8SJfR7Hr7qls4w3A
 qG7KB/9npSxhj5N67XqLF3Fby8H7V8coplzGEXLOx7ZUh/oHfMritepJAYVfSM9h9pwrhARLjo2Ns
 C/QqoHrw==;
Received: from [2001:4bb8:18c:20bd:88ad:7c9d:e85e:89ca] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVqpH-0005w5-5f; Fri, 23 Oct 2020 06:45:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: robin.murphy@arm.com
Subject: [PATCH] dma-mapping: document dma_{alloc,free}_pages
Date: Fri, 23 Oct 2020 08:45:20 +0200
Message-Id: <20201023064520.3473905-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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

Document the new dma_alloc_pages and dma_free_pages APIs, and fix
up the documentation for dma_alloc_noncoherent and dma_free_noncoherent.

Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/core-api/dma-api.rst | 49 ++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index ea0413276ddb70..209d7978cdaa1b 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -519,10 +519,9 @@ routines, e.g.:::
 Part II - Non-coherent DMA allocations
 --------------------------------------
 
-These APIs allow to allocate pages in the kernel direct mapping that are
-guaranteed to be DMA addressable.  This means that unlike dma_alloc_coherent,
-virt_to_page can be called on the resulting address, and the resulting
-struct page can be used for everything a struct page is suitable for.
+These APIs allow to allocate pages that are guranteed to be DMA addressable
+by the passed in device, but which need explicit management of memory
+ownership for the kernel vs the device.
 
 If you don't understand how cache line coherency works between a processor and
 an I/O device, you should not be using this part of the API.
@@ -537,7 +536,7 @@ an I/O device, you should not be using this part of the API.
 This routine allocates a region of <size> bytes of consistent memory.  It
 returns a pointer to the allocated region (in the processor's virtual address
 space) or NULL if the allocation failed.  The returned memory may or may not
-be in the kernels direct mapping.  Drivers must not call virt_to_page on
+be in the kernel direct mapping.  Drivers must not call virt_to_page on
 the returned memory region.
 
 It also returns a <dma_handle> which may be cast to an unsigned integer the
@@ -565,7 +564,45 @@ reused.
 Free a region of memory previously allocated using dma_alloc_noncoherent().
 dev, size and dma_handle and dir must all be the same as those passed into
 dma_alloc_noncoherent().  cpu_addr must be the virtual address returned by
-the dma_alloc_noncoherent().
+dma_alloc_noncoherent().
+
+::
+
+	struct page *
+	dma_alloc_pages(struct device *dev, size_t size, dma_addr_t *dma_handle,
+			enum dma_data_direction dir, gfp_t gfp)
+
+This routine allocates a region of <size> bytes of non-coherent memory.  It
+returns a pointer to first struct page for the region, or NULL if the
+allocation failed. The resulting struct page can be used for everything a
+struct page is suitable for.
+
+It also returns a <dma_handle> which may be cast to an unsigned integer the
+same width as the bus and given to the device as the DMA address base of
+the region.
+
+The dir parameter specified if data is read and/or written by the device,
+see dma_map_single() for details.
+
+The gfp parameter allows the caller to specify the ``GFP_`` flags (see
+kmalloc()) for the allocation, but rejects flags used to specify a memory
+zone such as GFP_DMA or GFP_HIGHMEM.
+
+Before giving the memory to the device, dma_sync_single_for_device() needs
+to be called, and before reading memory written by the device,
+dma_sync_single_for_cpu(), just like for streaming DMA mappings that are
+reused.
+
+::
+
+	void
+	dma_free_pages(struct device *dev, size_t size, struct page *page,
+			dma_addr_t dma_handle, enum dma_data_direction dir)
+
+Free a region of memory previously allocated using dma_alloc_pages().
+dev, size and dma_handle and dir must all be the same as those passed into
+dma_alloc_noncoherent().  page must be the pointer returned by
+dma_alloc_pages().
 
 ::
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
