Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB01C48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 06:25:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A752061209
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 06:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A752061209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60B7A60605;
	Fri, 18 Jun 2021 06:25:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BlBOY9j10cFv; Fri, 18 Jun 2021 06:25:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 25870605EC;
	Fri, 18 Jun 2021 06:25:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04CE7C000D;
	Fri, 18 Jun 2021 06:25:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FE2AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 06:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4342283CB0
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 06:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QkGY6oWtbhRv for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 06:25:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1042483C79
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 06:25:50 +0000 (UTC)
Received: by mail-il1-x136.google.com with SMTP id a11so786448ilf.2
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 23:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K4gmwVrd4ipCgh7Pt4U3qK6zM5RZFqVsfT+5m/JaTNY=;
 b=b3TOMvQ1kXF7QuAFyHdOkvmT8LXOEbUEDAbnT1VD77ESf6dWqJqkel2pij6H8qazUH
 qeKiHzooTElNu69H2pMv9jI9D4woaiXlDH7E4nc1glsurOz9EYewwC9YHW+cnkiHTax7
 tbypLVBnZif7y60KH97lEwI+rEiH+ILoO0+Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K4gmwVrd4ipCgh7Pt4U3qK6zM5RZFqVsfT+5m/JaTNY=;
 b=Uaeh5sKB6X24Ens/k7kEUXwsZB+744ul9R/+z64aRVFtZmjWljAUQTFWAhZ+3nUQVG
 vj7EumXRC9l8973gD7bn1tSFiVU29msBzYcjodQnRwwL6fd9eIjf6ns2045y4vvN+4z7
 UCaIanPJjaDKq3Nc0Km3KB77mTUe5h8pejPLvV5EP03gG0VtuIjd4HIN+/dYNVzJl7Vf
 eROTueeO8mL1g8+jltEPCU0w5kn2EsEcnJ3zyBo1MKYMCcZzb8NMr6LH7f6H2IuSgWto
 usSLYUvZ3H2zTgh9aBlZanv65JFEmZgE4xLz0c55iywBAlqSAGbuafzgCWAFy9msVhr9
 jhFQ==
X-Gm-Message-State: AOAM530aqUBd4p4VwnbzTqwdTho0UX2W9c8NzXfP+/bZE12yfHjxjh/j
 4zDTxCkNHgOLcbCAvxkjC+ncdV4OhhbhCQ==
X-Google-Smtp-Source: ABdhPJz7Zg0CX2LqLdVSHofDmqYnKe5M3FcsG62lapWqqpwluTkuWKRN+4PswP/q6c87iFepbjWvcg==
X-Received: by 2002:a05:6e02:e85:: with SMTP id
 t5mr6052451ilj.65.1623997549857; 
 Thu, 17 Jun 2021 23:25:49 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com.
 [209.85.166.54])
 by smtp.gmail.com with ESMTPSA id a22sm3980776iot.37.2021.06.17.23.25.48
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jun 2021 23:25:49 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id k5so5833745iow.12
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 23:25:48 -0700 (PDT)
X-Received: by 2002:a02:384b:: with SMTP id v11mr1842282jae.90.1623997548077; 
 Thu, 17 Jun 2021 23:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210617062635.1660944-1-tientzu@chromium.org>
 <20210617062635.1660944-2-tientzu@chromium.org>
 <alpine.DEB.2.21.2106171434480.24906@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2106171434480.24906@sstabellini-ThinkPad-T480s>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 18 Jun 2021 14:25:37 +0800
X-Gmail-Original-Message-ID: <CALiNf29SJ0jXirWVDhJw4BUNvkjUeGPyGNJK9m8c30OPX41=5Q@mail.gmail.com>
Message-ID: <CALiNf29SJ0jXirWVDhJw4BUNvkjUeGPyGNJK9m8c30OPX41=5Q@mail.gmail.com>
Subject: Re: [PATCH v13 01/12] swiotlb: Refactor swiotlb init functions
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
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

