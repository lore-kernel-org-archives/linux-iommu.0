Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF96299929
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019028; cv=none; b=DfN0XQJL3N3OmMyckCOO2ppEz76Ygf5GWdFuC+R/RiiS62Mj4lsmLIX19YLlh6e71amAFTChctxmyk8MCd98Lh2TtweG2C8M+xyjneQVf1rxrMFMxpoHBADBb9YoufI0qNAQp8dTDbuvuTX1Q7X6Ia6BwXj7F5k5zZhrAnYVlxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019028; c=relaxed/simple;
	bh=hHwtqUaEFph1e9dx7UvXr1mnmNdG4H8BsBjki4vvZPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdU2aWh/9qzsL893GT7KHWJ36RJVQ7BwTkVAL7SQ2VIaUB71IZSmgmDvnYbadzn1CX6mmtHRv89TipxtuuzoCpj4y6au1KV+shKZRhWKmRZ5VwLHXL4i6m8I+klcl1/ZM7gS9zsbv+W1KvXjE4SgzeY9F5Tb9lC/zojK3WojnNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WOMm+Yuo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WOMm+Yuo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso2759375e9.0
        for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751019024; x=1751623824; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpQ7AkRvShs03kmO7VCXGfaSepdwFFSh/faqrQd+6cQ=;
        b=WOMm+YuoZLkByF5p1YLVNz6ZuLuFbond/2vOwFIQdhA+9VmH3CVFdYTP64C8hYvzFm
         Yzu60b1kUNniRHNnHqpYOxFBdmKfJHzEx7hqoYCd2j22BaJ2GwL6BTC7QJrXg+Yyi5RE
         KBfTYaR4lwPRMfPrljB4unwOovdCSk8pZFVxg85e1ZySNwfHFD09+HuYioYaRSIGX9c6
         aCYRW51iKJOrR3xWFsBG1MFSwQ5woCTukr7VMST6LNDjDudJpXCqvR5ETw6GSgYwH4Ok
         YIL0bqRchuYy/aal1hbeNAG3pcFpdozfLDBIezJXOuM/bzv6UOIAxuy/+h9XTiMGZAjl
         zfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019024; x=1751623824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpQ7AkRvShs03kmO7VCXGfaSepdwFFSh/faqrQd+6cQ=;
        b=ptoiAx+f/SCUe3TaByvoW+xT+cVmr+pkx0PeK6SS7HrRi64aPWbc8SvpcZBfT0eL1S
         S6sdecE5rm+h+K1pDC2Rjz7mq6QYKYDAaXkKc96hKQMt/TzjI2iZx74+qdBUUWvIk82n
         w70twH+qdLBtt1Vu+efhasL9hCi5TlmhT4uD2ecZpLutjTY/mAaeVa92tyI+O8NHk38r
         GBbsen5E5LltQU637D9FL+eMuZvHXbyzNBA0cXg7QzA2TTP6VFzGx8nWvw0C7Ckf8ANG
         SCP5r9VfKWYD8TQ55xeOF5gnyrw5FUALXTLCqPio9Z3NfAHVMUCS9/U6V9mYfuZQ/xZw
         Si1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXF/hl0g9z6GF3wHnAjGLIqD1cg3YkR68IuwPhX/GtpsFQdf6io9DN7BWYllb3ZGO/LAdlbSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwgYlLq5RlZ6hokpuYtPaLB1MptR92OIIWMP7AXLR1c3NZrTpp
	TzDuiSrRpvzIJ+o6JvOVgrIbQhKrFL6/kGacWuGDz1SO5D1Wa+F2I5NcI0sXUUkNQpzIJ0zjaME
	TmVHw
X-Gm-Gg: ASbGncteib5xqaE+tGudZEwknbjpnzks1dGl34Hl/cLXuXjdo/8aC+Y9aH4e6jt3W3Z
	V3TvGqbVKi+E1PVsVKHUX23HaEgtFWwcuYkr7+CHNlq8KkT1ncxRilL6Olzw4gJk67m7YrjgmPe
	7IQxlIdj0OogIx2Fq0PnbwoEGPr2N3HiZjLkpZcugF23uYwNSaxXvgJGav0Isy+QgMttbagFCtm
	T08TnD7TRqtj9MGVBpKWXbk8juBE+zrooYmAetcr5aUw4t0Ch8jzSeNf9DiRbPdj5F3hlrwn6DY
	xFwQILeRPJUZVbcHnUvmLERruAFIkn3AGARamF7My+xd/k/MiqG4DBrLrEeWqtQv9SQTlgJTmfH
	EFz5gjR1X7O6Fosb0jBZDZFhF/9pA4I25INCcmUOb1ZWYKLDy3Qeu
