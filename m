Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61260C28CF5
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 13:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 035F240132;
	Wed, 26 Jan 2022 13:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VT06ztZ9pdk6; Wed, 26 Jan 2022 13:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 722A440977;
	Wed, 26 Jan 2022 13:08:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42E44C0031;
	Wed, 26 Jan 2022 13:08:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6BB5C002D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 13:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C65D340994
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 13:08:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id laSPKEeZYkyy for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 13:08:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id B205340977
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 13:08:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC6401FB;
 Wed, 26 Jan 2022 05:08:08 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18CBD3F793;
 Wed, 26 Jan 2022 05:08:07 -0800 (PST)
Message-ID: <bbf3b6d4-b2b5-64b3-6dec-f1cc45f96122@arm.com>
Date: Wed, 26 Jan 2022 13:08:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC][DISCUSSION] dma-mapping: allocating noncoherent buffer
 without mapping
Content-Language: en-GB
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, iommu@lists.linux-foundation.org
References: <YfE2XMSmFtDudXYT@ip-172-31-19-208.ap-northeast-1.compute.internal>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YfE2XMSmFtDudXYT@ip-172-31-19-208.ap-northeast-1.compute.internal>
Cc: Christoph Hellwig <hch@lst.de>
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

On 2022-01-26 11:54, Hyeonggon Yoo wrote:
> Last month we discussed drivers that uses kmalloc(GFP_DMA) for
> noncoherent mapping should be converted to use DMA API [1]. Simple
> grep with GFP_DMA shows that many of drivers are mistakenly
> using GFP_DMA flag.
> 
> So our purpose was to make DMA API choose right zone depending on
> device's dma mask. Baoquan and I are trying to make drivers to
> use dma_alloc_noncoherent() when allocating the buffer.
> 
> But it's not simple for some of drivers; there is a gap between
> dma_alloc_noncoherent() and the previous convention (allocating buffer
> from buddy or slab allocator and mapping it when needed.)
> 
> For example, some drivers allocate buffer and reuse it. it just maps
> and unmaps whenever needed. And some drivers does not even maps the
> buffer. (some drivers that does not use DMA API)
> 
> So I think we need to implement a version of dma_alloc_noncoherent()
> that does not map the buffer.

This doesn't make sense to me. The point of dma_alloc_* is you get back 
a dedicated DMA buffer which can then be used at any time. In the 
noncoherent case you have to put in explicit dma_sync_*() calls around 
accesses when the CPU or device is expected to have updated the buffer 
contents, but it's still fundamentally the same paradigm.

If you want to update drivers from using streaming mappings on 
specially-allocated pages to using proper dedicated DMA buffers, then 
update the logic in those drivers to use dedicated DMA buffers 
appropriately. Adding an API to allocate a DMA buffer which isn't 
actually a DMA buffer so we can "update" drivers from misusing streaming 
mappings to still misusing streaming mappings is nonsense.

Robin.

> I think implementing a helper that internally calls
> __dma_direct_alloc_pages() will be okay.
> 
> As I'm not expert in this area, I want to hear
> others' opinions.
> 
> [1] https://lkml.org/lkml/2021/12/13/1121
> 
> Thanks,
> Hyeonggon.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
