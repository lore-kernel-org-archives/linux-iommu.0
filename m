Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E33BC433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:09:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B422C64E56
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B422C64E56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 738F643025;
	Mon,  1 Mar 2021 08:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aRnBOMYd2lDR; Mon,  1 Mar 2021 08:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58FBC414EF;
	Mon,  1 Mar 2021 08:09:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 258A2C000A;
	Mon,  1 Mar 2021 08:09:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EBDCC0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 251CC4F255
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FIK8FJSGHpZR for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:09:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0048C4F253
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:09:46 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9341868BEB; Mon,  1 Mar 2021 09:09:42 +0100 (CET)
Date: Mon, 1 Mar 2021 09:09:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 4/7] dma-mapping: add a dma_alloc_noncontiguous API
Message-ID: <20210301080942.GA27723@lst.de>
References: <20210202095110.1215346-1-hch@lst.de>
 <20210202095110.1215346-5-hch@lst.de>
 <53a6c581-4d9f-c69a-80f5-2e95e810c4d1@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53a6c581-4d9f-c69a-80f5-2e95e810c4d1@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Sergey Senozhatsky <senozhatsky@google.com>, linux-media@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Christoph Hellwig <hch@lst.de>
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

On Tue, Feb 16, 2021 at 06:55:39PM +0000, Robin Murphy wrote:
> On 2021-02-02 09:51, Christoph Hellwig wrote:
>> Add a new API that returns a potentiall virtually non-contigous sg_table
>> and a DMA address.  This API is only properly implemented for dma-iommu
>> and will simply return a contigious chunk as a fallback.
>>
>> The intent is that media drivers can use this API if either:
>>
>>   - no kernel mapping or only temporary kernel mappings are required.
>>     That is as a better replacement for DMA_ATTR_NO_KERNEL_MAPPING
>>   - a kernel mapping is required for cached and DMA mapped pages, but
>>     the driver also needs the pages to e.g. map them to userspace.
>>     In that sense it is a replacement for some aspects of the recently
>>     removed and never fully implemented DMA_ATTR_NON_CONSISTENT
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   Documentation/core-api/dma-api.rst |  74 +++++++++++++++++++++
>>   include/linux/dma-map-ops.h        |  18 +++++
>>   include/linux/dma-mapping.h        |  31 +++++++++
>>   kernel/dma/mapping.c               | 103 +++++++++++++++++++++++++++++
>>   4 files changed, 226 insertions(+)
>>
>> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
>> index 157a474ae54416..e24b2447f4bfe6 100644
>> --- a/Documentation/core-api/dma-api.rst
>> +++ b/Documentation/core-api/dma-api.rst
>> @@ -594,6 +594,80 @@ dev, size, dma_handle and dir must all be the same as those passed into
>>   dma_alloc_noncoherent().  cpu_addr must be the virtual address returned by
>>   dma_alloc_noncoherent().
>>   +::
>> +
>> +	struct sg_table *
>> +	dma_alloc_noncontiguous(struct device *dev, size_t size,
>> +				enum dma_data_direction dir, gfp_t gfp)
>> +
>> +This routine allocates  <size> bytes of non-coherent and possibly non-contiguous
>> +memory.  It returns a pointer to struct sg_table that describes the allocated
>> +and DMA mapped memory, or NULL if the allocation failed. The resulting memory
>> +can be used for struct page mapped into a scatterlist are suitable for.
>> +
>> +The return sg_table is guaranteed to have 1 single DMA mapped segment as
>> +indicated by sgt->nents, but it might have multiple CPU side segments as
>> +indicated by sgt->orig_nents.
>> +
>> +The dir parameter specified if data is read and/or written by the device,
>> +see dma_map_single() for details.
>> +
>> +The gfp parameter allows the caller to specify the ``GFP_`` flags (see
>> +kmalloc()) for the allocation, but rejects flags used to specify a memory
>> +zone such as GFP_DMA or GFP_HIGHMEM.
>> +
>> +Before giving the memory to the device, dma_sync_sgtable_for_device() needs
>> +to be called, and before reading memory written by the device,
>> +dma_sync_sgtable_for_cpu(), just like for streaming DMA mappings that are
>> +reused.
>> +
>> +::
>> +
>> +	void
>> +	dma_free_noncontiguous(struct device *dev, size_t size,
>> +			       struct sg_table *sgt,
>> +			       enum dma_data_direction dir)
>> +
>> +Free memory previously allocated using dma_alloc_noncontiguous().  dev, size,
>> +and dir must all be the same as those passed into dma_alloc_noncontiguous().
>> +sgt must be the pointer returned by dma_alloc_noncontiguous().
>> +
>> +::
>> +
>> +	void *
>> +	dma_vmap_noncontiguous(struct device *dev, size_t size,
>> +		struct sg_table *sgt)
>> +
>> +Return a contiguous kernel mapping for an allocation returned from
>> +dma_alloc_noncontiguous().  dev and size must be the same as those passed into
>> +dma_alloc_noncontiguous().  sgt must be the pointer returned by
>> +dma_alloc_noncontiguous().
>> +
>> +Once a non-contiguous allocation is mapped using this function, the
>> +flush_kernel_vmap_range() and invalidate_kernel_vmap_range() APIs must be used
>> +to manage the coherency of the kernel mapping.
>
> Maybe say something like "coherency between the kernel mapping and any 
> userspace mappings"? Otherwise people like me may be easily confused and 
> think it's referring to coherency between the kernel mapping and the 
> device, where in most cases those APIs won't help at all :)

Well, it is all of the above for a VIVT cache setup.  I've ammended
it to:

Once a non-contiguous allocation is mapped using this function, the
flush_kernel_vmap_range() and invalidate_kernel_vmap_range() APIs must be used
to manage the coherency between the kernel mapping, the device and user space
mappings (if any).

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
