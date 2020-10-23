Return-Path: <SRS0=xWGd=D6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B61C388F9
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 10:01:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7927B221F9
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 10:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7927B221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E01D987133;
	Fri, 23 Oct 2020 10:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXnmXJsRGd38; Fri, 23 Oct 2020 10:01:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 69F7587132;
	Fri, 23 Oct 2020 10:01:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D384C088B;
	Fri, 23 Oct 2020 10:01:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F448C0051
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 10:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E41A22050D
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 10:01:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28AosOZ8v9M3 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 10:01:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 0A5312035C
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 10:01:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AAF831B;
 Fri, 23 Oct 2020 03:01:34 -0700 (PDT)
Received: from [10.57.50.191] (unknown [10.57.50.191])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3B9F3F66E;
 Fri, 23 Oct 2020 03:01:33 -0700 (PDT)
Subject: Re: [PATCH] dma-mapping: document dma_{alloc,free}_pages
To: Christoph Hellwig <hch@lst.de>
References: <20201023064520.3473905-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a5ab5d21-4ce4-66f8-a83d-cf0df369adff@arm.com>
Date: Fri, 23 Oct 2020 11:01:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201023064520.3473905-1-hch@lst.de>
Content-Language: en-GB
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-10-23 07:45, Christoph Hellwig wrote:
> Document the new dma_alloc_pages and dma_free_pages APIs, and fix
> up the documentation for dma_alloc_noncoherent and dma_free_noncoherent.
> 
> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   Documentation/core-api/dma-api.rst | 49 ++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index ea0413276ddb70..209d7978cdaa1b 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -519,10 +519,9 @@ routines, e.g.:::
>   Part II - Non-coherent DMA allocations
>   --------------------------------------
>   
> -These APIs allow to allocate pages in the kernel direct mapping that are
> -guaranteed to be DMA addressable.  This means that unlike dma_alloc_coherent,
> -virt_to_page can be called on the resulting address, and the resulting
> -struct page can be used for everything a struct page is suitable for.
> +These APIs allow to allocate pages that are guranteed to be DMA addressable

Typo: guaranteed

Otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +by the passed in device, but which need explicit management of memory
> +ownership for the kernel vs the device.
>   
>   If you don't understand how cache line coherency works between a processor and
>   an I/O device, you should not be using this part of the API.
> @@ -537,7 +536,7 @@ an I/O device, you should not be using this part of the API.
>   This routine allocates a region of <size> bytes of consistent memory.  It
>   returns a pointer to the allocated region (in the processor's virtual address
>   space) or NULL if the allocation failed.  The returned memory may or may not
> -be in the kernels direct mapping.  Drivers must not call virt_to_page on
> +be in the kernel direct mapping.  Drivers must not call virt_to_page on
>   the returned memory region.
>   
>   It also returns a <dma_handle> which may be cast to an unsigned integer the
> @@ -565,7 +564,45 @@ reused.
>   Free a region of memory previously allocated using dma_alloc_noncoherent().
>   dev, size and dma_handle and dir must all be the same as those passed into
>   dma_alloc_noncoherent().  cpu_addr must be the virtual address returned by
> -the dma_alloc_noncoherent().
> +dma_alloc_noncoherent().
> +
> +::
> +
> +	struct page *
> +	dma_alloc_pages(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +			enum dma_data_direction dir, gfp_t gfp)
> +
> +This routine allocates a region of <size> bytes of non-coherent memory.  It
> +returns a pointer to first struct page for the region, or NULL if the
> +allocation failed. The resulting struct page can be used for everything a
> +struct page is suitable for.
> +
> +It also returns a <dma_handle> which may be cast to an unsigned integer the
> +same width as the bus and given to the device as the DMA address base of
> +the region.
> +
> +The dir parameter specified if data is read and/or written by the device,
> +see dma_map_single() for details.
> +
> +The gfp parameter allows the caller to specify the ``GFP_`` flags (see
> +kmalloc()) for the allocation, but rejects flags used to specify a memory
> +zone such as GFP_DMA or GFP_HIGHMEM.
> +
> +Before giving the memory to the device, dma_sync_single_for_device() needs
> +to be called, and before reading memory written by the device,
> +dma_sync_single_for_cpu(), just like for streaming DMA mappings that are
> +reused.
> +
> +::
> +
> +	void
> +	dma_free_pages(struct device *dev, size_t size, struct page *page,
> +			dma_addr_t dma_handle, enum dma_data_direction dir)
> +
> +Free a region of memory previously allocated using dma_alloc_pages().
> +dev, size and dma_handle and dir must all be the same as those passed into
> +dma_alloc_noncoherent().  page must be the pointer returned by
> +dma_alloc_pages().
>   
>   ::
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