X-Google-Smtp-Source: AGHT+IEdyquFfyx9KUX5NVl3Szzj+1MmtSq9TEoKItOj38mGNZ/23I3A2OT7FNM9TsLGyfqL0ocpUg==
X-Received: by 2002:a05:600c:4ec8:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-4538f8834b1mr8127595e9.4.1751019024073;
        Fri, 27 Jun 2025 03:10:24 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a3fe0d6sm45512065e9.25.2025.06.27.03.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:10:23 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	Petr Tesarik <ptesarik@suse.com>,
	iommu@lists.linux.dev
Subject: [PATCH v2 2/8] docs: dma-api: replace consistent with coherent
Date: Fri, 27 Jun 2025 12:10:09 +0200
Message-ID: <20250627101015.1600042-3-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627101015.1600042-1-ptesarik@suse.com>
References: <20250627101015.1600042-1-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For consistency, always use the term "coherent" when talking about memory
that is not subject to CPU caching effects. The term "consistent" is a
relic of a long-removed PCI DMA API (pci_alloc_consistent() and
pci_free_consistent() functions).

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 Documentation/core-api/dma-api-howto.rst | 36 ++++++++++++------------
 Documentation/core-api/dma-api.rst       | 14 ++++-----
 mm/dmapool.c                             |  6 ++--
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index 0bf31b6c4383c..96fce2a9aa901 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -155,7 +155,7 @@ a device with limitations, it needs to be decreased.
 
 Special note about PCI: PCI-X specification requires PCI-X devices to support
 64-bit addressing (DAC) for all transactions.  And at least one platform (SGI
-SN2) requires 64-bit consistent allocations to operate correctly when the IO
+SN2) requires 64-bit coherent allocations to operate correctly when the IO
 bus is in PCI-X mode.
 
 For correct operation, you must set the DMA mask to inform the kernel about
@@ -174,7 +174,7 @@ used instead:
 
 		int dma_set_mask(struct device *dev, u64 mask);
 
-	The setup for consistent allocations is performed via a call
+	The setup for coherent allocations is performed via a call
 	to dma_set_coherent_mask()::
 
 		int dma_set_coherent_mask(struct device *dev, u64 mask);
@@ -241,7 +241,7 @@ it would look like this::
 
 The coherent mask will always be able to set the same or a smaller mask as
 the streaming mask. However for the rare case that a device driver only
-uses consistent allocations, one would have to check the return value from
+uses coherent allocations, one would have to check the return value from
 dma_set_coherent_mask().
 
 Finally, if your device can only drive the low 24-bits of
@@ -298,20 +298,20 @@ Types of DMA mappings
 
 There are two types of DMA mappings:
 
-- Consistent DMA mappings which are usually mapped at driver
+- Coherent DMA mappings which are usually mapped at driver
   initialization, unmapped at the end and for which the hardware should
   guarantee that the device and the CPU can access the data
   in parallel and will see updates made by each other without any
   explicit software flushing.
 
-  Think of "consistent" as "synchronous" or "coherent".
+  Think of "coherent" as "synchronous".
 
-  The current default is to return consistent memory in the low 32
+  The current default is to return coherent memory in the low 32
   bits of the DMA space.  However, for future compatibility you should
-  set the consistent mask even if this default is fine for your
+  set the coherent mask even if this default is fine for your
   driver.
 
-  Good examples of what to use consistent mappings for are:
+  Good examples of what to use coherent mappings for are:
 
 	- Network card DMA ring descriptors.
 	- SCSI adapter mailbox command data structures.
@@ -320,13 +320,13 @@ There are two types of DMA mappings:
 
   The invariant these examples all require is that any CPU store
   to memory is immediately visible to the device, and vice
-  versa.  Consistent mappings guarantee this.
+  versa.  Coherent mappings guarantee this.
 
   .. important::
 
-	     Consistent DMA memory does not preclude the usage of
+	     Coherent DMA memory does not preclude the usage of
 	     proper memory barriers.  The CPU may reorder stores to
-	     consistent memory just as it may normal memory.  Example:
+	     coherent memory just as it may normal memory.  Example:
 	     if it is important for the device to see the first word
 	     of a descriptor updated before the second, you must do
 	     something like::
@@ -365,10 +365,10 @@ Also, systems with caches that aren't DMA-coherent will work better
 when the underlying buffers don't share cache lines with other data.
 
 
-Using Consistent DMA mappings
-=============================
+Using Coherent DMA mappings
+===========================
 
-To allocate and map large (PAGE_SIZE or so) consistent DMA regions,
+To allocate and map large (PAGE_SIZE or so) coherent DMA regions,
 you should do::
 
 	dma_addr_t dma_handle;
@@ -385,10 +385,10 @@ __get_free_pages() (but takes size instead of a page order).  If your
 driver needs regions sized smaller than a page, you may prefer using
 the dma_pool interface, described below.
 