On Fri, Jun 18, 2021 at 7:30 AM Stefano Stabellini
<sstabellini@kernel.org> wrote:
>
> On Thu, 17 Jun 2021, Claire Chang wrote:
> > Add a new function, swiotlb_init_io_tlb_mem, for the io_tlb_mem struct
> > initialization to make the code reusable.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> > Tested-by: Will Deacon <will@kernel.org>
> > ---
> >  kernel/dma/swiotlb.c | 50 ++++++++++++++++++++++----------------------
> >  1 file changed, 25 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 52e2ac526757..47bb2a766798 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -168,9 +168,28 @@ void __init swiotlb_update_mem_attributes(void)
> >       memset(vaddr, 0, bytes);
> >  }
> >
> > -int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> > +static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> > +                                 unsigned long nslabs, bool late_alloc)
> >  {
> > +     void *vaddr = phys_to_virt(start);
> >       unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
> > +
> > +     mem->nslabs = nslabs;
> > +     mem->start = start;
> > +     mem->end = mem->start + bytes;
> > +     mem->index = 0;
> > +     mem->late_alloc = late_alloc;
> > +     spin_lock_init(&mem->lock);
> > +     for (i = 0; i < mem->nslabs; i++) {
> > +             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > +             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > +             mem->slots[i].alloc_size = 0;
> > +     }
> > +     memset(vaddr, 0, bytes);
> > +}
> > +
> > +int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> > +{
> >       struct io_tlb_mem *mem;
> >       size_t alloc_size;
> >
> > @@ -186,16 +205,8 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> >       if (!mem)
> >               panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
> >                     __func__, alloc_size, PAGE_SIZE);
> > -     mem->nslabs = nslabs;
> > -     mem->start = __pa(tlb);
> > -     mem->end = mem->start + bytes;
> > -     mem->index = 0;
> > -     spin_lock_init(&mem->lock);
> > -     for (i = 0; i < mem->nslabs; i++) {
> > -             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > -             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > -             mem->slots[i].alloc_size = 0;
> > -     }
> > +
> > +     swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
> >
> >       io_tlb_default_mem = mem;
> >       if (verbose)
> > @@ -282,8 +293,8 @@ swiotlb_late_init_with_default_size(size_t default_size)
> >  int
> >  swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
> >  {
> > -     unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
> >       struct io_tlb_mem *mem;
> > +     unsigned long bytes = nslabs << IO_TLB_SHIFT;
> >
> >       if (swiotlb_force == SWIOTLB_NO_FORCE)
> >               return 0;
> > @@ -297,20 +308,9 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
> >       if (!mem)
> >               return -ENOMEM;
> >
> > -     mem->nslabs = nslabs;
> > -     mem->start = virt_to_phys(tlb);
> > -     mem->end = mem->start + bytes;
> > -     mem->index = 0;
> > -     mem->late_alloc = 1;
> > -     spin_lock_init(&mem->lock);
> > -     for (i = 0; i < mem->nslabs; i++) {
> > -             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > -             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > -             mem->slots[i].alloc_size = 0;
> > -     }
> > -
> > +     memset(mem, 0, sizeof(*mem));
> > +     swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
> >       set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
> > -     memset(tlb, 0, bytes);
>
> This is good for swiotlb_late_init_with_tbl. However I have just noticed
> that mem could also be allocated from swiotlb_init_with_tbl, in which
> case the zeroing is missing. I think we need another memset in
> swiotlb_init_with_tbl as well. Or maybe it could be better to have a
> single memset at the beginning of swiotlb_init_io_tlb_mem instead. Up to
> you.

swiotlb_init_with_tbl uses memblock_alloc to allocate the io_tlb_mem
and memblock_alloc[1] will do memset in memblock_alloc_try_nid[2], so
swiotlb_init_with_tbl is also good.
I'm happy to add the memset in swiotlb_init_io_tlb_mem if you think
it's clearer and safer.

[1] https://elixir.bootlin.com/linux/v5.13-rc6/source/include/linux/memblock.h#L407
[2] https://elixir.bootlin.com/linux/v5.13-rc6/source/mm/memblock.c#L1555
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
