Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618271B21BF
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750913491; cv=none; b=IYpSCYRwufBhdtrYbSspcvlwp29VjNdnnhcSsH1VVkqagi7OgNMPhIaH8TBGYwLoXVH0X4+RAlNq7QJOSlOZZb8ADc8SWIWEoZw/iPtrZQkomCHENDH20v90tnwbqIhTMzZfkCw5fbrUWvuwxIudn04nCcu0MwXC3/P8/gIk2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750913491; c=relaxed/simple;
	bh=tzGZXdlM7XBeLEyjHJLQEm3F7vF1lwayGadaMQBgs20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDCnSOJNSHg8O8GG2R1HOORYV1CNrScoxeyURNXjrpxtTXonHckOP4Th9LAsAUIJSysDpBeiqYJmRuaKeRSgyt95TPrnwQvkSe2/QjPKszEJPXcBoxRUBjpRZVjenTd2leoJ2IWhEZAMtB0p8BLpq76nHekVsx0SJKCdAR/kcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SSM3plWQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SSM3plWQ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6071ac68636so112362a12.3
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 21:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750913488; x=1751518288; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWC7HBqSFUGlEPGH7aS8ihpBdyH7ak4aV8RQ6csJ+OY=;
        b=SSM3plWQ+IrUAXFy47EDcZV5y3IaFJB5z5ua+ht7GNkiSof7iLRvhJK/fvi6yKAHYL
         tuC9ltg8nrv+f6Em1QBiLYah/U3sTsrPDChtmAoKNIUABEclk+UernCqA5yXEKl9Srs0
         sNHtATk/82i/iEJM8qJpnx718eDbMsy11dL2aFdA6/MrkKluLg+2e90vfs730HGZEeyu
         E0kDbTqv0S48jj1z7TeVinzXFJZuGgDfdnbusECE4uNKRgoEwXCv/GPIf6EbqbciNbyO
         jADpWyU88s9HzDDchU1vcPujEGKpyoP03TBg2v4S0ctQfF7br4MKjfA4KS+5taikvfx8
         ZDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750913488; x=1751518288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWC7HBqSFUGlEPGH7aS8ihpBdyH7ak4aV8RQ6csJ+OY=;
        b=piJ/RTMaT6QfpJYnCy9S1M6NpesfvHuvl/EE51CazwE7h/k6CMs+Mt/7JDdWuICWeb
         2k1IAzmorO8r1X4SeA5n8tud84IQ7azx1fh+m5FQIz7g9dO9QHwE5xVxhujn3R5uPhp1
         r4kt6zEtTrazq6xd9S0vu6mrEuGWHDv3rXTd3+eve96UzdG3C79iHFpS5pPtqfpmlMSM
         v/D96Ry/4CZV+0UuIkmD4BxcVe1o6M9+tME50AocCElDL2KjGdfQ8DOZNYyRITFnRSy+
         R3O1LJxPo+2vlcD0wFot0W4NUqz+KoK/kkDViCppeaCXtLd8D3RF1cHvx7gt/wwEtisq
         16Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUfRVh8PlOEKmEuvoBvNiaIlg1Z/9MY2qM4da2iscHkt56Di7Fanwab1yS/YW9TfNiDAmo2xQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+26tmgxBWoYE/KFaeY8C73VfsjkihZS9rEtrHF/prCCWrqrJI
	tgMTk+6bJSINFGXZ4syg05pc3s80J4hW0E8DB8rGclxwcFhaoHhiythMvAXKWTq1clA=
X-Gm-Gg: ASbGncvhgMpDwfxqiPvjQSRcQQarTDJ+rJ0eT0LeK+jtdQ4X+TZelIAbouFuNNTroOB
	keOtNkACezIuoqiuaw+e/8ahDgAm1ApMsWvj+rLhVIGBthQXXQvB2YOpZ3IpikfJMPjEkpa5lsL
	lNoAdRywV9rzX4ziB5oVjkr3KrjEyV8bxIDbV4JhVLuCNFyKqqCiJSRPahq76RIFadbzSGAFzo0
	Wg0WWNdVfYsgNYAySGPw0Dhu67/9f2Jtfv3gufvKzTnS1GsArGRtmT4AwFohukhTTjDlf/ywL4K
	+9Jtx6wm349EcX4m/jK4M/R4zdDB9BkvLK/6bZFsRY5Ptw==
X-Google-Smtp-Source: AGHT+IEZlq6eUrM1lQ3SGemnqkMSipc938+0VRxHvwMg1lalNKduhac6t/8hXwjkIGMnsXPZ7dnJlw==
X-Received: by 2002:a17:907:9691:b0:ae0:d83c:bcc3 with SMTP id a640c23a62f3a-ae0d83cc2f6mr28824866b.7.1750913487561;
        Wed, 25 Jun 2025 21:51:27 -0700 (PDT)