-The consistent DMA mapping interfaces, will by default return a DMA address
+The coherent DMA mapping interfaces, will by default return a DMA address
 which is 32-bit addressable.  Even if the device indicates (via the DMA mask)
-that it may address the upper 32-bits, consistent allocation will only
-return > 32-bit addresses for DMA if the consistent DMA mask has been
+that it may address the upper 32-bits, coherent allocation will only
+return > 32-bit addresses for DMA if the coherent DMA mask has been
 explicitly changed via dma_set_coherent_mask().  This is true of the
 dma_pool interface as well.
 
@@ -497,7 +497,7 @@ program address space.  Such platforms can and do report errors in the
 kernel logs when the DMA controller hardware detects violation of the
 permission setting.
 
-Only streaming mappings specify a direction, consistent mappings
+Only streaming mappings specify a direction, coherent mappings
 implicitly have a direction attribute setting of
 DMA_BIDIRECTIONAL.
 
diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 97f42c15f5e43..c0a2cc7d0b959 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -8,9 +8,9 @@ This document describes the DMA API.  For a more gentle introduction
 of the API (and actual examples), see Documentation/core-api/dma-api-howto.rst.
 
 This API is split into two pieces.  Part I describes the basic API.
-Part II describes extensions for supporting non-consistent memory
+Part II describes extensions for supporting non-coherent memory
 machines.  Unless you know that your driver absolutely has to support
-non-consistent platforms (this is usually only legacy platforms) you
+non-coherent platforms (this is usually only legacy platforms) you
 should only use the API described in part I.
 
 Part I - DMA API
@@ -33,13 +33,13 @@ Part Ia - Using large DMA-coherent buffers
 	dma_alloc_coherent(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flag)
 
-Consistent memory is memory for which a write by either the device or
+Coherent memory is memory for which a write by either the device or
 the processor can immediately be read by the processor or device
 without having to worry about caching effects.  (You may however need
 to make sure to flush the processor's write buffers before telling
 devices to read that memory.)
 
-This routine allocates a region of <size> bytes of consistent memory.
+This routine allocates a region of <size> bytes of coherent memory.
 
 It returns a pointer to the allocated region (in the processor's virtual
 address space) or NULL if the allocation failed.
@@ -48,9 +48,9 @@ It also returns a <dma_handle> which may be cast to an unsigned integer the
 same width as the bus and given to the device as the DMA address base of
 the region.
 
-Note: consistent memory can be expensive on some platforms, and the
+Note: coherent memory can be expensive on some platforms, and the
 minimum allocation length may be as big as a page, so you should
-consolidate your requests for consistent memory as much as possible.
+consolidate your requests for coherent memory as much as possible.
 The simplest way to do that is to use the dma_pool calls (see below).
 
 The flag parameter (dma_alloc_coherent() only) allows the caller to
@@ -64,7 +64,7 @@ the returned memory, like GFP_DMA).
 	dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
 			  dma_addr_t dma_handle)
 
-Free a region of consistent memory you previously allocated.  dev,
+Free a region of coherent memory you previously allocated.  dev,
 size and dma_handle must all be the same as those passed into
 dma_alloc_coherent().  cpu_addr must be the virtual address returned by
 the dma_alloc_coherent().
diff --git a/mm/dmapool.c b/mm/dmapool.c
index 5be8cc1c65292..5d8af6e291276 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -200,7 +200,7 @@ static void pool_block_push(struct dma_pool *pool, struct dma_block *block,
 
 
 /**
- * dma_pool_create_node - Creates a pool of consistent memory blocks, for dma.
+ * dma_pool_create_node - Creates a pool of coherent DMA memory blocks.
  * @name: name of pool, for diagnostics
  * @dev: device that will be doing the DMA
  * @size: size of the blocks in this pool.
@@ -210,7 +210,7 @@ static void pool_block_push(struct dma_pool *pool, struct dma_block *block,
  * Context: not in_interrupt()
  *
  * Given one of these pools, dma_pool_alloc()
- * may be used to allocate memory.  Such memory will all have "consistent"
+ * may be used to allocate memory.  Such memory will all have coherent
  * DMA mappings, accessible by the device and its driver without using
  * cache flushing primitives.  The actual size of blocks allocated may be
  * larger than requested because of alignment.
@@ -395,7 +395,7 @@ void dma_pool_destroy(struct dma_pool *pool)
 EXPORT_SYMBOL(dma_pool_destroy);
 
 /**
- * dma_pool_alloc - get a block of consistent memory
+ * dma_pool_alloc - get a block of coherent memory
  * @pool: dma pool that will produce the block
  * @mem_flags: GFP_* bitmask
  * @handle: pointer to dma address of block
-- 
2.49.0

