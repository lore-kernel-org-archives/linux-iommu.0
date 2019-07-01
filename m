Return-Path: <SRS0=o8L7=U6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACEC06511
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 18:36:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C70821841
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 18:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRjwVcrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C70821841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A4494CDB;
	Mon,  1 Jul 2019 18:36:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5EF2BC00
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 18:36:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com
	[209.85.221.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AD410832
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 18:36:15 +0000 (UTC)
Received: by mail-vk1-f195.google.com with SMTP id w186so2899959vkd.11
	for <iommu@lists.linux-foundation.org>;
	Mon, 01 Jul 2019 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ME/BMFz6NjZC07J0/XWrhiS+OPbFaTEtUu/72plFOIs=;
	b=jRjwVcrQqXZNLpn3VqHQ3MNa85+tUsohQg8XyZGRfIVSN9Dg4ifRAkBUmZRDluUndU
	DwyOoDiibj9Hqm0vxcf9whB4JTjNMbHhRhF7Zt3xAQE4EnxfNeP0slrYel8Kh8TdNCDz
	3rakNvIy/gyaTwUK+L28P6T36xww+8w7c/VJsP9Bui57GEXN9W0EhTeMdYCN+SKfFczz
	Ij3FEA4vevsqUeueZwJSjsQW8vQ6TBmGJAiGYuy6ZJXP3KS0BByhUboKXHO6jxGNMem+
	hSOrrt0L509dYmb6kxlKdzNf4AqXAurpg39HNaSvBIW8+ccaColJ3RJauD3Uru+EK5kC
	4RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ME/BMFz6NjZC07J0/XWrhiS+OPbFaTEtUu/72plFOIs=;
	b=YC4/0p7ku+y8gY8M/bX8owjC6vtH4VJtqHCIHQlE5yLmUNNUumX723ymOIIvSKk7ch
	eLJEW4+tgSlSdjXyFinx3cqoMbVsYTt4xNhCU5P2Mc7GUSsH7SIOInGt6Gjg3QL8w5vu
	WCL1Y84JLZtK5Q0IBhDtTUhdbska4M3KZxBE2ZdxjpGnudFs7MAm3h9sjqYYTbJDlL5n
	ClVOiaAyZjjIjK8QE4DKttA6oQI/35t0KH7hCqFIhR5qf9t8ogjFquazbt8wORxPYMqd
	qNqbiNYEVdDdsppgaFdjUYLRB1bVYL/CrUZrEjmj5m4ZE/f9owbONdy/vTO5IQwjeakz
	2cBA==
X-Gm-Message-State: APjAAAVAag2Cs3RPuNPo4nBP1m+BVO4EVV3KD1He2UjT5c/n1/EnjYm2
	bfohpFoiPZT6v7bK+AT6ZT9GHPuV+lC9dSls9fU=
X-Google-Smtp-Source: APXvYqxHi98I0sWxmIGmh3jNQhZD68UapxsiPklkNgaXVkZVV94WssxNS+ZXvzcSmlI/hWtXHMrtuNrf4wiVPtP41OQ=
X-Received: by 2002:a1f:2896:: with SMTP id o144mr3294269vko.73.1562006174652; 
	Mon, 01 Jul 2019 11:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo564RoWpi8y2pOxoddnn0s3f3sA-fmNxpiXuxebV5TFBJA@mail.gmail.com>
	<CACDBo55GfomD4yAJ1qaOvdm8EQaD-28=etsRHb39goh+5VAeqw@mail.gmail.com>
	<20190626175131.GA17250@infradead.org>
	<CACDBo56fNVxVyNEGtKM+2R0X7DyZrrHMQr6Yw4NwJ6USjD5Png@mail.gmail.com>
	<c9fe4253-5698-a226-c643-32a21df8520a@arm.com>
	<CACDBo57CcYQmNrsTdMbax27nbLyeMQu4kfKZOzNczNcnde9g3Q@mail.gmail.com>
In-Reply-To: <CACDBo57CcYQmNrsTdMbax27nbLyeMQu4kfKZOzNczNcnde9g3Q@mail.gmail.com>
From: Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date: Tue, 2 Jul 2019 00:06:03 +0530
Message-ID: <CACDBo54TUut15pr0pJ_6TcQxu-wc5uo5vEJ+bsU6L=abBoN80Q@mail.gmail.com>
Subject: Re: DMA-API attr - DMA_ATTR_NO_KERNEL_MAPPING
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	Vlastimil Babka <vbabka@suse.cz>
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

On Mon, Jul 1, 2019 at 11:17 PM Pankaj Suryawanshi
<pankajssuryawanshi@gmail.com> wrote:
>
>
>
>
> On Mon, Jul 1, 2019 at 7:39 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 28/06/2019 17:29, Pankaj Suryawanshi wrote:
>> > On Wed, Jun 26, 2019 at 11:21 PM Christoph Hellwig <hch@infradead.org> wrote:
>> >>
>> >> On Wed, Jun 26, 2019 at 10:12:45PM +0530, Pankaj Suryawanshi wrote:
>> >>> [CC: linux kernel and Vlastimil Babka]
>> >>
>> >> The right list is the list for the DMA mapping subsystem, which is
>> >> iommu@lists.linux-foundation.org.  I've also added that.
>> >>
>> >>>> I am writing driver in which I used DMA_ATTR_NO_KERNEL_MAPPING attribute
>> >>>> for cma allocation using dma_alloc_attr(), as per kernel docs
>> >>>> https://www.kernel.org/doc/Documentation/DMA-attributes.txt  buffers
>> >>>> allocated with this attribute can be only passed to user space by calling
>> >>>> dma_mmap_attrs().
>> >>>>
>> >>>> how can I mapped in kernel space (after dma_alloc_attr with
>> >>>> DMA_ATTR_NO_KERNEL_MAPPING ) ?
>> >>
>> >> You can't.  And that is the whole point of that API.
>> >
>> > 1. We can again mapped in kernel space using dma_remap() api , because
>> > when we are using  DMA_ATTR_NO_KERNEL_MAPPING for dma_alloc_attr it
>> > returns the page as virtual address(in case of CMA) so we can mapped
>> > it again using dma_remap().
>>
>> No, you really can't. A caller of dma_alloc_attrs(...,
>> DMA_ATTR_NO_KERNEL_MAPPING) cannot make any assumptions about the void*
>> it returns, other than that it must be handed back to dma_free_attrs()
>> later. The implementation is free to ignore the flag and give back a
>> virtual mapping anyway. Any driver which depends on how one particular
>> implementation on one particular platform happens to behave today is,
>> essentially, wrong.
>
>
> Here is the example that i have tried in my driver.
> ///////////////code snippet/////////////////////////////////////////////////////////////////////////
>
> For CMA allocation using DMA API with DMA_ATTR_NO_KERNEL_MAPPING  :-
>
> if(strcmp("video",info->name) == 0)
>         {
>         printk("Testing CMA Alloc %s\n", info->name);
>         info->dma_virt = dma_alloc_attrs(pmap_device, info->size, &phys, GFP_KERNEL,
>                         DMA_ATTR_WRITE_COMBINE | DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING);
>         if (!info->dma_virt) {
>                 pr_err("\x1b[31m" "pmap: cma: failed to alloc %s" "\x1b[0m\n",
>                                 info->name);
>                 return 0;
>         }
>                 __dma_remap(info->dma_virt, info->size, PAGE_KERNEL); // /*TO DO pgprot we will be taken from attr */  // we will use this only when virtual mapping is required.
>                 virt = page_address(info->dma_virt); // will use this virtual when kernel mapping needed.
>         }
>
> For CMA free using DMA api with DMA_ATTR_NO_KERNEL_MAPPING:-
>
> if(strcmp("video",info->name) == 0)
>         {
>         printk("Testing CMA Release\n");
>         __dma_remap(info->dma_virt, info->size, PAGE_KERNEL);
>         dma_free_attrs(pmap_device, info->size, info->dma_virt, phys,
>                         DMA_ATTR_WRITE_COMBINE | DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING);
>         }
>
> Flow of Function calls :-
>
> 1. static void *__dma_alloc() // .want_vaddr = ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
>
> 2.cma_allocator :-
>                             i.  static void *cma_allocator_alloc ()
>                             ii. static void *__alloc_from_contiguous()  // file name :- ./arch/arm/mm/dma-mapping.c
>                                                                      if (!want_vaddr)
>                                                                                     goto out; // condition true for DMA_ATTR_NO_KERNEL_MAPPING
>
>                                                                      if (PageHighMem(page)) {
>                                                                      ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
>                                                                      if (!ptr) {
>                                                                                 dma_release_from_contiguous(dev, page, count);
>                                                                                 return NULL;
>                                                                       }
>                                                                      } else {
>                                                                      __dma_remap(page, size, prot);
>                                                                     ptr = page_address(page);
>                                                                      }
>
>                                                                    out:
>                                                                   *ret_page = page; // return  page
>                                                                    return ptr;  // nothing in ptr
>                                                                   }
>                             iii. struct page *dma_alloc_from_contiguous()
>                             iv. cma_alloc()
> 3. dma_alloc () // returns
> return args.want_vaddr ? addr : page; // returns page which is return by alloc_from_contiguous().
>
> What wrong with this if we already know page is returning dma_alloc_attr().
> we can use dma_remap in our driver and free as freed in static void __free_from_contiguous ().
> Please let me know if i missing anything.
>
>> > 2. We can mapped in kernel space using vmap() as used for ion-cma
>> > https://github.com/torvalds/linux/tree/master/drivers/staging/android/ion
>> >   as used in function ion_heap_map_kernel().
>> >
>> > Please let me know if i am missing anything.
>>
>> If you want a kernel mapping, *don't* explicitly request not to have a
>> kernel mapping in the first place. It's that simple.
>
>
> Do you mean do not use dma-api ? because if i used dma-api it will give you mapped virtual address.
> or i have to use directly cma_alloc() in my driver. // if i used this approach i need to reserved more vmalloc area.
>
> Any help would be appreciated.
>>
>>
>> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