Received: from mordecai.tesarici.cz ([213.235.133.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054080e8esm1149691466b.82.2025.06.25.21.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 21:51:27 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:51:23 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Leon Romanovsky <leon@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, John Garry
 <john.g.garry@oracle.com>, linux-doc@vger.kernel.org (open
 list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list),
 linux-mm@kvack.org (open list:MEMORY MANAGEMENT), iommu@lists.linux.dev
Subject: Re: [PATCH 2/8] docs: dma-api: replace consistent with coherent
Message-ID: <20250626065123.646bd954@mordecai.tesarici.cz>
In-Reply-To: <20250624133923.1140421-3-ptesarik@suse.com>
References: <20250624133923.1140421-1-ptesarik@suse.com>
	<20250624133923.1140421-3-ptesarik@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 15:39:17 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> For consistency, always use the term "coherent" when talking about memory
> that is not subject to CPU caching effects. The term "consistent" is a
> relic of a long-removed pci_alloc_consistent() function.

I realize that I'm not an authoritative source for this, but I forgot
to add more trusted maintainers to the recipient list.

Now, all you DMA experts, do you agree that the word "consistent"
should be finally eradicated from DMA API documentation?

Petr T

> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  Documentation/core-api/dma-api-howto.rst | 36 ++++++++++++------------
>  Documentation/core-api/dma-api.rst       | 14 ++++-----
>  mm/dmapool.c                             |  6 ++--
>  3 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
> index 0bf31b6c4383..96fce2a9aa90 100644
> --- a/Documentation/core-api/dma-api-howto.rst
> +++ b/Documentation/core-api/dma-api-howto.rst
> @@ -155,7 +155,7 @@ a device with limitations, it needs to be decreased.
>  
>  Special note about PCI: PCI-X specification requires PCI-X devices to support
>  64-bit addressing (DAC) for all transactions.  And at least one platform (SGI
> -SN2) requires 64-bit consistent allocations to operate correctly when the IO
> +SN2) requires 64-bit coherent allocations to operate correctly when the IO
>  bus is in PCI-X mode.
>  
>  For correct operation, you must set the DMA mask to inform the kernel about
> @@ -174,7 +174,7 @@ used instead:
>  
>  		int dma_set_mask(struct device *dev, u64 mask);
>  
> -	The setup for consistent allocations is performed via a call
> +	The setup for coherent allocations is performed via a call
>  	to dma_set_coherent_mask()::
>  
>  		int dma_set_coherent_mask(struct device *dev, u64 mask);
> @@ -241,7 +241,7 @@ it would look like this::
>  
>  The coherent mask will always be able to set the same or a smaller mask as
>  the streaming mask. However for the rare case that a device driver only
> -uses consistent allocations, one would have to check the return value from
> +uses coherent allocations, one would have to check the return value from
>  dma_set_coherent_mask().
>  
>  Finally, if your device can only drive the low 24-bits of
> @@ -298,20 +298,20 @@ Types of DMA mappings
>  
>  There are two types of DMA mappings:
>  
> -- Consistent DMA mappings which are usually mapped at driver
> +- Coherent DMA mappings which are usually mapped at driver
>    initialization, unmapped at the end and for which the hardware should
>    guarantee that the device and the CPU can access the data
>    in parallel and will see updates made by each other without any
>    explicit software flushing.
>  
> -  Think of "consistent" as "synchronous" or "coherent".
> +  Think of "coherent" as "synchronous".
>  
> -  The current default is to return consistent memory in the low 32
> +  The current default is to return coherent memory in the low 32
>    bits of the DMA space.  However, for future compatibility you should
> -  set the consistent mask even if this default is fine for your
> +  set the coherent mask even if this default is fine for your
>    driver.
>  
> -  Good examples of what to use consistent mappings for are:
> +  Good examples of what to use coherent mappings for are:
>  
>  	- Network card DMA ring descriptors.
>  	- SCSI adapter mailbox command data structures.
> @@ -320,13 +320,13 @@ There are two types of DMA mappings:
>  
>    The invariant these examples all require is that any CPU store
>    to memory is immediately visible to the device, and vice
> -  versa.  Consistent mappings guarantee this.
> +  versa.  Coherent mappings guarantee this.
>  
>    .. important::
>  
> -	     Consistent DMA memory does not preclude the usage of
> +	     Coherent DMA memory does not preclude the usage of
>  	     proper memory barriers.  The CPU may reorder stores to
> -	     consistent memory just as it may normal memory.  Example:
> +	     coherent memory just as it may normal memory.  Example:
>  	     if it is important for the device to see the first word
>  	     of a descriptor updated before the second, you must do
>  	     something like::
> @@ -365,10 +365,10 @@ Also, systems with caches that aren't DMA-coherent will work better
>  when the underlying buffers don't share cache lines with other data.
>  
>  
> -Using Consistent DMA mappings
> -=============================
> +Using Coherent DMA mappings
> +===========================
>  
> -To allocate and map large (PAGE_SIZE or so) consistent DMA regions,
> +To allocate and map large (PAGE_SIZE or so) coherent DMA regions,
>  you should do::
>  
>  	dma_addr_t dma_handle;
> @@ -385,10 +385,10 @@ __get_free_pages() (but takes size instead of a page order).  If your
>  driver needs regions sized smaller than a page, you may prefer using
>  the dma_pool interface, described below.
>  
> -The consistent DMA mapping interfaces, will by default return a DMA address
> +The coherent DMA mapping interfaces, will by default return a DMA address
>  which is 32-bit addressable.  Even if the device indicates (via the DMA mask)
> -that it may address the upper 32-bits, consistent allocation will only
> -return > 32-bit addresses for DMA if the consistent DMA mask has been
> +that it may address the upper 32-bits, coherent allocation will only
> +return > 32-bit addresses for DMA if the coherent DMA mask has been
>  explicitly changed via dma_set_coherent_mask().  This is true of the
>  dma_pool interface as well.
>  
> @@ -497,7 +497,7 @@ program address space.  Such platforms can and do report errors in the
>  kernel logs when the DMA controller hardware detects violation of the
>  permission setting.
>  
> -Only streaming mappings specify a direction, consistent mappings
> +Only streaming mappings specify a direction, coherent mappings
>  implicitly have a direction attribute setting of
>  DMA_BIDIRECTIONAL.
>  
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index 97f42c15f5e4..c0a2cc7d0b95 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -8,9 +8,9 @@ This document describes the DMA API.  For a more gentle introduction
>  of the API (and actual examples), see Documentation/core-api/dma-api-howto.rst.
>  
>  This API is split into two pieces.  Part I describes the basic API.
> -Part II describes extensions for supporting non-consistent memory
> +Part II describes extensions for supporting non-coherent memory
>  machines.  Unless you know that your driver absolutely has to support
> -non-consistent platforms (this is usually only legacy platforms) you
> +non-coherent platforms (this is usually only legacy platforms) you
>  should only use the API described in part I.
>  
>  Part I - DMA API
> @@ -33,13 +33,13 @@ Part Ia - Using large DMA-coherent buffers
>  	dma_alloc_coherent(struct device *dev, size_t size,
>  			   dma_addr_t *dma_handle, gfp_t flag)
>  
> -Consistent memory is memory for which a write by either the device or
> +Coherent memory is memory for which a write by either the device or
>  the processor can immediately be read by the processor or device
>  without having to worry about caching effects.  (You may however need
>  to make sure to flush the processor's write buffers before telling
>  devices to read that memory.)
>  
> -This routine allocates a region of <size> bytes of consistent memory.
> +This routine allocates a region of <size> bytes of coherent memory.
>  
>  It returns a pointer to the allocated region (in the processor's virtual
>  address space) or NULL if the allocation failed.
> @@ -48,9 +48,9 @@ It also returns a <dma_handle> which may be cast to an unsigned integer the
>  same width as the bus and given to the device as the DMA address base of
>  the region.
>  
> -Note: consistent memory can be expensive on some platforms, and the
> +Note: coherent memory can be expensive on some platforms, and the
>  minimum allocation length may be as big as a page, so you should
> -consolidate your requests for consistent memory as much as possible.
> +consolidate your requests for coherent memory as much as possible.
>  The simplest way to do that is to use the dma_pool calls (see below).
>  
>  The flag parameter (dma_alloc_coherent() only) allows the caller to
> @@ -64,7 +64,7 @@ the returned memory, like GFP_DMA).
>  	dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
>  			  dma_addr_t dma_handle)
>  
> -Free a region of consistent memory you previously allocated.  dev,
> +Free a region of coherent memory you previously allocated.  dev,
>  size and dma_handle must all be the same as those passed into
>  dma_alloc_coherent().  cpu_addr must be the virtual address returned by
>  the dma_alloc_coherent().
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index 5be8cc1c6529..5d8af6e29127 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -200,7 +200,7 @@ static void pool_block_push(struct dma_pool *pool, struct dma_block *block,
>  
>  
>  /**
> - * dma_pool_create_node - Creates a pool of consistent memory blocks, for dma.
> + * dma_pool_create_node - Creates a pool of coherent DMA memory blocks.
>   * @name: name of pool, for diagnostics
>   * @dev: device that will be doing the DMA
>   * @size: size of the blocks in this pool.
> @@ -210,7 +210,7 @@ static void pool_block_push(struct dma_pool *pool, struct dma_block *block,
>   * Context: not in_interrupt()
>   *
>   * Given one of these pools, dma_pool_alloc()
> - * may be used to allocate memory.  Such memory will all have "consistent"
> + * may be used to allocate memory.  Such memory will all have coherent
>   * DMA mappings, accessible by the device and its driver without using
>   * cache flushing primitives.  The actual size of blocks allocated may be
>   * larger than requested because of alignment.
> @@ -395,7 +395,7 @@ void dma_pool_destroy(struct dma_pool *pool)
>  EXPORT_SYMBOL(dma_pool_destroy);
>  
>  /**
> - * dma_pool_alloc - get a block of consistent memory
> + * dma_pool_alloc - get a block of coherent memory
>   * @pool: dma pool that will produce the block
>   * @mem_flags: GFP_* bitmask
>   * @handle: pointer to dma address of block

