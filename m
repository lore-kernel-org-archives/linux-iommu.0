Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E364BC07E9B
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 03:36:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9675161175
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 03:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9675161175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6039840452;
	Tue, 20 Jul 2021 03:36:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N8MvpR4p1E9E; Tue, 20 Jul 2021 03:36:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 87AEC40448;
	Tue, 20 Jul 2021 03:36:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60FB9C001A;
	Tue, 20 Jul 2021 03:36:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 878C1C000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68AB7402EE
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:36:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RLXDRE93Puw6 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 03:36:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F3CC400E4
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:36:32 +0000 (UTC)
Received: by mail-io1-xd32.google.com with SMTP id p186so22482417iod.13
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jJGPzo2D/QmYN8C9EYVFi8OnTZ2+dp4VjkWxhHVMGZU=;
 b=YVfiS0+FAd6ubNrNKtyu4lmHksMwrO/9rRQ3BxuHPe6lei7o4+muBmTzOy7eeC1jes
 mZLq1jtxDpJ6d30HnvM4tjIjr98oAXOWjInYI6f39yZ1iMkAaUj3olaxe3nkzQyMPgnN
 B7OBXN8k4rYmTrwZrIpVDavtLTsEVWpJ4jYAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jJGPzo2D/QmYN8C9EYVFi8OnTZ2+dp4VjkWxhHVMGZU=;
 b=RYjaZ6VHAx4tXFU17NtXJ9yexoQabyCEA9G7MWJcTUMqU3CzMvCFofSR/SCeAlGBVI
 WX0xtvqCrCkuHiwJQw2KzRSa2120CrwsQuT3v83jBCXq7LNM6Nyuk8pRPtMtR5r9j8DE
 tcP4FIzLSZIatZzuEmAZMXhztne+jyFHK7KCJQfTJly7ZhInjbhIoFVeytuTiyQIAZWS
 IJ1cju7MqPJfpVwcI46Cfl6k3OG3o510WqJdYg0oG9uUZXOQKscDSyxe1zbjdT2TuceS
 9akzy0zi6705kPRbzbrFlQ5F8gBFqcanmQztIgERNUD4kyIzcGu3APSRoe2f7YrfdUcA
 /kBQ==
X-Gm-Message-State: AOAM532q43OsUix83XndYKnkxF9+YmWNa8SUG9o/W5E2nlE6a93P9856
 ty8j9Q8lzg8UCs4p4WkntV5R0SUUb+Utxg==
X-Google-Smtp-Source: ABdhPJyb7Jl7u+tBJfWY9sG8Lee2+NHddhKTC3uDP8n82rr5ih70eVKpRvRbFmegAIzE9e6D9ObI1A==
X-Received: by 2002:a02:942e:: with SMTP id a43mr25069586jai.74.1626752191131; 
 Mon, 19 Jul 2021 20:36:31 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com.
 [209.85.166.174])
 by smtp.gmail.com with ESMTPSA id z24sm5595015iog.46.2021.07.19.20.36.30
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 20:36:30 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id b6so17963519iln.12
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 20:36:30 -0700 (PDT)
X-Received: by 2002:a92:d58f:: with SMTP id a15mr2544884iln.18.1626752190055; 
 Mon, 19 Jul 2021 20:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210719123054.6844-1-will@kernel.org>
 <20210719123054.6844-6-will@kernel.org>
In-Reply-To: <20210719123054.6844-6-will@kernel.org>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 20 Jul 2021 11:36:19 +0800
X-Gmail-Original-Message-ID: <CALiNf2_Ubi9cynH1Rjy-o87V3MyvdTazv5rO=sggNai0WJZ81g@mail.gmail.com>
Message-ID: <CALiNf2_Ubi9cynH1Rjy-o87V3MyvdTazv5rO=sggNai0WJZ81g@mail.gmail.com>
Subject: Re: [PATCH 5/5] swiotlb: Free tbl memory in swiotlb_exit()
To: Will Deacon <will@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 lkml <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

On Mon, Jul 19, 2021 at 8:31 PM Will Deacon <will@kernel.org> wrote:
>
> Although swiotlb_exit() frees the 'slots' metadata array referenced by
> 'io_tlb_default_mem', it leaves the underlying buffer pages allocated
> despite no longer being usable.
>
> Extend swiotlb_exit() to free the buffer pages as well as the slots
> array.
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Claire Chang <tientzu@chromium.org>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b3c793ed9e64..87c40517e822 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -328,18 +328,27 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>
>  void __init swiotlb_exit(void)
>  {
> -       size_t size;
>         struct io_tlb_mem *mem = &io_tlb_default_mem;
> +       unsigned long tbl_vaddr;
> +       size_t tbl_size, slots_size;
>
>         if (!mem->nslabs)
>                 return;
>
>         pr_info("tearing down default memory pool\n");
> -       size = array_size(sizeof(*mem->slots), mem->nslabs);
> -       if (mem->late_alloc)
> -               free_pages((unsigned long)mem->slots, get_order(size));
> -       else
> -               memblock_free_late(__pa(mem->slots), PAGE_ALIGN(size));
> +       tbl_vaddr = (unsigned long)phys_to_virt(mem->start);
> +       tbl_size = PAGE_ALIGN(mem->end - mem->start);
> +       slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
> +
> +       set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
> +       if (mem->late_alloc) {
> +               free_pages(tbl_vaddr, get_order(tbl_size));
> +               free_pages((unsigned long)mem->slots, get_order(slots_size));
> +       } else {
> +               memblock_free_late(mem->start, tbl_size);
> +               memblock_free_late(__pa(mem->slots), slots_size);
> +       }
> +
>         memset(mem, 0, sizeof(*mem));
>  }
>
> --
> 2.32.0.402.g57bb445576-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
