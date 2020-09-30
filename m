Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CCCC4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:09:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4125A20789
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U3M0mwN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4125A20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C0408721B;
	Wed, 30 Sep 2020 16:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqeZWbAB0x8p; Wed, 30 Sep 2020 16:09:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A349287220;
	Wed, 30 Sep 2020 16:09:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82DAEC1AD7;
	Wed, 30 Sep 2020 16:09:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98E21C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 889438553C
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:09:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1GudNC4EZCgJ for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:09:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 38B5885567
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ss1B5LS02Dl8LXyPvF2nQEHb1zf2SKhaR9X/Ikso6f4=; b=U3M0mwN0TpO/LPCKIbzUN6bVR3
 sbfhV1rPcgeix+8XaxfVRCcQskhVhU7vvvKQ7ecovz8eNTM0uT3zhlxPMm5uT9VR+0rO6xnsMVzap
 nByo9G9jhaMzKIf8fmMD1FQxS75w0+1uAS7PVzz3PVEyXv17geuHe1R8lRORK07fWWHQdlFCSzD5X
 rKP9QzSli/u5mKEeRgUXa3i1goK5SJBCfFIVU+uTkVNHrY2hZycKCYo2q+2wNWyAk/uDcJk6X2DK3
 gENyet37MSyh/MLgo6meq2uwbImm42OXGensQcnMr6w0GaqKzyqeqPZms5J/I2eDM/GpYbvpwKpUy
 ye+htRWg==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNefT-0003Cx-Mk; Wed, 30 Sep 2020 16:09:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 2/8] dma-mapping: document dma_{alloc,free}_pages
Date: Wed, 30 Sep 2020 18:09:11 +0200
Message-Id: <20200930160917.1234225-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930160917.1234225-1-hch@lst.de>
References: <20200930160917.1234225-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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
 Documentation/core-api/dma-api.rst | 45 ++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index ea0413276ddb70..a75c469dbcaa7c 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -534,11 +534,9 @@ an I/O device, you should not be using this part of the API.
 			dma_addr_t *dma_handle, enum dma_data_direction dir,
 			gfp_t gfp)
 
-This routine allocates a region of <size> bytes of consistent memory.  It
+This routine allocates a region of <size> bytes of non-coherent memory.  It
 returns a pointer to the allocated region (in the processor's virtual address
-space) or NULL if the allocation failed.  The returned memory may or may not
-be in the kernels direct mapping.  Drivers must not call virt_to_page on
-the returned memory region.
+space) or NULL if the allocation failed.
 
 It also returns a <dma_handle> which may be cast to an unsigned integer the
 same width as the bus and given to the device as the DMA address base of
@@ -565,7 +563,44 @@ reused.
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
+allocation failed.
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
